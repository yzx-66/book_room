package com.yzx.service.admin.Impl;

import com.yzx.mapper.AccountMapper;
import com.yzx.mapper.RoomTypeMapper;
import com.yzx.mapper.admin.CheckInMapper;
import com.yzx.mapper.admin.FloorMapper;
import com.yzx.model.admin.CheckIn;
import com.yzx.service.admin.CheckInService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class CheckInServiceImpl implements CheckInService {

    @Autowired
    private CheckInMapper checkInMapper;
    @Autowired
    private AccountMapper accountMapper;
    @Autowired
    private RoomTypeMapper roomTypeMapper;
    @Autowired
    private FloorMapper floorMapper;

    @Override
    public int addCheckIn(CheckIn checkIn) {
        return checkInMapper.addCheckIn(checkIn);
    }

    @Override
    public int eidtCheckIn(CheckIn checkIn) {
        return checkInMapper.eidtCheckIn(checkIn);
    }

    @Override
    public int deleteCheckIn(int id) {
        return checkInMapper.deleteCheckIn(id);
    }

    @Override
    public int getTotal(Map<String, Object> map) {
        return checkInMapper.getTotal(map);
    }

    @Override
    public List<CheckIn> findList(Map<String, Object> map){
        List<CheckIn> checkInList=checkInMapper.findList(map);
        for (CheckIn checkIn:checkInList){
            if(checkIn.getAccountId()!=null){
                checkIn.setAccountPhone(accountMapper.findAccountById(checkIn.getAccountId()).getPhoneNum());
            }
            int roomTypeId=roomTypeMapper.findRoomTypeByRoomId(checkIn.getRoomId()).getId();
            checkIn.setRoomTypeAndFloor("&nbsp;&nbsp;&nbsp;"+floorMapper.findFloorByRoomTypeId(roomTypeId).getHight()+"&nbsp;F&nbsp;&nbsp;|&nbsp;&nbsp;"+roomTypeMapper.findRoomTypeById(roomTypeId).getName());
        }
        return checkInList;
    }

    @Override
    public CheckIn findCheckInById(int id) {
        return checkInMapper.findCheckInById(id);
    }

    @Override
    public List<CheckIn> findAll() {
        return checkInMapper.findAll();
    }

    @Override
    public List<Map> getStatsByMonth() {
        return checkInMapper.getStatsByMonth();
    }

    @Override
    public List<Map> getStatsByDay() {
        return checkInMapper.getStatsByDay();
    }
}
