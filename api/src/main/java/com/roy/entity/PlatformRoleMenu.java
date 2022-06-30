package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * <pre>
 *     用户角色菜单
 * </pre>
 *
 */
@Data
@TableName("t_platform_role_menu")
public class PlatformRoleMenu implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 角色ID
     */
    private String roleId;
    /**
     * 菜单ID
     */
    private String menuId;
    /**
     * 菜单名称
     */
    private String menuName;
    /**
     * 菜单编码
     */
    private String menuCode;
    /**
     * 上级菜单id
     */
    private String pMenuId;
    /**
     * 菜单层级
     */
    private String menuLevel;
    /**
     * 菜单URL
     */
    private String menuUrl;
    /**
     * 菜单图标
     */
    private String menuIcon;
    /**
     * 排序
     */
    private Integer sort;
    /**
     * 子级
     */
    private List Children;

}
