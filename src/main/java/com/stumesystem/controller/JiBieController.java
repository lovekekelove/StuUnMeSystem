package com.stumesystem.controller;

import com.stumesystem.bean.DeptName;
import com.stumesystem.bean.JiBie;
import com.stumesystem.bean.Msg;
import com.stumesystem.service.JiBieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class JiBieController {

    @Autowired
    private JiBieService jiBieService;

    /**
     * 获取所有年级信息
      * @return
     */
    @ResponseBody
    @RequestMapping("/jibies")
    public Msg getDeptNames(){
        //所有年级信息
        List<JiBie> list=jiBieService.getJiBies();
        return Msg.success().add("jibies",list);
    }

    /**
     * 添加年级
     * @param dengji
     * @return
     */
    @ResponseBody
    @RequestMapping("/addJiBie")
    public Msg DeptNames(@RequestParam("dengji")String dengji){
        JiBie jiBie=new JiBie();
        jiBie.setDengji(dengji);
        if(jiBieService.getJiBie(dengji)==null){
            jiBieService.insertJiBie(jiBie);
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 跳转到添加年级页面
     * @return
     */
    @RequestMapping("/addJibieJsp")
    public String toaddJiBie(){
        return "addJibie";
    }
}
