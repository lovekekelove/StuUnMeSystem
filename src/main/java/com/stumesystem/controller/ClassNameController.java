package com.stumesystem.controller;

import com.stumesystem.bean.ClassName;
import com.stumesystem.bean.Msg;
import com.stumesystem.service.ClassNameService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ClassNameController {

    @Autowired
    private ClassNameService classNameService;


    /**
     * 跳转页面
     * @return
     */
    @RequestMapping("/addClassNameJsp")
    public String toaddClassName(){
        return "addClass";
    }

    /**
     * 添加年级
     * @param className
     * @return
     */
    @ResponseBody
    @RequestMapping("/addClass")
    public Msg insertClassName(@RequestParam("className") String className,
                               @RequestParam("deptNameId") Integer deptNameId,
                               @RequestParam("jiid") Integer jiid){
        ClassName className1=new ClassName();
        className1.setClassName(className);
        className1.setDeptNameId(deptNameId);
        className1.setJiid(jiid);
        if(classNameService.getClassName(className1)==null){
             if(classNameService.insertClassName(className1)>0){
                 return Msg.success();
             }
            return Msg.fail();
        }
        return Msg.notFind();
    }

}
