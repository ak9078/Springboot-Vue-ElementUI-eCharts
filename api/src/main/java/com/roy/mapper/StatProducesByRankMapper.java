package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.roy.entity.StatProducesByRank;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StatProducesByRankMapper extends BaseMapper<StatProducesByRank> {
    // 全部 排名
    List<StatProducesByRank> findAllRankData(String statChannel, String orderType, String statType, String startDate, String endDate);
    // 按人员ID查询 排名
    List<StatProducesByRank> findRankData(String statChannel, String orderType, String statType, String startDate, String endDate, String sysAccountIds);
}

