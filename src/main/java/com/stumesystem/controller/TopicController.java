package com.stumesystem.controller;

import com.stumesystem.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
