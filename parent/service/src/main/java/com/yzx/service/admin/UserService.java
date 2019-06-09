package com.yzx.service.admin;

import com.yzx.model.admin.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    User findUserByUsername(String username);
    int addUser(User user);
    int delete(int id);
    int update(User user);
    int edit_password(long id,String password);
    List<User> findList(Map<String,Object> map);
    int getTotalNum(Map<String, Object> map);
    int findRoleId(long id);
}
