package com.roy.controller;

import com.alibaba.fastjson.JSONObject;
import com.roy.entity.SysOrganization;
import com.roy.service.SysOrganizationService;
import com.roy.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

/**
 * @author roy
 * @date 2020-08-27
 */

@RestController
@RequestMapping("/api/sysOrganization")
public class SysOrganizationController {

    @Autowired
    private SysOrganizationService sysOrganizationService;

    @PostMapping("/allTeam")
    public Response allTeam(@RequestHeader("token") String token, @RequestBody JSONObject params) {
        if(Objects.equals(token, "null") || token == null || token.length() <= 0){
            return Response.no("您还没有登录！");
        }
        List<SysOrganization> sysOrganization = null;
        if (Objects.equals(token, "CG")) {
            // 超级管理员
            String code = params.getString("code");
            sysOrganization = sysOrganizationService.findAllTeam(code);
        }else{
            // 其他主管
            sysOrganization = sysOrganizationService.findTeamByCode(token);
        }

        if (sysOrganization == null) {
            return Response.no("没查到相应团队（小组）！");
        }

        return Response.yes(sysOrganization);
    }

}
