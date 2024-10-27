package com.jeholppx.bbgbackendserviceclient.service;

import com.jeholppx.bbgbackendmodel.model.entity.ScoringResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(name = "bbg-backend-scoring-service", path = "/api/scoringResult/inner")
public interface ScoringFeignClient {

    @GetMapping("/get/appId")
    List<ScoringResult> getByAppId(@RequestParam("appId") Long appId);
}
