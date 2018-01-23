package com.stumesystem.mapper;

import com.stumesystem.bean.ClassName;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClassNameMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ClassName record);

    int insertSelective(ClassName record);

    ClassName selectByPrimaryKey(Integer id);

    ClassName selectBYClassName(@Param("className") String className,
                                @Param("deptNameId") Integer deptNameId,
                                @Param("jiid") Integer jiid);

    List<ClassName> selectBYJiidAndDeptId(@Param("deptNameId") Integer deptNameId,
                                          @Param("jiid") Integer jiid);

    List<ClassName> getClassNames();

    int updateByPrimaryKeySelective(ClassName record);

    int updateByPrimaryKey(ClassName record);
}