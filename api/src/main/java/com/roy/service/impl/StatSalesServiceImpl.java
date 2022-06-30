package com.roy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.StatSalesByYear;
import com.roy.entity.StatSales;
import com.roy.entity.StatSalesByRank;
import com.roy.mapper.StatSalesByYearMapper;
import com.roy.mapper.StatSalesMapper;
import com.roy.mapper.StatSalesByRankMapper;
import com.roy.service.StatSalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <pre>
 *     数据平台-统计销售数据业务逻辑实现类
 * </pre>
 *
 */
@Service
public class StatSalesServiceImpl implements StatSalesService {

    @Autowired(required = false)
    private StatSalesByYearMapper statSalesByYearMapper;

    @Autowired(required = false)
    private StatSalesMapper statSalesMapper;

    @Autowired(required = false)
    private StatSalesByRankMapper statSalesByRankMapper;

    @Override
    public StatSalesByYear findByYear() {
        return statSalesByYearMapper.findByYear();
    }
    // 超期未回款额度
    public Long unreturnedMoneyTotal(int days){
        return statSalesByYearMapper.unreturnedMoneyTotal(days);
    }

    @Override
    public List<StatSales> findBySysAccountIds(String statType, String startDate, String endDate, String sysAccountIds) {
        return statSalesMapper.findBySysAccountIds(statType, startDate, endDate, sysAccountIds);
    }

    // 排名
    @Override
    public List<StatSalesByRank> findRankData(String statType, String startDate, String endDate, String sysAccountIds) {
        return statSalesByRankMapper.findRankData(statType, startDate, endDate, sysAccountIds);
    }

    @Override
    public List<StatSales> findByGroupIds(String statType, String startDate, String endDate, String groupIds) {
        return statSalesMapper.findByGroupIds(statType, startDate, endDate, groupIds);
    }

    @Override
    public List<StatSales> findByDepartmentIds(String statType, String startDate, String endDate, String departmentIds) {
        return statSalesMapper.findByDepartmentIds(statType, startDate, endDate, departmentIds);
    }

    /**
     * 定时统计
     * 统计类型 1：下单额，2：开票额，3：回款额，4：超期未回
     */
    @Override
    public void timingStatistics_1_xd(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statSalesMapper.timingStatistics_1_xd(statDate);
        }else {
            statSalesMapper.timingStatistics_1_xd(statDate);
        }
    }

    @Override
    public void timingStatistics_2_kp(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statSalesMapper.timingStatistics_2_kp(statDate);
        }else {
            statSalesMapper.timingStatistics_2_kp(statDate);
        }
    }

    @Override
    public void timingStatistics_3_hk(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statSalesMapper.timingStatistics_3_hk(statDate);
        }else {
            statSalesMapper.timingStatistics_3_hk(statDate);
        }
    }

    @Override
    public void timingStatistics_4_cq(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statSalesMapper.timingStatistics_4_cq(statDate);
        }else {
            statSalesMapper.timingStatistics_4_cq(statDate);
        }
    }

}
