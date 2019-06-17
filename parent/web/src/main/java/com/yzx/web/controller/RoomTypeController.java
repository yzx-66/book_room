package com.yzx.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yzx.model.RoomType;
import com.yzx.model.admin.Page;
import com.yzx.service.RoomTypeService;
import com.yzx.service.admin.FloorService;
import com.yzx.service.admin.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.*;

@Controller
@RequestMapping("admin/room_type")
public class RoomTypeController {
    @Autowired
    private RoomTypeService roomTypeService;
    @Autowired
    private FloorService floorService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(HttpServletRequest request,String dowhat,Integer id) throws JsonProcessingException {
        if(dowhat!=null){
            if(dowhat.equals("add")){
                request.getSession().setAttribute("dowhat","add");
            }
            if(dowhat.equals("edit")){
                request.getSession().setAttribute("dowhat","edit");
                ObjectMapper mapper=new ObjectMapper();
                String editRoomType=mapper.writeValueAsString(roomTypeService.findRoomTypeById(id));
                request.getSession().setAttribute("editRoomType",editRoomType);
            }
        }else {
            request.getSession().setAttribute("dowhat","no");
        }
        List<RoomType> allRoomTypes=roomTypeService.findAllRoomeType();
        Set<String> roomTypeNames=new HashSet<>();
        for(RoomType r:allRoomTypes){
            roomTypeNames.add(r.getName());
        }
        request.getSession().setAttribute("floors",floorService.findAllFloors());
        request.getSession().setAttribute("roomTypeNames",roomTypeNames);
        return "admin/room_type/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(HttpServletRequest request,RoomType roomType,int [] floorIds){//注意传的是数组
        Map<String,String> ret=new HashMap<>();
        Set<Integer> checkSame=new HashSet<>();
        for(int check:floorIds){
            if(check==-1){
                continue;
            }
            if(checkSame.add(check)==false){
                ret.put("type","error");
                ret.put("msg","添加中不可以有重复楼层！");
                return ret;
            }
            if(roomTypeService.findRoomTypeByNameAndHight(roomType.getName(),floorService.findFloorById(check).getHight())!=null){
                ret.put("type","error");
                ret.put("msg","添加的存在和已存在的重复的！");
                return ret;
            }
        }
        for(int fid:floorIds){
            if(fid==-1){
                continue;
            }
            roomType.setFloorId(fid);
            roomType.setLivedNum(0);
            roomType.setBookNum(0);
            roomType.setcanNotLiveNum(0);
            if(roomTypeService.addRoomType(roomType)<=0){
                ret.put("type","error");
                ret.put("msg","添加失败 请联系管理员");
                return ret;
            }
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(HttpServletRequest request,RoomType roomType){
        List<RoomType> sameNameTypes=roomTypeService.findRoomTypeByName(roomType.getName());
        if(sameNameTypes.size()>1){
            for(RoomType rt:sameNameTypes){
                if(rt.getId()!=roomType.getId()){
                    if(!rt.getName().equals(roomType.getName()) || !rt.getPhoto().equals(roomType.getPhoto())){
                        rt.setName(roomType.getName());
                        rt.setPhoto(roomType.getPhoto());
                        roomTypeService.eidtRoomType(rt);
                    }
                }
            }
        }

        Map<String,String> ret=new HashMap<>();
//        if(roomType.getAvilableNum()<0){
//            ret.put("type","error");
//            ret.put("msg","修改失败 房间数修改不合理");
//            return ret;
//        }

//        if(roomType.getStatus()==RoomType.NOT_LIVE){
//            if(roomType.getBedNum()!=0 && roomType.getBookNum()!=0){
//                ret.put("type","error");
//                ret.put("msg","修改失败 房间有预定或者使用 状态不可改为不可用");
//                return ret;
//            }
//        }
        if(roomTypeService.eidtRoomType(roomType)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","修改失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(Integer id){
        Map<String,String> ret=new HashMap<>();
        try{
            if(roomTypeService.deleteRoomType(id)<=0) {
                ret.put("type", "error");
                ret.put("msg", "删除出错 请联系管理员");
                return ret;
            }
        }catch (Exception e){
            ret.put("type", "error");
            ret.put("msg", "删除出错 房型表存在外键");
            return ret;
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping(value="list",method = RequestMethod.POST)//搜索的时候的参数名
    @ResponseBody
    public Map<String,Object> findList(Page page,
                                       @RequestParam(value = "name",defaultValue = "",required = false)String name,
                                       @RequestParam(value = "floorId",required = false)Integer floorId,
                                       @RequestParam(value = "status",required = false)Integer status) throws ParseException {
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());
        queryMap.put("name",name);
        queryMap.put("floorId",floorId);
        queryMap.put("status",status);

        ret.put("rows",roomTypeService.findList(queryMap));
        ret.put("total",roomTypeService.getTotal(queryMap));
        return ret;
    }

    @RequestMapping("getTypesByFloorId")
    @ResponseBody
    public List<RoomType> getTypesByFloorId(int floorId){
        return roomTypeService.findRoomTypesByFloorId(floorId);
    }

    @RequestMapping("findRoomTypeById")
    @ResponseBody
    public RoomType findRoomTypeById(int id){
        return roomTypeService.findRoomTypeById(id);
    }

    @RequestMapping("findRoomTypeByName")
    @ResponseBody
    public List<RoomType> findRoomTypeByName(String name){
        return roomTypeService.findRoomTypeByName(name);
    }

    @RequestMapping("findRoomTypeByRoomId")
    @ResponseBody
    public RoomType findRoomTypeByRoomId(int id){
        return roomTypeService.findRoomTypeByRoomId(id);
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
        String idaePath="C:/EXCS/IDEA_exc/SSM_Hotel/parent/web/src/main/webapp/upload/upload_roomType";  //
        String mavenPath=request.getServletContext().getRealPath("/upload/upload_roomType");
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
        ret.put("filepath","/hotel/upload/upload_roomType/"+filename);
        return ret;
    }
}
