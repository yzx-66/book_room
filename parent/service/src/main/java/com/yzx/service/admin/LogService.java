package com.yzx.service.admin;

import com.yzx.model.admin.Log;

import java.util.List;
import java.util.Map;

public interface LogService {
     int addLog(int type,String tittle,String content);
     List<Log> findList(Map<String,Object> map);
     int getTotalNum(Map<String, Object> map);
     int delete(int id);
}
