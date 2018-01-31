package com.stumesystem.bean;

import java.util.List;

public class StuRose {
    private Integer id;

    private String rose;

    private List<StuRight> rightList;

    public List<StuRight> getRightList() {
        return rightList;
    }

    public void setRightList(List<StuRight> rightList) {
        this.rightList = rightList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRose() {
        return rose;
    }

    public void setRose(String rose) {
        this.rose = rose == null ? null : rose.trim();
    }
}