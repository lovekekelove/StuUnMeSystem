package com.stumesystem.bean;

public class DeptStu {
    private Integer id;

    private String deptStuName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeptStuName() {
        return deptStuName;
    }

    public void setDeptStuName(String deptStuName) {
        this.deptStuName = deptStuName == null ? null : deptStuName.trim();
    }
}