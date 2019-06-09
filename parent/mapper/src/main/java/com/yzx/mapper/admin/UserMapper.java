package com.yzx.mapper.admin;

import com.yzx.model.admin.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    User findUesrByUserame(@Param("name") String name);
    int addUser(User user);
    int delete(int id);
    int update(User user);
    int edit_password(@Param("id") long id,@Param("password") String password);
    List<User> findList(Map<String,Object> map);
    int getTotalNum(Map<String, Object> map);
    int findRoleId(long id);
}
