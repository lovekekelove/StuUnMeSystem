package com.stumesystem.bean;

import java.util.Date;

public class LeaveMsg {
    private Integer id;

    private String count;

    private Date creattime;

    private Integer sendUid;

    private Integer state;

    private Integer zanNum;

    private String imgHeah;

    private String nickname;

    private Integer zanUid;

    public Integer getZanUid() {
        return zanUid;
    }

    public void setZanUid(Integer zanUid) {
        this.zanUid = zanUid;
    }

    public String getImgHeah() {
        return imgHeah;
    }

    public void setImgHeah(String imgHeah) {
        this.imgHeah = imgHeah;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count == null ? null : count.trim();
    }

    public Date getCreattime() {
        return creattime;
    }

    public void setCreattime(Date creattime) {
        this.creattime = creattime;
    }

    public Integer getSendUid() {
        return sendUid;
    }

    public void setSendUid(Integer sendUid) {
        this.sendUid = sendUid;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getZanNum() {
        return zanNum;
    }

    public void setZanNum(Integer zanNum) {
        this.zanNum = zanNum;
    }
}