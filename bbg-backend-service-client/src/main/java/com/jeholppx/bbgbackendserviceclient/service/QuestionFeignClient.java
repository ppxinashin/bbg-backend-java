package com.jeholppx.bbgbackendserviceclient.service;

import com.jeholppx.bbgbackendmodel.model.entity.Question;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "bbg-backend-question-service", path = "/api/question/inner")
public interface QuestionFeignClient {
    @GetMapping("/get/appId")
    Question getByAppId(@RequestParam("appId") Long appId);
}
