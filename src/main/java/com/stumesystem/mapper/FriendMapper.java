package com.stumesystem.mapper;

import com.stumesystem.bean.Friend;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FriendMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Friend record);

    int insertSelective(Friend record);

    List<Friend> selectByUidAndName(@Param("uid") Integer uid, @Param("name") String name);

    Friend selectByPrimaryKey(Integer id);

    Friend selectByUid(Integer uid);

    Friend selectByAddFriend(@Param("id") Integer id, @Param("uid") Integer uid);

    int updateByPrimaryKeySelective(Friend record);

    int updateByPrimaryKey(Friend record);
}