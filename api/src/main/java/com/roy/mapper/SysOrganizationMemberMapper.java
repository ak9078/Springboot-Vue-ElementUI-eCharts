package com.roy.mapper;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.roy.entity.SysOrganizationMember;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@DS("ds_translate_base") // 这里是配置数据源注解，默认是ds_translate_data_platform
@Mapper
public interface SysOrganizationMemberMapper extends BaseMapper<SysOrganizationMember> {

    List<SysOrganizationMember> findByOrgId(String orgId);

    List<SysOrganizationMember> findByOrgIds(String orgIds);

    List<SysOrganizationMember> findRandLimit10();

    List<SysOrganizationMember> findBySysAccountIds(String sysAccountIds);

    // 根据类型编码（比如 XS:销售，XM:项目）获取所有成员
    List<SysOrganizationMember> findByTypeCode(String typeCode);
}

