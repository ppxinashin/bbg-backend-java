package com.jeholppx.bbgbackendcommon.config;

import com.alibaba.dashscope.aigc.generation.GenerationParam;
import lombok.Data;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

/**
 * 通义千问配置
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/18 17:01
 */
@Configuration
@ConfigurationProperties(prefix = "ai")
@ConditionalOnProperty(prefix = "ai", name = {"apiKey", "model"})
@Data
public class AiConfig {

    /**
     * apiKey
     */
    private String apiKey;

    /**
     * 模型
     */
    private String model;

    
    @Bean
    public GenerationParam.GenerationParamBuilder<?, ?> createBuilder() {
        // 新建一个GenerationParamBuilder对象
        GenerationParam.GenerationParamBuilder<?, ?> builder = GenerationParam.builder();
        // 设置api和模型
        builder.apiKey(apiKey).model(model);
        return builder;
    }
}
