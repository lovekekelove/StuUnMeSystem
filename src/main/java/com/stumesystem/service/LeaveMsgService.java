package com.stumesystem.service;

import com.stumesystem.bean.LeaveMsg;
import com.stumesystem.mapper.LeaveMsgMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LeaveMsgService {

    @Autowired
    private LeaveMsgMapper leaveMsgMapper;


    /**
     * 添加留言
     *
     * @param leaveMsg
     * @return
     */
    public int insertLeaveMsg(LeaveMsg leaveMsg) {
        return leaveMsgMapper.insertSelective(leaveMsg);
    }

    /**
     * 查询所有的留言
     *
     * @return
     */
    public List<LeaveMsg> getAllLeaveMsg() {
        return leaveMsgMapper.selectLeaveMsg();
    }


    /**
     * 通过id和state查询所有的
     *
     * @param id
     * @param state
     * @return
     */
    public List<LeaveMsg> getAllLeaveMsgBYid(int id, int state) {
        return leaveMsgMapper.selectMsgsByPrimaryKey(id, state);
    }

    /**
     * 插入点赞的人
     *
     * @param msgId
     * @param uid
     * @return
     */
    public int insertZanUser(int msgId, int uid) {
        return leaveMsgMapper.insertZanUser(msgId, uid);
    }

    /**
     * id查找留言
     *
     * @param id
     * @return
     */
    public LeaveMsg getLeaveById(int id) {
        return leaveMsgMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新点赞
     *
     * @param leaveMsg
     * @return
     */
    public int updateLeave(LeaveMsg leaveMsg) {
        return leaveMsgMapper.updateByPrimaryKeySelective(leaveMsg);
    }


}
