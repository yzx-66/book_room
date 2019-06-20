package com.yzx.service.Impl;

import com.yzx.mapper.BookOrderMapper;
import com.yzx.mapper.admin.LogMapper;
import com.yzx.model.Account;
import com.yzx.model.BookOrder;
import com.yzx.model.RoomType;
import com.yzx.model.admin.Room;
import com.yzx.service.AccountService;
import com.yzx.service.BookOrderService;
import com.yzx.service.RoomTypeService;
import com.yzx.service.admin.FloorService;
import com.yzx.service.admin.RoomService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Service
@Transactional
public class BookOrderServiceImpl implements BookOrderService {
    @Autowired
    private BookOrderMapper bookOrderMapper;
    @Autowired
    private RoomService roomService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private RoomTypeService roomTypeService;
    @Autowired
    private FloorService floorService;

    @Override
    public int addBookOrder(BookOrder bookOrder) {
        return bookOrderMapper.addBookOrder(bookOrder);
    }

    @Override
    public int eidtBookOrder(BookOrder bookOrder) {
        return bookOrderMapper.eidtBookOrder(bookOrder);
    }

    @Override
    public int deleteBookOrder(int id) {
        return bookOrderMapper.deleteBookOrder(id);
    }

    @Override
    public int getTotal(Map<String, Object> map) {
        return bookOrderMapper.getTotal(map);
    }

    @Override
    public List<BookOrder> findList(Map<String, Object> map) throws ParseException {
        refresh();
        List<BookOrder> bookOrderList=bookOrderMapper.findList(map);
        for(BookOrder bookOrder:bookOrderList){
            bookOrder.setAccountPhone(accountService.findAccountById(bookOrder.getAccountId()).getPhoneNum());
            bookOrder.setRoomTypeAndFloor("&nbsp;&nbsp;&nbsp;"+floorService.findFloorByRoomTypeId(bookOrder.getRoomTypeId()).getHight()+"&nbsp;F&nbsp;&nbsp|&nbsp;&nbsp; "+roomTypeService.findRoomTypeById(bookOrder.getRoomTypeId()).getName());
        }
        return bookOrderList;
    }

    @Override
    public BookOrder findBookOrderById(int id) {
        return bookOrderMapper.findBookOrderById(id);
    }

    @Override
    public List<BookOrder> findAll() {
        return bookOrderMapper.findAll();
    }

    @Override
    public List<BookOrder> findBookOrdersByAccountId(int accountId) {
        return bookOrderMapper.findBookOrdersByAccountId(accountId);
    }

    @Override
    public void refresh() throws ParseException {
        List<BookOrder> bookOrderList=findAll();
        for (BookOrder bookOrder:bookOrderList){
            if(bookOrder.getStatus()==BookOrder.IN_BOOK){
                Date leaveDate=bookOrder.getLeaveDate();
                Date now=new Date();
                if(now.compareTo(leaveDate)==1){
                    bookOrder.setStatus(BookOrder.IN_BREAK);
                    eidtBookOrder(bookOrder);

                    RoomType type=roomTypeService.findRoomTypeById(bookOrder.getRoomTypeId());
                    type.setBookNum(type.getBookNum()-1);
                    roomTypeService.eidtRoomType(type);

                    List<Room> rooms=roomService.findRoomByTypeIdAndStatus(bookOrder.getRoomTypeId(), Room.ALEARY_BOOK);
                    Random random=new Random();
                    Room room=rooms.get(random.nextInt(rooms.size()));
                    room.setStatus(Room.CAN_LIVE);
                    roomService.eidtRoom(room);

                    Account account=accountService.findAccountById(bookOrder.getAccountId());
                    account.setMonthBreakTimes(account.getMonthBreakTimes()+1);
                    account.setSumBreakTimes(account.getSumBreakTimes()+1);
                    accountService.eidtAccount(account);
                }
            }
        }
        accountService.rufresh();
        roomTypeService.refresh();
    }

}
