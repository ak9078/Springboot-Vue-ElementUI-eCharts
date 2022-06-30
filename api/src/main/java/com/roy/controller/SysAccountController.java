package com.roy.controller;

import com.roy.entity.SysAccount;
import com.roy.service.SysAccountService;
import com.roy.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Objects;

/**
 * @author roy
 * @date 2020-07-27
 */

@RestController
@RequestMapping("/api/sysAccount")
public class SysAccountController {

    @Autowired
    private SysAccountService sysAccountService;

    @PostMapping("/login")
    public Response login(@RequestParam("accountCode") String accountCode,
                          @RequestParam("accountPwd") String accountPwd,
                          HttpSession session) {
        SysAccount sysAccount = sysAccountService.findByCode(accountCode);
        if (sysAccount == null) {
            return Response.no("用户名不存在！");
        }
        if (!Objects.equals(sysAccount.getAccountPwd(), accountPwd)) {
            return Response.no("密码不正确！");
        }
        session.setAttribute("sysAccount", sysAccount);
        return Response.yes(sysAccount);
    }

    @GetMapping("/logout")
    public Response logout(HttpSession session) {
        session.removeAttribute("sysAccount");
        return Response.yes();
    }

    @GetMapping("/currentSysAccount")
    public Response login(HttpSession session) {
        SysAccount sysAccount = (SysAccount) session.getAttribute("sysAccount");
        if (sysAccount == null) {
            return Response.no("用户未登录");
        }
        return Response.yes(sysAccount);
    }

//    @PostMapping("/save")
//    public Response addUser(@RequestBody User sysAccount) {
//        try {
//            sysAccountService.saveByUser(sysAccount);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return Response.no();
//        }
//        return Response.yes();
//    }


}
