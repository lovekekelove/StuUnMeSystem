package com.stumesystem.controller;

import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.FriendService;
import com.stumesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FriendController {

    @Autowired
    private FriendService friendService;

    @Autowired
    private UserService userService;


    @RequestMapping("/addFriendJsp")
    public String toAddFriend() {
        return "addfriend";
    }

    @ResponseBody
    @RequestMapping("/findFriend")
    public Msg findFriend(@RequestParam("email") String email) {
        StuUser stuUser = userService.getUser(email);
        return Msg.success().add("user", stuUser);
    }
}
