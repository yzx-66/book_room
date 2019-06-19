package com.yzx.web.controller.admin;

import com.yzx.model.admin.Log;
import com.yzx.model.admin.Page;
import com.yzx.service.admin.LogService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("admin/log")
public class LogController {

    @Autowired
    private LogService logService;

    @RequestMapping(value = "system/list",method = RequestMethod.GET)
    public String listBySystem(){
        System.out.println("log");
        return "admin/log/systemList";
    }

    @RequestMapping(value = "bussiness/list",method = RequestMethod.GET)
    public String listByBussiness(){
        System.out.println("log");
        return "admin/log/bussinessList";
    }

    @RequestMapping(value = "account/list",method = RequestMethod.GET)
    public String listByAccount(){
        System.out.println("log");
        return "admin/log/accountList";
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int [] id){
        Map<String,String> ret=new HashMap<>();
        for(int n:id){
            if(logService.delete(n)<=0) {
                ret.put("type","error");
                ret.put("msg","删除出错 请联系管理员");
                return ret;
            }
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping(value="list",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> findList(Page page,int type, @RequestParam(value = "content",defaultValue = "",required = false)String content,
                                               @RequestParam(value = "tittle",defaultValue = "",required = false)String tittle,
                                               @RequestParam(value = "startTime",defaultValue = "",required = false)String startTime,
                                               @RequestParam(value = "endTime",defaultValue = "",required = false)String endTime) throws ParseException {
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
        if(!StringUtils.isEmpty(startTime)){
            queryMap.put("startDate",dateFormat.parse(startTime));
        }else {
            queryMap.put("startDate",null);
        }
        if(!StringUtils.isEmpty(endTime)){
            queryMap.put("endDate",dateFormat.parse(endTime));
        }else {
            queryMap.put("endDate",null);
        }

        queryMap.put("type",type);
        queryMap.put("tittle",tittle);
        queryMap.put("content",content);
        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());

        ret.put("rows",logService.findList(queryMap));
        ret.put("total",logService.getTotalNum(queryMap));
        return ret;
    }

}
