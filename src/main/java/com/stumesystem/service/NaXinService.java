package com.stumesystem.service;

import com.stumesystem.bean.NaXin;
import com.stumesystem.mapper.NaXinMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class NaXinService {

    @Autowired
    private NaXinMapper naXinMapper;

    /**
     * 纳新
     *
     * @param naXin
     * @return
     */
    public int insertNaXin(NaXin naXin) {
        return naXinMapper.insertSelective(naXin);
    }

    /**
     * get NaXin
     *
     * @param uid
     * @return
     */
    public NaXin getNaXinByUId(Integer uid) {
        return naXinMapper.selectByUId(uid);
    }

    /**
     * 根据条件查询纳新信息
     *
     * @param map
     * @return
     */
    public List<NaXin> getNaXinAll(HashMap<String, Integer> map) {
        return naXinMapper.selectAll(map);
    }

    /**
     * 根据条件查询纳新信息
     *
     * @param map
     * @return
     */
    public List<NaXin> getNaXinAllEnd(HashMap<String, Integer> map) {
        return naXinMapper.selectAllEnd(map);
    }

    /**
     * 删除纳新人员
     *
     * @param id
     * @return
     */
    public int deleteNaXin(Integer id) {
        return naXinMapper.deleteByPrimaryKey(id);
    }

    /**
     * by id
     *
     * @param id
     * @return
     */
    public NaXin getNaXinById(Integer id) {
        return naXinMapper.selectByPrimaryKey(id);
    }

    /**
     * 连接查询
     *
     * @param id
     * @return
     */
    public NaXin getNaXinByIdWithName(Integer id) {
        return naXinMapper.selectByUIdWithName(id);
    }

    /**
     * 审核
     *
     * @param naXin
     * @return
     */
    public int updateNaXin(NaXin naXin) {
        return naXinMapper.updateByPrimaryKeySelective(naXin);
    }
}
