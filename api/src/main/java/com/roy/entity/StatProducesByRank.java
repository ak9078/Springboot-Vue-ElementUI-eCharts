package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     统计生产数据 排名
 * </pre>
 *
 */
@Data
@TableName("t_stat_produces")
public class StatProducesByRank implements Serializable {
    /**
     * 用户账号
     */
    private String accountCode;
    /**
     * 统计结果
     */
    private String statResult;
}
