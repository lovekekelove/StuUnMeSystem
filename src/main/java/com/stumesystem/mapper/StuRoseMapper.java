package com.stumesystem.mapper;

import com.stumesystem.bean.StuRose;

public interface StuRoseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StuRose record);

    int insertSelective(StuRose record);

    StuRose selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StuRose record);

    int updateByPrimaryKey(StuRose record);
}