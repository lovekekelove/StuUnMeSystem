package com.stumesystem.mapper;

import com.stumesystem.bean.NaXin;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface NaXinMapper {
    int deleteByPrimaryKey(Integer naId);

    int insert(NaXin record);

    int insertSelective(NaXin record);

    NaXin selectByPrimaryKey(Integer naId);

    NaXin selectByUId(Integer uId);

    NaXin selectByUIdWithName(Integer naId);

    List<NaXin> selectAll(HashMap<String, Integer> map);

    List<NaXin> selectAllEnd(HashMap<String, Integer> map);

    int updateByPrimaryKeySelective(NaXin record);

    int updateByPrimaryKey(NaXin record);
}