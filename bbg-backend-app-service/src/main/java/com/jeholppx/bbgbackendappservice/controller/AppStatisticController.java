package com.jeholppx.bbgbackendappservice.controller;


import com.jeholppx.bbgbackendappservice.mapper.UserAnswerMapper;
import com.jeholppx.bbgbackendcommon.common.BaseResponse;
import com.jeholppx.bbgbackendcommon.common.ErrorCode;
import com.jeholppx.bbgbackendcommon.common.ResultUtils;
import com.jeholppx.bbgbackendcommon.exception.ThrowUtils;
import com.jeholppx.bbgbackendmodel.model.dto.userAnswer.AppAnswerCountDTO;
import com.jeholppx.bbgbackendmodel.model.dto.userAnswer.AppAnswerResultCountDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 应用统计模块
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/26 20:27
 */
@RestController
@RequestMapping("/statistic")
@Slf4j
public class AppStatisticController {

    @Resource
    private UserAnswerMapper userAnswerMapper;

    /**
     * 热门应用排行统计
     *
     * @return
     */
    @GetMapping("/answer_count")
    public BaseResponse<List<AppAnswerCountDTO>> getAppAnswerCount() {
        return ResultUtils.success(userAnswerMapper.doAppAnswerCount());
    }

    /**
     * 应用回答分布统计
     *
     * @param appId
     * @return
     */
    @GetMapping("/answer_result_count")
    public BaseResponse<List<AppAnswerResultCountDTO>> getAppAnswerResultCount(Long appId) {
        ThrowUtils.throwIf(appId == null || appId <= 0, ErrorCode.PARAMS_ERROR);
        return ResultUtils.success(userAnswerMapper.doAppAnswerResultCount(appId));
    }
}
