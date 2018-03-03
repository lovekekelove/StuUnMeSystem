package com.stumesystem.service;

import com.stumesystem.bean.NaXin;
import com.stumesystem.mapper.NaXinMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
