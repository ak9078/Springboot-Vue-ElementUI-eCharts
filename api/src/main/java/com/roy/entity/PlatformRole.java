package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     用户角色
 * </pre>
 *
 */
@Data
@TableName("t_platform_role")
public class PlatformRole implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 角色名称
     */
    private String roleName;
    /**
     * 角色编码
     */
    private String roleCode;
    /**
     * 角色状态 1：启用 0：禁用
     */
    private String roleState;
    /**
     * 角色说明
     */
    private String roleDesc;
    /**
     * 删除状态1：未删除 0：已删除
     */
    private String delState;
}
