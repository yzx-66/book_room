package com.yzx.web.controller;

import com.yzx.mapper.admin.LogMapper;
import com.yzx.model.BookOrder;
import com.yzx.model.RoomType;
import com.yzx.model.admin.Page;
import com.yzx.service.AccountService;
import com.yzx.service.BookOrderService;
import com.yzx.service.RoomTypeService;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("admin/bookOrder")
public class BookOrderController {

    @Autowired
    private BookOrderService bookOrderService;
    @Autowired
    private RoomTypeService roomTypeService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(HttpServletRequest request){
        return "admin/bookOrder/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(BookOrder bookOrder,String arriveTime,String leaveTime){
        Map<String,String> ret=new HashMap<>();
        Date arriveDate;
        Date leaveDate;

        try{
            SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
            arriveDate=formater.parse(arriveTime);
            leaveDate=formater.parse(leaveTime);

            if(!checkArriveAndLeaveTime(arriveDate,leaveDate)){
                ret.put("type","error");
                ret.put("msg","日期填写不合适 请修改");
                return ret;
            }
        }catch (Exception e){
            ret.put("type","error");
            ret.put("msg","日期格式转化不正确 请按格式填写");
            return ret;
        }

        bookOrder.setArriveDate(arriveDate);
        bookOrder.setLeaveDate(leaveDate);
        bookOrder.setCreateTime(new Date());

        if(bookOrderService.addBookOrder(bookOrder)<=0){
            ret.put("type","error");
            ret.put("msg","添加失败 请联系管理员");
        }else {
            ret.put("type","success");
            RoomType roomType=roomTypeService.findRoomTypeById(bookOrder.getRoomTypeId());
            roomType.setRoomNum(roomType.getRoomNum()+1);
            roomTypeService.eidtRoomType(roomType);
        }
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(BookOrder bookOrder,String arriveTime,String leaveTime,int oldRoomTypeId){
        Map<String,String> ret=new HashMap<>();
        Date arriveDate;
        Date leaveDate;
        try{
            SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
            arriveDate=formater.parse(arriveTime);
            leaveDate=formater.parse(leaveTime);

            if(!checkArriveAndLeaveTime(arriveDate,leaveDate)){
                ret.put("type","error");
                ret.put("msg","日期填写不合适 请修改");
                return ret;
            }
        }catch (Exception e){
            ret.put("type","error");
            ret.put("msg","日期格式转化不正确 请按格式填写");
            return ret;
        }
        bookOrder.setArriveDate(arriveDate);
        bookOrder.setLeaveDate(leaveDate);
        if(bookOrderService.eidtBookOrder(bookOrder)<=0){
            ret.put("type","error");
            ret.put("msg","修改失败 请联系管理员");
        }else{
            ret.put("type","success");
            if(oldRoomTypeId!=bookOrder.getRoomTypeId()){
                RoomType oldRoomType=roomTypeService.findRoomTypeById(oldRoomTypeId);
                oldRoomType.setRoomNum(oldRoomType.getRoomNum()-1);
                RoomType newRoomType=roomTypeService.findRoomTypeById(bookOrder.getRoomTypeId());
                newRoomType.setRoomNum(newRoomType.getRoomNum()+1);

                roomTypeService.eidtRoomType(oldRoomType);
                roomTypeService.eidtRoomType(newRoomType);
            }
        }
        return ret;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int [] id){
        Map<String,String> ret=new HashMap<>();
        for(int i=0;i<id.length;i++){
            if(bookOrderService.deleteBookOrder(id[i])<=0) {
                ret.put("type", "error");
                ret.put("msg", "删除中出错 请联系管理员");
                return ret;
            }else {
                BookOrder bookOrder = bookOrderService.findBookOrderById(id[i]);
                RoomType roomType=roomTypeService.findRoomTypeById(bookOrder.getRoomTypeId());
                roomType.setRoomNum(roomType.getRoomNum()-1);
                roomTypeService.eidtRoomType(roomType);
            }
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping(value="list",method = RequestMethod.POST)//搜索的时候的参数名
    @ResponseBody
    public Map<String,Object> findList(Page page,Integer status,String arriveTime,String leaveTime,
                                       @RequestParam(value = "accountName",defaultValue = "",required = false)String accountName,
                                       @RequestParam(value = "name",defaultValue = "",required = false)String name,
                                       @RequestParam(value = "phoneNum",defaultValue = "",required = false)String phoneNum

    ) throws ParseException {
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        queryMap.put("accountName",accountName);
        queryMap.put("name",name);
        queryMap.put("phoneNum",phoneNum);
        if (!StringUtils.isEmpty(arriveTime)){
            queryMap.put("arriveDate",format.parse(arriveTime));
        }else {
            queryMap.put("arriveDate",null);
        }
        if (!StringUtils.isEmpty(arriveTime)){
            queryMap.put("leaveDate",format.parse(leaveTime));
        }else {
            queryMap.put("leaveDate",null);
        }
        queryMap.put("status",status);
        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());
        System.out.println(queryMap);

        ret.put("rows",bookOrderService.findList(queryMap));
        ret.put("total",bookOrderService.getTotal(queryMap));
        return ret;
    }


    @RequestMapping("findbookOrderById")
    @ResponseBody
    public BookOrder findbookOrderById(int id){
        return bookOrderService.findBookOrderById(id);
    }

    boolean checkArriveAndLeaveTime(Date arrive,Date leave) throws ParseException {
        SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
        Date now_day=formater.parse(formater.format(new Date()));
        if(now_day.compareTo(arrive)!=1) {
            if(arrive.compareTo(leave)!=1){
                return true;
            }
        }
        return false;
    }

}
