package com.yzx.model;

import java.util.Date;

public class BookOrder {
    private int id;//预定订单id
    private int accountId;//客户id
    private int roomTypeId;//房型id
    private String name;//预定者姓名
    private String idCard;//身份证号码
    private String phoneNum;//手机号
    private int status;//状态：0：预定中，1：已入住,2:已结算离店 3:已违约
    private Date arriveDate;//入住日期
    private Date leaveDate;//离店日期
    private Date createTime;//预定日期
    private String remark;

    public final static int IN_BOOK=0;
    public final static int IN_ARRIVED=1;
    public final static int IN_LEAVE=2;
    public final static int IN_BREAK=3;

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

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getArriveDate() {
        return arriveDate;
    }

    public void setArriveDate(Date arriveDate) {
        this.arriveDate = arriveDate;
    }

    public Date getLeaveDate() {
        return leaveDate;
    }

    public void setLeaveDate(Date leaveDate) {
        this.leaveDate = leaveDate;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
