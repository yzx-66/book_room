package com.yzx.web.controller.home;

import com.yzx.model.Account;
import com.yzx.model.RoomType;
import com.yzx.service.AccountService;
import com.yzx.service.RoomTypeService;
import com.yzx.service.admin.FloorService;
import com.yzx.util.CpachaUtil;
import com.yzx.util.SendMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.ParseException;
import java.util.*;

@Controller
@RequestMapping("home/index")
public class HomeController {

    @Autowired
    private RoomTypeService roomTypeService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private FloorService floorService;

     @RequestMapping("homepage")
     public String homepage(HttpServletRequest request,String name) throws ParseException {
         Map<String,Object> queryMap=new HashMap<>();
         queryMap.put("name",name);
         List<RoomType> roomTypeList=roomTypeService.findList(queryMap);
         List<RoomType> roomTypes=new ArrayList<>();
         Set<String> roomTypeNames=new HashSet<>();
         for(RoomType roomType:roomTypeList){
             if(roomTypeNames.add(roomType.getName())){
                 roomTypes.add(roomType);
             }else {
                 for(RoomType type:roomTypes){
                     if(type.getName().equals(roomType.getName())){
                         type.setRoomNum(roomType.getRoomNum()+type.getRoomNum());
                         type.setBookNum(type.getBookNum()+roomType.getBookNum());
                         type.setcanNotLiveNum(type.getcanNotLiveNum()+roomType.getcanNotLiveNum());
                         type.setLivedNum(type.getLivedNum()+roomType.getLivedNum());
                         break;
                     }
                 }
             }
         }
         request.getSession().setAttribute("roomTypeList",roomTypes);
         request.getSession().setAttribute("allRoomTypes",roomTypeService.findAllRoomeType());
         request.getSession().setAttribute("allFloors",floorService.findAllFloors());
         return "home/index/homepage";
     }

    @RequestMapping("login")
    public String login(){
        return "home/index/login";
    }

    @RequestMapping("regist")
    public String regist(){
        return "home/index/regist";
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

    @RequestMapping("loginUp")
    @ResponseBody
    public Map<String,String> load(HttpServletRequest request,String phoneNum,String password,String cpacha){
        Map<String,String> ret=new HashMap<>();
        String trueCpacha= (String) request.getSession().getAttribute("generatorVCode");
        if(trueCpacha==null){
            ret.put("type","error");
            ret.put("msg","验证码失效");
            return ret;
        }
        if(!cpacha.toUpperCase().equals(trueCpacha.toUpperCase())){
            ret.put("type","error");
            ret.put("msg","验证码错误");
            return ret;
        }

        Account account =accountService.findAccountByPhoneNum(phoneNum);
        if(account==null){
            ret.put("type","error");
            ret.put("msg","该账户不存在");
        }else if(!account.getPassword().equals(password)){
            ret.put("type","error");
            ret.put("msg","账号或密码错误");
        }else{
            request.getSession().setAttribute("account",account);
            ret.put("type","success");
        }
        return ret;
    }

    @RequestMapping("loginOut")
    public String loginout(HttpServletRequest request){
        HttpSession session=request.getSession();
        session.setAttribute("account",null);
        return "redirect:/home/index/login";
    }

    @RequestMapping("checkCpachaMsg")
    @ResponseBody
    public Map<String,String> checkCpachaMsg(HttpServletRequest request,String cpacha){
        Map<String,String> ret=new HashMap<>();
        String trueCpacha= (String) request.getSession().getAttribute("generatorVCode");
        if(trueCpacha==null){
            ret.put("type","error");
            ret.put("msg","验证码失效");
            return ret;
        }
        if(!cpacha.toUpperCase().equals(trueCpacha.toUpperCase())){
            ret.put("type","error");
            ret.put("msg","验证码错误");
            return ret;
        }
        ret.put("type","success");
        return ret;
    }

    @RequestMapping("sendMsg")
    @ResponseBody
    public Map<String,String> sendMsg(String phoneNum,HttpServletRequest request){
         Map<String,String> ret=new HashMap<>();
         Map res=SendMsg.sendmsg(phoneNum);
         if(res.get("type").equals("success")){
             request.getSession().setAttribute("cpachaCode",res.get("code"));
             ret.put("type","success");
             System.out.println(res.get("code"));
         }else {
             ret.put("type","error");
             ret.put("msg", (String) res.get("msg"));
         }
         return ret;
    }

    @RequestMapping("registUp")
    @ResponseBody
    public Map<String,String> registUp(HttpServletRequest request,String name,String phoneNum,String password,String cpacha_pic,String cpacha_msg){
        Map<String,String> ret=new HashMap<>();
        String trueCpacha= (String) request.getSession().getAttribute("generatorVCode");
        if(trueCpacha==null){
            ret.put("type","error");
            ret.put("msg","验证码失效");
            return ret;
        }
        if(!cpacha_pic.toUpperCase().equals(trueCpacha.toUpperCase())){
            ret.put("type","error");
            ret.put("msg","验证码错误");
            return ret;
        }
         if(accountService.findAccountByPhoneNum(phoneNum)!=null){
             ret.put("type","error");
             ret.put("msg","改手机号已经注册" );
             return ret;
         }
         if(!cpacha_msg.equals(request.getSession().getAttribute("cpachaCode"))){
             ret.put("type","error");
             ret.put("msg","手机验证码错误" );
             return ret;
         }

         Account account=new Account();
         account.setName(name);
         account.setPassword(password);
         account.setPhoneNum(phoneNum);
         account.setSumBreakTimes(0);
         account.setMonthBreakTimes(0);
         account.setStatus(1);
         accountService.addAccount(account);
         ret.put("type","success");

         return ret;
    }
}
