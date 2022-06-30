package com.roy;
import junit.framework.TestCase;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class ApplicationTests {
    /**
     * 使用断言
     */
    @Test
    public void test2() {
        log.info("test hello 2");
        TestCase.assertEquals(1, 1);
    }
}