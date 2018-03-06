package com.stumesystem.controller;

import com.stumesystem.bean.LeaveMsg;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuUser;
import com.stumesystem.bean.Topic;
import com.stumesystem.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * @Author:张腾飞
 * @Date:2018/2/7 17:08
 */
@Controller
public class TopicController {

    @Autowired
    private TopicService topicService;

    @RequestMapping("/reportNewsJsp")
    public String toReportNews() {
        return "reportNews";
    }


}
