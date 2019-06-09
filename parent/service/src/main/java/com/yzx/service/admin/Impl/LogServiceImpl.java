package com.yzx.service.admin.Impl;

import com.yzx.mapper.admin.LogMapper;
import com.yzx.model.admin.Log;
import com.yzx.service.admin.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class LogServiceImpl implements LogService {
    @Autowired
    private LogMapper mapper;

    @Override
    public int addLog(String content) {
        Log log=new Log(content,new Date());
        return mapper.addLog(log);
    }

    @Override
    public List<Log> findList(Map<String, Object> map) {
        return mapper.findList(map);
    }

    @Override
    public int getTotalNum(Map<String, Object> map) {
        return mapper.getTotalNum(map);
    }

    @Override
    public int delete(int id) {
        return mapper.delete(id);
    }
}
