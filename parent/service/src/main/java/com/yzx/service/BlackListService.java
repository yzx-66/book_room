package com.yzx.service;

import com.yzx.model.Account;
import com.yzx.model.BlackList;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface BlackListService {
    int addBlackList(BlackList blackList);
    int deleteBlackList(int id);
    BlackList findBlackListById(int id);
    BlackList findBlackListByAccountId(int id);
    List<BlackList> findAll();
    void doInBreakListBySumBreakTimes(int accountId) throws ParseException;
    void doInBreakListByMonthBreakTimes(int accountId);
    void doIsShouldOut(Account account) throws ParseException;
}
