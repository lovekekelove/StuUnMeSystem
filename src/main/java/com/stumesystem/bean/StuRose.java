package com.stumesystem.bean;

public class StuRose {
    private Integer id;

    private String rRose;

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