package com.stumesystem.bean;

import java.util.Date;

public class Comments {
    private Integer comId;

    private Integer comFid;

    private Integer topicId;

    private String comCount;

    private Date comTime;

    private Integer comUserId;

    private Integer comState;

    private String imgHeah;

    private String nickname;

    private String title;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public Integer getComId() {
        return comId;
    }

    public void setComId(Integer comId) {
        this.comId = comId;
    }

    public Integer getComFid() {
        return comFid;
    }

    public void setComFid(Integer comFid) {
        this.comFid = comFid;
    }

    public Integer getTopicId() {
        return topicId;
    }

    public void setTopicId(Integer topicId) {
        this.topicId = topicId;
    }

    public String getComCount() {
        return comCount;
    }

    public void setComCount(String comCount) {
        this.comCount = comCount == null ? null : comCount.trim();
    }

    public Date getComTime() {
        return comTime;
    }

    public void setComTime(Date comTime) {
        this.comTime = comTime;
    }

    public Integer getComUserId() {
        return comUserId;
    }

    public void setComUserId(Integer comUserId) {
        this.comUserId = comUserId;
    }

    public Integer getComState() {
        return comState;
    }

    public void setComState(Integer comState) {
        this.comState = comState;
    }
}