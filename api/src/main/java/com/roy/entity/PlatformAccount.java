package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * <pre>
 *     用户信息
 * </pre>
 *
 */
@Data
@TableName("t_platform_account")
public class PlatformAccount implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 用户账号或手机号码
     */
    private String accountCode;
    /**
     * 角色ID 多角色以 逗号隔开
     */
    private String roleId;
    /**
     * 角色List
     */
    private List roleList;
    /**
     * 角色菜单List
     */
    private List roleMenuList;
}
