package com.roy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.PlatformRole;
import com.roy.mapper.PlatformRoleMapper;
import com.roy.service.PlatformRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <pre>
 *     数据平台-后台用户角色业务逻辑实现类
 * </pre>
 *
 */
@Service
public class PlatformRoleServiceImpl implements PlatformRoleService {

    @Autowired(required = false)
    private PlatformRoleMapper platformRoleMapper;

    @Override
    public PlatformRole findById(String roleId) {
        return platformRoleMapper.selectById(roleId);
    }

    @Override
    public List<PlatformRole> findByIds(String roleIds) {
        return platformRoleMapper.findByIds(roleIds);
    }

    @Override
    public PlatformRole findByCode(String roleCode) {
        PlatformRole param = new PlatformRole();
        param.setRoleCode(roleCode);
        return platformRoleMapper.selectOne(param);
    }

    @Override
    public Page<PlatformRole> findAll(Page<PlatformRole> page) {
        return page.setRecords(platformRoleMapper.findAll(page));
    }

}
