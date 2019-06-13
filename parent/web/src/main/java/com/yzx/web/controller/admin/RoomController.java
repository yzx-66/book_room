package com.yzx.web.controller.admin;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yzx.model.RoomType;
import com.yzx.model.admin.Floor;
import com.yzx.model.admin.Page;
import com.yzx.model.admin.Room;
import com.yzx.service.RoomTypeService;
import com.yzx.service.admin.FloorService;
import com.yzx.service.admin.RoomService;
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
import java.util.*;

@Controller
@RequestMapping("admin/room")
public class RoomController {
    
   @Autowired
    private RoomService roomService;
   @Autowired
   private RoomTypeService roomTypeService;
   @Autowired
   private FloorService floorService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(HttpServletRequest request){
        List<RoomType> allRoomTypes=roomTypeService.findAllRoomeType();
        Set<String> roomTypeNames=new HashSet<>();
        for(RoomType r:allRoomTypes){
            roomTypeNames.add(r.getName());
        }
        request.getSession().setAttribute("roomTypeNames",roomTypeNames);

        List<Floor> allFloors=floorService.findAllFloors();
        Set<Integer> floorHights=new HashSet<>();
        for(Floor f:allFloors){
            floorHights.add(f.getHight());
        }
        request.getSession().setAttribute("floorHights",floorHights);
        return "admin/room/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(Room room,String roomTypeName,int hight){
        Map<String,String> ret=new HashMap<>();
        RoomType roomType=roomTypeService.findRoomTypeByNameAndHight(roomTypeName,hight);

        room.setRoomTypeId(roomType.getId());
        if(roomService.addRoom(room)<=0){
            ret.put("type","error");
            ret.put("msg","添加失败 请联系管理员");
        }else {
            ret.put("type","success");
            roomType.setRoomNum(roomType.getRoomNum()+1);
            roomTypeService.eidtRoomType(roomType);
        }
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(Room room,String roomTypeName,int hight,int oldTypeId){
        RoomType roomType=roomTypeService.findRoomTypeByNameAndHight(roomTypeName,hight);
        if(roomType.getId()!=oldTypeId){
            RoomType oldRoomType=roomTypeService.findRoomTypeById(oldTypeId);
            oldRoomType.setRoomNum(oldRoomType.getRoomNum()-1);
            roomTypeService.eidtRoomType(oldRoomType);
            roomType.setRoomNum(roomType.getRoomNum()+1);
            roomTypeService.eidtRoomType(roomType);
        }
        room.setRoomTypeId(roomType.getId());
        Map<String,String> ret=new HashMap<>();
        if(roomService.eidtRoom(room)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","修改失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int []  id,int [] roomTypeId){
        Map<String,String> ret=new HashMap<>();
        for(int i=0;i<id.length;i++){
            RoomType type = roomTypeService.findRoomTypeById(roomTypeId[i]);
            if(roomService.deleteRoom(id[i])<=0) {
                ret.put("type", "error");
                ret.put("msg", "删除出错 请联系管理员");
                return ret;
            }
            type.setRoomNum(type.getRoomNum()-1);
            roomTypeService.eidtRoomType(type);
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping(value="list",method = RequestMethod.POST)//搜索的时候的参数名
    @ResponseBody
    public Map<String,Object> findList(Page page,String sn,Integer status,Integer hight,String roomTypeName,
                                       @RequestParam(value = "name",defaultValue = "",required = false)String name
                                        ) {
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        queryMap.put("hight",hight);
        queryMap.put("roomTypeName",roomTypeName);
        queryMap.put("name",name);
        queryMap.put("sn",sn);
        queryMap.put("status",status);
        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());
        System.out.println(queryMap);

        ret.put("rows",roomService.findList(queryMap));
        ret.put("total",roomService.getTotal(queryMap));
        return ret;
    }


    @RequestMapping("findRoomById")
    @ResponseBody
    public Room findRoomById(int id){
        return roomService.findRoomById(id);
    }

    @RequestMapping("subpic")
    @ResponseBody
    public Map<String,String> subpic(MultipartFile tempPhoto, HttpServletRequest request){
        Map<String,String> ret=new HashMap<>();
        String suffix=tempPhoto.getOriginalFilename().substring(tempPhoto.getOriginalFilename().lastIndexOf('.')+1);
        if(tempPhoto==null){
            ret.put("type","error");
            ret.put("msg","请选择一张图片");
            return ret;
        }
        if(!"jpg,png,gif".toUpperCase().contains(suffix.toUpperCase())){
            ret.put("type","error");
            ret.put("msg","请选择图片格式的文件");
            return ret;
        }
        if(tempPhoto.getSize()>1024*1024*1024){
            ret.put("type","error");
            ret.put("msg","图片过大");
            return ret;
        }
        String idaePath="C:/EXCS/IDEA_exc/SSM_Hotel/parent/web/src/main/webapp/upload/upload_room";  //
        String mavenPath=request.getServletContext().getRealPath("/upload/upload_room");
        String filename="pic_"+ UUID.randomUUID()+"_"+tempPhoto.getOriginalFilename();

        Map<String,String> ideaRet=addFile(idaePath,tempPhoto,filename);             //
        if(ideaRet.get("type").equals("error")){                                            //
            return ideaRet;                                                          //
        }else {                                                                      //
            return addFile(mavenPath,tempPhoto,filename);
        }                                                                            //
    }

    public Map<String,String> addFile(String path,MultipartFile photo,String filename){
        Map<String,String> ret=new HashMap<>();
        File File=new File(path);
        File mavenFile=new File(path);
        if(!File.exists()){
            File.mkdirs();
        }

        try {
            photo.transferTo(new File(path+"/"+filename));
        } catch (IOException e) {
            ret.put("type","error");
            ret.put("msg","文件保存失败");
            return ret;
        }
        ret.put("type","success");
        ret.put("filepath","/hotel/upload/upload_room/"+filename);
        return ret;
    }

}
