package com.stumesystem.bean;

import java.util.Date;

public class Topic {
    private Integer id;

    private Integer title;

    private Integer deptNameId;

    private String stuSendId;

    private Date ttime;

    private Integer treplaycount;

    private Integer tclickcount;

    private Date tlastclicktime;

    private Integer tstaus;

    private Integer tzan;

    private String tcontent;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTitle() {
        return title;
    }

    public void setTitle(Integer title) {
        this.title = title;
    }

    public Integer getDeptNameId() {
        return deptNameId;
    }

    public void setDeptNameId(Integer deptNameId) {
        this.deptNameId = deptNameId;
    }

    public String getStuSendId() {
        return stuSendId;
    }

    public void setStuSendId(String stuSendId) {
        this.stuSendId = stuSendId == null ? null : stuSendId.trim();
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