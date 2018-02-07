package com.stumesystem.bean;

import java.util.Date;

public class Comment {
    private Integer cid;

    private Integer ctid;

    private Integer cuid;

    private Date ctime;

    private String content;

    private Integer rootcid;

    private Integer parentuid;

    private Integer czan;

    private Integer isread;

    private Integer parentcid;

    private Integer isshow;

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getCtid() {
        return ctid;
    }

    public void setCtid(Integer ctid) {
        this.ctid = ctid;
    }

    public Integer getCuid() {
        return cuid;
    }

    public void setCuid(Integer cuid) {
        this.cuid = cuid;
    }

    public Date getCtime() {
        return ctime;
    }

    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getRootcid() {
        return rootcid;
    }

    public void setRootcid(Integer rootcid) {
        this.rootcid = rootcid;
    }

    public Integer getParentuid() {
        return parentuid;
    }

    public void setParentuid(Integer parentuid) {
        this.parentuid = parentuid;
    }

    public Integer getCzan() {
        return czan;
    }

    public void setCzan(Integer czan) {
        this.czan = czan;
    }

    public Integer getIsread() {
        return isread;
    }

    public void setIsread(Integer isread) {
        this.isread = isread;
    }

    public Integer getParentcid() {
        return parentcid;
    }

    public void setParentcid(Integer parentcid) {
        this.parentcid = parentcid;
    }

    public Integer getIsshow() {
        return isshow;
    }

    public void setIsshow(Integer isshow) {
        this.isshow = isshow;
    }
}