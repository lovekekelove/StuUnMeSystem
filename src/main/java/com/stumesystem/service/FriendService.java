package com.stumesystem.service;

import com.stumesystem.bean.Friend;
import com.stumesystem.mapper.FriendMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FriendService {

    @Autowired
    private FriendMapper friendMapper;

    /**
     * 添加好友
     *
     * @param friend
     * @return
     */
    public int insertFriend(Friend friend) {
        return friendMapper.insertSelective(friend);
    }

    /**
     * 通过添加好友的id,判断是否是好友
     *
     * @param add_id,uid
     * @return
     */
    public Friend getFriend(Integer add_id, Integer uid) {
        return friendMapper.selectByAddFriend(add_id, uid);
    }

    /**
     * 我的好友
     *
     * @param uid
     * @return
     */
    public List<Friend> getFriends(Integer uid, String name) {
        return friendMapper.selectByUidAndName(uid, name);
    }

    /**
     * 更新好友
     *
     * @param friend
     * @return
     */
    public int updateFriend(Friend friend) {
        return friendMapper.updateByPrimaryKeySelective(friend);
    }

    /**
     * 查找Friend
     *
     * @param id
     * @return
     */
    public Friend getFriend(Integer id) {
        return friendMapper.selectByPrimaryKey(id);
    }

    /**
     * 查找Friend
     *
     * @param uid
     * @return
     */
    public Friend getFriendByUid(Integer uid) {
        return friendMapper.selectByUid(uid);
    }

    /**
     * 删除好友
     *
     * @param id
     * @return
     */
    public int deleteFriend(Integer id) {
        return friendMapper.deleteByPrimaryKey(id);
    }
}
