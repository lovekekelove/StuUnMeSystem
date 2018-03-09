package com.stumesystem.service;

import com.stumesystem.bean.News;
import com.stumesystem.mapper.NewsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsService {

    @Autowired
    private NewsMapper mapper;

    /**
     * 插入新闻
     *
     * @param news
     * @return
     */
    public int insertNews(News news) {
        return mapper.insertSelective(news);
    }

    /**
     * 获得新闻列表
     *
     * @return
     */
    public List<News> getList() {
        return mapper.selectNewsList();
    }

    /**
     * 获得新闻列表(后台)
     *
     * @return
     */
    public List<News> getManagerList() {
        return mapper.selectNewsListWithUser();
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    public int deleteNews(Integer id) {
        return mapper.deleteByPrimaryKey(id);
    }



    /**
     * id得到news
     *
     * @param id
     * @return
     */
    public News getNews(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    /**
     * 更新news
     *
     * @param news
     * @return
     */
    public int updateNews(News news) {
        return mapper.updateByPrimaryKeySelective(news);
    }
}
