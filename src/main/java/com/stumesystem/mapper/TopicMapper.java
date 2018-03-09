package com.stumesystem.mapper;

import com.stumesystem.bean.Topic;
import com.stumesystem.bean.TopicZan;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TopicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Topic record);

    int insertZanWithUser(@Param("uid") Integer uid, @Param("topicid") Integer topicid);

    int insertSelective(Topic record);

    Topic selectByPrimaryKey(Integer id);

    TopicZan getTopicZan(@Param("uid") Integer uid, @Param("topicid") Integer topicid);

    List<Topic> getTopicList();

    List<Topic> getTopicListManager(Integer state);

    List<Topic> getTopicListWithUser(Integer uid);

    int updateByPrimaryKeySelective(Topic record);

    int updateByPrimaryKeyWithBLOBs(Topic record);

    int updateByPrimaryKey(Topic record);
}