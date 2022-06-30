package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     统计销售数据 排名
 * </pre>
 *
 */
@Data
@TableName("t_stat_sales")
public class StatSalesByRank implements Serializable {
    /**
     * 用户账号
     */
    private String accountCode;
    /**
     * 统计结果
     */
    private String statResult;
}
