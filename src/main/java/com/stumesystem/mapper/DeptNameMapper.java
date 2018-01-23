package com.stumesystem.mapper;

import com.stumesystem.bean.DeptName;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeptNameMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DeptName record);

    int insertSelective(DeptName record);

    DeptName selectByPrimaryKey(Integer id);

    DeptName selectByDeptName(String deptName);

    int updateByPrimaryKeySelective(DeptName record);

    int updateByPrimaryKey(DeptName record);

    List<DeptName> getDeptName();

    List<DeptName> selectByDeptStuName(String deptStuName);


    int insertDeptNameAndDeptStuName(@Param("deptId")int deptId, @Param("deptStuId")int deptStuId);
}