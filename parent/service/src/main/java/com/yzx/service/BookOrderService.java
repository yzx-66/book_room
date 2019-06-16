package com.yzx.service;

import com.yzx.model.BookOrder;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface BookOrderService {
    int addBookOrder(BookOrder bookOrder);
    int eidtBookOrder(BookOrder bookOrder);
    int deleteBookOrder(int id);
    int getTotal(Map<String,Object> map);
    List<BookOrder> findList(Map<String,Object> map) throws ParseException;
    BookOrder findBookOrderById(int id);
    List<BookOrder> findAll();
    List<BookOrder> findBookOrdersByAccountId(int accountId);
    public void refresh() throws ParseException;
}
