package com.stumesystem.controller;

import com.stumesystem.bean.Friend;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.PointMsg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.FriendService;
import com.stumesystem.service.PointMsgService;
import com.stumesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class FriendController {

    @Autowired
    private FriendService friendService;

    @Autowired
    private UserService userService;

    @Autowired
    private PointMsgService pointMsgService;


    @RequestMapping("/addFriendJsp")
    public String toAddFriend() {
        return "addfriend";
    }

    /**
     * 查找好友
     *
     * @param email
     * @return
     */
    @ResponseBody
    @RequestMapping("/findFriend")
    public Msg findFriend(@RequestParam("email") String email) {
        StuUser stuUser = userService.getUser(email);
        return Msg.success().add("user", stuUser);
    }

    /**
     * 添加好友
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/addFriend")
    public Msg addFriend(@RequestParam("id") Integer id, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        Friend friend = new Friend();
        friend.setAddUid(id);
        friend.setAddTime(new Date());
        friend.setUid(stuUser.getId());
        friend.setState(2);
        if (id == null) {
            return Msg.fail();
        }
        if (friendService.getFriend(id) != null) {
            return Msg.fail().add("error", 1);
        }
        StuUser stuUser1 = userService.getUser(id);
        if (stuUser1.getState().equals("2")) {
            return Msg.fail().add("error", 2);
        }
        if (friendService.insertFriend(friend) > 0) {
            PointMsg pointMsg = new PointMsg();
            pointMsg.setMsgCount("好友添加请求！");
            pointMsg.setAcceptUid(id);
            pointMsg.setSendUid(stuUser.getId());
            pointMsg.setSendTime(new Date());
            pointMsg.setState("2");
            if (pointMsgService.insertPointMsg(pointMsg) > 0) {
                return Msg.success();
            }
        }
        return Msg.fail();
    }
}
