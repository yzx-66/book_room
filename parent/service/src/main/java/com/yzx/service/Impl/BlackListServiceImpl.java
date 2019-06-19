package com.yzx.service.Impl;

import com.yzx.mapper.AccountMapper;
import com.yzx.mapper.BlackListMapper;
import com.yzx.model.Account;
import com.yzx.model.BlackList;
import com.yzx.model.admin.Log;
import com.yzx.service.AccountService;
import com.yzx.service.BlackListService;
import com.yzx.service.BlackListService;
import com.yzx.service.admin.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class BlackListServiceImpl implements BlackListService {
    @Autowired
    private BlackListMapper blackListMapper;
    @Autowired
    private AccountMapper accountMapper;
    @Autowired
    private LogService logService;

    @Override
    public int addBlackList(BlackList blackList) {
        return blackListMapper.addBlackList(blackList);
    }

    @Override
    public int deleteBlackList(int id) {
        return blackListMapper.deleteBlackList(id);

    }

    @Override
    public BlackList findBlackListById(int id) {
        return blackListMapper.findBlackListById(id);
    }

    @Override
    public BlackList findBlackListByAccountId(int id) {
        return blackListMapper.findBlackListByAccountId(id);
    }

    @Override
    public List<BlackList> findAll() {
        return blackListMapper.findAll();
    }

    @Override
    public void doInBreakListBySumBreakTimes(int accountId) throws ParseException {
        BlackList blackList=new BlackList();
        blackList.setAccountId(accountId);

        Date now=new Date();
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        blackList.setInTime(now);
        blackList.setOutTime(simpleDateFormat.parse("1970-01-01"));

        logService.addLog(Log.ACCOUNT,"黑名单","手机号为"+accountMapper.findAccountById(accountId).getPhoneNum()+"的用户违约次数达总上限被永久加黑");
        blackListMapper.addBlackList(blackList);
    }

    @Override
    public void doInBreakListByMonthBreakTimes(int accountId) {
        BlackList blackList=new BlackList();
        blackList.setAccountId(accountId);

        Date now=new Date();
        Calendar calendar=Calendar.getInstance();
        calendar.setTime(now);
        calendar.add(Calendar.DAY_OF_YEAR,30);

        blackList.setInTime(now);
        blackList.setOutTime(calendar.getTime());

        logService.addLog(Log.ACCOUNT,"黑名单","手机号为"+accountMapper.findAccountById(accountId).getPhoneNum()+"的用户违约次数达月上限被加黑一月");
        blackListMapper.addBlackList(blackList);
    }

    @Override
    public void doIsShouldOut(Account account) throws ParseException {
        List<BlackList> blackLists=blackListMapper.findAll();
        for(BlackList blackList:blackLists){
            if (blackList.getAccountId()==account.getId()){
                SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
                Date notOut=formater.parse("1970-01-01");
                Date accountOutTime=blackList.getOutTime();

                if(!(notOut.compareTo(accountOutTime)==0)){
                    Date now=new Date();
                    if(now.compareTo(accountOutTime)==1){
                        blackListMapper.deleteBlackList(blackList.getId());
                        account.setStatus(1);
                        account.setMonthBreakTimes(0);
                        accountMapper.eidtAccount(account);
                    }
                }
                break;
            }
        }
    }



}
