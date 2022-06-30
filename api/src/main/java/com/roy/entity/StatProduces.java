package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     统计生产数据
 * </pre>
 *
 */
@Data
@TableName("t_stat_produces")
public class StatProduces implements Serializable {

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
     * 渠道 1：线上，2：线下
     */
    private String statChannel;
    /**
     * 订单类型 1：快速翻译（线上），2：文档订单（线上、线下），3：口译服务（线下），4：其他
     */
    private String orderType;
    /**
     * 统计类型 1：利润率，2：超时率/时长，3：返稿率/量，4：交付字数
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
