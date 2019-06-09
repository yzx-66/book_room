package com.yzx.web.controller.admin;

import com.yzx.model.admin.Menu;
import com.yzx.model.admin.Page;
import com.yzx.service.admin.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("admin/menu")
public class menuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public ModelAndView list(ModelAndView mv){
        mv.setViewName("admin/menu/list");
        mv.addObject("menuTopList",menuService.findTopList());
        return mv;
    }

    @RequestMapping("findTopList")
    @ResponseBody
    public Map<String,Object> findTopList(Model model){
        Map<String,Object> ret=new HashMap<>();
        ret.put("menuTopList",menuService.findTopList());
        return ret;
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(Menu menu){
        Map<String,String> ret=new HashMap<>();
        if(menuService.addMenu(menu)>0){
            ret.put("type","success");
        }else{
            ret.put("type","error");
            ret.put("msg","添加失败 请联系管理员");
        }
        return ret;
    }

    @RequestMapping("update")
    @ResponseBody
    public Map<String,String> update(Menu menu){
        System.out.println(menu);
        Map<String,String> ret=new HashMap<>();
        if(menuService.update(menu)>0){
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
        try{
            for(int n:id){
                if(menuService.chridNums(n)>0){
                    ret.put("type","error");
                    ret.put("msg","删除出错 存在包含有子目录的文件");
                    return ret;
                }
                if(menuService.delete(n)<=0) {
                    ret.put("type","error");
                    ret.put("msg","删除出错 请联系管理员");
                    return ret;
                }
            }
            ret.put("type","success");
        }catch (Exception e){
            e.printStackTrace();
            ret.put("type","error");
            ret.put("msg","删除出错 菜单表存在外键");
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

        ret.put("rows",menuService.findList(queryMap));
        ret.put("total",menuService.getTotalNum(queryMap));
        return ret;
    }

    @RequestMapping("showIcons")
    @ResponseBody
    public List<String> showIcons(HttpServletRequest request){
        List<String> icons=new ArrayList<>();
        String contextPath=request.getServletContext().getRealPath("/");
        String filePath=contextPath+"/resource/admin/easyui/css/icons";
        File file=new File(filePath);
        for(File f:file.listFiles()){
            icons.add(f.getName());
        }
        return icons;
    }

}
