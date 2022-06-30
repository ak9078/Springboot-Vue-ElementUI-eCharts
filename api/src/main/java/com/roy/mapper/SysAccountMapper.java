package com.roy.mapper;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.roy.entity.SysAccount;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@DS("ds_translate_account") // 这里是配置数据源注解，默认是ds_translate_data_platform
@Mapper
public interface SysAccountMapper extends BaseMapper<SysAccount> {

    SysAccount findByCode(String accountCode);

    List<SysAccount> findAll(Pagination pagination);

}

