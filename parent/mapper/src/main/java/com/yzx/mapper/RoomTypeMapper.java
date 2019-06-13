package com.yzx.mapper;

import com.yzx.model.RoomType;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RoomTypeMapper {
    int addRoomType(RoomType roomType);
    int eidtRoomType(RoomType roomType);
    int deleteRoomType(int id);
    int getTotal(Map<String,Object> map);
    List<RoomType> findList(Map<String,Object> map);
    List<RoomType> findAllRoomeType();
    List<RoomType> findRoomTypesByFloorId(int floorId);
    RoomType findRoomTypeById(int id);
    RoomType findRoomTypeByNameAndHight(@Param("name") String name,@Param("hight")int hight);
    List<RoomType> findRoomTypeByName(@Param("name") String name);
}
