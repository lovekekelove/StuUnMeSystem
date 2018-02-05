package com.stumesystem.mapper;

import com.stumesystem.bean.PointMsg;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PointMsgMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(PointMsg record);

    int insertSelective(PointMsg record);

    List<PointMsg> selectAllWithState();

    int selectNum();

    PointMsg selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(PointMsg record);

    int updateByPrimaryKey(PointMsg record);


}