package com.stumesystem.bean;

import java.util.Date;

public class Topic {
    private Integer id;

    private String title;

    private Integer stuSendId;

    private Date ttime;

    private Integer treplaycount;

    private Integer tclickcount;

    private Date tlastclicktime;

    private Integer tstaus;

    private Integer tzan;

    private String tcontent;

    private String imgHeah;

    private String nickname;

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getStuSendId() {
        return stuSendId;
    }

    public void setStuSendId(Integer stuSendId) {
        this.stuSendId = stuSendId;
    }

    public Date getTtime() {
        return ttime;
    }

    public void setTtime(Date ttime) {
        this.ttime = ttime;
    }

    public Integer getTreplaycount() {
        return treplaycount;
    }

    public void setTreplaycount(Integer treplaycount) {
        this.treplaycount = treplaycount;
    }

    public Integer getTclickcount() {
        return tclickcount;
    }

    public void setTclickcount(Integer tclickcount) {
        this.tclickcount = tclickcount;
    }

    public Date getTlastclicktime() {
        return tlastclicktime;
    }

    public void setTlastclicktime(Date tlastclicktime) {
        this.tlastclicktime = tlastclicktime;
    }

    public Integer getTstaus() {
        return tstaus;
    }

    public void setTstaus(Integer tstaus) {
        this.tstaus = tstaus;
    }

    public Integer getTzan() {
        return tzan;
    }

    public void setTzan(Integer tzan) {
        this.tzan = tzan;
    }

    public String getTcontent() {
        return tcontent;
    }

    public void setTcontent(String tcontent) {
        this.tcontent = tcontent == null ? null : tcontent.trim();
    }
}