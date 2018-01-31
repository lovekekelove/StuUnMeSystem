package com.stumesystem.mapper;

import com.stumesystem.bean.StuRose;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StuRoseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StuRose record);

    int insertSelective(StuRose record);

    List<StuRose> getRoses();

    StuRose selectId(Integer uid);

    StuRose selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StuRose record);

    int updateByUidSelective(@Param("rid") Integer rid, @Param("uid") Integer uid);

    int updateByPrimaryKey(StuRose record);
}