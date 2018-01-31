package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.*;
import com.stumesystem.service.StuRightService;
import com.stumesystem.service.StuRoseService;
import com.stumesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StuRoseController {

    @Autowired
    private StuRoseService stuRoseService;

    @Autowired
    private UserService userService;

    @Autowired
    private StuRightService stuRightService;

    /**
     * 更新角色
     *
     * @param uid
     * @param rid
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateRose")
    public Msg getRose(@RequestParam("uid") Integer uid, @RequestParam("rid") Integer rid) {
        if (stuRoseService.updateRose(rid, uid) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 获取所有班级信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/roseManagers")
    public Msg getDeptNames(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<StuRose> lists = stuRoseService.getRose();
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 添加角色
     *
     * @param rose
     * @return
     */
    @ResponseBody
    @RequestMapping("/addRose")
    public Msg addRose(@RequestParam("rose") String rose) {
        StuRose stuRose = new StuRose();
        stuRose.setRose(rose);
        List<StuRose> lists = stuRoseService.getRose();

        for (StuRose s : lists) {
            if (rose.equals(s.getRose())) {
                return Msg.fail();
            }
        }
        if (stuRoseService.insertRose(stuRose) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 删除角色
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delRose")
    public Msg deleteRose(@RequestParam("id") Integer id) {
        if (stuRoseService.deleteRose(id) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


    /**
     * 跳转页面
     *
     * @return
     */
    @RequestMapping("/roseManager")
    public String toRoseManeger() {
        return "roseManager";
    }

    @RequestMapping("/addRoseJsp")
    public String toAddRose() {
        return "addRose";
    }

    @RequestMapping("/distRightJsp")
    public String toPutRight(@RequestParam("id") Integer id, HttpServletRequest request) {
        request.setAttribute("rid", id);
        return "distRight";
    }

    /**
     * 菜单栏
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/rights")
    public Msg getRight(HttpServletRequest request) {
        StuUser user = (StuUser) request.getSession(false).getAttribute("userinfo");
        List<StuRight> rights = new ArrayList<StuRight>();
        if (user != null) {
            rights = userService.getRoseAndRightByUid(user.getId());
            return Msg.success().add("rights", rights);
        }
        return Msg.fail();
    }

    /**
     * 通过角色Id查询right
     *
     * @param rid
     * @return
     */
    @ResponseBody
    @RequestMapping("/rightsWithRose")
    public Msg checkRight(@RequestParam("rid") Integer rid) {
        List<StuRight> rights = new ArrayList<StuRight>();
        rights = stuRightService.getRightByRoseId(rid);
        return Msg.success().add("rights", rights);
    }
}
