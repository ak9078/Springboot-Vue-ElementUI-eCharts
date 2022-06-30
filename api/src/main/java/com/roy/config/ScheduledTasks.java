package com.roy.config;

import com.roy.service.StatSalesService;
import com.roy.service.StatProducesService;
import com.roy.service.StatOrdersService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author roy
 * @date 2020-07-18
 */
@Component
@Slf4j
public class ScheduledTasks {

    @Autowired
    private StatSalesService statSalesService;

    @Autowired
    private StatProducesService statProducesService;

    @Autowired
    private StatOrdersService statOrdersService;

    /**
     * 轮询统计
     * https://www.jianshu.com/p/1defb0f22ed1
     * 每隔1分钟执行一次：*\/60 * * * * ?
     * 为了测试，先用1分钟
     * 每天凌晨3点执行一次：0 0 3 * * ?
     * 每天22:24分执行一次 0 24 22 * * ?
     */
    @Scheduled(cron = "0 0 3 * * ?")
    public void automaticStatistics() {
        Date yesterdayDate = new Date(System.currentTimeMillis() - 1000 * 60 * 60 * 24);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String yesterday = simpleDateFormat.format(yesterdayDate);//获取昨天日期
        // yesterday = "2020-01-01";

        // 定时统计销售数据
        // region 统计类型 1：下单额，2：开票额，3：回款额，4：超期未回
        statSalesService.timingStatistics_1_xd("insert", yesterday);
        statSalesService.timingStatistics_2_kp("insert", yesterday);
        statSalesService.timingStatistics_3_hk("insert", yesterday);
        statSalesService.timingStatistics_4_cq("insert", yesterday);
        // endregion

        // 定时统计生产数据
        // region 统计类型 1：利润率，2：超时率/时长，3：返稿率/量，4：交付字数
        statProducesService.timingStatistics_1_lr("insert", yesterday);
        statProducesService.timingStatistics_2_cs("insert", yesterday);
        statProducesService.timingStatistics_3_fg("insert", yesterday);
        statProducesService.timingStatistics_4_jf("insert", yesterday);
        // endregion

        // 定时统计订单数据
        // region 统计类型 1：订单额，2：退款率，3：超时率，4：利润率，5：渠道占比
        statOrdersService.timingStatistics_1_dd("insert", yesterday);
        statOrdersService.timingStatistics_2_tk("insert", yesterday);
        statOrdersService.timingStatistics_3_cs("insert", yesterday);
        statOrdersService.timingStatistics_4_lr("insert", yesterday);
        statOrdersService.timingStatistics_5_qd("insert", yesterday);
        // endregion
    }

}
