package com.jeholppx.bbgbackendfileservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableDiscoveryClient
@EnableScheduling
@EnableAspectJAutoProxy(proxyTargetClass = true, exposeProxy = true)
@EnableConfigurationProperties
@ComponentScan("com.jeholppx")
@EnableFeignClients(basePackages = "com.jeholppx.bbgbackendserviceclient.service")
public class BbgBackendFileServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(BbgBackendFileServiceApplication.class, args);
    }

}
