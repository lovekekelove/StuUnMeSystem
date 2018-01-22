package com.stumesystem.mapper;

import com.stumesystem.bean.DeptName;
import com.stumesystem.bean.DeptStu;

import java.util.List;

public interface DeptStuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DeptStu record);

    int insertSelective(DeptStu record);

    DeptStu selectByPrimaryKey(Integer id);

    DeptStu selectBydeptStuName(String  deptStuName);

    List<DeptStu> getDeptStus();

    List<DeptStu> selectByDeptNameId(Integer id);

    int updateByPrimaryKeySelective(DeptStu record);

    int updateByPrimaryKey(DeptStu record);

}