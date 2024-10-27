package com.jeholppx.bbgbackendquestionservice.controller.inner;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.jeholppx.bbgbackendmodel.model.entity.Question;
import com.jeholppx.bbgbackendquestionservice.service.QuestionService;
import com.jeholppx.bbgbackendserviceclient.service.QuestionFeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/inner")
public class QuestionInnerController implements QuestionFeignClient {

    @Resource
    private QuestionService questionService;

    @Override
    @GetMapping("/get/appId")
    public Question getByAppId(@RequestParam("appId") Long appId) {
        return questionService.getOne(
                Wrappers.lambdaQuery(Question.class).eq(Question::getAppId, appId)
        );
    }
}
