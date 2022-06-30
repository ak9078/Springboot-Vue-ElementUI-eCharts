package com.roy.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.SysOrganizationMember;

import java.util.List;


/**
 * <pre>
 *     业务平台-组织成员业务逻辑接口
 * </pre>
 *
 */
public interface SysOrganizationMemberService {

    /**
     * 获得辖下的团队（小组）成员
     * @param orgId 机构id
     * @return 组织成员
     */
    List<SysOrganizationMember> findByOrgId(String orgId);

    /**
     * 获得辖下的团队（小组）成员
     * @param orgIds 机构id，多个以逗号分隔
     * @return 组织成员
     */
    List<SysOrganizationMember> findByOrgIds(String orgIds);

    /**
     * 随机获取10个成员
     * @return 组织成员
     */
    List<SysOrganizationMember> findRandLimit10();

    /**
     * 根据成员ID，获取其对应的用户账号
     * @return 组织成员
     */
    List<SysOrganizationMember> findBySysAccountIds(String sysAccountIds);

    /**
     * 根据类型编码获取所有成员
     * @param typeCode 类型编码（XS:销售，XM:项目）
     * @return 组织成员
     */
    List<SysOrganizationMember> findByTypeCode(String typeCode);

}
