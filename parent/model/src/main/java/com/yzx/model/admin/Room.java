package com.yzx.model.admin;

public class Room {
    private int id;
    private String sn;
    private String name;
    private int roomTypeId;
    private String photo;
    private String remark;
    private int status;//房型状态，0：可入住,1:已预定,2:已入住,3:打扫中

    private String roomTypeAndFloor;

    public final static int CAN_LIVE=0;
    public final static int ALEARY_BOOK=1;
    public final static int ALEARY_LIVE=2;
    public final static int DO_CLEAN=3;
    public final static int CAN_NOT_LIVE=4;

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

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getRoomTypeAndFloor() {
        return roomTypeAndFloor;
    }

    public void setRoomTypeAndFloor(String roomTypeAndFloor) {
        this.roomTypeAndFloor = roomTypeAndFloor;
    }
}
