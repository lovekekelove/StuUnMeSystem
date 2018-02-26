package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuRight;
import com.stumesystem.service.StuRightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StuRightController {

    @Autowired
    private StuRightService stuRightService;

    /**
     * 删除角色的权限
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/delRight")
    public Msg deleteRightWithRose(@RequestParam("rgId") Integer rgId, @RequestParam("rid") Integer rid, @RequestParam("fid") Integer fid) {

        boolean flag=false;
        if (stuRightService.deleteRightWithRose(rgId, rid) > 0) {
            List<StuRight> fidRight = stuRightService.getStuRightByFid(fid);
            List<StuRight> ridRight = stuRightService.getRightByRoseId(rid);
            for (StuRight fidRId:fidRight){
                for (StuRight ridId:ridRight){
                    if(fidRId.getId()==ridId.getId()){
                        flag=false;
                        return Msg.success();
                    }else {
                        flag=true;
                    }
                }
            }
            if(flag){
                if(stuRightService.deleteRightWithRoseByFid(fid,rid)>0){
                    return Msg.success();
                }
            }

        }
        return Msg.fail();
    }

    /**
     * 添加角色的权限
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/addRight")
    public Msg addRightWithRose(@RequestParam("rgId") Integer rgId, @RequestParam("rid") Integer rid, @RequestParam("fid") Integer fid) {

        List<StuRight> ridRight = stuRightService.getRightByRoseId(rid);
        for (StuRight ridId : ridRight) {
            if (ridId.getId() == rgId) {
                return Msg.fail();
            }
        }
        boolean flag = false;

        if (stuRightService.insertRight(rgId, rid) > 0) {
            List<StuRight> ridRight2 = stuRightService.getRightByRoseId(rid);
            a:
            for (StuRight ridId : ridRight2) {
                if (ridId.getId() == fid) {
                    flag = false;
                    break a;
                } else {
                    flag = true;
                    continue;
                }
            }
            if (flag) {
                if (stuRightService.insertRight(fid, rid) > 0) {
                    return Msg.success();
                }
            }
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * @return
     */
    @RequestMapping("/rightManager")
    public String toRightManager() {
        return "rightManager";
    }

    @RequestMapping("/rightJsp")
    public String toRightJsp() {
        return "addRightJsp";
    }

    @RequestMapping("/updateRightJsp")
    public String toRightJsp(@RequestParam("id") Integer id, HttpServletRequest request) {
        StuRight stuRight = stuRightService.getStu(id);
        request.setAttribute("stuRight", stuRight);
        List<StuRight> fidRight = stuRightService.getStuRightNull();
        request.setAttribute("fidRight", fidRight);
        return "updateRight";
    }

    @RequestMapping("/addRightJsp")
    public String toAddRightJsp(@RequestParam("id") Integer id, HttpServletRequest request) {
        request.setAttribute("rid", id);
        return "addRight";
    }

    /**
     * 所有权限
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/addRights")
    public Msg getRight() {
        List<StuRight> rights = new ArrayList<StuRight>();
        rights = stuRightService.getStuRights();
        return Msg.success().add("rights", rights);
    }

    /**
     * 添加权限
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/addStuRight")
    public Msg addRight(StuRight stuRight) {
        if (stuRight.getFid() == null) {
            stuRight.setUrl("fa fa-laptop  text-yellow");
        }
        List<StuRight> rights = new ArrayList<StuRight>();
        rights = stuRightService.getStuRights();
        for (StuRight s : rights) {
            if (stuRight.getRight().equals(s.getRight())) {
                return Msg.fail().add("error", 300);
            }
        }
        if (stuRightService.addRight(stuRight) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 获取所有主菜单
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/fid")
    public Msg getFid() {
        List<StuRight> fidRight = stuRightService.getStuRightNull();
        return Msg.success().add("fidRight", fidRight);
    }

    /**
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateStuRight")
    public Msg updateStuRight(StuRight stuRight) {
        if (stuRightService.updateStuRight(stuRight) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


    /**
     * 权限管理
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/rightManagers")
    public Msg Rights(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<StuRight> rights = stuRightService.getStuRights();
        PageInfo page = new PageInfo(rights, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 删除权限
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteRight")
    public Msg delRight(@RequestParam(value = "id") Integer id) {
        if (stuRightService.delRight(id) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }




}
