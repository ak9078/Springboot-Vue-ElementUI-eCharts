package com.roy.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.PlatformRoleMenu;

import java.util.List;


/**
 * <pre>
 *     数据平台-后台用户角色-菜单业务逻辑接口
 * </pre>
 *
 */
public interface PlatformRoleMenuService {

    /**
     * 根据用户权限Id获得其所有菜单
     *
     * @param roleIds 角色Id，多个以逗号分开
     * @return 用户角色List
     */
    List<PlatformRoleMenu> findByRoleIds(String roleIds);

    List<PlatformRoleMenu> listWithTree(String roleIds);

}
