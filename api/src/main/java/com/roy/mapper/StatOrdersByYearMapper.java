package com.roy.mapper;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.roy.entity.StatOrdersByYear;
import org.apache.ibatis.annotations.Mapper;

@DS("ds_translate_core") // 这里是配置数据源注解，默认是ds_translate_data_platform
@Mapper
public interface StatOrdersByYearMapper extends BaseMapper<StatOrdersByYear> {

    // 按年度查询
    StatOrdersByYear findByYear(String channels, String orderTypes);

}

