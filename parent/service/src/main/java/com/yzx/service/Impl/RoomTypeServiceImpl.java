package com.yzx.service.Impl;

import com.yzx.mapper.RoomTypeMapper;
import com.yzx.model.RoomType;
import com.yzx.service.BookOrderService;
import com.yzx.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public class RoomTypeServiceImpl implements RoomTypeService {
    @Autowired
    private RoomTypeMapper roomTypeMapper;
    @Autowired
    private BookOrderService bookOrderService;

    @Override
    public int addRoomType(RoomType roomType) {
        return roomTypeMapper.addRoomType(roomType);
    }

    @Override
    public int eidtRoomType(RoomType roomType) {
        return roomTypeMapper.eidtRoomType(roomType);
    }

    @Override
    public int deleteRoomType(int id) {
        return roomTypeMapper.deleteRoomType(id);
    }

    @Override
    public int getTotal(Map<String, Object> map) {
        return roomTypeMapper.getTotal(map);
    }

    @Override
    public List<RoomType> findList(Map<String, Object> map) throws ParseException {
        bookOrderService.refresh();
        return roomTypeMapper.findList(map);
    }

    @Override
    public List<RoomType> findAllRoomeType() {
        return roomTypeMapper.findAllRoomeType();
    }

    @Override
    public List<RoomType> findRoomTypesByFloorId(int floorId) {
        return roomTypeMapper.findRoomTypesByFloorId(floorId);
    }

    @Override
    public RoomType findRoomTypeById(int id) {
        return roomTypeMapper.findRoomTypeById(id);
    }

    @Override
    public RoomType findRoomTypeByNameAndHight(String typeName, int hight) {
        return roomTypeMapper.findRoomTypeByNameAndHight(typeName,hight);
    }

    @Override
    public List<RoomType> findRoomTypeByName(String name) {
        return roomTypeMapper.findRoomTypeByName(name);
    }

    @Override
    public RoomType findRoomTypeByRoomId(int id){
        return roomTypeMapper.findRoomTypeByRoomId(id);
    }

    @Override
    public void refresh() {
        List<RoomType> roomTypeList=roomTypeMapper.findAllRoomeType();
        for(RoomType r:roomTypeList){
            if(r.getStatus()!=2){
                r.setStatus(r.getAvilableNum()<=0?0:1);
                r.setAvilableNum(r.getAvilableNum());
                eidtRoomType(r);
            }
        }
    }
}
