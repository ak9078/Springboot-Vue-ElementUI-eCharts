package com.roy.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * <pre>
 *     用户信息
 * </pre>
 *
 */
@Data
@TableName("t_sys_account")
public class SysAccount implements Serializable {

    private static final long serialVersionUID = -5144055068797033748L;
    /**
     * ID
     */
    @TableId(type = IdType.UUID)
    private String id;
    /**
     * 用户账号
     */
    private String accountCode;
    /**
     * 手机号码
     */
    private String mobilePhone;
    /**
     * 用户邮箱
     */
    private String email;
    /**
     * 账号密码
     */
    private String accountPwd;
    /**
     * 昵称
     */
    private String nickName;
    /**
     * 用户头像url
     */
    private String userHeadImg;
    /**
     * 用户类型 1：前台用户 2：后台用户
     */
    private String accountType;
    /**
     * 工号，只针对后台用户
     */
    private String workNumber;
    /**
     * 注册时间
     */
    private Timestamp registerTime;
    /**
     * 注册IP
     */
    private String registerIp;
    /**
     * 注册来源
     */
    private String registerSource;
    /**
     * 最后登陆时间
     */
    private Timestamp lastLoginTime;
    /**
     * 最后登陆IP
     */
    private String lastLoginIp;
    /**
     * 登陆次数
     */
    private String loginCount;
    /**
     * 角色ID 多角色以 逗号隔开
     */
    private String roleId;
    /**
     * 在线状态 1：在线 0：离线
     */
    private String onlieState;
    /**
     * 账号状态 1：启用 2：禁用 3：注销
     */
    private String accountState;
    /**
     * 删除状态 1:未删除 0：已删除
     */
    private String delState;
    /**
     * 是否已个人实名认证 1：是  0:否
     */
    private String personalAuthFlag;
    /**
     * 是否已企业认证 1：是 0：否
     */
    private String companyAuthFlag;
    /**
     * 是否绑定银行卡 1：是 0：否
     */
    private String bindCardFlag;
    /**
     * 是否绑定支付宝 1：是 0：否
     */
    private String bindAlipaynoFlag;
    /**
     * 是否绑定微信 1：是 0：否
     */
    private String bindWxnoFlag;
    /**
     * 分享码
     */
    private String shareCode;
    /**
     * 是否禁止：0.正常；1.禁止
     */
    private String forbidCodeFlag;
    /**
     * 创建者
     */
    private String createUser;
    /**
     * 创建时间
     */
    private Timestamp createTime;
    /**
     * 最后编辑者
     */
    private String lastEditUser;
    /**
     * 最后编辑时间
     */
    //@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
    private Timestamp lastEditTime;
    /**
     * 账号绑定时间
     */
    private Timestamp accountCodeBindTime;


}
