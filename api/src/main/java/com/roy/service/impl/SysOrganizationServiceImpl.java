package com.roy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.SysOrganization;
import com.roy.mapper.SysOrganizationMapper;
import com.roy.service.SysOrganizationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <pre>
 *     业务平台-组织业务逻辑实现类
 * </pre>
 *
 */
@Service
public class SysOrganizationServiceImpl implements SysOrganizationService {

    @Autowired(required = false)
    private SysOrganizationMapper sysOrganizationMapper;

    @Override
    public SysOrganization findByCode(String code) {
        SysOrganization param = new SysOrganization();
        param.setCode(code);
        return sysOrganizationMapper.selectOne(param);
    }

    @Override
    public List<SysOrganization> findAllTeam(String code) {
        return sysOrganizationMapper.findAllTeam(code);
    }

    @Override
    public List<SysOrganization> findTeamByCode(String code) {
        return sysOrganizationMapper.findTeamByCode(code);
    }

    @Override
    public Page<SysOrganization> findAll(Page<SysOrganization> page) {
        return page.setRecords(sysOrganizationMapper.findAll(page));
    }

}
