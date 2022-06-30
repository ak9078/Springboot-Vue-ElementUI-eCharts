package com.roy;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * <pre>
 *     App run!
 * </pre>
 *
 */
@Slf4j
@EnableCaching
@EnableScheduling
@MapperScan("com.roy.mapper*")
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class, DataSourceTransactionManagerAutoConfiguration.class }) // 去掉springboot默认的数据源配置
public class Application {
    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(Application.class, args);
        String serverPort = context.getEnvironment().getProperty("server.port");
        log.info("Started at http://localhost:" + serverPort);
    }
}
