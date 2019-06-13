package com.yzx.web.controller.admin;

import com.yzx.mapper.admin.FloorMapper;
import com.yzx.model.RoomType;
import com.yzx.model.admin.Floor;
import com.yzx.model.admin.Page;
import com.yzx.service.admin.FloorService;
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
@RequestMapping("admin/floor")
public class FloorController {
    @Autowired
    private FloorService floorService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(){
        System.out.println("log");
        return "admin/floor/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(Floor floor){
        Map<String,String> ret=new HashMap<>();
        if(floorService.addFloor(floor)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","添加失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(Floor floor){
        Map<String,String> ret=new HashMap<>();
        if(floorService.eidtFloor(floor)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","修改失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int  id){
        Map<String,String> ret=new HashMap<>();
        try{
            if(floorService.deleteFloor(id)<=0) {
                ret.put("type", "error");
                ret.put("msg", "删除出错 请联系管理员");
                return ret;
            }else {
                ret.put("type","success");
            }
        }catch (Exception e){
            ret.put("type", "error");
            ret.put("msg", "删除出错 楼层表存在外键");
            return ret;
        }
        return ret;
    }

    @RequestMapping(value="list",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> findList(Page page, @RequestParam(value = "name",defaultValue = "",required = false)String name){
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());
        queryMap.put("name",name);

        ret.put("rows",floorService.findList(queryMap));
        ret.put("total",floorService.getTotal(queryMap));
        return ret;
    }

    @RequestMapping("findFloorById")
    @ResponseBody
    public Map<String,Object> findFloorById(int id){
        Map<String,Object> ret=new HashMap<>();
        Floor floor=floorService.findFloorById(id);
        if(floor==null){
            ret.put("type", "error");
            ret.put("msg", "查询该房型对应的楼层时出错");
        }else {
            ret.put("type", "success");
            ret.put("floor", floor);
        }
        return ret;
    }

    @RequestMapping("findFloorByRoomTypeId")
    @ResponseBody
    public Floor findFloorByRoomTypeId(int id){
        return floorService.findFloorByRoomTypeId(id);
    }

    @RequestMapping("findFloorsByRoomTypeName")
    @ResponseBody
    public List<Floor> findFloorsByRoomTypeName(String name){
        return floorService.findFloorsByRoomTypeName(name);
    }


}
