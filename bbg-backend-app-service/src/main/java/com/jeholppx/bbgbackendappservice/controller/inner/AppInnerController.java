package com.jeholppx.bbgbackendappservice.controller.inner;

import com.jeholppx.bbgbackendappservice.service.AppService;
import com.jeholppx.bbgbackendmodel.model.entity.App;
import com.jeholppx.bbgbackendserviceclient.service.AppFeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 该服务不提供给前端
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/27 21:58
 */
@RestController
@RequestMapping("/inner")
public class AppInnerController implements AppFeignClient {

    @Resource
    private AppService appService;


    /**
     * 根据id获取应用
     *
     * @param id
     * @return
     */
    @Override
    @GetMapping("/get/id")
    public App getById(@RequestParam("appId") Long id) {
        return appService.getById(id);
    }
}
