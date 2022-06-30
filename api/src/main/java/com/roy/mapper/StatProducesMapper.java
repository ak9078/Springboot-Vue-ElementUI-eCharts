package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.roy.entity.StatProduces;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StatProducesMapper extends BaseMapper<StatProduces> {
    // 查全部数据
    List<StatProduces> getAllData(String statChannel, String orderType, String statType, String startDate, String endDate);

    // 按人员ID查询
    List<StatProduces> findBySysAccountIds(String statChannel, String orderType, String statType, String startDate, String endDate, String sysAccountIds);

    // 按销售团队（组）ID查询
    List<StatProduces> findByGroupIds(String statChannel, String orderType, String statType, String startDate, String endDate, String groupIds);

    // 按销售部门（团队）ID查询
    List<StatProduces> findByDepartmentIds(String statChannel, String orderType, String statType, String startDate, String endDate, String departmentIds);

    /**
     * 定时统计
     * 统计类型 1：利润率，2：超时率/时长，3：返稿率/量，4：交付字数
     * 新增
     */
    void timingStatistics_1_lr(String statDate);
    void timingStatistics_2_cs(String statDate);
    void timingStatistics_3_fg(String statDate);
    void timingStatistics_4_jf(String statDate);
}

