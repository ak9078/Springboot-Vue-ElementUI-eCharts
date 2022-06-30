package com.roy.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.PlatformRole;

import java.util.List;


/**
 * <pre>
 *     数据平台-后台用户角色业务逻辑接口
 * </pre>
 *
 */
public interface PlatformRoleService {

    /**
     * 根据用户Id获得用户角色
     *
     * @param roleId 角色Id
     * @return 用户角色
     */
    PlatformRole findById(String roleId);

    /**
     * 根据用户Id获得用户角色
     *
     * @param roleIds 角色Id，多个以逗号分开
     * @return 用户角色List
     */
    List<PlatformRole> findByIds(String roleIds);

    /**
     * 根据用户名获得用户角色
     *
     * @param roleCode 角色编码
     * @return 用户角色
     */
    PlatformRole findByCode(String roleCode);

    /**
     * 分页获取用户角色
     *
     * @param page 分页
     * @return 分页数据
     */
    Page<PlatformRole> findAll(Page<PlatformRole> page);

}
