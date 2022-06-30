package com.roy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.roy.entity.PlatformAccount;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PlatformAccountMapper extends BaseMapper<PlatformAccount> {

    PlatformAccount findById(String accountId);

    PlatformAccount findByCode(String accountCode);

    List<PlatformAccount> findAll(Pagination pagination);
}

