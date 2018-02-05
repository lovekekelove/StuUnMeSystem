package com.stumesystem.bean;

import java.util.Date;

public class PointMsg {
    private Integer id;

    private String msgCount;

    private Integer sendUid;

    private Integer acceptUid;

    private Date sendTime;

    private String state;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMsgCount() {
        return msgCount;
    }

    public void setMsgCount(String msgCount) {
        this.msgCount = msgCount == null ? null : msgCount.trim();
    }

    public Integer getSendUid() {
        return sendUid;
    }

    public void setSendUid(Integer sendUid) {
        this.sendUid = sendUid;
    }

    public Integer getAcceptUid() {
        return acceptUid;
    }

    public void setAcceptUid(Integer acceptUid) {
        this.acceptUid = acceptUid;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }
}