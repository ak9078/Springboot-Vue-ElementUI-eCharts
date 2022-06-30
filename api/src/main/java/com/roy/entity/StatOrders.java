package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     统计订单数据
 * </pre>
 *
 */
@Data
@TableName("t_stat_orders")
public class StatOrders implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 渠道 1：译鱼，2：百度，3：360，4：腾讯，5：线
     */
    private String statChannel;
    /**
     * 渠道名称
     */
    private String channelName;
    /**
     * 订单类型 1：快速翻译（线上），2：文档订单（线上、线下），3：口译服务（线下），4：其他
     */
    private String orderType;
    /**
     * 统计类型 1：订单额，2：退款率，3：超时率，4：利润率，5：渠道概览，6：订单交付量
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
