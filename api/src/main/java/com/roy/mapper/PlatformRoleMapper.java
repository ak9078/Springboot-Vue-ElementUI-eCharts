package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.roy.entity.PlatformRole;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PlatformRoleMapper extends BaseMapper<PlatformRole> {

    PlatformRole findById(String roleId);

    List<PlatformRole> findByIds(String roleIds);

    PlatformRole findByCode(String roleCode);

    List<PlatformRole> findAll(Pagination pagination);

}

