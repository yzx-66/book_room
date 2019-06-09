package com.yzx.mapper.admin;

import com.yzx.model.admin.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RoleMapper {
     int addRole(Role role);
     List<Role> findList(Map<String,Object> map);
     int getTotalNum(Map<String, Object> map);
     int update(Role role);
     int delete(int id);
}
