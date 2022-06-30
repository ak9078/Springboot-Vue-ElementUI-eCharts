package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     年度统计销售数据
 * </pre>
 *
 */
@Data
@TableName("t_stat_sales")
public class StatSalesByYear implements Serializable {
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
}
