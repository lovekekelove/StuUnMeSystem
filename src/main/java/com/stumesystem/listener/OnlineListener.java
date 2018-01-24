package com.stumesystem.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * 项目启动容器会自己生成session,这里有三个一开始就生成.估计是个环境框架等有关
 */
public class OnlineListener implements HttpSessionListener {
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
//        HttpSession session=httpSessionEvent.getSession();
//        if(session.getAttribute("user")!=null){
//            Online.add();
//            System.out.println("用户+1");
//        }
//        System.out.println("session创建");
    }

    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        if (session.getAttribute("user") != null) {
            Online.delete();
            System.out.println("==SESSION 失效 ：user在线退出减一===");
        }
        System.out.println("session销毁==减1==");
    }

}
