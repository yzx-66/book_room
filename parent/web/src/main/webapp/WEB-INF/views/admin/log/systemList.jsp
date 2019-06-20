<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@include file="/WEB-INF/views/admin/commen/header.jsp" %>

    <div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
    <div class="wu-toolbar-button">
    <c:forEach items="${button }" var="b">
        <c:if test="${b.key== '系统日志'}">
            <c:forEach items="${b.value }" var="m">
                <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
            </c:forEach>
        </c:if>
    </c:forEach>
    </div>
    <div class="wu-toolbar-search">
        <label>日志标题：</label><input id="search-tittle" class="wu-text" style="width:100px">
        <label>日志内容：</label><input id="search-content" class="wu-text" style="width:100px">
        <label>日志起始日期：</label><input type="text" id="search-startTime" style="width:100px" class="wu-text easyui-datebox">
        <label>日志截至日期：</label><input id="search-endTime" type="text" class="easyui-datebox">
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
    url:'/lnn/admin/log/delete',
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
        $('#wu-datagrid').datagrid('reload',{tittle:$('#search-tittle').val(),content:$('#search-content').val(),startTime:$('#search-startTime').datebox('getValue'),endTime:$('#search-endTime').datebox('getValue')});
    })


    /**
    * Name 载入数据
    */
    $('#wu-datagrid').datagrid({
        url:'/lnn/admin/log/list?type=1',
        rownumbers:true,
        singleSelect:false,
        pageSize:50,
        pageList:[10,20,30,50,100],
        pagination:true,
        multiSort:true,
        fit:true,
        fitColumns:true,
        columns:[[
            { field:'tittle',title:'标题',width:100},
            { field:'content',title:'内容',width:100},
            { field:'creatTime',title:'创建时间',width:100,sortable:true,formatter:function (value) {
                    return new Date(value).toLocaleString();
                }},
            ]]
    });
    </script>
</html>
