package com.stumesystem.bean;

public class JiBie {
    private Integer jid;

    private String dengji;

    public Integer getJid() {
        return jid;
    }

    public void setJid(Integer jid) {
        this.jid = jid;
    }

    public String getDengji() {
        return dengji;
    }

    public void setDengji(String dengji) {
        this.dengji = dengji == null ? null : dengji.trim();
    }
}