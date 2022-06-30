package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     年度统计生产数据
 * </pre>
 *
 */
@Data
@TableName("t_stat_produces")
public class StatProducesByYear implements Serializable {
    /**
     * 利润率
     */
    private Long totalProfitMargin;
    /**
     * 年支出
     */
    private Long annualExpenditure;
    /**
     * 返稿率
     */
    private String returnRate;
    /**
     * 交付字数
     */
    private Long deliveryWords;
}
