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
public class DeptNameController {

    @Autowired
    private DeptNameService deptNameService;

    @Autowired
    private DeptStuService deptStuService;

    /**
     * 给系部分配部门
     * @param deptNameId
     * @param deptStuId
     * @return
     */
    @ResponseBody
    @RequestMapping("/giveDeptStu")
    public Msg giveDeptStu(@RequestParam("deptNameId") Integer deptNameId,
                           @RequestParam("deptStuId") Integer deptStuId){

            DeptStu deptStu=deptStuService.getDeptStuKey(deptStuId);
            DeptName deptName=deptNameService.getDeptName(deptNameId);
            List<DeptName>  depts=deptNameService.getDeptNameByDeptStuName(deptStu.getDeptStuName());
        if (depts.size() > 0) {
            for (DeptName d : depts) {
                if (d.getDeptname() == null || (!d.getDeptname().equals(deptName.getDeptname()))) {
                    deptNameService.insertDeptAndDeptStu(deptNameId, deptStuId);
                    return Msg.success();
                }
            }
        } else {
            if (deptNameId != null && deptStuId != null) {
                deptNameService.insertDeptAndDeptStu(deptNameId, deptStuId);
                return Msg.success();
            }
        }
        return Msg.fail();
    }

    /**
     * 获取分页
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping("/deptNames")
    public Msg getDeptNames(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        PageHelper.startPage(pn, 5);
        List<DeptName> lists=deptNameService.getDeptNames();
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo",page);
    }



    /**
     * 获取所有系部信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/deptNames2")
    public Msg getDeptNames(){
        List<DeptName> lists=deptNameService.getDeptNames();
        return Msg.success().add("deptNames",lists);
    }

    /**
     * 插入系部
     * @param deptName
     * @return
     */
    @ResponseBody
    @RequestMapping("/addDeptName")
    public Msg DeptNames(@RequestParam("deptName")String deptName){
        DeptName deptName1=new DeptName();
        deptName1.setDeptname(deptName);
        if(deptNameService.getDeptName(deptName)==null){
            deptNameService.insertDeptName(deptName1);
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 删除系部
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delDeptName")
    public Msg deleteDeptName(@RequestParam("id") Integer id){
        if(id!=null){
            if(deptNameService.deleteDeptName(id)>0) {
                return Msg.success();
            }
            return Msg.fail();
        }
        return Msg.fail();
    }

    /**
     * 跳转添加系部页面
     * @return
     */
    @RequestMapping("/addDeptNameJsp")
    public String toAddDeptName(){
        return "addDeptName";
    }
}
