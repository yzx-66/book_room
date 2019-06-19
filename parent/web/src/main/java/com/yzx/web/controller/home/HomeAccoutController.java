package com.yzx.web.controller.home;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yzx.model.Account;
import com.yzx.model.BookOrder;
import com.yzx.model.RoomType;
import com.yzx.model.admin.Log;
import com.yzx.service.AccountService;
import com.yzx.service.BookOrderService;
import com.yzx.service.RoomTypeService;
import com.yzx.service.admin.FloorService;
import com.yzx.service.admin.LogService;
import com.yzx.util.CheckId;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("home/account")
public class HomeAccoutController {

    @Autowired
    private RoomTypeService roomTypeService;
    @Autowired
    private BookOrderService bookOrderService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private LogService logService;

    @RequestMapping("homepage")
    public String homepage(HttpServletRequest request,Integer status,String arriveTime,String leaveTime,
                                 @RequestParam(value = "name",defaultValue = "",required = false)String name,
                                 @RequestParam(value = "phoneNum",defaultValue = "",required = false)String phoneNum
    ) throws ParseException {
        Account account = (Account) request.getSession().getAttribute("account");
        account=accountService.findAccountById(account.getId());
        request.getSession().setAttribute("account",account);
        Map<String, Object> queryMap = new HashMap<>();

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        queryMap.put("accountPhone", account.getPhoneNum());
        queryMap.put("name", name);
        queryMap.put("phoneNum", phoneNum);
        if (!StringUtils.isEmpty(arriveTime)) {
            queryMap.put("arriveDate", format.parse(arriveTime));
        } else {
            queryMap.put("arriveDate", null);
        }
        if (!StringUtils.isEmpty(leaveTime)) {
            queryMap.put("leaveDate", format.parse(leaveTime));
        } else {
            queryMap.put("leaveDate", null);
        }
        queryMap.put("status", status);

        List<BookOrder> bookOrderList= bookOrderService.findList(queryMap);

        request.getSession().setAttribute("bookOrderList", bookOrderService.findList(queryMap));
        return "home/account/homepage";
    }

    @RequestMapping("bookOrder")
    public String bookOrder(HttpServletRequest request,int showDoWhat,Integer roomTypeId,Integer bookOrderId) throws JsonProcessingException {
        Account account = (Account) request.getSession().getAttribute("account");
        account=accountService.findAccountById(account.getId());
        request.getSession().setAttribute("account",account);

        ObjectMapper mapper=new ObjectMapper();
        request.getSession().setAttribute("showDoWhat",showDoWhat);
        BookOrder bookOrder=null;
        if(bookOrderId!=null){
            bookOrder=bookOrderService.findBookOrderById(bookOrderId);
            request.getSession().setAttribute("choseBookOrder",mapper.writeValueAsString(bookOrder));
        }
        if(roomTypeId!=null){
            RoomType roomType=roomTypeService.findRoomTypeById(roomTypeId);
            request.getSession().setAttribute("roomType",roomType);
        }else {
            request.getSession().setAttribute("roomType",roomTypeService.findRoomTypeById(bookOrder.getRoomTypeId()));
        }
        return "home/account/bookOrder";
    }

    @RequestMapping("editInfo")
    @ResponseBody
    public Map<String,Object> editInfo(HttpServletRequest request,String name,String realName,String idCard,String address,String photo){
        Map<String,Object> ret=new HashMap<>();
        Account account= (Account) request.getSession().getAttribute("account");
        if(StringUtils.isEmpty(name)){
            ret.put("type","error");
            ret.put("msg","用户名不可以为空！");
            return ret;
        }
        if((StringUtils.isEmpty(realName) && !StringUtils.isEmpty(idCard)) || (!StringUtils.isEmpty(realName) && StringUtils.isEmpty(idCard)) ){
            ret.put("type","error");
            ret.put("msg","真实姓名和身份证号可以不填 但是填必须一起填！");
            return ret;
        }
        if(!StringUtils.isEmpty(realName) && !StringUtils.isEmpty(idCard)){
            if(StringUtils.isEmpty(account.getIdCard())){
                Map<String,Object> res=CheckId.getRequest1(idCard,realName);
                if(res.get("type").equals("error")){
                    logService.addLog(Log.ACCOUNT,"实名认证","手机号为"+account.getPhoneNum()+"实名认证失败");
                    return res;
                }
            }
            logService.addLog(Log.ACCOUNT,"实名认证","手机号为"+account.getPhoneNum()+"实名认证成功");
        }
        if(StringUtils.isEmpty(account.getIdCard())){
            account.setIdCard(idCard);
        }
        if(StringUtils.isEmpty(account.getRealName())){
            account.setRealName(realName);
        }
        account.setAddress(address);
        account.setName(name);
        account.setPhoto(photo);
        accountService.eidtAccount(account);

        logService.addLog(Log.ACCOUNT,"修改信息","手机号为"+account.getPhoneNum()+"修改信息成功");
        ret.put("type","success");
        return ret;
    }

    @RequestMapping("editPassword")
    @ResponseBody
    public Map<String,String> editPassword(HttpServletRequest request,String old_password,String new_password){
        Map<String,String> ret=new HashMap<>();
        Account account= (Account) request.getSession().getAttribute("account");
        if(!old_password.equals(account.getPassword())){
            ret.put("type","error");
            ret.put("msg","旧密码不正确");
        }else if(account.getPassword().equals(new_password)){
            ret.put("type","error");
            ret.put("msg","新旧密码一样");
        }else if(StringUtils.isEmpty(new_password)){
            ret.put("type","error");
            ret.put("msg","新密码为空");
        }else{
            account.setPassword(new_password);
            if(accountService.eidtAccount(account)<=0){
                ret.put("type","error");
                ret.put("msg","修改密码失败，请联系管理员");
            }else {
                ret.put("type","success");
                request.getSession().setAttribute("account",null);
            }
        }
        logService.addLog(Log.ACCOUNT,"修改密码","手机号为"+account.getPhoneNum()+"修改密码成功");
        return ret;
    }

}
