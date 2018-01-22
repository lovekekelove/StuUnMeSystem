package com.stumesystem.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class AuthorityFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);
        try {
            if (session.getAttribute("userinfo") == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } finally {
            filterChain.doFilter(request, response);
        }
    }

    private static boolean ajaxDofilterSessionNull(HttpServletRequest request, HttpServletResponse response) {
        boolean isAjax = false;
        if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equals("XMLHttpRequest")) {
            // ajax请求
            response.setHeader("sessionstatus", "timeout");
            isAjax = true;
        }
        return isAjax;
    }

    public void destroy() {
    }
}
