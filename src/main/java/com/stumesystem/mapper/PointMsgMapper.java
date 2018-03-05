package com.stumesystem.mapper;

import com.stumesystem.bean.PointMsg;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PointMsgMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(PointMsg record);

    int insertSelective(PointMsg record);

    List<PointMsg> selectAllWithState(Integer id);

    List<PointMsg> selectAllWithStateAndTalk(Integer id);

    List<PointMsg> selectAllWithStateAndAdvice(Integer id);

    int selectNum(Integer id);

    int selectNumAdvice(Integer id);

    int selectNumTalk(Integer id);

    PointMsg selectByPrimaryKey(Integer id);

    PointMsg selectByAcceptUid(@Param("acc_id") Integer acc_id, @Param("send_id") Integer send_id);

    PointMsg selectByAcceptUidAndSendUid(@Param("acc_id") Integer acc_id, @Param("send_id") Integer send_id);

    int updateByPrimaryKeySelective(PointMsg record);

    int updateByPrimaryKey(PointMsg record);


}