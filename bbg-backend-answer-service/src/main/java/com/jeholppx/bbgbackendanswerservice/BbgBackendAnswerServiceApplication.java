package com.jeholppx.bbgbackendanswerservice;

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

@SpringBootApplication
@EnableDiscoveryClient
@MapperScan("com.jeholppx.bbgbackendanswerservice.mapper")
@EnableScheduling
@EnableAspectJAutoProxy(proxyTargetClass = true, exposeProxy = true)
@EnableConfigurationProperties
@ComponentScan("com.jeholppx")
@EnableFeignClients(basePackages = "com.jeholppx.bbgbackendserviceclient.service")
public class BbgBackendAnswerServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(BbgBackendAnswerServiceApplication.class, args);
    }

}
