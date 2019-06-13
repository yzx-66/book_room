package com.yzx.web.controller.admin;

import com.yzx.model.admin.Page;
import com.yzx.model.admin.User;
import com.yzx.service.admin.RoleService;
import com.yzx.service.admin.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("admin/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public ModelAndView list(ModelAndView mv){
        mv.setViewName("admin/user/list");
        Map<String,Object> queryMap=new HashMap<>();
        queryMap.put("pageSize",null);
        queryMap.put("offset",null);
        queryMap.put("name",null);
        mv.addObject("roleList",roleService.findList(queryMap));
        return mv;
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(User user){
        Map<String,String> ret=new HashMap<>();
        if(userService.addUser(user)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","添加失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(User user){
        System.out.println(user);
        Map<String,String> ret=new HashMap<>();
        if(userService.update(user)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","修改失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int [] id){
        Map<String,String> ret=new HashMap<>();
        for(int i:id){
            if(userService.delete(i)<=0) {
                ret.put("type", "error");
                ret.put("msg", "删除出错 请联系管理员");
                return ret;
            }
        }
        ret.put("type","success");
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

        List<User> users=userService.findList(queryMap);
        for(User user:users){
            user.setPassword("");
        }
        ret.put("rows",users);
        ret.put("total",userService.getTotalNum(queryMap));
        return ret;
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
        String idaePath="C:/EXCS/IDEA_exc/SSM_Hotel/parent/web/src/main/webapp/upload/upload_userPhoto";
        String mavenPath=request.getServletContext().getRealPath("/upload/upload_userPhoto");
        String filename="pic_"+UUID.randomUUID()+"_"+tempPhoto.getOriginalFilename();

        Map<String,String> ideaRet=addFile(idaePath,tempPhoto,filename);
        if(ideaRet.get("type").equals("error")){
            return ideaRet;
        }else {
            return addFile(mavenPath,tempPhoto,filename);
        }
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
        ret.put("filepath","/hotel/upload/upload_userPhoto/"+filename);
        return ret;
    }
}
