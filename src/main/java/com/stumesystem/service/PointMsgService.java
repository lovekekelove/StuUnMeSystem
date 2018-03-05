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
    public int getNum(Integer id) {
        return pointMsgMapper.selectNum(id);
    }

    /**
     * 查询数量
     *
     * @return
     */
    public int getNumAdvice(Integer id) {
        return pointMsgMapper.selectNumAdvice(id);
    }


    /**
     * 查询数量
     *
     * @return
     */
    public int getNumWithTalk(Integer id) {
        return pointMsgMapper.selectNumTalk(id);
    }

    /**
     * 提示列表
     *
     * @return
     */
    public List<PointMsg> getPointMsg(Integer id) {
        return pointMsgMapper.selectAllWithState(id);
    }

    /**
     * 提示列表
     *
     * @return
     */
    public List<PointMsg> getAdviceMsg(Integer id) {
        return pointMsgMapper.selectAllWithStateAndAdvice(id);
    }

    /**
     * 提示列表
     *
     * @return
     */
    public List<PointMsg> getPointMsgWithTalk(Integer id) {
        return pointMsgMapper.selectAllWithStateAndTalk(id);
    }

    /**
     * 接受方 查找提示
     *
     * @param acc_id,send_id
     * @return
     */
    public PointMsg getPointMsgByAcceptId(Integer acc_id, Integer send_id) {
        return pointMsgMapper.selectByAcceptUid(acc_id, send_id);
    }

    /**
     * 接受方 查找提示
     *
     * @param acc_id,send_id
     * @return
     */
    public PointMsg getMsgByAcceptIdAndSendUid(Integer acc_id, Integer send_id) {
        return pointMsgMapper.selectByAcceptUidAndSendUid(acc_id, send_id);
    }

    /**
     * 更新
     *
     * @param pointMsg
     * @return
     */
    public int updatePointMsg(PointMsg pointMsg) {
        return pointMsgMapper.updateByPrimaryKeySelective(pointMsg);
    }

    /**
     * 查找PointMsg
     *
     * @param id
     * @return
     */
    public PointMsg getPointMsgById(Integer id) {
        return pointMsgMapper.selectByPrimaryKey(id);
    }

}
