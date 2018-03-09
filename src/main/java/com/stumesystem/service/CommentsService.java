package com.stumesystem.service;

import com.stumesystem.bean.Comments;
import com.stumesystem.mapper.CommentsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentsService {

    @Autowired
    private CommentsMapper commentsMapper;

    /**
     * 删除我的评论
     *
     * @param id
     * @return
     */
    public int delComment(Integer id) {
        return commentsMapper.deleteByPrimaryKey(id);
    }

    /**
     * 获取评论数
     *
     * @param topicid
     * @return
     */
    public int getCommentNum(Integer topicid) {
        return commentsMapper.getCommentNum(topicid);
    }

    /**
     * 插入评论
     *
     * @param comments
     * @return
     */
    public int insertComment(Comments comments) {
        return commentsMapper.insertSelective(comments);
    }

    /**
     * 帖子列表
     *
     * @param topicid
     * @return
     */
    public List<Comments> getCommentList(Integer topicid) {
        return commentsMapper.selectListWithUser(topicid);
    }

    /**
     * 全部
     *
     * @return
     */
    public List<Comments> getCommentLists() {
        return commentsMapper.selectList();
    }

    /**
     * 根下的评论
     *
     * @param fid
     * @return
     */
    public List<Comments> getCommentListWithRoot(Integer fid) {
        return commentsMapper.selectListWithUserRoot(fid);
    }

    /**
     * 查询所有
     *
     * @param fid
     * @return
     */
    public List<Comments> getCommentListAll(Integer fid) {
        return commentsMapper.selectListAll(fid);
    }

    /**
     * 最低级评论
     *
     * @param topicid
     * @param fid
     * @return
     */
    public List<Comments> getCommentListWithFid(Integer topicid, Integer fid) {
        return commentsMapper.selectListWithFid(topicid, fid);
    }

    /**
     * 我的评论
     *
     * @param uid
     * @return
     */
    public List<Comments> getCommentListWithTopic(Integer uid) {
        return commentsMapper.selectListAllWithTopic(uid);
    }


}
