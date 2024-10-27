package com.jeholppx.bbgbackendanswerservice.scoring;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.jeholppx.bbgbackendmodel.model.dto.question.QuestionContentDTO;
import com.jeholppx.bbgbackendmodel.model.entity.App;
import com.jeholppx.bbgbackendmodel.model.entity.Question;
import com.jeholppx.bbgbackendmodel.model.entity.ScoringResult;
import com.jeholppx.bbgbackendmodel.model.entity.UserAnswer;
import com.jeholppx.bbgbackendmodel.model.vo.QuestionVO;
import com.jeholppx.bbgbackendserviceclient.service.QuestionFeignClient;
import com.jeholppx.bbgbackendserviceclient.service.ScoringFeignClient;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;

/**
 * 自定义打分类评分策略
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/16 14:43
 */
@ScoringStrategyConfig(appType = 0, scoringStrategy = 0)
public class CustomScoreScoringStrategy implements ScoringStrategy {

    @Resource
    private QuestionFeignClient questionFeignClient;

    @Resource
    private ScoringFeignClient scoringFeignClient;

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
        // 1. 根据ID查询到题目和题目结果的信息(分数降序排序)
        Long appId = app.getId();
        Question question = questionFeignClient.getByAppId(appId);
        List<ScoringResult> scoringResultList = scoringFeignClient.getByAppId(appId);

        // 2. 统计用户总得分
        int totalScore = 0;
        // 获取题目结构
        QuestionVO questionVO = QuestionVO.objToVo(question);
        // 获取题目列表
        List<QuestionContentDTO> questionContents = questionVO.getQuestionContent();
        // 遍历题目列表
        for (int i = 0; i < choices.size(); i++) {
            QuestionContentDTO questionContentDTO = questionContents.get(i);
            // 遍历答案列表
            List<QuestionContentDTO.Option> options = questionContentDTO.getOptions();
            // 遍历题目中的选项
            for (QuestionContentDTO.Option option : options) {
                // 如果选项的值和用户选择的值相等，则将选项的分数加到总分上
                if (option.getKey().equals(choices.get(i))) {
                    totalScore += Optional.of(option.getScore()).orElse(0);
                    break;
                }
            }
        }

        // 3. 遍历得分结果，找到第一个符合得分范围的结果，作为最终结果
        ScoringResult maxScoringResult = scoringResultList.get(0);
        for (ScoringResult scoringResult : scoringResultList) {
            if (totalScore >= scoringResult.getResultScoreRange()) {
                maxScoringResult = scoringResult;
                break;
            }
        }

        // 4. 构造返回值，填充答案的对象属性
        UserAnswer userAnswer = new UserAnswer();
        userAnswer.setAppId(appId);
        userAnswer.setAppType(app.getAppType());
        userAnswer.setScoringStrategy(app.getScoringStrategy());
        userAnswer.setChoices(JSONUtil.toJsonStr(choices));
        userAnswer.setResultId(maxScoringResult.getId());
        userAnswer.setResultName(maxScoringResult.getResultName());
        userAnswer.setResultDesc(maxScoringResult.getResultDesc());
        userAnswer.setResultPicture(maxScoringResult.getResultPicture());
        userAnswer.setResultScore(totalScore);

        return userAnswer;
    }
}
