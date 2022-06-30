package com.roy.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.SysAccount;


/**
 * <pre>
 *     业务平台-后台用户业务逻辑接口
 * </pre>
 *
 */
public interface SysAccountService {

    /**
     * 根据用户名获得用户
     *
     * @param accountCode 用户名
     * @return 用户
     */
    SysAccount findByCode(String accountCode);

    /**
     * 根据用户Id获得用户
     *
     * @param sysAccountId 用户Id
     * @return 用户
     */
    SysAccount findById(String sysAccountId);

    /**
     * 分页获取用户
     *
     * @param page 分页
     * @return 分页数据
     */
    Page<SysAccount> findAll(Page<SysAccount> page);

}
