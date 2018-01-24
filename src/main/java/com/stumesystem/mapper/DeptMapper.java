package com.stumesystem.mapper;

import com.stumesystem.bean.Dept;

public interface DeptMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Dept record);

    int insertSelective(Dept record);

    Dept selectByPrimaryKey(Integer id);

    Dept selectByUId(Integer uid);

    Dept selectWithByUId(Integer uid);

    int updateByPrimaryKeySelective(Dept record);

    int updateByPrimaryKey(Dept record);
}