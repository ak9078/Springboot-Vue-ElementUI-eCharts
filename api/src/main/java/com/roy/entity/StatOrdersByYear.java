package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     年度统计订单数据
 * </pre>
 *
 */
@Data
@TableName("t_stat_orders")
public class StatOrdersByYear implements Serializable {
    /**
     * 年下单额
     */
    private Long costPriceTotal;
    /**
     * 年应收额
     */
    private Long parTotal;
    /**
     * 年回款额
     */
    private Long returnedMoneyTotal;
    /**
     * 交付字数
     */
    private Long deliveryWords;
}
