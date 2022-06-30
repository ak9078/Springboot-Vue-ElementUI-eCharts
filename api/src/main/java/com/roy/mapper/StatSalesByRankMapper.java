package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.roy.entity.StatSalesByRank;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StatSalesByRankMapper extends BaseMapper<StatSalesByRank> {
    // 按人员ID查询 排名
    List<StatSalesByRank> findRankData(String statType, String startDate, String endDate, String sysAccountIds);
}
