package com.roy.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.entity.PlatformAccount;


/**
 * <pre>
 *     数据平台-后台用户业务逻辑接口
 * </pre>
 *
 */
public interface PlatformAccountService {

    /**
     * 根据用户Id获得用户
     *
     * @param accountId 用户Id
     * @return 用户
     */
    PlatformAccount findById(String accountId);

    /**
     * 根据用户名获得用户
     *
     * @param accountCode 用户名
     * @return 用户
     */
    PlatformAccount findByCode(String accountCode);

    /**
     * 分页获取用户
     *
     * @param page 分页
     * @return 分页数据
     */
    Page<PlatformAccount> findAll(Page<PlatformAccount> page);

}
