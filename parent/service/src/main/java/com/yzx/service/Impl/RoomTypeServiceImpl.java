package com.yzx.service.Impl;

import com.yzx.mapper.RoomTypeMapper;
import com.yzx.model.RoomType;
import com.yzx.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Transactional
@Service
public class RoomTypeServiceImpl implements RoomTypeService {
    @Autowired
    private RoomTypeMapper roomTypeMapper;

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
    public List<RoomType> findList(Map<String, Object> map){
        List<RoomType> roomTypeList=roomTypeMapper.findList(map);
        for(RoomType r:roomTypeList){
            if(r.getStatus()==1){
                r.setStatus(r.getAvilableNum()<=0?0:1);
                r.setAvilableNum(r.getAvilableNum());
                eidtRoomType(r);
            }
        }
        return roomTypeList;
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
}
