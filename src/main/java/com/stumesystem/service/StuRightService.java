package com.stumesystem.service;

import com.stumesystem.bean.StuRight;
import com.stumesystem.mapper.StuRightMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StuRightService {

    @Autowired
    private StuRightMapper stuRightMapper;

    /**
     * 通过角色Id查询right
     *
     * @param rid
     * @return
     */
    public List<StuRight> getRightByRoseId(Integer rid) {
        return stuRightMapper.selectByRoseId(rid);
    }

    /**
     * 删除权限中间表
     *
     * @param rgId
     * @param rid
     * @return
     */
    public int deleteRightWithRose(Integer rgId, Integer rid) {
        return stuRightMapper.deleteRoseWithRight(rgId, rid);
    }

    /**
     * 删除权限中间表fid
     *
     * @param fId
     * @param rid
     * @return
     */
    public int deleteRightWithRoseByFid(Integer fId, Integer rid) {
        return stuRightMapper.deleteRoseWithRight(fId, rid);
    }


    /**
     * fid查询权限
     * @param fid
     * @return
     */
    public List<StuRight> getStuRightByFid(Integer fid){
        return stuRightMapper.selectByFid(fid);
    }

    /**
     * 查询主菜单
     *
     * @return
     */
    public List<StuRight> getStuRightNull() {
        return stuRightMapper.selectNull();
    }

    /**
     * 获取所有的权限
     *
     * @return
     */
    public List<StuRight> getStuRights() {
        return stuRightMapper.selectAll();
    }

    /**
     * 插入中间表
     *
     * @param rgId
     * @param rid
     * @return
     */
    public int insertRight(Integer rgId, Integer rid) {
        return stuRightMapper.insertRoseWithRight(rgId, rid);
    }

    /**
     * 删除权限
     *
     * @param id
     * @return
     */
    public int delRight(Integer id) {
        return stuRightMapper.deleteByPrimaryKey(id);
    }

    /**
     * 添加权限
     *
     * @param stuRight
     * @return
     */
    public int addRight(StuRight stuRight) {
        return stuRightMapper.insertSelective(stuRight);
    }

    /**
     * id获取权限
     *
     * @param id
     * @return
     */
    public StuRight getStu(Integer id) {
        return stuRightMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新权限
     *
     * @param stuRight
     * @return
     */
    public int updateStuRight(StuRight stuRight) {
        return stuRightMapper.updateByPrimaryKeySelective(stuRight);
    }
}
