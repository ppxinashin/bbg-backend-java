package com.jeholppx.bbgbackendscoringservice.controller.inner;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.jeholppx.bbgbackendmodel.model.entity.ScoringResult;
import com.jeholppx.bbgbackendscoringservice.service.ScoringResultService;
import com.jeholppx.bbgbackendserviceclient.service.ScoringFeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/inner")
public class ScoringResultInnerController implements ScoringFeignClient {

    @Resource
    private ScoringResultService scoringResultService;

    @Override
    @GetMapping("/get/appId")
    public List<ScoringResult> getByAppId(@RequestParam("appId") Long appId) {
        return scoringResultService.list(
                Wrappers.lambdaQuery(ScoringResult.class)
                        .eq(ScoringResult::getAppId, appId)
                        .orderByDesc(ScoringResult::getResultScoreRange)
        );
    }
}
