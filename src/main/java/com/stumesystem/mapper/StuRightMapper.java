package com.stumesystem.mapper;

import com.stumesystem.bean.StuRight;

public interface StuRightMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StuRight record);

    int insertSelective(StuRight record);

    StuRight selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StuRight record);

    int updateByPrimaryKey(StuRight record);
}