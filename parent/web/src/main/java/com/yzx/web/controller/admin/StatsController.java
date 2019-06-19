package com.yzx.web.controller.admin;

import com.aliyuncs.utils.StringUtils;
import com.yzx.service.admin.CheckInService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("admin/stats")
public class StatsController {

    @Autowired
    private CheckInService checkinService;

    @RequestMapping("list")
    public String list(){
        return "admin/stats/list";
    }

    @RequestMapping("get_stats")
    @ResponseBody
    public Map<String, Object> getStats(String type){
        Map<String, Object> ret = new HashMap<>();
        if(StringUtils.isEmpty(type)){
            ret.put("type", "error");
            ret.put("msg", "请选择统计类型!");
            return ret;
        }
        switch (type) {
            case "month":{
                ret.put("type", "success");
                ret.put("content", getStatsValue(checkinService.getStatsByMonth()));
                return ret;
            }
            case "day":{
                ret.put("type", "success");
                ret.put("content", getStatsValue(checkinService.getStatsByDay()));
                return ret;
            }
            default:{
                ret.put("type", "error");
                ret.put("msg", "请选择正确的统计类型!");
                return ret;
            }
        }
    }

    private Map<String, Object> getStatsValue(List<Map> statsValue){
        Map<String, Object> ret = new HashMap<>();
        List<String> keyList = new ArrayList<>();
        List<Float> valueList = new ArrayList<>();
        for(Map m:statsValue){
            keyList.add(m.get("stats_date").toString());
            valueList.add(Float.valueOf(m.get("money").toString()));
        }
        ret.put("keyList", keyList);
        ret.put("valueList", valueList);
        return ret;
    }
}
