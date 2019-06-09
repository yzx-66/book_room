package com.yzx.service.admin.Impl;

import com.yzx.mapper.admin.MenuMapper;
import com.yzx.model.admin.Menu;
import com.yzx.service.admin.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper mapper;

    /*
    还差校验是否存在
     */
    @Override
    public int addMenu(Menu menu) {
        return mapper.addMenu(menu);
    }

    @Override
    public List<Menu> findList(Map<String, Object> map) {
        return mapper.findList(map);
    }

    @Override
    public List<Menu> findTopList() {
        return mapper.findTopList();
    }

    @Override
    public List<Menu> findChildListByParentId(int parentId) {
        return mapper.findChildListByParentId(parentId);
    }

    @Override
    public int getTotalNum(Map<String, Object> map) {
        return mapper.getTotalNum(map);
    }

    @Override
    public int update(Menu menu) {
        return mapper.update(menu);
    }

    @Override
    public int delete(int id) {
        return mapper.delete(id);
    }

    @Override
    public int chridNums(int id) {
        return mapper.chridNums(id);
    }
}
