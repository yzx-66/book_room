package com.yzx.mapper;

import com.yzx.model.Account;
import com.yzx.model.BlackList;

import java.util.List;
import java.util.Map;

public interface BlackListMapper {
    int addBlackList(BlackList blackList);
    int eidtBlackList(BlackList blackList);
    int deleteBlackList(int id);
    int getTotal(Map<String,Object> map);
    List<BlackList> findList(Map<String,Object> map);
    BlackList findBlackListById(int id);
    List<BlackList> findAll();
    BlackList findBlackListByAccountId(int id);
}
