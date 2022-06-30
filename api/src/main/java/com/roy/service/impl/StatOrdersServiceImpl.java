package com.roy.service.impl;

import com.roy.entity.StatOrdersByYear;
import com.roy.entity.StatOrders;
import com.roy.entity.StatOrdersByRank;
import com.roy.mapper.StatOrdersByYearMapper;
import com.roy.mapper.StatOrdersMapper;
import com.roy.mapper.StatOrdersByRankMapper;
import com.roy.service.StatOrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <pre>
 *     数据平台-统计订单数据业务逻辑实现类
 * </pre>
 *
 */
@Service
public class StatOrdersServiceImpl implements StatOrdersService {

    @Autowired(required = false)
    private StatOrdersByYearMapper statOrdersByYearMapper;

    @Autowired(required = false)
    private StatOrdersMapper statOrdersMapper;

    @Autowired(required = false)
    private StatOrdersByRankMapper statOrdersByRankMapper;

    @Override
    public StatOrdersByYear findByYear(String channels, String orderTypes) {
        return statOrdersByYearMapper.findByYear(channels, orderTypes);
    }

    @Override
    public List<StatOrders> findByChannels(String orderType, String statType, String startDate, String endDate, String channels) {
        return statOrdersMapper.findByChannels(orderType, statType, startDate, endDate, channels);
    }

    // 排名
    @Override
    public List<StatOrdersByRank> findRankData(String orderType, String statType, String startDate, String endDate, String channels) {
        return statOrdersByRankMapper.findRankData(orderType, statType, startDate, endDate, channels);
    }

    /**
     * 定时统计
     * 统计类型 1：订单额，2：退款率，3：超时率，4：利润率，5：渠道占比
     */
    @Override
    public void timingStatistics_1_dd(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statOrdersMapper.timingStatistics_1_dd(statDate);
        }else {
            statOrdersMapper.timingStatistics_1_dd(statDate);
        }
    }

    @Override
    public void timingStatistics_2_tk(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statOrdersMapper.timingStatistics_2_tk(statDate);
        }else {
            statOrdersMapper.timingStatistics_2_tk(statDate);
        }
    }

    @Override
    public void timingStatistics_3_cs(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statOrdersMapper.timingStatistics_3_cs(statDate);
        }else {
            statOrdersMapper.timingStatistics_3_cs(statDate);
        }
    }

    @Override
    public void timingStatistics_4_lr(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statOrdersMapper.timingStatistics_4_lr(statDate);
        }else {
            statOrdersMapper.timingStatistics_4_lr(statDate);
        }
    }

    @Override
    public void timingStatistics_5_qd(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statOrdersMapper.timingStatistics_5_qd(statDate);
        }else {
            statOrdersMapper.timingStatistics_5_qd(statDate);
        }
    }

}
