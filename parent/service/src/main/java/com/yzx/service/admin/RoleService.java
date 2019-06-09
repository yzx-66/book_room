package com.yzx.service.admin;

import com.yzx.model.admin.Authority;
import com.yzx.model.admin.Role;

import java.util.List;
import java.util.Map;

public interface RoleService {
     int addRole(Role role);
     List<Role> findList(Map<String, Object> map);
     int getTotalNum(Map<String, Object> map);
     int update(Role role);
     int delete(int id);
     int addAuthority(Authority authority);
     int deleteAuthoritys(int roleId);
     List<Authority> getAuthoritys(int roleId);
}
