<%--
  Created by IntelliJ IDEA.
  User: 霉偷煤南
  Date: 2019/6/10
  Time: 1:47
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
                <c:if test="${b.key== '订单列表'}">
                    <c:forEach items="${b.value }" var="m">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <div class="wu-toolbar-search">
            <label>预定账号的手机：</label><input type="text" id="search-accountPhone" class="wu-text" style="width:100px">
            <label>入住者姓名：</label><input type="text" id="search-name" class="wu-text" style="width:100px">
            <label>入住者手机：</label><input type="text" id="search-phoneNum" class="wu-text" style="width:100px">
            <label>入住起始日期：</label> <input type="text" id="search-arriveTime" style="width:100px" class="wu-text easyui-datebox"/>
            <label>入住截至日期：</label><input type="text" id="search-leaveTime" style="width:100px" class="wu-text easyui-datebox"/>
            <label>状态</label><select id="search-status">
                                    <option value="-1" selected="selected">全部</option>
                                    <option value="0" selected="selected">预定中</option>
                                    <option value="1" selected="selected">已入住</option>
                                    <option value="2" selected="selected">已离店</option>
                                </select>
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid-2" class="easyui-datagrid" toolbar="#wu-toolbar-2"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="wu-dialog-2" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-2" method="post">
        <table id="tab">
                <td align="right">预定账号的手机:</td>
                <td><input type="text" id="accountPhone" name="accountPhone" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写订单名称'"/></td>
            </tr>
            <tr>
                <td align="right">入住者姓名:</td>
                <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写订单名称'"/></td>
            </tr>
            <tr id="edit-hide1">
                <td align="right">选择房型:</td>
                <td>
                    <select id="typeRoomName_id" onchange="fllowChangRoomType()" name="roomTypeName" style="width: 268px;">
                        <c:forEach items="${roomTypeNames}" var="n">
                            <option value=${n}>${n}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr id="edit-hide2">
                <td align="right">楼 层:</td>
                <td>
                    <select id="hight_id"  name="hight" style="width: 268px;">

                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">入住者身份证号:</td>
                <td><input type="text" id="idCard_id" name="idCard" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写订单名称'"/></td>
            </tr>
            <tr>
                <td align="right">入住者手机:</td>
                <td><input type="text" id="phoneNum_id" name="phoneNum" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写订单名称'"/></td>
            </tr>
            <tr>
                <td align="right">入住日期:</td>
                <td><input type="text" id="arriveTime_id" name="arriveTime" class="wu-text easyui-datebox easyui-validatebox" data-options="required:true, missingMessage:'请填写订单名称'"/></td>
            </tr>
            <tr>
                <td align="right">退房日期:</td>
                <td><input type="text" id="leaveTime_id" name="leaveTime" class="wu-text easyui-datebox easyui-validatebox" data-options="required:true, missingMessage:'请填写订单名称'"/></td>
            </tr>
            <tr>
                <td valign="top" align="right">备 注:</td>
                <td><textarea name="remark" id="remark_id" rows="6" class="wu-textarea" style="width:260px"></textarea></td>
            </tr>
        </table>
    </form>
</div>

<%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

