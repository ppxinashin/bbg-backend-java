package com.jeholppx.bbgbackendappservice;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.FilterType;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * 应用服务启动入口
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/27 16:37
 */
@SpringBootApplication
@EnableDiscoveryClient
@MapperScan("com.jeholppx.bbgbackendappservice.mapper")
@EnableScheduling
@EnableAspectJAutoProxy(proxyTargetClass = true, exposeProxy = true)
@EnableConfigurationProperties
@ComponentScan("com.jeholppx")
@EnableFeignClients(basePackages = "com.jeholppx.bbgbackendserviceclient.service")
public class BbgBackendAppServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(BbgBackendAppServiceApplication.class, args);
    }

}
