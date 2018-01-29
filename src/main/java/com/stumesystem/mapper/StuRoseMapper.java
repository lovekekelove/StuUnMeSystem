package com.stumesystem.mapper;

import com.stumesystem.bean.StuRose;

import java.util.List;

public interface StuRoseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StuRose record);

    int insertSelective(StuRose record);

    StuRose selectId(Integer uid);

    StuRose selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StuRose record);

    int updateByPrimaryKey(StuRose record);
}