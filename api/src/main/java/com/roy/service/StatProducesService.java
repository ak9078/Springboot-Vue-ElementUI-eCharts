package com.roy.service;

import com.roy.entity.StatProducesByYear;
import com.roy.entity.StatProduces;
import com.roy.entity.StatProducesByRank;

import java.util.List;


/**
 * <pre>
 *     数据平台-统计生产数据业务逻辑接口
 * </pre>
 *
 */
public interface StatProducesService {

    /**
     * 按年度查询
     *
     * @return 统计数据
     */
    StatProducesByYear findByYear();

    /**
     * 查全部数据
     *
     * @param statChannel 渠道
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 统计数据
     */
    List<StatProduces> getAllData(String statChannel, String orderType, String statType, String startDate, String endDate);

    /**
     * 按人员ID查询
     *
     * @param statChannel 渠道
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param sysAccountIds 账号表主键（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatProduces> findBySysAccountIds(String statChannel, String orderType, String statType, String startDate, String endDate, String sysAccountIds);

    /**
     * 全部数据 排名
     *
     * @param statChannel 渠道
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 统计数据
     */
    List<StatProducesByRank> findAllRankData(String statChannel, String orderType, String statType, String startDate, String endDate);

    /**
     * 按sysAccountIds获取排名
     *
     * @param statChannel 渠道
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param sysAccountIds 账号表主键（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatProducesByRank> findRankData(String statChannel, String orderType, String statType, String startDate, String endDate, String sysAccountIds);

    /**
     * 按销售团队（组）ID查询
     *
     * @param statChannel 渠道
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param groupIds 销售团队（组）ID（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatProduces> findByGroupIds(String statChannel, String orderType, String statType, String startDate, String endDate, String groupIds);

    /**
     * 按销售部门（团队）ID查询
     *
     * @param statChannel 渠道
     * @param orderType 订单类型
     * @param statType 统计类型
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @param departmentIds 销售部门（团队）ID（多个以逗号","分开）
     * @return 统计数据
     */
    List<StatProduces> findByDepartmentIds(String statChannel, String orderType, String statType, String startDate, String endDate, String departmentIds);

    /**
     * 定时统计
     * 统计类型 1：利润率，2：超时率/时长，3：返稿率/量，4：交付字数
     * @param operation insert:新增，update:更新
     * @param statDate 统计日期
     */
    void timingStatistics_1_lr(String operation, String statDate);
    void timingStatistics_2_cs(String operation, String statDate);
    void timingStatistics_3_fg(String operation, String statDate);
    void timingStatistics_4_jf(String operation, String statDate);

}
