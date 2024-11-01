package com.jeholppx.bbgbackendanswerservice.scoring;


import com.jeholppx.bbgbackendcommon.common.ErrorCode;
import com.jeholppx.bbgbackendcommon.exception.BusinessException;
import com.jeholppx.bbgbackendmodel.model.entity.App;
import com.jeholppx.bbgbackendmodel.model.entity.UserAnswer;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 评分策略执行器
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/16 15:53
 */
@Service
public class ScoringStrategyExecutor {

    // 策略列表
    @Resource
    private List<ScoringStrategy> scoringStrategyList;


    /**
     * 评分
     *
     * @param choiceList
     * @param app
     * @return
     * @throws Exception
     */
    public UserAnswer doScore(List<String> choiceList, App app) throws Exception {
        Integer appType = app.getAppType();
        Integer appScoringStrategy = app.getScoringStrategy();
        if (appType == null || appScoringStrategy == null) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "应用配置有误，未找到匹配的策略");
        }
        // 根据注解获取策略
        for (ScoringStrategy strategy : scoringStrategyList) {
            if (strategy.getClass().isAnnotationPresent(ScoringStrategyConfig.class)) {
                ScoringStrategyConfig scoringStrategyConfig = strategy.getClass().getAnnotation(ScoringStrategyConfig.class);
                if (scoringStrategyConfig.appType() == appType && scoringStrategyConfig.scoringStrategy() == appScoringStrategy) {
                    return strategy.doScore(choiceList, app);
                }
            }
        }
        throw new BusinessException(ErrorCode.SYSTEM_ERROR, "应用配置有误，未找到匹配的策略");
    }
}
