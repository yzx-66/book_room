package com.yzx.model.admin;

public class Authority {
    private int id;
    private int menuId;
    private int roleId;

    public Authority() {
    }

    public Authority(int roleId, int menuId) {
        this.menuId = menuId;
        this.roleId = roleId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
