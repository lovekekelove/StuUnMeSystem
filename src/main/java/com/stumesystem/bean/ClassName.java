package com.stumesystem.bean;

public class ClassName {
    private Integer id;

    private String className;

    private Integer deptNameId;

    private Integer jiid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
    }

    public Integer getDeptNameId() {
        return deptNameId;
    }

    public void setDeptNameId(Integer deptNameId) {
        this.deptNameId = deptNameId;
    }

    public Integer getJiid() {
        return jiid;
    }

    public void setJiid(Integer jiid) {
        this.jiid = jiid;
    }
}