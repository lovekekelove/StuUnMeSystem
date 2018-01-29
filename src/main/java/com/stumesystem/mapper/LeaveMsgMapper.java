package com.stumesystem.mapper;

import com.stumesystem.bean.LeaveMsg;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LeaveMsgMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(LeaveMsg record);

    int insertZanUser(@Param("msgid") Integer msgid, @Param("uid") Integer uid);

    int insertSelective(LeaveMsg record);

    LeaveMsg selectByUid(Integer uid);

    List<LeaveMsg> selectMsgsByPrimaryKey(@Param("id") Integer id, @Param("state") Integer state);

    LeaveMsg selectByPrimaryKey(Integer id);

    List<LeaveMsg> selectLeaveMsg();

    List<LeaveMsg> selectLeaveMsgWithState(@Param("niName") String niName);

    List<LeaveMsg> selectLeaveMsgWithUid(@Param("uid") Integer uid);

    List<LeaveMsg> selectLeaveMsgByRose(int uid);

    int updateByPrimaryKeySelective(LeaveMsg record);

    int updateByPrimaryKey(LeaveMsg record);
}