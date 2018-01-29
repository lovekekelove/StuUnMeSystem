package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.LeaveMsg;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.LeaveMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class LeaveMsgController {

    @Autowired
    private LeaveMsgService leaveMsgService;

    /**
     * 所有的通过留言
     *
     * @param request
     * @return
     */
    @RequestMapping("/leaveMsg")
    public String toTopicCatalog(HttpServletRequest request) {
//        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        List<LeaveMsg> lists = leaveMsgService.getAllLeaveMsg();
        request.setAttribute("tcvos", lists);
        return "topicCatalog";
    }

    /**
     * 系统留言管理
     *
     * @param pn
     * @param serch
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaves")
    public Msg getLeaveMsg(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                           @RequestParam(value = "serch") String serch) {
        PageHelper.startPage(pn, 5);
        List<LeaveMsg> lists = leaveMsgService.getAllWithState(serch);
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 个人留言管理
     *
     * @param pn
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/personLeaves")
    public Msg getLeaveMsg(@RequestParam(value = "pn", defaultValue = "1") Integer pn
            , HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        PageHelper.startPage(pn, 5);
        List<LeaveMsg> lists = leaveMsgService.getAllWithUid(stuUser.getId());
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 添加留言
     *
     * @param count
     * @return
     */
    @ResponseBody
    @RequestMapping("/addLeaveMsg")
    public Msg addLeaveMsg(@RequestParam("count") String count, HttpServletRequest request) {
        if (!count.equals("")) {
            LeaveMsg leaveMsg = new LeaveMsg();
            leaveMsg.setState(2);
            leaveMsg.setCount(count);
            leaveMsg.setCreattime(new Date());
            leaveMsg.setSendUid(((StuUser) request.getSession().getAttribute("userinfo")).getId());
            if (leaveMsgService.insertLeaveMsg(leaveMsg) > 0) {
                return Msg.success();
            }
        }
        return Msg.fail();
    }

    /**
     * 点赞
     * @param request
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/addzan")
    public Msg addZan(HttpServletRequest request, @RequestParam("id") Integer id) {
        List<LeaveMsg> lists = leaveMsgService.getAllLeaveMsgBYid(id, 1);
        boolean flag = false;
        StuUser stuUser = (StuUser) request.getSession(false).getAttribute("userinfo");
        for (LeaveMsg l : lists) {
            if (l.getZanUid() != null) {
                if (l.getZanUid() == (stuUser.getId())) {
                    flag = false;
                    return Msg.fail();
                } else {
                    flag = true;
                }
            } else {
                flag = true;
            }
        }
        if (flag) {
            if (leaveMsgService.insertZanUser(id, stuUser.getId()) > 0) {
                LeaveMsg leaveMsg = leaveMsgService.getLeaveById(id);
                if (leaveMsg.getZanNum() == null) {
                    leaveMsg.setZanNum(1);
                    if (leaveMsgService.updateLeave(leaveMsg) > 0) {
                        return Msg.success().add("zanNum", (1));
                    }
                } else {
                    leaveMsg.setZanNum(leaveMsg.getZanNum() + 1);
                    if (leaveMsgService.updateLeave(leaveMsg) > 0) {
                        return Msg.success().add("zanNum", (leaveMsg.getZanNum()));
                    }
                }
            }
        }
        return Msg.fail();
    }

    /**
     * 删除留言
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delLeave")
    public Msg deleteDeptName(@RequestParam("id") Integer id) {
        if (id != null) {
            if (leaveMsgService.deleteLeaveMsg(id) > 0) {
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
    @RequestMapping(value = "/deleteLeaves/{ids}")
    public Msg deleteEmp(@PathVariable(value = "ids") String ids) {
        //批量删除
        if (ids.contains("-")) {
            String[] str_ids = ids.split("-");
            for (String id : str_ids) {
                leaveMsgService.deleteLeaveMsg(Integer.parseInt(id));
            }

        } else {
            //单个删除
            Integer id = Integer.parseInt(ids);
            leaveMsgService.deleteLeaveMsg(id);
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
    @RequestMapping("/updateLeave")
    public Msg updateDeptName(@RequestParam("id") Integer id) {
        if (id != null) {
            LeaveMsg leaveMsg = leaveMsgService.getLeaveById(id);
            leaveMsg.setState(1);
            if (leaveMsgService.updateLeave(leaveMsg) > 0) {
                return Msg.success();
            }
        }
        return Msg.fail();
    }

    @RequestMapping("/leaveMsgJsp")
    public String toChangeLeaveMsg() {
        return "changLeaveMsg";
    }

    @RequestMapping("/myLeaveMsg")
    public String toMyLeaveMsg() {
        return "myLeaveMsg";
    }

}
