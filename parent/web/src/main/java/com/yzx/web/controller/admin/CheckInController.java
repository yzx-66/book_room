package com.yzx.web.controller.admin;

import com.yzx.model.BookOrder;
import com.yzx.model.RoomType;
import com.yzx.model.admin.CheckIn;
import com.yzx.model.admin.Log;
import com.yzx.model.admin.Page;
import com.yzx.model.admin.Room;
import com.yzx.service.BookOrderService;
import com.yzx.service.RoomTypeService;
import com.yzx.service.admin.CheckInService;
import com.yzx.service.admin.LogService;
import com.yzx.service.admin.RoomService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("admin/checkIn")
public class CheckInController {

    @Autowired
    private BookOrderService bookOrderService;
    @Autowired
    private RoomTypeService roomTypeService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private CheckInService checkInService;
    @Autowired
    private LogService logService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(HttpServletRequest request){
        List<RoomType> allRoomTypes=roomTypeService.findAllRoomeType();
        Set<String> roomTypeNames=new HashSet<>();
        for(RoomType r:allRoomTypes){
            if(r.getStatus()==RoomType.NOT_LIVE){
                continue;
            }
            roomTypeNames.add(r.getName());
        }
        request.getSession().setAttribute("roomTypeNames",roomTypeNames);
        return "admin/checkIn/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,Object> add(CheckIn checkIn, String arriveTime, String leaveTime,Integer chose){
            Map<String, Object> ret = new HashMap<>();

            if (!IsContinueByDateFormat(ret, arriveTime, leaveTime).get("type").equals("success")) {
                return ret;
            }

            checkIn.setArriveDate((Date) ret.get("arriveDate"));
            checkIn.setLeaveDate((Date) ret.get("leaveDate"));
            checkIn.setCreateTime(new Date());
            checkIn.setStatus(CheckIn.IN_ARRIVED);
            setPrice(checkIn);

            if (!makeRoom_0_to_2(checkIn, ret, chose)) {
                return ret;
            }

            if (checkInService.addCheckIn(checkIn) <= 0) {
                ret.put("type", "error");
                ret.put("msg", "添加失败 请联系管理员");
                logService.addLog(Log.SYSTEM, "添加失败", "添加入住订单时，操作个数小于1");
            } else {
                ret.put("type", "success");
            }
        return ret;
    }

