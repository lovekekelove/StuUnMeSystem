package com.stumesystem.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.Friend;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.PointMsg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.FriendService;
import com.stumesystem.service.PointMsgService;
import com.stumesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

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
        if (friendService.getFriend(id, stuUser.getId()) != null) {
            return Msg.fail().add("error", 1);
        }
        StuUser stuUser1 = userService.getUser(id);
        if (stuUser1.getState().equals("2")) {
            return Msg.fail().add("error", 2);
        }
        if (id == stuUser.getId()) {
            return Msg.fail().add("error", 3);
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

    /**
     * 好友列表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/myFriends")
    public Msg myFriends(HttpServletRequest request, @RequestParam(value = "pn", defaultValue = "1") Integer pn,
                         @RequestParam(value = "name") String name) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        PageHelper.startPage(pn, 5);
        List<Friend> friends = friendService.getFriends(stuUser.getId(), name);
        PageInfo pageInfo = new PageInfo(friends, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 好友列表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/lookmyFriends")
    public Msg lookmyFriends(HttpServletRequest request) {
        String name = "";
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        List<Friend> friends = friendService.getFriends(stuUser.getId(), name);
        return Msg.success().add("friends", friends);
    }

    /**
     * 同意好友
     *
     * @param uid 请求方的id
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateFriend")
    public Msg updateDeptName(@RequestParam("uid") Integer uid, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        if (friendService.getFriend(stuUser.getId(), uid).getState() == 1) {
            return Msg.fail();
        }

        if (uid != null) {
            Friend friend = friendService.getFriend(stuUser.getId(), uid);
            friend.setState(1);
            friend.setAddTime(new Date());
            if (friendService.updateFriend(friend) > 0) {
                Friend friend1 = new Friend();
                friend1.setUid(friend.getAddUid());
                friend1.setAddUid(uid);
                friend1.setAddTime(new Date());
                friend1.setState(1);
                if (friendService.insertFriend(friend1) > 0) {
                    PointMsg pointMsg = pointMsgService.getPointMsgByAcceptId(friend.getAddUid(), uid);
                    pointMsg.setState("3");
                    pointMsg.setSendTime(new Date());
                    pointMsg.setMsgCount(stuUser.getName() + "  同意了你的好友请求！");
                    if (pointMsgService.updatePointMsg(pointMsg) > 0) {
                        return Msg.success();
                    }
                }
            }
        }
        return Msg.fail();
    }

    /**
     * 拒绝好友
     *
     * @param uid 请求方的id
     * @return
     */
    @ResponseBody
    @RequestMapping("/refuseFriend")
    public Msg refuseDeptName(@RequestParam("uid") Integer uid, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        if (uid != null) {
            Friend friend = friendService.getFriend(stuUser.getId(), uid);
            if (friendService.deleteFriend(friend.getId()) > 0) {
                PointMsg pointMsg = pointMsgService.getPointMsgByAcceptId(friend.getAddUid(), uid);
                pointMsg.setState("3");
                pointMsg.setSendTime(new Date());
                pointMsg.setMsgCount(stuUser.getName() + "  拒绝您的好友请求！");
                if (pointMsgService.updatePointMsg(pointMsg) > 0) {
                    return Msg.success();
                }
            }
        }
        return Msg.fail();
    }

    /**
     * 删除好友
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delFriend")
    public Msg deleteDeptName(@RequestParam("id") Integer id) {
        if (id != null) {
            if (friendService.deleteFriend(id) > 0) {
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
    @RequestMapping(value = "/deleteFriends/{ids}")
    public Msg deleteUser(@PathVariable(value = "ids") String ids, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        //批量删除
        if (ids.contains("-")) {
            String[] str_ids = ids.split("-");
            for (String id : str_ids) {
                friendService.deleteFriend(Integer.parseInt(id));
            }

        } else {


            //单个删除
            Integer id = Integer.parseInt(ids);

            if (id == stuUser.getId()) {
                return Msg.fail().add("error", 1);
            }

            friendService.deleteFriend(id);
        }
        return Msg.success();
    }

    /**
     * 查看添加好友
     *
     * @param send_id
     * @param request
     * @return
     */
    @RequestMapping("/lookFriendMsg")
    public String toConAddFriend(@RequestParam("send_id") Integer send_id, HttpServletRequest request) {
        StuUser stuUser = userService.getUser(send_id);
        request.setAttribute("user", stuUser);
        return "conAddFriend";
    }

    /**
     * 删除通知
     *
     * @param id
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/delMsgTalk")
    public Msg delMsgTalk(@RequestParam("id") Integer id) {
        PointMsg pointMsg = pointMsgService.getPointMsgById(id);
        pointMsg.setState("1");
        if (pointMsgService.updatePointMsg(pointMsg) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


    @RequestMapping("/myFriendJsp")
    public String toMyFriend() {
        return "myFriends";
    }
}
