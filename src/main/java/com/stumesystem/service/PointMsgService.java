package com.stumesystem.service;

import com.stumesystem.bean.PointMsg;
import com.stumesystem.mapper.PointMsgMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author:张腾飞
 * @Date:2018/2/5 16:47
 */
@Service
public class PointMsgService {

    @Autowired
    private PointMsgMapper pointMsgMapper;

    /**
     * 插入提示信息
     *
     * @param pointMsg
     * @return
     */
    public int insertPointMsg(PointMsg pointMsg) {
        return pointMsgMapper.insertSelective(pointMsg);
    }

    /**
     * 查询数量
     *
     * @return
     */
    public int getNum() {
        return pointMsgMapper.selectNum();
    }

    /**
     * 提示列表
     *
     * @return
     */
    public List<PointMsg> getPointMsg() {
        return pointMsgMapper.selectAllWithState();
    }

}
