package com.stumesystem.service;

import com.stumesystem.bean.ClassName;
import com.stumesystem.bean.DeptName;
import com.stumesystem.mapper.ClassNameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClassNameService {

    @Autowired
    private ClassNameMapper classNameMapper;

    /**
     * 查询班级
     * @param className
     * @return
     */
    public ClassName getClassName(ClassName className){
        return classNameMapper.selectBYClassName(className.getClassName(),className.getDeptNameId(),className.getJiid());
    }

    /**
     * 插入班级
     * @param className
     * @return
     */
    public int insertClassName(ClassName className){
        return classNameMapper.insertSelective(className);
    }



}
