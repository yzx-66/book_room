package com.yzx.mapper.admin;

import com.yzx.model.admin.Floor;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface FloorMapper {
    int addFloor(Floor floor);
    int eidtFloor(Floor floor);
    int deleteFloor(int id);
    int getTotal(Map<String,Object> map);
    List<Floor> findList(Map<String,Object> map);
    List<Floor> findAllFloors();
    List<Integer> findAllFloorIds();
    Floor findFloorById(int id);
    Floor findFloorByRoomTypeId(int id);
    List<Floor> findFloorsByRoomTypeName(@Param("name") String name);
}
