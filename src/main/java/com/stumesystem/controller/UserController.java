package com.stumesystem.controller;

import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuRight;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.UserService;
import com.stumesystem.util.DateUtil;
import com.stumesystem.util.MD5Util;
import com.stumesystem.util.MailUtil;
import com.stumesystem.util.RandomUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.*;
import java.security.NoSuchAlgorithmException;
import java.util.*;


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
     * 退出系统
     * @param session
     * @return
     */
    @RequestMapping("/logout2")
    public String logout2(HttpSession session){
        session.invalidate();
        return "redirect:/index.jsp";
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
        String imgHeah="/img/a1.jpg";
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
     * 忘记密码，修改密码
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
     * 登录后，修改密码
     * @param password
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @ResponseBody
    @RequestMapping("/updatePwd")
    public Msg changePwd(@RequestParam("password") String password,HttpServletRequest request) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        StuUser stuUser= (StuUser) request.getSession().getAttribute("userinfo");
        stuUser.setPassword(MD5Util.EncoderByMd5(password.trim()));
        if (password !=null){
            userService.updatePwd(stuUser);
            return Msg.success();
        }else {
            return Msg.fail();
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
//    private static Logger logger = LoggerFactory.getLogger(UserController.class);
    /**
     * 获取菜单栏
     * @param request
     * @return
     */
    @RequestMapping("/personCon")
    public String sendPerson(HttpServletRequest request){
        StuUser user= (StuUser) request.getSession(false).getAttribute("userinfo");
        List<StuRight> rights=new ArrayList<StuRight>();
        if(user!=null) {
            rights = userService.getRoseAndRightByUid(user.getId());
        }
        if(rights!=null){
            request.setAttribute("rights",rights);
            return "home";
        }
        return "index";
    }

    /**
     * 跳转修改页码
     * @return
     */
    @RequestMapping("/changeinfo")
    public String changeInfo(){
        return "changeInfo";
    }

    @RequestMapping("/changePwd")
    public String changePwd(){
        return "alertPwd";
    }

    @RequestMapping("/complInfo")
    public String complInfo(){
        return "complInfo";
    }

//    @ModelAttribute
//    public void getUser(@RequestParam(value="email",required=false) String email,
//                        Map<String, Object> map){
//
//        if(email != null){
//          StuUser stu= userService.getUser(email);
//            map.put("stu", stu);
//        }
//    }

    @ResponseBody
    @RequestMapping(value = "/alterInfo" ,method = RequestMethod.POST)
    public Msg alterinfo(@RequestParam("nickname") String nickname,
                         @RequestParam("name") String name,
                         @RequestParam("phone") String phone,
                         @RequestParam("age") Integer age,
                         @RequestParam(value = "sex") String sex,
                         @RequestParam(value = "brith") Date brith,
                         @RequestParam(value = "imgHeah") String imgHeah,
                         @RequestParam("flag") int type,
                         @RequestParam(value = "docuAddress") String docuAddress,
                         HttpServletRequest request) throws UnsupportedEncodingException, NoSuchAlgorithmException {
      StuUser user = (StuUser) request.getSession(false).getAttribute("userinfo");
      StuUser stu=userService.getUser(user.getEmail());
      stu.setBrith(brith);
      stu.setSex(sex);
      stu.setAge(age);
      stu.setPhone(phone);
      stu.setDocuAddress(docuAddress);
      stu.setNickname(nickname);
      stu.setName(name);

        int flag = 0;
        if (type== 0) {    //不改头像
            if(userService.updatePwd(stu)) {
                flag=1;
            }
        } else if (type == 1) {  //改头像
            String dbpath = uploadheadimg(imgHeah, user, request);
            if (dbpath == null) {
                flag = 0;
            } else {
                stu.setImgHeah("/img/"+dbpath);
                if(userService.updatePwd(stu)) {
                    flag=1;
                }
            }
        }

        if (flag == 1) {
            request.getSession().removeAttribute("userinfo");
            request.getSession().setAttribute("userinfo",stu);
            return Msg.success();
        } else {
            return Msg.fail();
        }

    }

    private String uploadheadimg(String data, StuUser user, HttpServletRequest request) {
        String imgdata = data.split(",")[1];
        BASE64Decoder base64Decoder = new BASE64Decoder();
        String path = user.getId() + DateUtil.toDay_Format(new Date()) + ".jpg";
        String filepath = request.getServletContext().getRealPath("/") + "img" + File.separator + path;//项目地址
        System.out.println(filepath);
        File file = new File(filepath);
        try {
            byte[] decoderbyte = base64Decoder.decodeBuffer(imgdata);
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(decoderbyte);
            fos.close();
            return path;
        } catch (IOException e) {
            System.out.println("上传失败" + e.getMessage());
        }
        return null;
    }
}
