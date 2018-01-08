package com.stumesystem.mapper;

import com.stumesystem.bean.StuUser;

public interface StuUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StuUser record);

    int insertSelective(StuUser record);

    StuUser selectByPrimaryKey(Integer id);


    StuUser selectByEmail(String email);

    StuUser selectBynickname(String email);

    int updateByPrimaryKeySelective(StuUser record);


    int updateByEmailSelective(StuUser record);

    int updateByPrimaryKey(StuUser record);

}