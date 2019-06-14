package com.yzx.model;

public class Account {
    private int id;//客户id
    private String name;//显示用户名
    private String phoneNum;//手机号
    private String password;//客户登录密码
    private String realName;//真实姓名
    private String idCard;//身份证号码
    private String photo;
    private String address;//联系地址
    private int status=1;//状态：1：可用，0：冻结
    private int monthBreakTimes;
    private int sumBreakTimes;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
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

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getMonthBreakTimes() {
        return monthBreakTimes;
    }

    public void setMonthBreakTimes(int monthBreakTimes) {
        this.monthBreakTimes = monthBreakTimes;
    }

    public int getSumBreakTimes() {
        return sumBreakTimes;
    }

    public void setSumBreakTimes(int sumBreakTimes) {
        this.sumBreakTimes = sumBreakTimes;
    }
}
