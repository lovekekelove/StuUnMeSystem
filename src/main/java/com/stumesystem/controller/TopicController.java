package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.*;
import com.stumesystem.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * @Author:张腾飞
 * @Date:2018/2/7 17:08
 */
@Controller
public class TopicController {

    @Autowired
    private TopicService topicService;

    @RequestMapping("/reportDyJsp")
    public String toReportNews(HttpServletRequest request) {
        List<Topic> lists = topicService.getTopicList();
        request.setAttribute("tcvos", lists);
        return "newsJsp";
    }

    @RequestMapping("/totopicManager")
    public String toMyTopicJsp() {
        return "topicmanager";
    }

    @RequestMapping("/toMyTopic")
    public String toTopicManager() {
        return "myTopics";
    }

    /**
     * 我的动态
     *
     * @param pn
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/getMyTopicList")
    public Msg getMyTopic(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        PageHelper.startPage(pn, 5);
        List<Topic> lists = topicService.getTopicListWithUser(stuUser.getId());
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 后台管理
     *
     * @param pn
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/getManagerTopicList")
    public Msg getTopicList(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                            HttpServletRequest request, @RequestParam(value = "state") Integer state) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        PageHelper.startPage(pn, 5);
        List<Topic> lists = topicService.getTopicListManager(state);
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 发布动态
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/rtDynamic")
    public Msg reportDynamic(@RequestParam("tcontent") String tcontent,
                             @RequestParam("title") String title,
                             HttpServletRequest request) {
        Topic topic = new Topic();
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        topic.setTcontent(tcontent);
        topic.setTitle(title);
        topic.setTtime(new Date());
        topic.setTstaus(2);
        topic.setStuSendId(stuUser.getId());
        if (topicService.insertTopic(topic) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 点赞
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/addzanDy")
    public Msg addZan(@RequestParam("id") Integer id, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        Topic topic = topicService.getTopic(id);
        topic.setTstaus(1);
        topic.setTzan(topic.getTzan() + 1);
        if (topicService.getTopicZan(stuUser.getId(), id) != null) {
            return Msg.fail();
        }
        if (topicService.updateTopic(topic) > 0) {
            if (topicService.insertTopicZan(stuUser.getId(), id) > 0) {
                return Msg.success().add("zanNum", topic.getTzan());
            }
        }
        return Msg.fail();
    }

    /**
     * 删除动态
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delMyTopic")
    public Msg deleteTopic(@RequestParam("id") Integer id) {
        if (topicService.deleteMyTopic(id) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 更新动态
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/updatetopic")
    public Msg updateTopic(@RequestParam("id") Integer id) {
        Topic topic = topicService.getTopic(id);
        topic.setTstaus(1);
        if (topicService.updateTopic(topic) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

   }
