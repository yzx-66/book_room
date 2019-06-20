package com.yzx.model;

import java.util.Date;

public class BlackList {
    private int id;
    private int accountId;
    private Date inTime;
    private Date outTime;

    public final static int MONTH_MOST_BREAKTIMES=3;
    public final static int SUM_MOST_BREAKTIMES=20;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public Date getInTime() {
        return inTime;
    }

    public void setInTime(Date inTime) {
        this.inTime = inTime;
    }

    public Date getOutTime() {
        return outTime;
    }

    public void setOutTime(Date outTime) {
        this.outTime = outTime;
    }
}
