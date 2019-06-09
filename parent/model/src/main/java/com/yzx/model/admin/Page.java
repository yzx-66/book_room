package com.yzx.model.admin;

public class Page {
    private int page=1;
    private int offset;
    private int rows=99;

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public int getOffset() {
        return (page-1)*rows;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }
}
