package com.yzx.web.controller.admin;

import com.yzx.model.admin.Authority;
import com.yzx.model.admin.Role;
import com.yzx.model.admin.Page;
import com.yzx.service.admin.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("admin/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public ModelAndView list(ModelAndView mv){
        mv.setViewName("admin/role/list");
        return mv;
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(Role role){
        Map<String,String> ret=new HashMap<>();
        if(roleService.addRole(role)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","添加失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(Role role){
        System.out.println(role);
        Map<String,String> ret=new HashMap<>();
        if(roleService.update(role)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","修改失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int id){
        Map<String,String> ret=new HashMap<>();
        try{
            if(roleService.delete(id)<=0){
                ret.put("type","error");
                ret.put("msg","删除出错 请联系管理员");
            }else{
                ret.put("type","success");
            }
        }catch (Exception e){
            ret.put("type","error");
            ret.put("msg","删除出错 角色表存在外键");
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

        ret.put("rows",roleService.findList(queryMap));
        ret.put("total",roleService.getTotalNum(queryMap));
        return ret;
    }

    @RequestMapping("addAuthority")
    @ResponseBody
    public Map<String,String> addAuthority(int roleId, int [] menuId){
        roleService.deleteAuthoritys(roleId);
        Map<String,String> ret=new HashMap<>();
        if(menuId!=null){
            for(int mid:menuId){
                Authority authority=new Authority(roleId,mid);
                if(roleService.addAuthority(authority)<=0) {
                    ret.put("type", "error");
                    ret.put("msg", "存在添加出错 请联系管理员");
                    return ret;
                }
            }
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping("deleteAuthoritys")
    @ResponseBody
    public Map<String,String> deleteAuthoritys(int roleId){
        Map<String,String> ret=new HashMap<>();
        if(roleService.deleteAuthoritys(roleId)<=0){
            ret.put("type","error");
            ret.put("msg","添加出错 请联系管理员");
        }else{
            ret.put("type","success");
        }
        return ret;
    }

    @RequestMapping("getAuthoritys")
    @ResponseBody
    public List<Authority> getAuthoritys(int roleId){
        return roleService.getAuthoritys(roleId);
    }

}
