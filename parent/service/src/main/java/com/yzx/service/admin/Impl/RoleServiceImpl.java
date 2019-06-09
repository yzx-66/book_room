package com.yzx.service.admin.Impl;

import com.yzx.mapper.admin.AuthorityMapper;
import com.yzx.mapper.admin.RoleMapper;
import com.yzx.model.admin.Authority;
import com.yzx.model.admin.Role;
import com.yzx.service.admin.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private AuthorityMapper authorityMapper;

    /*
    还差校验是否存在
     */
    @Override
    public int addRole(Role role) {
        return roleMapper.addRole(role);
    }

    @Override
    public List<Role> findList(Map<String, Object> map) {
        return roleMapper.findList(map);
    }

    @Override
    public int getTotalNum(Map<String, Object> map) {
        return roleMapper.getTotalNum(map);
    }

    @Override
    public int update(Role role) {
        return roleMapper.update(role);
    }

    @Override
    public int delete(int id) {
        return roleMapper.delete(id);
    }

    @Override
    public int addAuthority(Authority authority) {
        return authorityMapper.addAuthority(authority);
    }

    @Override
    public int deleteAuthoritys(int roleId) {
        return authorityMapper.deleteAuthoritys(roleId);
    }

    @Override
    public List<Authority> getAuthoritys(int roleId) {
        return authorityMapper.getAuthorityList(roleId);
    }


}
