package com.yzx.service.Impl;

import com.yzx.mapper.AccountMapper;
import com.yzx.mapper.BlackListMapper;
import com.yzx.model.Account;
import com.yzx.model.BlackList;
import com.yzx.service.AccountService;
import com.yzx.service.BlackListService;
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
@Transactional
public class AccountServiceImpl implements AccountService {
    @Autowired
    private AccountMapper accountMapper;
    @Autowired
    private BlackListService blackListService;
    @Autowired
    private BlackListMapper blackListMapper;

    @Override
    public int addAccount(Account account) {
        return accountMapper.addAccount(account);
    }

    @Override
    public int eidtAccount(Account account) {
        return accountMapper.eidtAccount(account);
    }

    @Override
    public int deleteAccount(int id) {
        return accountMapper.deleteAccount(id);
    }

    @Override
    public int getTotal(Map<String, Object> map) {
        return accountMapper.getTotal(map);
    }

    @Override
    public List<Account> findList(Map<String, Object> map) throws ParseException {
        rufreshAccounts();
        List<Account> accounts=accountMapper.findList(map);
        for(Account account:accounts){
            account.setPassword("");
        }
        return accounts;
    }

    @Override
    public Account findAccountById(int id) {
        return accountMapper.findAccountById(id);
    }

    @Override
    public List<Account> findAll() {
        return accountMapper.findAll();
    }

    public void rufreshAccounts() throws ParseException {
        System.out.println(999);
        List<Account> accounts=findAll();
        List<BlackList> blackLists=blackListMapper.findAll();
        boolean ishave=false;

        for(Account account:accounts){
            blackListService.doIsShouldOut(account);
            for(BlackList blackList:blackLists){
                if (blackList.getAccountId()==account.getId()){
                    ishave=true;
                    continue;
                }
            }
            if(ishave){
                ishave=false;;
                continue;
            }

            if(account.getSumBreakTimes()>=BlackList.SUM_MOST_BREAKTIMES && account.getStatus()==1){
                blackListService.doInBreakListBySumBreakTimes(account.getId());
                account.setStatus(0);
                accountMapper.eidtAccount(account);
                continue;
            }

            if(account.getMonthBreakTimes()>=BlackList.MONTH_MOST_BREAKTIMES && account.getStatus()==1){
                System.out.println(111);
                blackListService.doInBreakListByMonthBreakTimes(account.getId());
                account.setStatus(0);
                accountMapper.eidtAccount(account);
            }
        }
    }
}
