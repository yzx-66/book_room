package com.yzx.model.admin;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CheckIn {
    private int id;//入住id
    private int roomId;//房间id
    private Float checkinPrice;//入住价格
    private int liveDays;
    private String name;//入住者姓名
    private String idCard;//身份证号码
    private String phoneNum;//手机号
    private int status;//状态：0：入住中，1：已结算离店
    private Date arriveDate;//入住日期
    private Date leaveDate;//离店日期
    private Date createTime;//创建时间
    private Integer bookOrderId;//预定订单id，可为空
    private Integer accountId;
    private String remark;

    public final static int IN_ARRIVED=0;
    public final static int IN_LEAVE=1;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Float getCheckinPrice() {
        return checkinPrice;
    }

    public void setCheckinPrice(Float checkinPrice) {
        this.checkinPrice = checkinPrice;
    }

    public int getLiveDays() {
        //时间转换类
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = arriveDate;
        Date date2 = leaveDate;
        //将转换的两个时间对象转换成Calendard对象
        Calendar can1 = Calendar.getInstance();
        can1.setTime(date1);
        Calendar can2 = Calendar.getInstance();
        can2.setTime(date2);
        //拿出两个年份
        int year1 = can1.get(Calendar.YEAR);
        int year2 = can2.get(Calendar.YEAR);
        //天数
        int days = 0;
        Calendar can = null;
        //如果can1 < can2
        //减去小的时间在这一年已经过了的天数
        //加上大的时间已过的天数
        if(can1.before(can2)){
            days -= can1.get(Calendar.DAY_OF_YEAR);
            days += can2.get(Calendar.DAY_OF_YEAR);
            can = can1;
        }else{
            days -= can2.get(Calendar.DAY_OF_YEAR);
            days += can1.get(Calendar.DAY_OF_YEAR);
            can = can2;
        }
        for (int i = 0; i < Math.abs(year2-year1); i++) {
            //获取小的时间当前年的总天数
            days += can.getActualMaximum(Calendar.DAY_OF_YEAR);
            //再计算下一年。
            can.add(Calendar.YEAR, 1);
        }
        return days;
    }

    public void setLiveDays(int liveDays) {
        this.liveDays = liveDays;
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

    public Integer getBookOrderId() {
        return bookOrderId;
    }

    public void setBookOrderId(Integer bookOrderId) {
        this.bookOrderId = bookOrderId;
    }

    public Integer getAccountId() {
        return accountId;
    }

    public void setAccountId(Integer accountId) {
        this.accountId = accountId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}

