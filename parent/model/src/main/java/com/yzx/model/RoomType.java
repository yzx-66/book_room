package com.yzx.model;

public class RoomType {
    private int id;
    private int floorId;//属于哪个楼层
    private String name;//房型名
    private String photo;//房间类型图片
    private Float price;//房型价格
    private int liveNum;//可住人数
    private int bedNum;//床位数
    private int roomNum=0;//房间数
    private int avilableNum;//可住或可预定房间数
    private int bookNum;//预定数
    private int livedNum;//已经入住数
    private int canNotLiveNum;
    private int status;//房型状态，0：房型已满,1:可预订可入住 2:不可住
    private String remark;//房型备注

    public final static int FULL=0;
    public final static int CAN_LIVE=1;
    public final static int NOT_LIVE=2;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFloorId() {
        return floorId;
    }

    public void setFloorId(int floorId) {
        this.floorId = floorId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public int getLiveNum() {
        return liveNum;
    }

    public void setLiveNum(int liveNum) {
        this.liveNum = liveNum;
    }

    public int getBedNum() {
        return bedNum;
    }

    public void setBedNum(int bedNum) {
        this.bedNum = bedNum;
    }

    public int getRoomNum() {
        return roomNum;
    }

    public void setRoomNum(int roomNum) {
        this.roomNum = roomNum;
    }

    public int getcanNotLiveNum() {
        return canNotLiveNum;
    }

    public void setcanNotLiveNum(int canNotLiveNum) {
        this.canNotLiveNum = canNotLiveNum;
    }

    public int getAvilableNum() {
        return roomNum-(bookNum+livedNum+canNotLiveNum);
    }

    public void setAvilableNum(int avilableNum) {
        this.avilableNum = avilableNum;
    }

    public int getBookNum() {
        return bookNum;
    }

    public void setBookNum(int bookNum) {
        this.bookNum = bookNum;
    }

    public int getLivedNum() {
        return livedNum;
    }

    public void setLivedNum(int livedNum) {
        this.livedNum = livedNum;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "RoomType{" +
                "id=" + id +
                ", floorId=" + floorId +
                ", name='" + name + '\'' +
                ", photo='" + photo + '\'' +
                ", price=" + price +
                ", liveNum=" + liveNum +
                ", bedNum=" + bedNum +
                ", roomNum=" + roomNum +
                ", avilableNum=" + avilableNum +
                ", bookNum=" + bookNum +
                ", livedNum=" + livedNum +
                ", status=" + status +
                ", remark='" + remark + '\'' +
                '}';
    }
}
