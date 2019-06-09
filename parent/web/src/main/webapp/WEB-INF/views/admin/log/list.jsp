<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@include file="/WEB-INF/views/admin/commen/header.jsp" %>

    <div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
    <div class="wu-toolbar-button">
    <c:forEach items="${button }" var="b">
        <c:if test="${b.key== '日志管理'}">
            <c:forEach items="${b.value }" var="m">
                <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
            </c:forEach>
        </c:if>
    </c:forEach>
    </div>
    <div class="wu-toolbar-search">
    <label>日志内容：</label><input id="search-data" class="wu-text" style="width:100px">
    <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
    </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar-2"></table>
    </div>

    <%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

    <!-- End of easyui-dialog -->
    <script type="text/javascript">

    function remove(){
    var items = $('#wu-datagrid').datagrid('getSelections');
    if(items==null || items.length==0){
    $.messager.message('信息提示','至少选择一条要删除的信息','info');
    }
    $.messager.confirm('信息提示','确定要删除该记录？', function(result){
    if(result){
    var ids="";
    for(var i=0;i<items.length;i++){
        ids+='id='+items[i].id+'&';
    }

    $.ajax({
    url:'/admin/log/delete',
    data:ids,
    success:function(data){
    if(data.type=='success'){
    $.messager.alert('信息提示','删除成功！','info');
    $('#wu-datagrid').datagrid('reload');
    }
    else
    {
    $.messager.alert('信息提示',data.msg,'info');
    $('#wu-datagrid').datagrid('reload');
    }
    }
    });
    }
    });
    }


    $('#search-btn').click(function() {
        $('#wu-datagrid').datagrid('reload',{content:$('#search-data').val()});
    })

    /**
    * Name 分页过滤器
    */
    function pagerFilter(data){
    if (typeof data.length == 'number' && typeof data.splice == 'function'){// is array
    data = {
    total: data.length,
    rows: data
    }
    }
    var dg = $(this);
    var opts = dg.datagrid('options');
    var pager = dg.datagrid('getPager');
    pager.pagination({
    onSelectPage:function(pageNum, pageSize){
    opts.pageNumber = pageNum;
    opts.pageSize = pageSize;
    pager.pagination('refresh',{pageNumber:pageNum,pageSize:pageSize});
    dg.datagrid('loadData',data);
    }
    });
    if (!data.originalRows){
    data.originalRows = (data.rows);
    }
    var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
    var end = start + parseInt(opts.pageSize);
    data.rows = (data.originalRows.slice(start, end));
    return data;
    }

    /**
    * Name 载入数据
    */
    $('#wu-datagrid').datagrid({
    url:'/admin/log/list',
    rownumbers:true,
    singleSelect:false,
    loadFilter:pagerFilter,
    pageSize:20,
    pagination:true,
    multiSort:true,
    fit:true,
    fitColumns:true,
    columns:[[
    { field:'content',title:'内容',width:100},
    { field:'creatTime',title:'创建时间',width:100,sortable:true,formatter:function (value) {
            return new Date(value).toLocaleString();
        }},
    ]]
    });
    </script>
</html>
