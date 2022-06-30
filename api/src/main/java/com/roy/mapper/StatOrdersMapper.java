package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.roy.entity.StatOrders;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StatOrdersMapper extends BaseMapper<StatOrders> {

    // 按渠道查询
    List<StatOrders> findByChannels(String orderType, String statType, String startDate, String endDate, String channels);

    /**
     * 定时统计
     * 统计类型 1：订单额，2：退款率，3：超时率，4：利润率，5：渠道占比
     * 新增
     */
    void timingStatistics_1_dd(String statDate);
    void timingStatistics_2_tk(String statDate);
    void timingStatistics_3_cs(String statDate);
    void timingStatistics_4_lr(String statDate);
    void timingStatistics_5_qd(String statDate);
}

