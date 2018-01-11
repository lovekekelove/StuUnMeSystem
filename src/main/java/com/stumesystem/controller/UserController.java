package com.stumesystem.controller;

import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.UserService;
import com.stumesystem.util.MD5Util;
import com.stumesystem.util.MD5Utils;
import com.stumesystem.util.MailUtil;
import com.stumesystem.util.RandomUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
                if("1".equals(user.getState())){
                    request.getSession().setAttribute("userinfo",user);
                    return Msg.success();
                }else{
                    return Msg.fail().add("errors","未通过审核！");
                }

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
     * 用户注册
     * @param stu
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/reg",method = RequestMethod.POST)
    @ResponseBody
   public Msg registerUser(@Valid StuUser stu, HttpServletRequest request ,BindingResult result) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String imgHeah="img/a1.jpg";
        stu.setImgHeah(imgHeah);
        stu.setState("2");
        stu.setPassword(MD5Util.EncoderByMd5(stu.getPassword()));
        String  yanzhenma=String.valueOf(request.getSession().getServletContext().getAttribute(stu.getEmail()));

        if(result.hasErrors()){
            Map<String,Object> map=new HashMap<String,Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError:fieldErrors) {
                System.out.println("错误字段名："+fieldError.getField());
                System.out.println("错误字信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
              return Msg.fail().add("errorFileds",map);
        }else if(stu.getYzm().equals(yanzhenma)){
                if(userService.getUser(stu.getEmail())!=null){
                    return Msg.fail().add("errors","email");
            }

            if(userService.getUserYZniC(stu.getNickname())!=null){
                return Msg.fail().add("errors","niname");
            }
            if(userService.regUser(stu)){
                return Msg.success();
            }
        }
            return Msg.fail().add("errors", "error");
    }

    /**
     * 验证昵称是否存在
     * @param nickname
     * @return
     */
    @ResponseBody
    @RequestMapping("/nicheng")
    public Msg yzNiChen(@RequestParam("nickname") String nickname){
        if (userService.getUserYZniC(nickname)==null){
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 验证邮箱是否存在
     * @param email
     * @return
     */
    @ResponseBody
    @RequestMapping("/yemail")
    public Msg yzEmail(@RequestParam("email") String email){
        if (userService.getUser(email)==null){
            return Msg.success();
        }
        return Msg.fail();
    }


    /**
     * 获取验证码
     * @param request
     */
    @ResponseBody
    @RequestMapping("/sendyzm")
    public Msg sendyzm(HttpServletRequest request) {
        String email = request.getParameter("email");
        String uemail = email.trim();
//        String regx="(^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$)";
        if (userService.getUser(email)==null){
            return Msg.fail().add("va_msg","用户不存在！");
        }
        MailUtil mailUtil = new MailUtil();
        String yzm = RandomUtil.getyzm(6);
        String content = "您的验证码为：" + yzm + "(请在60s内完成验证)--修改密码" +
                "请勿告诉他人！";
        mailUtil.sendSimpleMail(uemail, "成功学院学生会", content.trim());
        //存放到application,当验证完清除
        request.getSession().getServletContext().setAttribute(uemail, yzm);
        return Msg.success();
    }

    /**
     * 获取验证码
     * @param request
     */
    @ResponseBody
    @RequestMapping("/sendyzm2")
    public Msg sendzceyzm(HttpServletRequest request) {
        String email = request.getParameter("email");
        String uemail = email.trim();
//        String regx="(^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$)";
        if (userService.getUser(email)!=null){
            return Msg.fail().add("va_msg","用户已存在！");
        }
        MailUtil mailUtil = new MailUtil();
        String yzm = RandomUtil.getyzm(6);
        String content = "您的验证码为：" + yzm + "(请在60s内完成验证)--注册信息" +
                "请勿告诉他人！";
        mailUtil.sendSimpleMail(uemail, "成功学院学生会", content.trim());
        //存放到application,当验证完清除
        request.getSession().getServletContext().setAttribute(uemail, yzm);
        return Msg.success();
    }

    /**
     * 需改密码
     * @param email
     * @param password
     * @param yzm
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @ResponseBody
    @RequestMapping("/intoalterpassword")
    public Msg changePWD(@RequestParam("email") String email,
                         @RequestParam("password") String password,
                         @RequestParam("yzm") String yzm,
                         HttpServletRequest request) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        StuUser stuUser=new StuUser();
        stuUser.setEmail(email);
        stuUser.setPassword(MD5Util.EncoderByMd5(password.trim()));
         String  yanzhenma=String.valueOf(request.getSession().getServletContext().getAttribute(stuUser.getEmail()));
         if (yzm.equals(yanzhenma)){
             userService.updatePwd(stuUser);
             return Msg.success();
         }else {
             return Msg.fail().add("erroryzm","验证码错误！");
         }
    }

    /**
     * 清除验证码
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkoutyzm")
    public  Msg checkOutYZM(HttpServletRequest request){
        String email = request.getParameter("email");
        String uemail = email.trim();
        request.getSession().getServletContext().removeAttribute(uemail);
        return Msg.success();
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
