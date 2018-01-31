package com.stumesystem.bean;

public class StuRight {
    private Integer id;

    private String right;

    private Integer fid;

    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRight() {
        return right;
    }

    public void setRight(String right) {
        this.right = right == null ? null : right.trim();
    }

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }
}