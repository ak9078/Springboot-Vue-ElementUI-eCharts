package com.roy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.roy.mapper.SysAccountMapper;
import com.roy.entity.SysAccount;
import com.roy.service.SysAccountService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <pre>
 *     业务平台-后台用户业务逻辑实现类
 * </pre>
 *
 */
@Service
public class SysAccountServiceImpl implements SysAccountService {

    @Autowired(required = false)
    private SysAccountMapper sysAccountMapper;

    @Override
    public SysAccount findById(String sysAccountId) {
        return sysAccountMapper.selectById(sysAccountId);
    }

    @Override
    public SysAccount findByCode(String accountCode) {
        SysAccount param = new SysAccount();
        param.setAccountCode(accountCode);
        return sysAccountMapper.selectOne(param);
    }

    @Override
    public Page<SysAccount> findAll(Page<SysAccount> page) {
        return page.setRecords(sysAccountMapper.findAll(page));
    }

}
