package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     组织成员
 * </pre>
 *
 */
@Data
@TableName("t_sys_organization_member")
public class SysOrganizationMember implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 机构id
     */
    private String orgId;
    /**
     * 成员id
     */
    private String userId;
    /**
     * 角色
     */
    private String roleState;
    /**
     * 删除状态 1：未删除 0：已删除
     */
    private String delState;
    /**
     * 用户账号
     */
    private String accountCode;
}
