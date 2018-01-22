package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.DeptName;
import com.stumesystem.bean.DeptStu;
import com.stumesystem.bean.Msg;
import com.stumesystem.service.DeptNameService;
import com.stumesystem.service.DeptStuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptStuController {

    @Autowired
    private DeptStuService deptStuService;



    /**
     * 获取所有部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/deptStus")
    public Msg DeptStus(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        PageHelper.startPage(pn, 5);
       List<DeptStu> lists= deptStuService.getDeptStus();
        PageInfo page = new PageInfo(lists, 5);
       return  Msg.success().add("pageInfo",page);
    }

    /**
     * 获取所有部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/deptStus2")
    public Msg DeptStus(){
        List<DeptStu> lists= deptStuService.getDeptStus();
        return  Msg.success().add("list",lists);
    }

    /**
     * 根据系部id获取所有部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg DeptStusByDeptName(@RequestParam("deptNameId") Integer deptNameId){
        if(deptNameId!=null){
            List<DeptStu> lists=deptStuService.getDeptStuByDeptId(deptNameId);
            return  Msg.success().add("list",lists);
        }
        return Msg.fail();
    }

    /**
     * 插入部门
     * @param deptStuName
     * @return
     */
    @ResponseBody
    @RequestMapping("/addDeptStu")
    public Msg insertDeptStu(@RequestParam("deptStuName")String deptStuName){
        DeptStu deptStu1=new DeptStu();
        deptStu1.setDeptStuName(deptStuName);
        if(deptStuService.getDeptStu(deptStuName)==null){
            deptStuService.insertDeptStu(deptStu1);
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 删除部门
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delDeptStu")
    public Msg deleteDeptName(@RequestParam("id") Integer id){
        if(id!=null){
            if(deptStuService.deleteDeptName(id)>0) {
                return Msg.success();
            }
            return Msg.fail();
        }
        return Msg.fail();
    }

    /**
     * 跳转到添加系部页面
     * @return
     */
    @RequestMapping("/addDeptStuNameJsp")
    public String toAddDeptName(){
        return "addDept";
    }

    /**
     * 跳转到分配部门页面
     * @return
     */
    @RequestMapping("/giveDeptStuJsp")
    public String toGiveDeptStu(){
        return "givedept";
    }
}
