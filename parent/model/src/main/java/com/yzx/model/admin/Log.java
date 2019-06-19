package com.yzx.model.admin;

import java.util.Date;

public class Log {
    int id;
    int type;
    String tittle;
    String content;
    Date createTime;

    public final static int SYSTEM=1;
    public final static int BUSSINESS=2;
    public final static int ACCOUNT=3;

    public Log() {
    }

    public Log(int type, String tittle, String content) {
        this.type = type;
        this.tittle = tittle;
        this.content = content;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getTittle() {
        return tittle;
    }

    public void setTittle(String tittle) {
        this.tittle = tittle;
    }

    public Date getCreatTime() {
        return createTime;
    }

    public void setCreatTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
