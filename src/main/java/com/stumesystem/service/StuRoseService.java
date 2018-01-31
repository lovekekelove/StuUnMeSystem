
package com.stumesystem.service;

import com.stumesystem.bean.StuRose;
import com.stumesystem.mapper.StuRoseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StuRoseService {

    @Autowired
    private StuRoseMapper stuRoseMapper;

    /**
     * 判断角色
     *
     * @param uid
     * @return
     */
    public int getRose(Integer uid) {
        StuRose stuRose = stuRoseMapper.selectId(uid);
        return stuRose.getId();
    }

    /**
     * 获取所有的角色
     *
     * @return
     */
    public List<StuRose> getRose() {
        return stuRoseMapper.getRoses();
    }

    /**
     * id获取rose
     *
     * @param id
     * @return
     */
    public StuRose getRoses(Integer id) {
        return stuRoseMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新角色
     *
     * @param uid
     * @param rid
     * @return
     */
    public int updateRose(Integer rid, Integer uid) {
        return stuRoseMapper.updateByUidSelective(rid, uid);
    }

    /**
     * 添加角色
     *
     * @param rose
     * @return
     */
    public int insertRose(StuRose rose) {
        return stuRoseMapper.insertSelective(rose);
    }

    /**
     * 删除角色
     *
     * @param id
     * @return
     */
    public int deleteRose(Integer id) {
        return stuRoseMapper.deleteByPrimaryKey(id);
    }
}
