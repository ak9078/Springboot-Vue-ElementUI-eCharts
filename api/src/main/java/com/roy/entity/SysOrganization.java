package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *     组织信息
 * </pre>
 *
 */
@Data
@TableName("t_sys_organization")
public class SysOrganization implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 机构编码
     */
    private String code;
    /**
     * 机构名称
     */
    private String name;
    /**
     * 上级机构id
     */
    private String pid;
    /**
     * 机构类型
     */
    private String type;
    /**
     * 删除状态 1：未删除 0：已删除
     */
    private String delState;
}
