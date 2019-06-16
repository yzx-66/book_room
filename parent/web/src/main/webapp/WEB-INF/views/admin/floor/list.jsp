<%--
  Created by IntelliJ IDEA.
  User: 霉偷煤南
  Date: 2019/6/10
  Time: 1:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/views/admin/commen/header.jsp" %>

<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
        <div class="wu-toolbar-button">
            <c:forEach items="${button }" var="b">
                <c:if test="${b.key== '楼层列表'}">
                    <c:forEach items="${b.value }" var="m">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <div class="wu-toolbar-search">
            <label>楼层名称：</label><input id="search-data" class="wu-text" style="width:100px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid-2" class="easyui-datagrid" toolbar="#wu-toolbar-2"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="wu-dialog-2" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-2" method="post">
        <table>
            <tr>
                <td width="60" align="right">楼层名:</td>
                <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写楼层名称'"/></td>
            </tr>
            <tr>
                <td width="60" align="right">层 数:</td>
                <td><input type="text" id="hight_id" name="hight" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填层数'"/></td>
            </tr>
            <tr>
                <td valign="top" align="right">备 注:</td>
                <td><textarea name="remark" id="remark_id" rows="6" class="wu-textarea" style="width:260px"></textarea></td>
            </tr>
        </table>
    </form>
</div>

<%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

<style>
    span{
        text-align: justify;
        float: left;
    }
    span:after{
        content:'.';
        width: 100%;
        display: inline-block;
        overflow: hidden;
        height: 0;
    }
