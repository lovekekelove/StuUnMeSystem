package com.stumesystem.controller;

import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.UserService;
import com.stumesystem.util.MD5Util;
import com.stumesystem.util.MailUtil;
import com.stumesystem.util.RandomUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("user")
@Controller
public class UserController {

    @Autowired
    private UserService userService;


    /**
     * 用户登录
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    public Msg checkLogin(HttpServletRequest request)
            throws UnsupportedEncodingException, NoSuchAlgorithmException {
         String email=request.getParameter("email");
         String pwd=request.getParameter("password");
        //查数据库 如果查到数据  调用MD5加密对比密码
        StuUser user = userService.getUser(email);
        if(user!=null){
            if(MD5Util.checkPassword(pwd,user.getPassword())){
               //校验成功  设置session
               request.getSession().setAttribute("userinfo",user);
               return Msg.success();
           }else{
               // 校验失败  返回校验失败signal
                return Msg.fail().add("errors","密码错误");
           }
        }else {
            // 校验失败  返回校验失败signal
            return Msg.notFind().add("errors","用户不存在！");
        }
    }

    /**
     * 退出系统
     * @param session
     * @return
     */
    @RequestMapping("/logout")
    @ResponseBody
    public Msg logout(HttpSession session){
        session.invalidate();
        return Msg.success();
    }

    /**
     * 修改密码验证码
     * @param request
     */
    @RequestMapping("/sendyzm")
    public void sendyzm(HttpServletRequest request) {
        String email = request.getParameter("email");
        String uemail = email.trim();
        MailUtil mailUtil = new MailUtil();
        String yzm = RandomUtil.getyzm(4);
        String content = "您的验证码为：" + yzm + "(不区分大小写)--修改密码<br/>" +
                "请勿告诉他人！";
        mailUtil.sendSimpleMail(uemail, "仗剑论坛-SwordForum", content.trim());
        //存放到application,当验证完清除
        request.getSession().getServletContext().setAttribute(uemail, yzm);
    }

    /**
     * 验证码
     * @param email
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/sendyzm3")
    public void sendyzm3(@RequestParam("email") String email,
                         HttpServletRequest request,
                         HttpServletResponse response) throws IOException {
        /*账号是否存在*/
        StuUser user = userService.getUser(email);
        PrintWriter pw = null;
        if (user==null) {
            pw = response.getWriter();
            pw.write("has_email");//账号不存在
            pw.close();
        } else {
            MailUtil mailUtil = new MailUtil();
            String yzm = RandomUtil.getyzm(6);
            mailUtil.sendSimpleMail(email, "成功学院学生会",
                    "<h2>您的验证码为：</h2><font color='blue'>" + yzm + "</font>(不区分大小写)---修改密码<br/>");
            request.getSession().getServletContext().setAttribute(email, yzm);
        }
    }
}
