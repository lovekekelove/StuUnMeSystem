package com.stumesystem.mapper;

import com.stumesystem.bean.NaXin;

public interface NaXinMapper {
    int deleteByPrimaryKey(Integer naId);

    int insert(NaXin record);

    int insertSelective(NaXin record);

    NaXin selectByPrimaryKey(Integer naId);

    int updateByPrimaryKeySelective(NaXin record);

    int updateByPrimaryKey(NaXin record);
}