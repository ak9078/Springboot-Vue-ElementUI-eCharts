package com.roy.Interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author roy
 * @date 2020-07-18
 */

@Component
public class SecurityInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        // 这里可以根据session的用户是否登录
        if (request.getSession().getAttribute("sysAccount") == null) {
            //response.sendRedirect("/admin/index.html/#/home");
            return false;
        }else{
            response.sendRedirect("/admin/index.html/#/salesData/salesDashboard");
        }
        return true;
    }
}
