package com.roy.controller;

import com.roy.entity.PlatformAccount;
import com.roy.entity.PlatformRole;
import com.roy.entity.PlatformRoleMenu;
import com.roy.service.PlatformAccountService;
import com.roy.service.PlatformRoleMenuService;
import com.roy.service.PlatformRoleService;
import com.roy.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Objects;

/**
 * @author roy
 * @date 2020-08-17
 */

@RestController
@RequestMapping("/api/platformAccount")
public class PlatformAccountController {

    @Autowired
    private PlatformAccountService platformAccountService;
    @Autowired
    private PlatformRoleService platformRoleService;
    @Autowired
    private PlatformRoleMenuService platformRoleMenuService;

    // 桥接 业务平台 和 数据平台
    @GetMapping("/bridging")
    public Response bridging(@RequestParam(value = "accountId", required = false) String accountId,
                             @RequestParam(value = "accountMd5", required = false) String accountMd5,
                             HttpSession session) {

        if (accountId == null || accountId.length() <= 0) {
            return Response.no("没收到用户名！");
        }

        if (!Objects.equals(DigestUtils.md5DigestAsHex(accountId.getBytes()), accountMd5)) {
            return Response.no("非法链接！");
        }

        PlatformAccount platformAccount = platformAccountService.findById(accountId);
        if (platformAccount == null) {
            return Response.no("用户名不存在！");
        }

        // 查询其角色
        String temp = platformAccount.getRoleId();
        temp = "'" + temp + "'";
        String roleIds = temp.replaceAll(",", "','");
        List<PlatformRole> platformRole = platformRoleService.findByIds(roleIds);
        platformAccount.setRoleList(platformRole);
        // 查询其角色对应的所有菜单
        //List<PlatformRoleMenu> platformRoleMenu = platformRoleMenuService.findByRoleIds(roleIds);
        List<PlatformRoleMenu> platformRoleMenu = platformRoleMenuService.listWithTree(roleIds);
        platformAccount.setRoleMenuList(platformRoleMenu);

        session.setAttribute("platformAccount", platformAccount);
        return Response.yes(platformAccount);
    }

    @GetMapping("/logout")
    public Response logout(HttpSession session) {
        session.removeAttribute("platformAccount");
        return Response.yes();
    }

}
