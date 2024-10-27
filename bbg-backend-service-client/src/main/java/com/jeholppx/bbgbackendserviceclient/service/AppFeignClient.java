package com.jeholppx.bbgbackendserviceclient.service;

import com.jeholppx.bbgbackendmodel.model.entity.App;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 应用服务
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 
 */
@FeignClient(name = "bbg-backend-app-service", path = "/api/app/inner")
public interface AppFeignClient {
    /**
     * 根据id获取应用
     *
     * @param id
     * @return
     */
    @GetMapping("/get/id")
    App getById(@RequestParam("appId") Long id);
}
