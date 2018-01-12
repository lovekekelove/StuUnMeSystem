package com.stumesystem.bean;

import java.util.List;

public class StuRose {
    private Integer id;

    private String rRose;

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

    public String getrRose() {
        return rRose;
    }

    public void setrRose(String rRose) {
        this.rRose = rRose == null ? null : rRose.trim();
    }
}