</style>
<!-- End of easyui-dialog -->
<script type="text/javascript">

    function check(){
        var validate = $("#wu-form-2").form("validate");
        if(!validate){
            $.messager.alert("消息提醒","请检查你输入的数据!","warning");
            return false;
        }
        return true;
    }
    /**
     * Name 添加记录
     */
    function add(){
        if(!check()){
            return;
        }
        var hight=$('#hight_id').val();
        if(hight==null || hight=="" || isNaN(hight)){
            $.messager.alert('信息提示','请输入正确的楼层！','info');
            return;
        }
        var data=$('#wu-form-2').serialize();
        $.ajax({
            url:'/hotel/admin/floor/add',
            type:'post',
            dataType:'json',
            data:data,
            success:function(data){
                if(data.type=='success'){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog-2').dialog('close');
                    $('#wu-datagrid-2').datagrid('reload');
                }
                else
                {
                    $.messager.alert('信息提示',data.msg,'info');
                }
            }
        });
    }

    /**
     * Name 修改记录
     */
    function edit(id){
        if(!check()){
            return;
        }
        var hight=$('#hight_id').val();
        if(hight==null || hight=="" || isNaN(hight)){
            $.messager.alert('信息提示','请输入正确的楼层！','info');
            return;
        }
        var data=$('#wu-form-2').serialize()+"&id="+id;
        $.ajax({
            url:'/hotel/admin/floor/update',
            type:'post',
            dataType:'json',
            data:data,
            success:function(data){
                if(data.type=='success'){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog-2').dialog('close');
                    $('#wu-datagrid-2').datagrid('reload');
                }
                else
                {
                    $.messager.alert('信息提示',data.msg,'info');
                }
            }
        });

    }

    /**
     * Name 删除记录
     */
    function remove(){
        var item = $('#wu-datagrid-2').datagrid('getSelected');
        if(item==null || item.length==0 ){
            $.messager.message('信息提示','请至少选择一条','info');
            return;
        }
        $.messager.confirm('信息提示','确定要删除该记录？', function(result){
            if(result){
                $.ajax({
                    url:'/hotel/admin/floor/delete',
                    data:{id:item.id},
                    success:function(data){
                        if(data.type=='success'){
                            $.messager.alert('信息提示','删除成功！','info');
                            $('#wu-datagrid-2').datagrid('reload');
                        }
                        else
                        {
                            $.messager.alert('信息提示',data.msg,'info');
                            $('#wu-datagrid-2').datagrid('reload');
                        }
                    }
                });
            }
        });
    }

    $('#search-btn').click(function() {
        $('#wu-datagrid-2').datagrid('reload',{name:$('#search-data').val()});
    });

    /**
     * Name 打开添加窗口
     */
    function openAdd(){
        $.messager.show({showType:'slide', showSpeed:'600',msg:'请按：“第n层：...房 + ...房” 格式增加层名',title:'小提示'});
        $('#wu-form-2').form('clear');
        $('#wu-dialog-2').dialog({
            closed: false,
            modal:true,
            title: "添加信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: add
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#wu-dialog-2').dialog('close');
                }
            }]
        });
    }

    /**
     * Name 打开修改窗口
     */
    function openEdit(){
        $.messager.show({showType:'slide', showSpeed:'600',msg:'请按：“第n层：...房 + ...房” 格式修改层名',title:'小提示'});
        $('#wu-form-2').form('clear');
        var item = $('#wu-datagrid-2').datagrid('getSelected');
        if(item==null || item.length==0){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }

        $('#name_id').val(item.name);
        $('#hight_id').val(item.hight);
        $('#remark_id').val(item.remark);
        $('#wu-dialog-2').dialog({
            closed: false,
            modal:true,
            title: "修改信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler:function() {
                    edit(item.id);
                }
            },{
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#wu-dialog-2').dialog('close');
                }
            }]
        });
    }


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
    $('#wu-datagrid-2').datagrid({
        url:'/hotel/admin/floor/list',
        rownumbers:true,
        singleSelect:true,
        loadFilter:pagerFilter,
        pageSize:100,
        pageList:[10,20,30,50,100],
        pagination:true,
        multiSort:true,
        fit:true,
        fitColumns:true,
        idField:'id',
        treeField:'name',
        columns:[[
            { field:'name',title:'楼层名',width:180,},
            { field:'hight',title:'层高',width:90,sortable:true,formatter:function(value,row,index){
                if(value==0){
                    return "不确定楼层"
                }
                return value+" 层";
                }},
            { field:'remark',title:'备注',width:300},
            { field:'icon',title:'信息概览',width:800,formatter:function(value,row,index){
                //return "&nbsp;&nbsp;&nbsp;<img src=/hotel/resource/admin/easyui/css/icons/heart.png />&nbsp;&nbsp;&nbsp;&nbsp;11 预定数:1 已入住数:1 可用数:-2<br>&nbsp;&nbsp;&nbsp;<img src=/resource/admin/easyui/css/icons/heart.png />&nbsp;&nbsp;&nbsp;&nbsp;11 预定数:1 已入住数:1 可用数:-2<br>";
                    var img = "<li>&nbsp;&nbsp;&nbsp;<img src=/hotel/resource/admin/easyui/css/icons/star.png />&nbsp;&nbsp;&nbsp;&nbsp;";
                    var ret="";
                    $.ajax({
                        url:'/hotel/admin/room_type/getTypesByFloorId',
                        data:{floorId:row.id},
                        type:'post',
                        dataType:'json',
                        async: false,
                        success:function (data) {
                            var roomNum=0;
                            var avilableNum=0;
                            var bookNum=0;
                            var livedNum=0;
                            var roomType="";
                            for(var i=0;i<data.length;i++){
                                //var roomtype=img+"<a href='/hotel/admin/room_type/list?dowhat=edit&id="+data[i].id+"' title=\"点我编辑\" style='text-decoration: underline' xmlns=\"http://www.w3.org/1999/htm\"><span style='width: 150px'> 房间类型：<font color='red' size='3'>"+data[i].name+"</font></span>&nbsp;&nbsp;价格："+data[i].price+"&nbsp;（晚/RMB）&nbsp;&nbsp;&nbsp;、&nbsp;&nbsp;&nbsp;&nbsp;预定数：<font color='blue' size='2' >"+data[i].bookNum+"</font>&nbsp;&nbsp;&nbsp;&nbsp;、&nbsp;&nbsp;&nbsp;&nbsp;已入住数：<font color='#d2691e' size='2'> "+data[i].livedNum+"</font>&nbsp;&nbsp;&nbsp;&nbsp;、&nbsp;&nbsp;&nbsp;&nbsp;可用数：<font color='#8a2be2' size='2'>"+data[i].avilableNum+"</font></a></li><br>";
                                roomNum+=data[i].roomNum;
                                avilableNum+=data[i].avilableNum;
                                bookNum+=data[i].bookNum;
                                livedNum+=data[i].livedNum;
                                roomType+="<a href='/hotel/admin/room_type/list?dowhat=edit&id="+data[i].id+"' title=\"点我查询\" style='text-decoration: underline'><font color='blue'> "+data[i].name+"</font></a>&nbsp;&nbsp;&nbsp;&nbsp";
                            }
                            ret="<li>&nbsp;<img src=/hotel/resource/admin/easyui/css/icons/heart.png />&nbsp;&nbsp;&nbsp;&nbsp;房间总数："+roomNum+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预定总数："+bookNum+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已入住数："+livedNum+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;可用数：<font color='#006400' size='3'> "+avilableNum+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;全部房型："+roomType+"</li>";
                            if(data.length==0){
                                ret="<li>&nbsp;<img src=/hotel/resource/admin/easyui/css/icons/heart_broken.png />&nbsp;&nbsp;&nbsp;&nbsp;<a href='/hotel/admin/room_type/list?dowhat=add' title=\"点我添加\" style='text-decoration: underline'><font color='blue'>没有房型点击添加</font></a> </li>"
                            }
                        }
                    });
                    return ret;
            }},
        ]]
    });
</script>
</html>
