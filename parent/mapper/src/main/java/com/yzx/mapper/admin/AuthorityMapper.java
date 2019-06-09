package com.yzx.mapper.admin;

import com.yzx.model.admin.Authority;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuthorityMapper {
    int addAuthority(Authority authority);
    int deleteAuthoritys(@Param("roleId") int roleId);
    List<Authority> getAuthorityList(@Param("roleId") int roleId);
}
