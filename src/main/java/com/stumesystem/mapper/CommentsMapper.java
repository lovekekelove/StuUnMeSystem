package com.stumesystem.mapper;

import com.stumesystem.bean.Comments;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentsMapper {
    int deleteByPrimaryKey(Integer comId);

    int insert(Comments record);

    int insertSelective(Comments record);

    Comments selectByPrimaryKey(Integer comId);

    List<Comments> getCommentList(Integer topicid);

    int getCommentNum(Integer topicid);

    List<Comments> selectListWithUser(Integer topicid);

    List<Comments> selectListAll(Integer fid);

    List<Comments> selectList();

    List<Comments> selectListAllWithTopic(Integer uid);

    List<Comments> selectListWithFid(@Param("topicid") Integer topicid, @Param("fid") Integer fid);

    List<Comments> selectListWithUserRoot(Integer fid);

    int updateByPrimaryKeySelective(Comments record);

    int updateByPrimaryKey(Comments record);
}