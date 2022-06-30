package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.roy.entity.StatOrdersByRank;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StatOrdersByRankMapper extends BaseMapper<StatOrdersByRank> {
    // 按渠道查询 排名
    List<StatOrdersByRank> findRankData(String orderType, String statType, String startDate, String endDate, String channels);
}

