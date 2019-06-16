package com.yzx.model.admin;

import java.util.Date;


public class Checkin {
	private Long id;//入住id
	private Long roomId;//房间id
	private Long roomTypeId;//房型id
	private Float checkinPrice;//入住价格

	private String name;//入住者姓名
	private String idCard;//身份证号码
	private String mobile;//手机号
	private int status;//状态：0：入住中，1：已结算离店
	private String arriveDate;//入住日期
	private String leaveDate;//离店日期
	private Date createTime;//创建时间
	private Long bookOrderId;//预定订单id，可为空
	private String remark;

	public final static int IN_ARRIVED=0;
	public final static int IN_LEAVE=1;
}
