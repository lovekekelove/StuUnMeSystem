package com.stumesystem.controller;

import com.stumesystem.bean.Dept;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.NaXin;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.NaXinService;
import com.stumesystem.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

@Controller
public class NaXinController {

    @Autowired
    private NaXinService naXinService;


    @RequestMapping("/naXinJSP")
    public String toNaXin() {
        return "naxin";
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
        naXin.setuId(stuUser.getId());
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
        String path = naXin.getuId() + DateUtil.toDay_Format(new Date()) + ".jpg";
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

}
