package com.roy.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.StatSalesByYear;
import com.roy.entity.StatSales;
import com.roy.entity.StatSalesByRank;

import java.util.List;


/**
 * <pre>
 *     数据平台-统计销售数据业务逻辑接口
 * </pre>
 *
 */
public interface StatSalesService {

    /**
     * 按年度查询
     *
     * @return 统计数据
     */
    StatSalesByYear findByYear();

    /**
     * 超期未回款额度
     * @param days 天数
     * @return 统计数据
     */
     Long unreturnedMoneyTotal(int days);

    /**
     * 按人员ID查询
     *
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param sysAccountIds 账号表主键（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatSales> findBySysAccountIds(String statType, String startDate, String endDate, String sysAccountIds);

    /**
     * 获取排名
     *
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param sysAccountIds 账号表主键（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatSalesByRank> findRankData(String statType, String startDate, String endDate, String sysAccountIds);

    /**
     * 按销售团队（组）ID查询
     *
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param groupIds 销售团队（组）ID（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatSales> findByGroupIds(String statType, String startDate, String endDate, String groupIds);

    /**
     * 按销售部门（团队）ID查询
     *
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param departmentIds 销售部门（团队）ID（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatSales> findByDepartmentIds(String statType, String startDate, String endDate, String departmentIds);

    /**
     * 定时统计
     * 统计类型 1：下单额，2：开票额，3：回款额，4：超期未回
     * @param operation insert:新增，update:更新
     * @param statDate 统计日期
     */
    void timingStatistics_1_xd(String operation, String statDate);
    void timingStatistics_2_kp(String operation, String statDate);
    void timingStatistics_3_hk(String operation, String statDate);
    void timingStatistics_4_cq(String operation, String statDate);

}
