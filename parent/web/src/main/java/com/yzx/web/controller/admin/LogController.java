package com.yzx.web.controller.admin;

import com.yzx.model.admin.Log;
import com.yzx.model.admin.Page;
import com.yzx.service.admin.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("admin/log")
public class LogController {

    @Autowired
    private LogService logService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(){
        System.out.println("log");
        return "admin/log/list";
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
    public Map<String,Object> findList(Page page, @RequestParam(value = "content",defaultValue = "",required = false)String content){
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());
        queryMap.put("content",content);

        ret.put("rows",logService.findList(queryMap));
        ret.put("total",logService.getTotalNum(queryMap));
        return ret;
    }

}
