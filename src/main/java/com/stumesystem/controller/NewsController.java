package com.stumesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stumesystem.bean.Msg;
import com.stumesystem.bean.News;
import com.stumesystem.bean.StuRose;
import com.stumesystem.bean.StuUser;
import com.stumesystem.service.NewsService;
import com.stumesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
public class NewsController {

    @Autowired
    private NewsService newService;

    @Autowired
    private UserService userService;

    @RequestMapping("/newsJSP")
    public String toNewsJsp() {
        return "newsIndex";
    }

    @RequestMapping("/newsManagerJsp")
    public String newsManagerJsp() {
        return "newsmanager";
    }

    @RequestMapping("/reportNewsJsp")
    public String fabiao() {
        return "reportNews";
    }

    /**
     * 发布新闻
     *
     * @param news
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/reportDynamic")
    public Msg reportDynamic(News news, HttpServletRequest request) {
        StuUser stuUser = (StuUser) request.getSession().getAttribute("userinfo");
        news.setSendTime(new Date());
        news.setSendUid(stuUser.getId());
        if (newService.insertNews(news) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 查看新闻列表
     *
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping("/getNews")
    public Msg getNews(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 8);
        List<News> lists = newService.getList();
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 删除纳新人员
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delNews")
    public Msg deleteNaXin(@RequestParam("id") Integer id) {
        if (newService.deleteNews(id) > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 后台查看新闻列表
     *
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping("/newsManager")
    public Msg getNewsManager(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 8);
        List<News> lists = newService.getManagerList();
        PageInfo page = new PageInfo(lists, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 详细内容
     *
     * @param id
     * @return
     */
    @RequestMapping("/lookNewsCount")
    public String LookNews(@RequestParam(value = "id") Integer id, HttpServletRequest request) {
        News news = newService.getNews(id);
        news.setLookNum(news.getLookNum() + 1);
        if (newService.updateNews(news) > 0) {
            StuUser user = userService.getUser(news.getSendUid());
            news.setName(user.getName());
            request.setAttribute("news", news);
        }
        return "looknewscount";
    }

}
