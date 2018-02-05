package com.stumesystem.interceptor;

import com.stumesystem.bean.StuUser;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by JackWangon[www.aiprogram.top] 2017/6/18.
 */
public class SessionInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        String uri = request.getRequestURI();
        if ((uri.indexOf("index") >= 0) || (uri.indexOf("login") >= 0) || (uri.indexOf("sendyzm") >= 0) || (uri.indexOf("intoalterpassword") >= 0) || (uri.indexOf("nicheng") >= 0) || (uri.indexOf("yEmail") >= 0) || (uri.indexOf("sendyzm2") >= 0) || (uri.indexOf("reg") >= 0)) {
            return true;
        }
        // StuUser user = (User) SecurityUtils.getSubject().getSession().getAttribute("userinfo");
        StuUser user = (StuUser) request.getSession().getAttribute("userinfo");
        if (user != null) {
            return true;
        }
        //转发到登录
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
