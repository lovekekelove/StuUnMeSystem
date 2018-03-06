package com.stumesystem.service;

import com.stumesystem.bean.Dept;
import com.stumesystem.mapper.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeptService {

    @Autowired
    private DeptMapper deptMapper;

    /**
     * 完善资料
     *
     * @param dept
     * @return
     */
    public int insertDept(Dept dept) {
        return deptMapper.insertSelective(dept);
    }

    /**
     * 通过用户id查询dept
     *
     * @param uid
     * @return
     */
    public Dept getDept(Integer uid) {
        return deptMapper.selectByUId(uid);
    }

    /**
     * 更新dept
     *
     * @param dept
     * @return
     */
    public int updateDept(Dept dept) {
        return deptMapper.updateByPrimaryKeySelective(dept);
    }

    /**
     * 通过用户id查询dept包含其他字段
     *
     * @param uid
     * @return
     */
    public Dept getDeptWith(Integer uid) {
        return deptMapper.selectWithByUId(uid);
    }

    /**
     * 删除通过
     *
     * @param uid
     * @return
     */
    public int deleteDeptByUid(Integer uid) {
        return deptMapper.deleteByUid(uid);
    }
}
