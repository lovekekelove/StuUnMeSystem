package com.stumesystem.service;

import com.stumesystem.bean.DeptName;
import com.stumesystem.bean.DeptStu;
import com.stumesystem.mapper.DeptNameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DeptNameService {

    @Autowired
    private DeptNameMapper deptNameMapper;

    /**
     * 获取系部列表
     * @return
     */
    public List<DeptName> getDeptNames(){
        List<DeptName> deptNames=new ArrayList<DeptName>();
        return  deptNames=deptNameMapper.getDeptName();
    }

    /**
     * 插入系部
     * @param deptName
     * @return
     */
    public int insertDeptName(DeptName deptName){
        return deptNameMapper.insert(deptName);
    }

    /**
     * 获取系部
     * @param deptName
     * @return
     */
    public DeptName getDeptName(String deptName){
        return deptNameMapper.selectByDeptName(deptName);
    }

    /**
     * 获取系部
     * @param deptNameId
     * @return
     */
    public DeptName getDeptName(int deptNameId){
        return deptNameMapper.selectByPrimaryKey(deptNameId);
    }


    /**
     * 通过部门获取系部
     * @param deptStuName
     * @return
     */
    public List<DeptName> getDeptNameByDeptStuName(String deptStuName){
        return deptNameMapper.selectByDeptStuName(deptStuName);
    }

    /**
     * 插入系部和部门表
     * @param deptId
     * @param deptStuId
     * @return
     */
    public int insertDeptAndDeptStu(int deptId,int deptStuId){
        return deptNameMapper.insertDeptNameAndDeptStuName(deptId,deptStuId);
    }

    /**
     * 删除系部
     * @param id
     * @return
     */
    public int  deleteDeptName(int id){
        return deptNameMapper.deleteByPrimaryKey(id);
    }


}
