package com.yzx.web.controller;

import com.yzx.model.Account;
import com.yzx.model.BlackList;
import com.yzx.service.AccountService;
import com.yzx.service.BlackListService;
import com.yzx.service.BookOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.util.*;

@Controller
@RequestMapping("admin/blackList")
public class BlackListController {

    @Autowired
    private BlackListService blackListService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private BookOrderService bookOrderService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(){
        return "admin/blackList/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(int accountId) throws ParseException {
        Map<String,String> ret=new HashMap<>();
        Account account=accountService.findAccountById(accountId);
        if(blackListService.findBlackListByAccountId(accountId)!=null){
            ret.put("type","error");
            ret.put("msg","添加失败 该用户已经在黑名单");
        }else if(bookOrderService.findBookOrdersByAccountId(accountId)!=null){
            ret.put("type","error");
            ret.put("msg","添加失败 该用户还有未完成的定单");
        }else{
            blackListService.doInBreakListBySumBreakTimes(accountId);
            account.setStatus(0);
            accountService.eidtAccount(account);
            ret.put("type","success");
        }
        return ret;
    }

    @RequestMapping("findBlackListByAccountId")
    @ResponseBody
    public BlackList findBlackListByAccountId(int accountId) {
        return blackListService.findBlackListByAccountId(accountId);
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(int [] id,int [] accountId){
        Map<String,String> ret=new HashMap<>();
        for(int i=0;i<id.length;i++){
            Account account=accountService.findAccountById(accountId[i]);
            if(account.getSumBreakTimes()==BlackList.SUM_MOST_BREAKTIMES){
                ret.put("type", "error");
                ret.put("msg", "删除停止 有用户违约次数已达总上限 永久冻结");
                return ret;
            }
            if(blackListService.deleteBlackList(id[i])<=0) {
                ret.put("type", "error");
                ret.put("msg", "删除出错 请联系管理员");
                return ret;
            }
            account.setStatus(1);
            accountService.eidtAccount(account);
        }
        ret.put("type","success");
        return ret;
    }

//    @RequestMapping(value="list",method = RequestMethod.POST)//搜索的时候的参数名
//    @ResponseBody
//    public Map<String,Object> findList(Page page,
//                                       @RequestParam(value = "name",defaultValue = "",required = false)String name,
//                                       @RequestParam(value = "realName",defaultValue = "",required = false)String realName,
//                                       @RequestParam(value = "phoneNum",defaultValue = "",required = false)String phoneNum,
//                                       @RequestParam(value = "idCard",defaultValue = "",required = false)String idCard
//    ) {
//        Map<String,Object> ret=new HashMap<>();
//        Map<String,Object> queryMap=new HashMap<>();
//
//        queryMap.put("name",name);
//        queryMap.put("realName",realName);
//        queryMap.put("phoneNum",phoneNum);
//        queryMap.put("idCard",idCard);
//        queryMap.put("pageSize",page.getRows());
//        queryMap.put("offset",page.getOffset());
//        System.out.println(queryMap);
//
//        ret.put("rows",blackListService.findList(queryMap));
//        ret.put("total",blackListService.getTotal(queryMap));
//        return ret;
//    }

    @RequestMapping("findblackListById")
    @ResponseBody
    public BlackList findblackListById(int id){
        return blackListService.findBlackListById(id);
    }

}
