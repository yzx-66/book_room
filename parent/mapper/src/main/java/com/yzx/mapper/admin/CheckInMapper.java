package com.yzx.mapper.admin;

import com.yzx.model.admin.CheckIn;

import java.util.List;
import java.util.Map;

public interface CheckInMapper {
    int addCheckIn(CheckIn CheckIn);
    int eidtCheckIn(CheckIn CheckIn);
    int deleteCheckIn(int id);
    int getTotal(Map<String,Object> map);
    List<CheckIn> findList(Map<String,Object> map);
    CheckIn findCheckInById(int id);
    List<CheckIn> findAll();
    List<Map> getStatsByMonth();
    List<Map> getStatsByDay();
}