<!-- End of easyui-dialog -->
<script src="/hotel/resource/admin/easyui/js/jquery-form.js"></script>
<script type="text/javascript">

    $('#search-btn').click(function search() {
        console.log($('#search-leaveTime').val());
        var option = {name:$("#search-name").val()};
        if($('#search-accountPhone').val()!=null && $('#search-accountPhonephoneNum').val()!=""){
            option.accountPhone=$('#search-accountPhone').val();
        }
        if($('#search-phoneNum').val()!=null && $('#search-phoneNum').val()!=""){
            option.phoneNum=$('#search-phoneNum').val();
        }
        if($('#search-arriveTime').val()!=null && $('#search-arriveTime').val()!=""){
            option.arriveTime=$('#search-arriveTime').val();
        }
        if($('#search-leaveTime').val()!=null && $('#search-leaveTime').val()!=""){
            option.leaveTime=$('#search-leaveTime').val();
        }
        if(status=$('#search-leaveTime').val()!=-1){
            option.status=$('#search-status').val();
        }
        $('#wu-datagrid-2').datagrid('reload',option);
    })

    /**
     * Name 添加记录
     */
    function add(){
        var data=$('#wu-form-2').serialize();
        if($('#hight_id').val()==0){
            $.messager.alert('信息提示','不可以选择已经没有空房的楼层','info');
            return;
        }
        $.ajax({
            url:'/hotel/admin/bookOrder/add',
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
    function edit(item){
        if($('#hight_id').val()==0){
            $.messager.alert('信息提示','不可以选择已经没有空房的楼层','info');
            return;
        }
        var data=$('#wu-form-2').serialize()+"&id="+item.id+"&oldRoomTypeId="+item.roomTypeId;
        $.ajax({
            url:'/hotel/admin/bookOrder/update',
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

    function fllowChangRoomType() {
        $('#hight_id').empty();
        $.ajax({
             url:'/hotel/admin/floor/findFloorsByRoomTypeName',
             data:{name:$('#typeRoomName_id').val()},
             dataType:'json',
            success:function (data) {
                $('#hight_id').append("<option value=\"-1\">全部楼层随机分配！</option>");
                for(var i=0;i<data.length;i++){
                    $.ajax({
                        url:'/hotel/admin/room/getRoomNumsByTypeAndHight',
                        data:{roomTypeName:$('#typeRoomName_id').val(),hight:data[i]},
                        dataType:'json',
                        async:false,
                        success:function (size) {
                            if(size==0){
                                $('#hight_id').append("<option value=\"0\">"+data[i].hight+"&nbsp;层（该层已经预定全部 请勿选择！）</option>");
                            }else {
                                $('#hight_id').append("<option value="+data[i].hight+">"+data[i].hight+"&nbsp;层（该层剩余："+size+"间）</option>");
                            }
                        }
                    })
                }
            }
        });
    }

    /**
     * Name 删除记录
     */
    function remove(){
        var items = $('#wu-datagrid-2').datagrid('getSelections');
        if(items==null || items.length==0 ){
            $.messager.message('信息提示','请至少选择一条','info');
            return;
        }
        $.messager.confirm('信息提示','确定要删除该记录？', function(result){
            if(result){
                var ids="";
                for(var i=0;i<items.length;i++){
                    ids+='id='+items[i].id+'&';
                }

                $.ajax({
                    url:'/hotel/admin/bookOrder/delete',
                    data:ids,
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

    /**
     * Name 打开添加窗口
     */
    function openAdd(){
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
        item = $('#wu-datagrid-2').datagrid('getSelected');
        $('#wu-form-2').form('clear');
        if(item==null || item.length==0){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }
        $.ajax({
            url:'/hotel/admin/account/findaccountById',
            data:{id:item.accountId},
            dataType:'json',
            async:false,
            success:function (data) {
                $('#accountPhone').val(data.phoneNum);
            }
        })

        $('#name_id').val(item.name);
        $('#typeRoomId_id').val(null);
        $('#hight_id').val(null);
        $('#idCard_id').val(item.idCard);
        $('#phoneNum_id').val(item.phoneNum);
        $('#arriveTime_id').val(null);
        $('#leaveTime_id').val(null);
        $('#remark_id').val(item.remark);

        $('#wu-dialog-2').dialog({
            closed: false,
            modal:true,
            title: "修改信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler:function() {
                    edit(item);
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
        url:'/hotel/admin/bookOrder/list',
        rownumbers:true,
        singleSelect:false,
        loadFilter:pagerFilter,
        pageSize:100,
        pageList:[10,20,30,50,100],
        pagination:true,
        multiSort:true,
        fit:true,
        fitColumns:true,
        columns:[[
            { field:'accountId',title:'订单账号',width:100,sortable:true,formatter:function (value) {
                    var ret="";
                    $.ajax({
                        url:'/hotel/admin/account/findaccountById',
                        data:{id:value},
                        dataType:'json',
                        async:false,
                        success:function (data) {
                            ret+="&nbsp;&nbsp;真实姓名："+data.realName+"<br>&nbsp;&nbsp;手机号："+data.phoneNum;
                        }
                    })
                    return ret;
                }},
            { field:'name',title:'入住者姓名',width:100,sortable:true},
            { field:'roomTypeId',title:'房型',width:100,sortable:true,formatter:function (value,row,index) {
                var ret="";
                    $.ajax({
                        url:'/hotel/admin/floor/findFloorByRoomTypeId',
                        data:'id='+value,
                        dataType:'json',
                        async:false,
                        success:function (data) {
                            ret+="&nbsp;&nbsp;层数："+data.hight+"&nbsp;F<br>";
                        }
                    });
                $.ajax({
                    url:'/hotel/admin/room_type/findRoomTypeById',
                    data:'id='+value,
                    dataType:'json',
                    async:false,
                    success:function (data) {
                        ret+="&nbsp;&nbsp;房型："+data.name;
                    }
                });
                    return ret;
            }},
            { field:'idCard',title:'入住者身份证号',width:100,sortable:true},
            { field:'phoneNum',title:'入住者手机号',width:100,sortable:true},
            { field:'arriveDate',title:'入住时间',width:100,sortable:true,formatter:function (value) {
                    return new Date(value).toLocaleDateString();
                }},
            { field:'leaveDate',title:'退房时间',width:100,sortable:true,formatter:function (value) {
                    return new Date(value).toLocaleDateString();
                }},
            { field:'status',title:'状态',width:100,sortable:true,formatter:function (value) {
                    switch (value) {
                        case 0:return "预定中";
                        case 1:return "已入住";
                        case 2:return "已结算离店";
                    }
                }},
            { field:'remark',title:'备注',width:100},
        ]]
    });
</script>
</html>
