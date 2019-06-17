package com.yzx.mapper;

import com.yzx.model.Account;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AccountMapper {
    int addAccount(Account account);
    int eidtAccount(Account account);
    int deleteAccount(int id);
    int getTotal(Map<String,Object> map);
    List<Account> findList(Map<String,Object> map);
    Account findAccountById(int id);
    List<Account> findAll();
    Account findAccountByPhoneNum(@Param("phoneNum") String phoneNum);
    Account findaccountByBookOrderId(int id);
}
