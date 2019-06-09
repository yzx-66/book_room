package com.yzx.mapper.admin;

import com.yzx.model.admin.Log;
import com.yzx.model.admin.Page;

import java.util.List;
import java.util.Map;

public interface LogMapper {
     int addLog(Log log);
     List<Log> findList(Map<String,Object> map);
     int getTotalNum(Map<String, Object> map);
     int delete(int id);
}
