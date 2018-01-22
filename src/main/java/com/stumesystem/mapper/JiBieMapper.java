package com.stumesystem.mapper;

import com.stumesystem.bean.DeptName;
import com.stumesystem.bean.JiBie;

import java.util.List;

public interface JiBieMapper {
    int deleteByPrimaryKey(Integer jid);

    int insert(JiBie record);

    int insertSelective(JiBie record);

    JiBie selectByPrimaryKey(Integer jid);

    JiBie selectByDengJi(String  dengji);

    int updateByPrimaryKeySelective(JiBie record);

    int updateByPrimaryKey(JiBie record);

    List<JiBie> getJiBie();
}