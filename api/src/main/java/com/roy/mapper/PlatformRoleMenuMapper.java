package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.roy.entity.PlatformRoleMenu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PlatformRoleMenuMapper extends BaseMapper<PlatformRoleMenu> {
    List<PlatformRoleMenu> findByRoleIds(String roleIds);
}

