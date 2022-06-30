package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * <pre>
 *     统计销售数据
 * </pre>
 *
 */
@Data
@TableName("t_stat_sales")
public class StatSales implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 账号表主键
     */
    private String sysAccountId;
    /**
     * 用户账号
     */
    private String accountCode;
    /**
     * 销售团队（组）ID
     */
    private String groupId;
    /**
     * 销售部门（团队）ID
     */
    private String departmentId;
    /**
     * 统计类型 1：下单额，2：开票额，3：回款额，4：超期未回
     */
    private String statType;
    /**
     * 统计日期
     */
    private String statDate;
    /**
     * 统计结果
     */
    private String statResult;
}
