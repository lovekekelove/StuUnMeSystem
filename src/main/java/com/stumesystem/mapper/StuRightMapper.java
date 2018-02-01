package com.stumesystem.mapper;

import com.stumesystem.bean.StuRight;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StuRightMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteRoseWithRight(@Param("rgId") Integer rgId, @Param("rid") Integer rid);

    int deleteRoseWithRightByFid(@Param("fId") Integer fId, @Param("rid") Integer rid);

    int insert(StuRight record);

    int insertSelective(StuRight record);

    StuRight selectByPrimaryKey(Integer id);

    List<StuRight> selectByUserId(Integer id);

    List<StuRight> selectByRoseId(Integer id);

    List<StuRight> selectByFid(Integer fid);

    int updateByPrimaryKeySelective(StuRight record);

    int updateByPrimaryKey(StuRight record);
}