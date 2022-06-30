package com.roy.config;

import com.roy.Interceptor.SecurityInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.config.annotation.*;

/**
 * <pre>
 *     拦截器，资源路径配置
 * </pre>
 *
 * @author : roy
 * @date 2020-07-18
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.roy.controller")
@PropertySource(value = "classpath:application.yml", ignoreResourceNotFound = true, encoding = "UTF-8")
public class MvcConfig implements WebMvcConfigurer {

    @Bean
    SecurityInterceptor securityInterceptor() {
        return new SecurityInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(securityInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/api/**", "/admin/**");
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowCredentials(true)
                .allowedHeaders("*")
                .allowedOrigins("*")
                .allowedMethods("*");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/admin/**") // 对外暴露的访问路径
                .addResourceLocations("classpath:/adminDist/"); // 文件存放位置
    }

}
