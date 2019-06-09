package com.yzx.mapper.admin;

import com.yzx.model.admin.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MenuMapper {
     int addMenu(Menu menu);
     List<Menu> findList(Map<String,Object> map);
     List<Menu> findTopList();
     List<Menu> findChildListByParentId(int parentId);
     int getTotalNum(Map<String, Object> map);
     int update(Menu menu);
     int delete(int id);
     int chridNums(int id);
}
