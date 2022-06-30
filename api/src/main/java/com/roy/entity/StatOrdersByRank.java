package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     统计订单数据 排名
 * </pre>
 *
 */
@Data
@TableName("t_stat_orders")
public class StatOrdersByRank implements Serializable {
    /**
     * 渠道ID
     */
    private String statChannel;
    /**
     * 渠道名称
     */
    private String channelName;
    /**
     * 统计结果
     */
    private String statResult;
}
