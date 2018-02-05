package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.*;
import com.stumesystem.listener.Online;
import com.stumesystem.service.DeptService;
import com.stumesystem.service.PointMsgService;
import com.stumesystem.service.StuRoseService;
import com.stumesystem.service.UserService;
import com.stumesystem.util.DateUtil;
import com.stumesystem.util.MD5Util;
import com.stumesystem.util.MailUtil;
import com.stumesystem.util.RandomUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.misc.BASE64Decoder;

import javax.servlet.ServletContext;
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

    @Autowired
    private DeptService deptService;

    @Autowired
    private StuRoseService stuRoseService;

    @Autowired
    private PointMsgService pointMsgService;


    /**
     * 用户登录
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    public Msg checkLogin(HttpServletRequest request)
            throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String email = request.getParameter("email");
        String pwd = request.getParameter("password");
        String ip = request.getRemoteHost();
        //查数据库 如果查到数据  调用MD5加密对比密码
        StuUser user = userService.getUser(email);
        if (user != null) {
            if (MD5Util.checkPassword(pwd, user.getPassword())) {
                //校验成功  设置session
                if ("1".equals(user.getState())) {
                    Dept dept = deptService.getDeptWith(user.getId());
                    if (dept != null) {
                        request.getSession().setAttribute("dept", dept);
                    }

                    boolean flag = true;
                    ServletContext application = (ServletContext) request.getSession().getServletContext();


                    StuUser usr = (StuUser) application.getAttribute("user");
                    if (null != usr && usr.getName().equals(user.getName())) {//login repeatly!
                        flag = false;
                    }


                    if (flag) {
                        Online.add();
                        HttpSession session = request.getSession();
                        session.setAttribute("userinfo", user);
                        request.getServletContext().setAttribute("user", user);
                        return Msg.success();
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("userinfo", user);
                        return Msg.success();
                    }
                } else {
                    return Msg.fail().add("errors", "未通过审核！");
                }

            } else {
                // 校验失败  返回校验失败signal
                return Msg.fail().add("errors", "密码错误");
            }
        } else {
            // 校验失败  返回校验失败signal
            return Msg.notFind().add("errors", "用户不存在！");
        }
    }


    /**
     * 退出系统
     * @param request
     * @return
     */
    @RequestMapping("/logout")
    @ResponseBody
    public Msg logout(HttpServletRequest request) {
        request.getSession().invalidate();
        request.getServletContext().removeAttribute("user");
        Online.delete();
        return Msg.success();
    }

    /**
     * 退出系统
     * @param request
     * @return
     */
    @RequestMapping("/logout2")
    public String logout2(HttpServletRequest request) {
        request.getSession().invalidate();
        request.getServletContext().removeAttribute("user");
        Online.delete();
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
    @RequestMapping("/yEmail")
    public Msg yzEmail(@RequestParam("email") String email){
        if (userService.getUser(email)==null){
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 用户管理
     *
     * @param pn
     * @param name
     * @return
     */
    @ResponseBody
    @RequestMapping("/userManagers")
    public Msg getLeaveMsg(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                           @RequestParam(value = "name") String name) {
        PageHelper.startPage(pn, 5);
        List<StuUser> lists = userService.getStuUserByName(name);
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
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
            return "home";
    }

    /**
     * 提示
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/pointMsg")
    public Msg pointMsg(HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        int num = pointMsgService.getNum(stuUser.getId());
        List<PointMsg> pointMsgs = pointMsgService.getPointMsg(stuUser.getId());
        return Msg.success().add("pointMsgs", pointMsgs).add("num", num);
    }

    @RequestMapping("/welcome")
    public String welcome(HttpServletRequest request) {
        request.setAttribute("PersonCount", Online.getCount());
        return "welcome";
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

    /**
     * 修改资料
     *
     * @param nickname
     * @param name
     * @param phone
     * @param age
     * @param sex
     * @param brith
     * @param imgHeah
     * @param type
     * @param docuAddress
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
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

    /**
     * 删除用户
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delUser")
    public Msg deleteDeptName(@RequestParam("id") Integer id, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");

        if (id == stuUser.getId()) {
            return Msg.fail().add("error", 1);
        }


        if (id != null) {
            if (userService.deleteUser(id) > 0) {
                return Msg.success();
            }
        }
        return Msg.fail();
    }

    /**
     * 批量删除
     *
     * @param ids
     * @return
     */

    @ResponseBody
    @RequestMapping(value = "/deleteUsers/{ids}")
    public Msg deleteUser(@PathVariable(value = "ids") String ids, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        //批量删除
        if (ids.contains("-")) {
            String[] str_ids = ids.split("-");
            for (String id : str_ids) {
                if (Integer.parseInt(id) == stuUser.getId()) {
                    continue;
                }
                userService.deleteUser(Integer.parseInt(id));
            }

        } else {


            //单个删除
            Integer id = Integer.parseInt(ids);

            if (id == stuUser.getId()) {
                return Msg.fail().add("error", 1);
            }

            userService.deleteUser(id);
        }
        return Msg.success();
    }

    /**
     * 审核
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateUser")
    public Msg updateDeptName(@RequestParam("id") Integer id) {
        if (id != null) {
            StuUser stuUser = userService.getUser(id);
            stuUser.setState("1");
            if (userService.updateStu(stuUser) > 0) {
                return Msg.success();
            }
        }
        return Msg.fail();
    }

    /**
     * 显示角色
     *
     * @param id
     * @param request
     * @return
     */
    @RequestMapping("/checkRose")
    public String toCheckRose(@RequestParam("id") Integer id, HttpServletRequest request) {
        StuUser stuUser = userService.getUser(id);
        request.setAttribute("user", stuUser);
        List<StuRose> stuRoses = stuRoseService.getRose();
        request.setAttribute("roses", stuRoses);
        return "checkRose";
    }

    @RequestMapping("/stuInfo")
    public String toLookPersonInfo(@RequestParam("id") Integer id, HttpServletRequest request) {
        StuUser stuUser = userService.getUser(id);
        request.setAttribute("userInfo", stuUser);
        Dept dept = deptService.getDeptWith(id);
        request.setAttribute("deptInfo", dept);
        return "lookPersonInfo";
    }

    /**
     * 跳转修改页码
     *
     * @return
     */
    @RequestMapping("/changeinfo")
    public String changeInfo() {
        return "changeInfo";
    }

    @RequestMapping("/changePwd")
    public String changePwd() {
        return "alertPwd";
    }

    @RequestMapping("/complInfo")
    public String complInfo() {
        return "complInfo";
    }

    @RequestMapping("/personInfo")
    public String personInfo() {
        return "myplace";
    }

    @RequestMapping("/UserManeger")
    public String UserManeger() {
        return "stuManager";
    }
}
