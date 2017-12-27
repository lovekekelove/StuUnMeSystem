package com.stumesystem.bean;

public class StuRight {
    private Integer id;

    private String rRight;

    private Integer fid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getrRight() {
        return rRight;
    }

    public void setrRight(String rRight) {
        this.rRight = rRight == null ? null : rRight.trim();
    }

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }
}