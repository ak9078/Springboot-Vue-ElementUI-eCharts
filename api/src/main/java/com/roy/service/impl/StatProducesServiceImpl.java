package com.roy.service.impl;

import com.roy.entity.StatProducesByYear;
import com.roy.entity.StatProduces;
import com.roy.entity.StatProducesByRank;
import com.roy.mapper.StatProducesByYearMapper;
import com.roy.mapper.StatProducesMapper;
import com.roy.mapper.StatProducesByRankMapper;
import com.roy.service.StatProducesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <pre>
 *     数据平台-统计生产数据业务逻辑实现类
 * </pre>
 *
 */
@Service
public class StatProducesServiceImpl implements StatProducesService {

    @Autowired(required = false)
    private StatProducesByYearMapper statProducesByYearMapper;

    @Autowired(required = false)
    private StatProducesMapper statProducesMapper;

    @Autowired(required = false)
    private StatProducesByRankMapper statProducesByRankMapper;

    @Override
    public StatProducesByYear findByYear() {
        return statProducesByYearMapper.findByYear();
    }

    // 查全部数据
    @Override
    public List<StatProduces> getAllData(String statChannel, String orderType, String statType, String startDate, String endDate) {
        return statProducesMapper.getAllData(statChannel, orderType, statType, startDate, endDate);
    }

    @Override
    public List<StatProduces> findBySysAccountIds(String statChannel, String orderType, String statType, String startDate, String endDate, String sysAccountIds) {
        return statProducesMapper.findBySysAccountIds(statChannel, orderType, statType, startDate, endDate, sysAccountIds);
    }

    // 按全部数据 排名
    @Override
    public List<StatProducesByRank> findAllRankData(String statChannel, String orderType, String statType, String startDate, String endDate) {
        return statProducesByRankMapper.findAllRankData(statChannel, orderType, statType, startDate, endDate);
    }
    // 按 sysAccoundId 获取排名
    @Override
    public List<StatProducesByRank> findRankData(String statChannel, String orderType, String statType, String startDate, String endDate, String sysAccountIds) {
        return statProducesByRankMapper.findRankData(statChannel, orderType, statType, startDate, endDate, sysAccountIds);
    }

    @Override
    public List<StatProduces> findByGroupIds(String statChannel, String orderType, String statType, String startDate, String endDate, String groupIds) {
        return statProducesMapper.findByGroupIds(statChannel, orderType, statType, startDate, endDate, groupIds);
    }

    @Override
    public List<StatProduces> findByDepartmentIds(String statChannel, String orderType, String statType, String startDate, String endDate, String departmentIds) {
        return statProducesMapper.findByDepartmentIds(statChannel, orderType, statType, startDate, endDate, departmentIds);
    }

    /**
     * 定时统计
     * 统计类型 1：利润率，2：超时率/时长，3：返稿率/量，4：交付字数
     */
    @Override
    public void timingStatistics_1_lr(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statProducesMapper.timingStatistics_1_lr(statDate);
        }else {
            statProducesMapper.timingStatistics_1_lr(statDate);
        }
    }

    @Override
    public void timingStatistics_2_cs(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statProducesMapper.timingStatistics_2_cs(statDate);
        }else {
            statProducesMapper.timingStatistics_2_cs(statDate);
        }
    }

    @Override
    public void timingStatistics_3_fg(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statProducesMapper.timingStatistics_3_fg(statDate);
        }else {
            statProducesMapper.timingStatistics_3_fg(statDate);
        }
    }

    @Override
    public void timingStatistics_4_jf(String operation, String statDate){
        if(operation.equals("insert")){
            // 新增
            statProducesMapper.timingStatistics_4_jf(statDate);
        }else {
            statProducesMapper.timingStatistics_4_jf(statDate);
        }
    }

}
