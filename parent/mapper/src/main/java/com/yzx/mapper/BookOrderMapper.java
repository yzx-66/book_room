package com.yzx.mapper;

import com.yzx.model.BookOrder;

import java.util.List;
import java.util.Map;

public interface BookOrderMapper {
    int addBookOrder(BookOrder bookOrder);
    int eidtBookOrder(BookOrder bookOrder);
    int deleteBookOrder(int id);
    int getTotal(Map<String,Object> map);
    List<BookOrder> findList(Map<String,Object> map);
    BookOrder findBookOrderById(int id);
    List<BookOrder> findAll();
    List<BookOrder> findBookOrdersByAccountId(int accountId);
}
