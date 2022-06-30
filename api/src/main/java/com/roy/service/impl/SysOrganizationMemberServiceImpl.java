package com.roy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.SysOrganizationMember;
import com.roy.mapper.SysOrganizationMemberMapper;
import com.roy.service.SysOrganizationMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <pre>
 *     业务平台-组织成员业务逻辑实现类
 * </pre>
 *
 */
@Service
public class SysOrganizationMemberServiceImpl implements SysOrganizationMemberService {

    @Autowired(required = false)
    private SysOrganizationMemberMapper sysOrganizationMemberMapper;

    @Override
    public List<SysOrganizationMember> findByOrgId(String orgId) {
        return sysOrganizationMemberMapper.findByOrgId(orgId);
    }

    @Override
    public List<SysOrganizationMember> findByOrgIds(String orgIds) {
        return sysOrganizationMemberMapper.findByOrgIds(orgIds);
    }

    @Override
    public List<SysOrganizationMember> findRandLimit10() {
        return sysOrganizationMemberMapper.findRandLimit10();
    }

    @Override
    public List<SysOrganizationMember> findBySysAccountIds(String sysAccountIds) {
        return sysOrganizationMemberMapper.findBySysAccountIds(sysAccountIds);
    }

    // 根据类型编码（比如 XS:销售，XM:项目）获取所有成员
    @Override
    public List<SysOrganizationMember> findByTypeCode(String typeCode) {
        return sysOrganizationMemberMapper.findByTypeCode(typeCode);
    }

}
