package com.yzx.service.admin.Impl;

import com.yzx.mapper.admin.FloorMapper;
import com.yzx.model.admin.Floor;
import com.yzx.service.admin.FloorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Transactional
@Service
public class FloorServiceImpl implements FloorService {
    @Autowired
    private FloorMapper floorMapper;

    @Override
    public int addFloor(Floor floor) {
        return floorMapper.addFloor(floor);
    }

    @Override
    public int eidtFloor(Floor floor) {
        return floorMapper.eidtFloor(floor);
    }

    @Override
    public int deleteFloor(int id) {
        return floorMapper.deleteFloor(id);
    }

    @Override
    public int getTotal(Map<String, Object> map) {
        return floorMapper.getTotal(map);
    }

    @Override
    public List<Floor> findList(Map<String, Object> map) {
        return floorMapper.findList(map);
    }

    @Override
    public List<Floor> findAllFloors() {
        return floorMapper.findAllFloors();
    }

    @Override
    public List<Integer> findAllFloorIds() {
        return floorMapper.findAllFloorIds();
    }

    @Override
    public Floor findFloorById(int id) {
        return floorMapper.findFloorById(id);
    }

    @Override
    public Floor findFloorByRoomTypeId(int id) {
        return floorMapper.findFloorByRoomTypeId(id);
    }

    @Override
    public List<Floor> findFloorsByRoomTypeName(String name) {
        return floorMapper.findFloorsByRoomTypeName(name);
    }
}
