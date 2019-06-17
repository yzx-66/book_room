package com.yzx.service;

import com.yzx.model.Account;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface AccountService {
    int addAccount(Account account);
    int eidtAccount(Account account);
    int deleteAccount(int id);
    int getTotal(Map<String,Object> map);
    List<Account> findList(Map<String,Object> map) throws ParseException;
    Account findAccountById(int id);
    List<Account> findAll();
    Account findAccountByPhoneNum(String phoneNum);
    Account findaccountByBookOrderId(int id);
    void rufresh() throws ParseException;
}
