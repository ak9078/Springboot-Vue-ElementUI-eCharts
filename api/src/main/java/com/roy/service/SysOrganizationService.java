package com.roy.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.SysOrganization;

import java.util.List;


/**
 * <pre>
 *     业务平台-组织业务逻辑接口
 * </pre>
 *
 */
public interface SysOrganizationService {

    /**
     * 根据机构编码获得组织
     *
     * @param code 机构编码
     * @return 组织
     */
    SysOrganization findByCode(String code);

    /**
     * 获得所有团队（小组）
     * @param code 机构编码
     * @return 所有团队（小组）
     */
    List<SysOrganization> findAllTeam(String code);

    /**
     * 获得辖下的团队（小组）
     *
     * @return 辖下的团队（小组）
     */
    List<SysOrganization> findTeamByCode(String code);

    /**
     * 分页获取用户
     *
     * @param page 分页
     * @return 分页数据
     */
    Page<SysOrganization> findAll(Page<SysOrganization> page);

}
