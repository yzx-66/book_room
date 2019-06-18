package com.yzx.web.controller.admin;

import com.yzx.model.admin.Authority;
import com.yzx.model.admin.Menu;
import com.yzx.model.admin.User;
import com.yzx.service.admin.LogService;
import com.yzx.service.admin.MenuService;
import com.yzx.service.admin.RoleService;
import com.yzx.service.admin.UserService;
import com.yzx.util.CpachaUtil;
import com.yzx.util.SendMsg;
import com.yzx.util.model.SendBack;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
    放进出人后台管理系统的mapping
 */

@Controller
@RequestMapping("admin/system")
public class systemController {

    @Autowired
    private UserService userService;
    @Autowired
    private MenuService menuService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private LogService logService;

    @RequestMapping("index")
    public String login(){
        return "admin/system/login";
    }

    @RequestMapping("get_cpacha")
    public void get_cpacha(@RequestParam(value = "vc",defaultValue ="4") Integer vcodeLen,
                           @RequestParam(value = "w",defaultValue ="100")Integer width,
                           @RequestParam(value = "h",defaultValue ="30")Integer hight,
                           HttpServletRequest request,
                           HttpServletResponse response){
        CpachaUtil util=new CpachaUtil(vcodeLen,width,hight);
        String generatorVCode = util.generatorVCode();
        HttpSession session = request.getSession();
        session.setAttribute("generatorVCode",generatorVCode);

        BufferedImage generatorRotateVCodeImage = util.generatorRotateVCodeImage(generatorVCode, true);
        try {
            ImageIO.write(generatorRotateVCodeImage,"gif",response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("login")
    @ResponseBody
    public Map<String,String> loign(HttpServletRequest request,String username,String password,String cpacha){
        Map<String,String> ret=new HashMap<>();
        String trueCpacha= (String) request.getSession().getAttribute("generatorVCode");
        if(trueCpacha==null){
            ret.put("type","error");
            ret.put("msg","验证码失效");
            logService.addLog("用户名为："+username+" 输入验证码失效");
            return ret;
        }
//        if(!cpacha.toUpperCase().equals(trueCpacha.toUpperCase())){
//            ret.put("type","error");
//            ret.put("msg","验证码错误");
//            logService.addLog("用户名为："+username+" 输入验证码错误");
//            return ret;
//        }

        User user=userService.findUserByUsername(username);
        if(user==null){
            ret.put("type","error");
            ret.put("msg","用户名不存在");
            logService.addLog("用户名为："+username+" 不存在");
        }else if(!user.getPassword().equals(password)){
            ret.put("type","error");
            ret.put("msg","用户名或密码错误");
            logService.addLog("用户名为："+username+" 用户名或密码错误");
        }else{
            request.getSession().setAttribute("user",user);
            ret.put("type","success");
            logService.addLog("用户名为："+username+" 登陆成功");
        }
        setSupperControllerId(request,ret,username);
        return ret;
    }

    @RequestMapping("homepage")
    public String login_success(HttpServletRequest request){
        setMenu(request);
        return "admin/system/homepage";
    }

    @RequestMapping("welcom")
    public String welcom(){
        return "admin/system/welcom";
    }

    @RequestMapping("loginout")
    public String loginout(HttpServletRequest request){
        HttpSession session=request.getSession();
        User user= (User)session.getAttribute("user");
        logService.addLog("用户名为："+user.getName()+" 退出登陆");

        session.setAttribute("user",null);
        session.setAttribute("menu",null);
        session.setAttribute("button",null);
        return "redirect:/admin/system/index";
    }

    @RequestMapping(value = "edit-password",method = RequestMethod.GET)
    public String editPassworddPage(){
        return "admin/system/edit-password";
    }

    @RequestMapping(value = "edit-password",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> editPassword(HttpServletRequest request,String old_password,String new_password){
        Map<String,String> ret=new HashMap<>();
        User user= (User) request.getSession().getAttribute("user");
        if(!old_password.equals(user.getPassword())){
            ret.put("type","error");
            ret.put("msg","旧密码不正确");
            logService.addLog("用户名为："+user.getName()+" 修改密码失败（新旧密码不一致）");
        } else{
            if(userService.edit_password(user.getId(),new_password)<=0){
                ret.put("type","error");
                ret.put("msg","修改密码失败，请联系管理员");
                logService.addLog("用户名为："+user.getName()+" 修改密码失败");
            }else {
                ret.put("type","success");
                user.setPassword(new_password);
                logService.addLog("用户名为："+user.getName()+" 修改密码成功");
            }
        }
        return ret;
    }

    public void setSupperControllerId(HttpServletRequest request,Map<String,String> ret,String username){
        Map<String,Object> querymap=new HashMap<>();
        querymap.put("name","超级管理员");
        try{
            int supperControllerId=roleService.findList(querymap).get(0).getId();
            request.getSession().setAttribute("supperControllerId",supperControllerId);
        }catch (Exception e){
            ret.put("type","error");
            ret.put("msg","还不存在“超级管理员”角色，请在数据库添加，不然无法正确分配权限");
            logService.addLog("用户名为："+username+" 还不存在“超级管理员”角色，请在数据库添加，不然无法正确分配权限");
        }
    }

    public void setMenu(HttpServletRequest request){
        HttpSession session=request.getSession();
        User user= (User) session.getAttribute("user");
        int roleId=userService.findRoleId(user.getId());
        List<Authority> authorities=roleService.getAuthoritys(roleId);
        List<Menu> topMenuList=menuService.findTopList();
        Map<Menu,List<Menu>> menu=new HashMap();
        Map<String,List<Menu>> button=new HashMap<>();

        for(Authority authority:authorities){
            for(Menu parnet_menu:topMenuList){
                if(authority.getMenuId()==parnet_menu.getId()){
                    List<Menu> childs=menuService.findChildListByParentId(parnet_menu.getId());
                    List<Menu> childMenus=new ArrayList<>();
                    for(Menu child_menu:childs){
                        for(Authority authority2:authorities)
                        if(authority2.getMenuId()==child_menu.getId()){
                             childMenus.add(child_menu);
                        }

                        List<Menu> buttons=menuService.findChildListByParentId(child_menu.getId());
                        List<Menu> chileButtons=new ArrayList<>();
                        for(Menu b:buttons) {
                            for (Authority authority2 : authorities)
                                if (authority2.getMenuId() == b.getId()) {
                                    chileButtons.add(b);
                                }
                        }
                        button.put(child_menu.getName(),chileButtons);
                    }
                    menu.put(parnet_menu,childMenus);
                }

            }
        }
        System.out.println(menu);
        session.setAttribute("menu",menu);
        session.setAttribute("button",button);
    }
}
