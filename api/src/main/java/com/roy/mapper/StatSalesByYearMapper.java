package com.roy.mapper;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.roy.entity.StatSalesByYear;
import org.apache.ibatis.annotations.Mapper;

@DS("ds_translate_crm") // 这里是配置数据源注解，默认是ds_translate_data_platform
@Mapper
public interface StatSalesByYearMapper extends BaseMapper<StatSalesByYear> {

    // 按年度查询
    StatSalesByYear findByYear();

    // 超期未回款额度
    Long unreturnedMoneyTotal(int days);

}

