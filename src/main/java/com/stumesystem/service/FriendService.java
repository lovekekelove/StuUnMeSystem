package com.stumesystem.service;

import com.stumesystem.bean.Friend;
import com.stumesystem.mapper.FriendMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
     * @param id
     * @return
     */
    public Friend getFriend(Integer id) {
        return friendMapper.selectByAddFriend(id);
    }
}
