package com.yzx.service.admin.Impl;

import com.yzx.mapper.admin.UserMapper;
import com.yzx.model.admin.User;
import com.yzx.service.admin.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


@Transactional
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper mapper;

    @Override
    public User findUserByUsername(String username) {
        return mapper.findUesrByUserame(username);
    }

    @Override
    public int addUser(User user) {
        return mapper.addUser(user);
    }

    @Override
    public int delete(int id) {
        return mapper.delete(id);
    }

    @Override
    public int update(User user) {
        return mapper.update(user);
    }

    @Override
    public int edit_password(long id, String password) {
        return mapper.edit_password(id,password);
    }

    @Override
    public List<User> findList(Map<String, Object> map) {
        return mapper.findList(map);
    }

    @Override
    public int getTotalNum(Map<String, Object> map) {
        return mapper.getTotalNum(map);
    }

    @Override
    public int findRoleId(long id) {
        return mapper.findRoleId(id);
    }
}
