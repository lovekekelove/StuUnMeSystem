package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.*;
import com.stumesystem.service.*;
import com.stumesystem.util.DateUtil;
import com.stumesystem.util.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class NaXinController {

    @Autowired
    private NaXinService naXinService;

    @Autowired
    private PointMsgService pointMsgService;

    @Autowired
    private UserService userService;

    @Autowired
    private DeptService deptService;

    @Autowired
    private StuRoseService stuRoseService;


    @RequestMapping("/naXinJSP")
    public String toNaXin() {
        return "naxin";
    }

    @RequestMapping("/stuNaXinJsp")
    public String stuNaXinJsp() {
        return "stunaxin";
    }

    @RequestMapping("/naXinManager")
    public String tonaxinmanager() {
        return "naxinmanager";
    }


    /**
     * 人员纳新
     *
     * @param naXin
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/naXingPeoPle")
    public Msg ComplInfo(NaXin naXin, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        naXin.setId(stuUser.getId());
        naXin.setState(3);//等待面试
        if (naXinService.getNaXinByUId(stuUser.getId()) != null) {
            return Msg.fail().add("error", 500);
        }
        String imgPath = uploadheadimg(naXin.getPicture(), naXin, request);
        naXin.setPicture("/img/" + imgPath);
        if (naXinService.insertNaXin(naXin) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    private String uploadheadimg(String data, NaXin naXin, HttpServletRequest request) {
        String imgdata = data.split(",")[1];
        BASE64Decoder base64Decoder = new BASE64Decoder();
        String path = naXin.getId() + DateUtil.toDay_Format(new Date()) + ".jpg";
        String filepath = request.getServletContext().getRealPath("/") + "img" + File.separator + path;//项目地址
        System.out.println(filepath);
        File file = new File(filepath);
        try {
            System.out.println(path);
            byte[] decoderbytes = base64Decoder.decodeBuffer(imgdata);
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(decoderbytes);
            fos.close();
            return path;
        } catch (IOException e) {
            System.out.println("上传失败" + e.getMessage());
        }
        return null;
    }

    /**
     * 纳新列表
     *
     * @param naXin
     * @return
     */
    @ResponseBody
    @RequestMapping("/naxingmanager")
    public Msg getNaXin(NaXin naXin) {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("deptId", naXin.getdId());
        map.put("deptNameId", naXin.getDeptId());
        map.put("classId", naXin.getClassId());
        map.put("jiId", naXin.getJiId());
        PageHelper.startPage(naXin.getPn(), 5);
        List<NaXin> lists = naXinService.getNaXinAll(map);
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 纳新列表
     *
     * @param naXin
     * @return
     */
    @ResponseBody
    @RequestMapping("/stunaxingmanager")
    public Msg getstuNaXin(NaXin naXin) {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("deptId", naXin.getdId());
        map.put("deptNameId", naXin.getDeptId());
        map.put("classId", naXin.getClassId());
        map.put("jiId", naXin.getJiId());
        map.put("state", naXin.getState());
        PageHelper.startPage(naXin.getPn(), 5);
        List<NaXin> lists = naXinService.getNaXinAllEnd(map);
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 发送任务通知
     *
     * @param count
     * @param name
     * @return
     */
    @ResponseBody
    @RequestMapping("/sendMsg")
    public Msg sendMsg(@RequestParam("count") String count, @RequestParam("name") String name, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        StuUser accUser = userService.selectStuUser(name);
        PointMsg pointMsg = new PointMsg();
        pointMsg.setMsgCount(count);
        pointMsg.setSendUid(stuUser.getId());
        pointMsg.setAcceptUid(accUser.getId());
        pointMsg.setState("4");
        pointMsg.setSendTime(new Date());
        if (pointMsgService.insertPointMsg(pointMsg) > 0) {
            MailUtil mailUtil = new MailUtil();
            mailUtil.sendSimpleMail(accUser.getEmail(), "成功学院学生会", count);
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 删除纳新人员
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delNaXin")
    public Msg deleteDeptName(@RequestParam("id") Integer id) {
        if (naXinService.deleteNaXin(id) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 审核通过纳新人员
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateNaXin")
    public Msg updateNaXin(@RequestParam("id") Integer id) {
        NaXin naXin = naXinService.getNaXinById(id);
        StuUser accUser = userService.getUser(naXin.getId());
        naXin.setState(1);
        if (naXinService.updateNaXin(naXin) > 0) {
            Dept dept = new Dept();
            dept.setUid(naXin.getId());
            dept.setClassId(naXin.getClassId());
            dept.setdId(naXin.getdId());
            dept.setDeptId(naXin.getDeptId());
            dept.setJiid(naXin.getJiId());
            dept.setStuId(naXin.getStuId().toString());
            dept.setPolitical(naXin.getPolitical());
            deptService.insertDept(dept);
            stuRoseService.updateRose(4, naXin.getId());
            NaXin naXin1 = naXinService.getNaXinByIdWithName(id);
            String count = "恭喜你 " + naXin1.getName() + "，成为 " + naXin1.getDeptName() + "--" + naXin1.getDeptStuName() + "的一员！";
            MailUtil mailUtil = new MailUtil();
            mailUtil.sendSimpleMail(accUser.getEmail(), "成功学院学生会", count);
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 审核不通过纳新人员
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateNoNaXin")
    public Msg updateNoNaXin(@RequestParam("id") Integer id) {
        NaXin naXin = naXinService.getNaXinById(id);
        StuUser accUser = userService.getUser(naXin.getId());
        naXin.setState(2);
        if (naXinService.updateNaXin(naXin) > 0) {
            NaXin naXin1 = naXinService.getNaXinByIdWithName(id);
            String count = "非常抱歉 " + naXin1.getName() + "你不能成为 " + naXin1.getDeptName() + "--" + naXin1.getDeptStuName() + "的一员！,加入其他社团也会使你得到锻炼！";
            MailUtil mailUtil = new MailUtil();
            mailUtil.sendSimpleMail(accUser.getEmail(), "成功学院学生会", count);
            return Msg.success();
        }
        return Msg.fail();
    }

}
