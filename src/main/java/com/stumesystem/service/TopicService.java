package com.stumesystem.service;

import com.stumesystem.bean.Topic;
import com.stumesystem.bean.TopicZan;
import com.stumesystem.mapper.TopicMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author:张腾飞
 * @Date:2018/2/7 17:09
 */
@Service
public class TopicService {

    @Autowired
    private TopicMapper topicMapper;

    /**
     * 插入动态
     *
     * @param topic
     * @return
     */
    public int insertTopic(Topic topic) {
        return topicMapper.insertSelective(topic);
    }

    /**
     * 获取列表
     *
     * @return
     */
    public List<Topic> getTopicList() {
        return topicMapper.getTopicList();
    }

    /**
     * 获取列表
     *
     * @return
     */
    public List<Topic> getTopicListWithUser(Integer uid) {
        return topicMapper.getTopicListWithUser(uid);
    }


    /**
     * 获取列表
     *
     * @return
     */
    public List<Topic> getTopicListManager(Integer state) {
        return topicMapper.getTopicListManager(state);
    }

    /**
     * 获取动态
     *
     * @param id
     * @return
     */
    public Topic getTopic(Integer id) {
        return topicMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新动态
     *
     * @param topic
     * @return
     */
    public int updateTopic(Topic topic) {
        return topicMapper.updateByPrimaryKeySelective(topic);
    }

    /**
     * 插入判断赞 表
     *
     * @param uid
     * @param topicId
     * @return
     */
    public int insertTopicZan(Integer uid, Integer topicId) {
        return topicMapper.insertZanWithUser(uid, topicId);
    }

    /**
     * 判断是否点赞
     *
     * @param uid
     * @param topicId
     * @return
     */
    public TopicZan getTopicZan(Integer uid, Integer topicId) {
        return topicMapper.getTopicZan(uid, topicId);
    }

    /**
     * 删除动态
     *
     * @param id
     * @return
     */
    public int deleteMyTopic(Integer id) {
        return topicMapper.deleteByPrimaryKey(id);
    }

}
