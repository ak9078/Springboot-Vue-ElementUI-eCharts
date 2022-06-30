package com.roy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.mapper.PlatformAccountMapper;
import com.roy.entity.PlatformAccount;
import com.roy.service.PlatformAccountService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <pre>
 *     数据平台-后台用户业务逻辑实现类
 * </pre>
 *
 */
@Service
public class PlatformAccountServiceImpl implements PlatformAccountService {

    @Autowired(required = false)
    private PlatformAccountMapper platformAccountMapper;

    @Override
    public PlatformAccount findById(String accountId) {
        return platformAccountMapper.findById(accountId);
    }

    @Override
    public PlatformAccount findByCode(String accountCode) {
        PlatformAccount param = new PlatformAccount();
        param.setAccountCode(accountCode);
        return platformAccountMapper.selectOne(param);
    }

    @Override
    public Page<PlatformAccount> findAll(Page<PlatformAccount> page) {
        return page.setRecords(platformAccountMapper.findAll(page));
    }

}
