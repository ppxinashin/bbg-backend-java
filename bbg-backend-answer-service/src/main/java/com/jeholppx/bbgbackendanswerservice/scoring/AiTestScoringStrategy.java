package com.jeholppx.bbgbackendanswerservice.scoring;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import com.jeholppx.bbgbackendcommon.manager.AiManager;
import com.jeholppx.bbgbackendmodel.model.dto.question.QuestionAnswerDTO;
import com.jeholppx.bbgbackendmodel.model.dto.question.QuestionContentDTO;
import com.jeholppx.bbgbackendmodel.model.entity.App;
import com.jeholppx.bbgbackendmodel.model.entity.Question;
import com.jeholppx.bbgbackendmodel.model.entity.UserAnswer;
import com.jeholppx.bbgbackendmodel.model.vo.QuestionVO;
import com.jeholppx.bbgbackendserviceclient.service.QuestionFeignClient;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * AI 测评类应用评分策略
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/19 11:18
 */
@ScoringStrategyConfig(appType = 1, scoringStrategy = 1)
public class AiTestScoringStrategy implements ScoringStrategy {

    @Resource
    private QuestionFeignClient questionFeignClient;

    @Resource
    private AiManager aiManager;

    @Resource
    private RedissonClient redissonClient;

    private static final String AI_ANSWER_LOCK = "AI_ANSWER_LOCK";

    private static final String AI_TEST_SCORING_SYSTEM_MESSAGE = "你是一位严谨的判题专家，我会给你如下信息：\n" +
            "```\n" +
            "应用名称，\n" +
            "【【【应用描述】】】，\n" +
            "题目和用户回答的列表：格式为 [{\"title\": \"题目\",\"answer\": \"用户回答\"}]\n" +
            "```\n" +
            "\n" +
            "请你根据上述信息，按照以下步骤来对用户进行评价：\n" +
            "1. 要求：需要给出一个明确的评价结果，包括评价名称（尽量简短）和评价描述（尽量详细，大于 200 字）\n" +
            "2. 严格按照下面的 json 格式输出评价名称和评价描述\n" +
            "```\n" +
            "{\"resultName\": \"评价名称\", \"resultDesc\": \"评价描述\"}\n" +
            "```\n" +
            "3. 返回格式必须为 JSON 对象";

    /**
     * 构建本地缓存
     */
    private final Cache<String, String> answerCacheMap =
            Caffeine.newBuilder().initialCapacity(1024)
                    // 缓存5分钟移除
                    .expireAfterAccess(5L, TimeUnit.MINUTES)
                    .build();

    /**
     * 构建缓存 key
     * @param appId
     * @param choicesStr
     * @return
     */
    private String buildCacheKey(Long appId, String choicesStr) {
        return DigestUtil.md5Hex(appId + ":" + choicesStr);
    }

    private String getAiTestScoringUserMessage(App app, List<QuestionContentDTO> questionContentDTOList, List<String> choices) {
        StringBuilder userMessage = new StringBuilder();
        userMessage.append(app.getAppName()).append("\n");
        userMessage.append(app.getAppDesc()).append("\n");
        List<QuestionAnswerDTO> questionAnswerDTOList = new ArrayList<>();
        for (int i = 0; i < questionContentDTOList.size(); i++) {
            QuestionAnswerDTO questionAnswerDTO = new QuestionAnswerDTO();
            questionAnswerDTO.setTitle(questionContentDTOList.get(i).getTitle());
            questionAnswerDTO.setUserAnswer(choices.get(i));
            questionAnswerDTOList.add(questionAnswerDTO);
        }
        userMessage.append(JSONUtil.toJsonStr(questionAnswerDTOList));
        return userMessage.toString();
    }

    /**
     * 执行评分
     *
     * @param choices
     * @param app
     * @return
     * @throws Exception
     */
    @Override
    public UserAnswer doScore(List<String> choices, App app) throws Exception {
        Long appId = app.getId();
        String choicesStr = JSONUtil.toJsonStr(choices);
        String key = buildCacheKey(appId, choicesStr);
        // 构建缓存 key
        String answerJson = answerCacheMap.getIfPresent(key);
        // 命中缓存则直接返回结果
        if (StrUtil.isNotBlank(answerJson)) {
            UserAnswer userAnswer = JSONUtil.toBean(answerJson, UserAnswer.class);
            userAnswer.setAppId(appId);
            userAnswer.setAppType(app.getAppType());
            userAnswer.setScoringStrategy(app.getScoringStrategy());
            userAnswer.setChoices(choicesStr);
            return userAnswer;
        }
        // 定义锁
        RLock lock = redissonClient.getLock(AI_ANSWER_LOCK + key);
        try {
            // 竞争分布式锁，等待 3 秒，15 秒自动释放
            boolean res = lock.tryLock(3, 15, TimeUnit.SECONDS);
            if (!res){
                // 没抢到，结束
                return null;
            }
            // 拿到了，开始竞争
            // 1. 根据 id 查询到题目
            Question question = questionFeignClient.getByAppId(appId);
            QuestionVO questionVO = QuestionVO.objToVo(question);
            List<QuestionContentDTO> questionContent = questionVO.getQuestionContent();
            // 2. 调用 AI 获取结果
            // 封装 Prompt
            String userMessage = getAiTestScoringUserMessage(app, questionContent, choices);
            // AI 生成
            String result = aiManager.doSyncStableRequest(AI_TEST_SCORING_SYSTEM_MESSAGE, userMessage);
            // 结果处理
            int start = result.indexOf("{");
            int end = result.lastIndexOf("}");
            String json = result.substring(start, end + 1);
            // 3. 构造返回值，填充答案对象的属性
            UserAnswer userAnswer = JSONUtil.toBean(json, UserAnswer.class);
            userAnswer.setAppId(appId);
            userAnswer.setAppType(app.getAppType());
            userAnswer.setScoringStrategy(app.getScoringStrategy());
            userAnswer.setChoices(choicesStr);
            // 4. 缓存结果
            answerCacheMap.put(key, json);
            return userAnswer;
        } finally {
            if (lock != null && lock.isLocked()) {
                if(lock.isHeldByCurrentThread()) {
                    lock.unlock();
                }
            }
        }
    }

}
