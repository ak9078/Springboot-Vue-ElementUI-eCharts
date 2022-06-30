package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.roy.entity.StatSales;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StatSalesMapper extends BaseMapper<StatSales> {

    // 按人员ID查询
    List<StatSales> findBySysAccountIds(String statType, String startDate, String endDate, String sysAccountIds);

    // 按销售团队（组）ID查询
    List<StatSales> findByGroupIds(String statType, String startDate, String endDate, String groupIds);

    // 按销售部门（团队）ID查询
    List<StatSales> findByDepartmentIds(String statType, String startDate, String endDate, String departmentIds);

    /**
     * 定时统计
     * 统计类型 1：下单额，2：开票额，3：回款额，4：超期未回
     * 新增
     */
    void timingStatistics_1_xd(String statDate);
    void timingStatistics_2_kp(String statDate);
    void timingStatistics_3_hk(String statDate);
    void timingStatistics_4_cq(String statDate);
}
