package com.roy.controller;

import com.alibaba.fastjson.JSONObject;
import com.roy.entity.SysOrganizationMember;
import com.roy.service.SysOrganizationMemberService;
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
@RequestMapping("/api/sysOrganizationMember")
public class SysOrganizationMemberController {

    @Autowired
    private SysOrganizationMemberService sysOrganizationMemberService;

    @PostMapping("/findByOrgId")
    public Response findByOrgId(@RequestHeader("token") String token, @RequestBody JSONObject params) {
        if (Objects.equals(token, "null") || token == null || token.length() <= 0) {
            return Response.no("您还没有登录！");
        }
        List<SysOrganizationMember> sysOrganizationMember = sysOrganizationMemberService.findByOrgId(params.getString("orgId"));
        if (sysOrganizationMember == null) {
            return Response.no("没查到相应团队成员！");
        }
        return Response.yes(sysOrganizationMember);
    }

    @PostMapping("/findByOrgIds")
    public Response findByOrgIds(@RequestHeader("token") String token, @RequestBody JSONObject params) {
        if (Objects.equals(token, "null") || token == null || token.length() <= 0) {
            return Response.no("您还没有登录！");
        }
        List<SysOrganizationMember> sysOrganizationMember = sysOrganizationMemberService.findByOrgIds(params.getString("orgIds"));
        if (sysOrganizationMember == null) {
            return Response.no("没查到相应团队成员！");
        }
        return Response.yes(sysOrganizationMember);
    }

}
