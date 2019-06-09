package com.yzx.model.admin;

import java.util.Date;

public class Log {
    int id;
    String content;
    Date createTime;

    public Log() {
    }

    public Log(String content, Date createTime) {
        this.content = content;
        this.createTime = createTime;
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
