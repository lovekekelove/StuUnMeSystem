package com.stumesystem.mapper;

import com.stumesystem.bean.StuUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StuUserMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteStuWithRose(Integer uid);

    int insert(StuUser record);

    int insert_Rose(@Param("id")Integer id, @Param("r_id") Integer r_id);

    int insertSelective(StuUser record);

    StuUser selectByPrimaryKey(Integer id);

    List<StuUser> selectRoseAndRightByEmail(String email);

    List<StuUser> selectStuByName(@Param("name") String name);

    StuUser selectByEmail(String email);

    StuUser selectBynickname(String niname);

    int updateByPrimaryKeySelective(StuUser record);

    int updateByEmailSelective(StuUser record);

    int updateByPrimaryKey(StuUser record);

}