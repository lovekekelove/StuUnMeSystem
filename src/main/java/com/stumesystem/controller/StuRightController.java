package com.stumesystem.controller;

import com.stumesystem.bean.Msg;
import com.stumesystem.service.StuRightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public Msg deleteRightWithRose(@RequestParam("rgId") Integer rgId, @RequestParam("rid") Integer rid) {
        if (stuRightService.deleteRightWithRose(rgId, rid) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }
}
