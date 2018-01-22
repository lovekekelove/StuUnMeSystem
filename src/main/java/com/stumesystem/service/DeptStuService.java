package com.stumesystem.service;

import com.stumesystem.bean.DeptStu;
import com.stumesystem.mapper.DeptStuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptStuService {

    @Autowired
    private DeptStuMapper deptStuMapper;

    /**
     * 插入部门
     * @param deptStu
     * @return
     */
    public int insertDeptStu(DeptStu deptStu){
        return deptStuMapper.insert(deptStu);
    }

    /**
     * 获取部门
     * @param deptStuName
     * @return
     */
    public DeptStu getDeptStu(String deptStuName){
        return deptStuMapper.selectBydeptStuName(deptStuName);
    }

    /**
     * 获取部门
     * @param id
     * @return
     */
    public DeptStu getDeptStuKey(int id){
        return deptStuMapper.selectByPrimaryKey(id);
    }

    /**
     * 获取所有的部门
     * @return
     */
    public List<DeptStu> getDeptStus(){
        return deptStuMapper.getDeptStus();
    }

    /**
     * 删除系部
     * @param id
     * @return
     */
    public int  deleteDeptName(int id){
        return deptStuMapper.deleteByPrimaryKey(id);
    }

    /**
     * 根据系部ID获取所有的部门
     * @param deptId
     * @return
     */
    public List<DeptStu> getDeptStuByDeptId(int  deptId){
        return deptStuMapper.selectByDeptNameId(deptId);
    }
}
