package com.yzx.service.admin;

import com.yzx.model.RoomType;
import com.yzx.model.admin.Room;

import java.util.List;
import java.util.Map;

public interface RoomService {
    int addRoom(Room room);
    int eidtRoom(Room room);
    int deleteRoom(int id);
    int getTotal(Map<String,Object> map);
    List<Room> findList(Map<String,Object> map);
    Room findRoomById(int id);
    List<Room> findRoomByTypeNameOrHight(Map<String,Object> map);
}
