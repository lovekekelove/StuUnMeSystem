package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.*;
import com.stumesystem.service.CommentsService;
import com.stumesystem.service.PointMsgService;
import com.stumesystem.service.TopicService;
import com.stumesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CommentsController {

    @Autowired
    private CommentsService commentsService;

    @Autowired
    private TopicService topicService;

    @Autowired
    private PointMsgService pointMsgService;
    @Autowired
    private UserService userService;

    @RequestMapping("/toMyComments")
    public String toMyComments() {
        return "myComments";
    }

    @RequestMapping("/commentManneger")
    public String commentManneger() {
        return "commentManJsp";
    }

    @RequestMapping("/lookTopic")
    public String toCommentJsp(@RequestParam("id") Integer id,
                               @RequestParam("advice_id") Integer advice_id, HttpServletRequest request) {
        if (advice_id != 0) {
            PointMsg pointMsg = pointMsgService.getPointMsgById(advice_id);
            StuUser stu = userService.getUser(pointMsg.getAcceptUid());
            pointMsg.setMsgCount(stu.getName() + " 已查看通知！");
            pointMsg.setState("3");
            pointMsgService.updatePointMsg(pointMsg);
        }

        Topic topic = topicService.getTopic(id);
        topic.setTclickcount(topic.getTclickcount() + 1);
        List<CommentVoS> commentvoslist = new ArrayList<>();

        List<Comments> comments1 = commentsService.getCommentList(id);
        for (Comments c : comments1) {

            List<Comments> rootComments2 = commentsService.getCommentListWithRoot(c.getComId());
            List<Comments> rootComments4 = new ArrayList<>();
            for (Comments c2 : rootComments2) {
                List<Comments> rootComments3 = commentsService.getCommentListWithFid(c2.getTopicId(), c2.getComId());
                for (Comments c3 : rootComments3) {
                    rootComments4.add(c3);
                }
            }

            CommentVoS oneCommentvs = new CommentVoS();
            oneCommentvs.setComments(c);
            oneCommentvs.setRoot_directcomment(rootComments2);
            oneCommentvs.setRoot_Ndirectcomment(rootComments4);
            commentvoslist.add(oneCommentvs);

        }


        if (topicService.updateTopic(topic) > 0) {
            request.setAttribute("topic", topic);
            request.setAttribute("comment", commentvoslist);
        }
        return "looktopic";
    }

    /**
     * 评论数
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/lookCommentNum")
    public Msg getCommentNum(@RequestParam("topicid") Integer topicid) {
        int num = commentsService.getCommentNum(topicid);
        return Msg.success().add("Com_num", num);
    }

    /**
     * 插入
     *
     * @param comments
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/insertComment")
    public Msg insertComment(Comments comments, @RequestParam("nickname") String nickname, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        comments.setComState(2);
        comments.setComTime(new Date());
        comments.setComUserId(stuUser.getId());
        if (commentsService.insertComment(comments) > 0) {
            PointMsg pointMsg = new PointMsg();
            pointMsg.setMsgCount(comments.getTopicId() + ",您有一条消息回复");
            pointMsg.setSendUid(stuUser.getId());
            StuUser stuUser1 = userService.getUserYZniC(comments.getNickname());
            pointMsg.setAcceptUid(stuUser1.getId());
            pointMsg.setState("4");
            pointMsg.setSendTime(new Date());
            if (pointMsgService.insertPointMsg(pointMsg) > 0) {
                return Msg.success();
            }
        }
        return Msg.fail();
    }

    /**
     * 我的评论
     *
     * @param pn
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/myComment")
    public Msg myComment(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        PageHelper.startPage(pn, 5);
        List<Comments> lists = commentsService.getCommentListWithTopic(stuUser.getId());
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 管理
     *
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping("/commentMan")
    public Msg commentMan(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Comments> lists = commentsService.getCommentLists();
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 删除评论
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delComment")
    public Msg deleteTopic(@RequestParam("id") Integer id) {
        if (commentsService.delComment(id) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }
}
