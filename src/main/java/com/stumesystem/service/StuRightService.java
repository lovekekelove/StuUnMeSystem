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
}
