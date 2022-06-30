package com.roy.mapper;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.roy.entity.SysOrganization;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@DS("ds_translate_base") // 这里是配置数据源注解，默认是ds_translate_data_platform
@Mapper
public interface SysOrganizationMapper extends BaseMapper<SysOrganization> {

    SysOrganization findByCode(String code);

    List<SysOrganization> findAllTeam(String code);

    List<SysOrganization> findTeamByCode(String code);

    List<SysOrganization> findAll(Pagination pagination);
}