    @RequestMapping("back")
    @ResponseBody
    public Map<String,String> back(int id){
        Map<String,String> ret=new HashMap<>();

        CheckIn checkIn=checkInService.findCheckInById(id);
        makeRoom_2_to_0(checkIn,Room.DO_CLEAN);

        ret.put("type","success");
        return ret;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int id){
        Map<String,String> ret=new HashMap<>();
        CheckIn checkIn=checkInService.findCheckInById(id);
        if(checkInService.deleteCheckIn(id)<=0) {
            ret.put("type", "error");
            ret.put("msg", "删除出错 请联系管理员");
            logService.addLog(Log.SYSTEM,"添加失败","删除入住订单时，操作个数小于1");
            return ret;
        }else {
            makeRoom_2_to_0(checkIn,-1);
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping(value="list",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> findList(Page page,Integer status,String arriveTime,String leaveTime,
                                       @RequestParam(value = "accountPhone",defaultValue = "",required = false)String accountName,
                                       @RequestParam(value = "name",defaultValue = "",required = false)String name,
                                       @RequestParam(value = "phoneNum",defaultValue = "",required = false)String phoneNum

    ) throws ParseException {
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        queryMap.put("accountPhone",accountName);
        queryMap.put("name",name);
        queryMap.put("phoneNum",phoneNum);
        if (!StringUtils.isEmpty(arriveTime)){
            queryMap.put("arriveDate",format.parse(arriveTime));
        }else {
            queryMap.put("arriveDate",arriveTime);
        }
        if (!StringUtils.isEmpty(leaveTime)){
            queryMap.put("leaveDate",format.parse(leaveTime));
        }else {
            queryMap.put("leaveDate",leaveTime);
        }
        queryMap.put("status",status);
        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());
        System.out.println(queryMap);

        ret.put("rows",checkInService.findList(queryMap));
        ret.put("total",checkInService.getTotal(queryMap));
        return ret;
    }

    boolean checkArriveAndLeaveTime(Date arrive,Date leave) throws ParseException {
        SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
        Date now_day=formater.parse(formater.format(new Date()));
        if(now_day.compareTo(arrive)==0) {
            if(arrive.compareTo(leave)==-1){
                return true;
            }
        }
        return false;
    }


    public Map<String,Object> IsContinueByDateFormat(Map<String,Object> ret,String arriveTime,String leaveTime){
        Date arriveDate;
        Date leaveDate;
        try{
            SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
            arriveDate=formater.parse(arriveTime);
            leaveDate=formater.parse(leaveTime);

            if(!checkArriveAndLeaveTime(arriveDate,leaveDate)){
                ret.put("type","error");
                ret.put("msg","日期填写不合适,入住日期必须是今天，且至少住一天，请修改");
                return ret;
            }
        }catch (Exception e){
            ret.put("type","error");
            ret.put("msg","日期格式转化不正确 请按格式填写");
            return ret;
        }
        ret.put("type","success");
        ret.put("arriveDate",arriveDate);
        ret.put("leaveDate",leaveDate);
        return ret;
    }

    public void setPrice(CheckIn checkIn){
        Calendar arriveTime=Calendar.getInstance();
        Calendar leaveTime=Calendar.getInstance();

        arriveTime.setTime(checkIn.getArriveDate());
        leaveTime.setTime(checkIn.getLeaveDate());

        long arriveTimeTimeInMillis=arriveTime.getTimeInMillis();
        long leaveTimeTimeInMillis=leaveTime.getTimeInMillis();
        long days=(leaveTimeTimeInMillis-arriveTimeTimeInMillis)/(1000*60*60*24);//化为天

        checkIn.setCheckinPrice(days*checkIn.getCheckinPrice());
    }


    public boolean makeRoom_0_to_2(CheckIn checkIn,Map<String,Object> ret,int chose){
        RoomType roomType=roomTypeService.findRoomTypeByRoomId(checkIn.getRoomId());
        roomType.setLivedNum(roomType.getLivedNum()+1);

        Room room=roomService.findRoomById(checkIn.getRoomId());
        if((chose==0 && room.getStatus()!=Room.CAN_LIVE) || (chose==1 && room.getStatus()!=Room.ALEARY_BOOK) ){
            ret.put("type","error");
            ret.put("msg","来晚了，这间房被抢走了！");
            return false;
        }
        room.setStatus(Room.ALEARY_LIVE);
        logService.addLog(Log.SYSTEM,"test","0");
        roomService.eidtRoom(room);


        if(checkIn.getBookOrderId()!=null){
            checkIn.setAccountId(bookOrderService.findBookOrderById(checkIn.getBookOrderId()).getAccountId());
            roomType.setBookNum(roomType.getBookNum()-1);
            BookOrder bookOrder=bookOrderService.findBookOrderById(checkIn.getBookOrderId());
            bookOrder.setStatus(BookOrder.IN_ARRIVED);
            bookOrderService.eidtBookOrder(bookOrder);
        }else {
            checkIn.setAccountId(null);
        }
        roomTypeService.eidtRoomType(roomType);
        return true;
    }

    public void makeRoom_2_to_0(CheckIn checkIn,int toRoomStatus){
        RoomType roomType=roomTypeService.findRoomTypeByRoomId(checkIn.getRoomId());
        roomType.setLivedNum(roomType.getLivedNum()-1);

        BookOrder bookOrder=null;
        Room room=roomService.findRoomById(checkIn.getRoomId());

        if(toRoomStatus==Room.DO_CLEAN){//正常退房
            checkIn.setStatus(CheckIn.IN_LEAVE);
            room.setStatus(Room.DO_CLEAN);
            roomType.setcanNotLiveNum(roomType.getcanNotLiveNum()+1);

            if(checkIn.getBookOrderId()!=null) {
                bookOrder = bookOrderService.findBookOrderById(checkIn.getBookOrderId());
                bookOrder.setStatus(BookOrder.IN_LEAVE);
                checkIn.setBookOrderId(null);
            }
            logService.addLog(Log.BUSSINESS,"退房记录","手机号为"+checkIn.getPhoneNum()+"退房成功");
        }else {
            if(checkIn.getBookOrderId()!=null){//删除入住：删除现场订单 预定订单
                roomType.setBookNum(roomType.getBookNum()+1);
                bookOrder=bookOrderService.findBookOrderById(checkIn.getBookOrderId().intValue());
                bookOrder.setStatus(BookOrder.IN_BOOK);
                room.setStatus(Room.ALEARY_BOOK);
                checkIn.setBookOrderId(null);
            }else {
                room.setStatus(Room.CAN_LIVE);
            }
            logService.addLog(Log.BUSSINESS,"删除入住","手机号为"+checkIn.getPhoneNum()+"入住记录被删除");
        }

        checkInService.eidtCheckIn(checkIn);
        roomTypeService.eidtRoomType(roomType);
        if(bookOrder!=null){
            bookOrderService.eidtBookOrder(bookOrder);
        }
        roomService.eidtRoom(room);
    }


}
