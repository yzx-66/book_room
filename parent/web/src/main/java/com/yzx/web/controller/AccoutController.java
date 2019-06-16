package com.yzx.web.controller;

import com.yzx.model.Account;
import com.yzx.model.admin.Page;
import com.yzx.service.AccountService;
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
import java.util.*;

@Controller
@RequestMapping("admin/account")
public class AccoutController {

    @Autowired
    private AccountService accountService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(HttpServletRequest request){
        return "admin/account/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(Account account){
        Map<String,String> ret=new HashMap<>();
        if(accountService.findAccountByPhoneNum(account.getPhoneNum())!=null){
            ret.put("type","error");
            ret.put("msg","添加失败 手机号已经注册");
        }else {
            if(accountService.addAccount(account)<=0){
                ret.put("type","error");
                ret.put("msg","添加失败 请联系管理员");
            }else {
                ret.put("type","success");
            }
        }
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(Account account){
        Map<String,String> ret=new HashMap<>();
        if(accountService.eidtAccount(account)>0){
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
        for(int i=0;i<id.length;i++){
            try{
                if(accountService.deleteAccount(id[i])<=0) {
                    ret.put("type", "error");
                    ret.put("msg", "删除出错 请联系管理员");
                    return ret;
                }
            }catch (Exception e){
                ret.put("type", "error");
                ret.put("msg", "该用户还存在外键 无法删除");
                return ret;
            }
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping(value="list",method = RequestMethod.POST)//搜索的时候的参数名
    @ResponseBody
    public Map<String,Object> findList(Page page,Integer status,
                                       @RequestParam(value = "name",defaultValue = "",required = false)String name,
                                       @RequestParam(value = "realName",defaultValue = "",required = false)String realName,
                                       @RequestParam(value = "phoneNum",defaultValue = "",required = false)String phoneNum,
                                       @RequestParam(value = "idCard",defaultValue = "",required = false)String idCard
    ) throws ParseException {
        Map<String,Object> ret=new HashMap<>();
        Map<String,Object> queryMap=new HashMap<>();

        queryMap.put("name",name);
        queryMap.put("realName",realName);
        queryMap.put("phoneNum",phoneNum);
        queryMap.put("idCard",idCard);
        queryMap.put("status",status);
        queryMap.put("pageSize",page.getRows());
        queryMap.put("offset",page.getOffset());
        System.out.println(queryMap);

        ret.put("rows",accountService.findList(queryMap));
        ret.put("total",accountService.getTotal(queryMap));
        return ret;
    }


    @RequestMapping("findaccountById")
    @ResponseBody
    public Account findaccountById(int id){
        return accountService.findAccountById(id);
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
        String idaePath="C:/EXCS/IDEA_exc/SSM_Hotel/parent/web/src/main/webapp/upload/upload_accountPhoto";  //
        String mavenPath=request.getServletContext().getRealPath("/upload/upload_accountPhoto");
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
        ret.put("filepath","/hotel/upload/upload_accountPhoto/"+filename);
        return ret;
    }

}
