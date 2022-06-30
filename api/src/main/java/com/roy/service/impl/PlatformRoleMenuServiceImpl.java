package com.roy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.PlatformRoleMenu;
import com.roy.mapper.PlatformRoleMenuMapper;
import com.roy.service.PlatformRoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * <pre>
 *     数据平台-后台用户角色-菜单业务逻辑实现类
 * </pre>
 *
 */
@Service
public class PlatformRoleMenuServiceImpl implements PlatformRoleMenuService {

    @Autowired(required = false)
    private PlatformRoleMenuMapper platformRoleMenuMapper;

    @Override
    public List<PlatformRoleMenu> findByRoleIds(String roleIds) {
        return platformRoleMenuMapper.findByRoleIds(roleIds);
    }

    @Override
    public List<PlatformRoleMenu> listWithTree(String roleIds) {

        // 1.查询出所有的分类
        List<PlatformRoleMenu> entities = platformRoleMenuMapper.findByRoleIds(roleIds);

        // 2.组装成父子的树形结构
        List<PlatformRoleMenu> level1Menus = new ArrayList<>();
        // 找到所有的一级分类
        for (PlatformRoleMenu entity : entities) {
            if (entity.getPMenuId() == null || entity.getPMenuId().length() <= 0) {
                level1Menus.add(entity);
            }
        }

        for (PlatformRoleMenu level1Menu : level1Menus) {
            level1Menu.setChildren(getChildrens(level1Menu, entities));
        }
        //排序
        level1Menus.sort(new Comparator<PlatformRoleMenu>() {
            @Override
            public int compare(PlatformRoleMenu o1, PlatformRoleMenu o2) {
                return (o1.getSort() == null ? 0 : o1.getSort()) - (o2.getSort() == null ? 0 : o2.getSort());
            }
        });
        return level1Menus;
    }

    /**
     * 递归查找所有的下级分类
     * 在这一级别的分类中找下级分类
     *
     * @param root 当前级别的分类
     * @param all  全部分类
     * @return 下一级分类
     */
    private List<PlatformRoleMenu> getChildrens(PlatformRoleMenu root, List<PlatformRoleMenu> all) {
        List<PlatformRoleMenu> children = new ArrayList<>();
        for (PlatformRoleMenu a : all) {
            if (a.getPMenuId().equals(root.getMenuId())) {
                a.setChildren(getChildrens(a, all));
                children.add(a);
            }
        }
        children.sort(new Comparator<PlatformRoleMenu>() {
            @Override
            public int compare(PlatformRoleMenu o1, PlatformRoleMenu o2) {
                return (o1.getSort() == null ? 0 : o1.getSort()) - (o2.getSort() == null ? 0 : o2.getSort());
            }
        });
        return children;
    }

}
