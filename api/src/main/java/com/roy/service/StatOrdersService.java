package com.roy.service;

import com.roy.entity.StatOrdersByYear;
import com.roy.entity.StatOrders;
import com.roy.entity.StatOrdersByRank;

import java.util.List;


/**
 * <pre>
 *     数据平台-统计订单数据业务逻辑接口
 * </pre>
 *
 */
public interface StatOrdersService {

    /**
     * 按年度查询
     *
     * @param channels 渠道（多个以逗号","分开）
     * @param orderTypes 订单类型（多个以逗号","分开）
     * @return 统计数据
     */
    StatOrdersByYear findByYear(String channels, String orderTypes);

    /**
     * 按渠道查询
     *
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param channels 渠道（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatOrders> findByChannels(String orderType, String statType, String startDate, String endDate, String channels);

    /**
     * 获取排名
     *
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param channels 渠道（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatOrdersByRank> findRankData(String orderType, String statType, String startDate, String endDate, String channels);

    /**
     * 定时统计
     * 统计类型 统计类型 1：订单额，2：退款率，3：超时率，4：利润率，5：渠道占比
     * @param operation insert:新增，update:更新
     * @param statDate 统计日期
     */
    void timingStatistics_1_dd(String operation, String statDate);
    void timingStatistics_2_tk(String operation, String statDate);
    void timingStatistics_3_cs(String operation, String statDate);
    void timingStatistics_4_lr(String operation, String statDate);
    void timingStatistics_5_qd(String operation, String statDate);


}
