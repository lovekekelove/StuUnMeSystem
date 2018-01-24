package com.stumesystem.controller;

import com.stumesystem.bean.Dept;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    @ResponseBody
    @RequestMapping("/compl")
    public Msg ComplInfo(Dept dept, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        dept.setUid(stuUser.getId());
        if (deptService.getDept(stuUser.getId()) == null) {
            if (dept != null) {
                deptService.insertDept(dept);
                return Msg.success();
            }
        } else {
            if (dept != null) {
                dept.setId(deptService.getDept(stuUser.getId()).getId());
                deptService.updateDept(dept);
                return Msg.success();
            }
        }
        return Msg.fail();
    }

}
