package com.stumesystem.controller;

import com.stumesystem.bean.LeaveMsg;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.LeaveMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
public class leaveMsgController {

    @Autowired
    private LeaveMsgService leaveMsgService;

    @RequestMapping("/leaveMsg")
    public String toTopicCatalog(HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        List<LeaveMsg> lists = leaveMsgService.getAllLeaveMsg();
        request.setAttribute("tcvos", lists);
        return "topicCatalog";
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
            leaveMsg.setState(1);
            leaveMsg.setCount(count);
            leaveMsg.setCreattime(new Date());
            leaveMsg.setSendUid(((StuUser) request.getSession().getAttribute("userinfo")).getId());
            if (leaveMsgService.insertLeaveMsg(leaveMsg) > 0) {
                return Msg.success();
            }
        }
        return Msg.fail();
    }

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

}
