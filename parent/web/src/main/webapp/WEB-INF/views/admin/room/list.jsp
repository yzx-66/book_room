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
                <c:if test="${b.key== '房间管理'}">
                    <c:forEach items="${b.value }" var="m">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <div class="wu-toolbar-search">
            <label>房间名称：</label><input id="search-name" class="wu-text" style="width:100px">
            <label>房间编号：</label><input id="search-sn" class="wu-text" style="width:100px">
            <label>房型：</label> <select id="search-typeRoomId" style="width:100px">
                                        <option value="-1" selected="selected">全部房型</option>
                                        <c:forEach items="${roomTypeNames}" var="n">
                                            <option value="${n}">${n}</option>
                                        </c:forEach>
                                     </select>
            <label>楼层：</label> <select id="search-hight" style="width:100px">
                                    <option value="-1" selected="selected">全部楼层</option>
                                    <c:forEach items="${floorHights}" var="h">
                                        <option value="${h}">${h}</option>
                                    </c:forEach>
                                </select>
            <label>房间状态：</label> <select id="search-status" style="width:100px">
                                        <option value="-1" selected="selected">全部状态</option>
                                        <option value="0">可入住</option>
                                        <option value="1">已预定</option>
                                        <option value="2">已入住</option>
                                        <option value="3">打扫中</option>
                                      </select>
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search" click="search()">开始检索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid-2" class="easyui-datagrid" toolbar="#wu-toolbar-2"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="wu-dialog-2" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-2" method="post">
        <table id="tab">
            <tr>
                <td>房间预览</td>
                <td><img src="/lnn/resource/admin/easyui/images/user_photo.jpg" id="img_id" style="width: 100px;height:100px;">
                    <input type="file" name="tempPhoto" style="width: 90px" onchange="subpic()"/>
                    <input type="hidden" name="photo" id="photo_id">
                    &nbsp;&nbsp;<input type="checkbox" id="IsSameAsType" onclick="checkIsHaveRoomType()">与房型一致
                </td>
            <tr>
                <td align="right">房间名:</td>
                <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写房间名称'"/></td>
            </tr>
            <tr>
                <td align="right">房间编号:</td>
                <td><input type="text" id="sn_id" name="sn" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写房间编号'"/></td>
            </tr>
            <tr id="edit-hide1">
                <td align="right">选择房型:</td>
                <td>
                    <select id="typeRoomName_id" onchange="fllowChangRoomType()" name="roomTypeName" style="width: 268px;" class="easyui-validatebox" data-options="required:true, missingMessage:'请选择房型'">
                        <c:forEach items="${roomTypeNames}" var="n">
                            <option value=${n}>${n}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr id="edit-hide2">
                <td align="right">楼 层:</td>
                <td>
                    <select id="hight_id"  name="hight" style="width: 268px;" class="easyui-validatebox" data-options="required:true, missingMessage:'请选择楼层'">

                    </select>
            </tr>
            <tr id="add-hide">
                <td align="right">状 态:</td>
                <td>
                    <select id="status_id"  name="status" style="width: 268px;" class="easyui-validatebox" data-options="required:true, missingMessage:'请选择状态'">
                         <option value="0">可入住</option>
                         <option value="3">打扫中</option>
                         <option value="4">不可住</option>
                    </select>
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
<script src="/lnn/resource/admin/easyui/js/jquery-form.js"></script>
<script type="text/javascript">

    function check(){
        if($('#typeRoomName_id').val()==null || $('#typeRoomName_id').val()==""){
            $.messager.alert('信息提示','房型不可以为空！','info');
            return false;
        }
        if($('#hight_id').val()==null || $('#hight_id').val()==""){
            $.messager.alert('信息提示','楼层不可以为空！','info');
            return false;
        }
        var validate = $("#wu-form-2").form("validate");
        if(!validate){
            $.messager.alert("消息提醒","请检查你输入的数据!","warning");
            return false;
        }
        return true;
    }

    $('#search-btn').click(function search() {
        var option = {name:$("#search-name").val()};
        if($('#search-sn').val()!=null && $('#search-sn').val()!=""){
            option.sn=$('#search-sn').val();
        }
        if(hight=$('#search-hight').val()!=-1){
            option.hight=$('#search-hight').val();
        }
        if($('#search-typeRoomId').val()!=-1){
            option.roomTypeName=$('#search-typeRoomId').val();
        }
        if(status=$('#search-status').val()!=-1){
            option.status=$('#search-status').val();
        }
        $('#wu-datagrid-2').datagrid('reload',option);
    })

    /**
     * Name 添加记录
     */
    function add(){
        if(!check()){
            return;
        }
        var data=$('#wu-form-2').serialize();
        $.ajax({
            url:'/lnn/admin/room/add',
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
        if(!check()){
            return;
        }
        var data=$('#wu-form-2').serialize()+"&id="+item.id+"&oldTypeId="+item.roomTypeId+"&oldStatus="+item.status;
        $.ajax({
            url:'/lnn/admin/room/update',
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

    function subpic() {
        var options={
            url:'/lnn/admin/room/subpic',
            type:'post',
            dataType:'json',
            success:function (data) {
                if(data.type=='success'){
                    $('#img_id').attr('src',data.filepath);
                    $('#photo_id').val(data.filepath);
                }else{
                    alert(data.msg);
                }
            }
        };
        $('#wu-form-2').ajaxSubmit(options);
    }

    function photoSameAsType() {
        $.ajax({
            url:'/lnn/admin/room_type/findRoomTypeByName',
            data:'name='+$('#typeRoomName_id').val(),
            dataType:'json',
            success:function (data) {
                $('#img_id').attr('src',data[0].photo);
                $('#photo_id').val(data[0].photo);
            }
        })
    }

    function checkIsHaveRoomType() {
        if($('#typeRoomName_id').val()==null){
            $.messager.alert('信息提示','请检查房型是否已选','info');
        }else{
            photoSameAsType();
        }
    }

    function fllowChangRoomType() {
        $('#hight_id').empty();
        $.ajax({
             url:'/lnn/admin/floor/findFloorsByRoomTypeName',
             data:{name:$('#typeRoomName_id').val()},
             dataType:'json',
            success:function (data) {
                for(var i=0;i<data.length;i++){
                    $('#hight_id').append("<option value="+data[i].hight+">"+data[i].hight+"&nbsp;层</option>");
                }
            }
        });
        if($('#IsSameAsType').attr('checked')=='checked'){
            photoSameAsType();
        }
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
                    ids+='id='+items[i].id+'&roomTypeId='+items[i].roomTypeId+'&';
                }

                $.ajax({
                    url:'/lnn/admin/room/delete',
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
    //    $('#edit-hide1').show();
     //   $('#edit-hide2').show();
        $('#add-hide').hide();
        $('#hight_id').empty();
        $('#img_id').attr('src','/lnn/resource/admin/easyui/images/user_photo.jpg');
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
   //     $('#edit-hide1').hide();
  //      $('#edit-hide2').hide();
        $('#add-hide').show();
        $('#hight_id').empty();
        item = $('#wu-datagrid-2').datagrid('getSelected');
        $('#wu-form-2').form('clear');
        if(item==null || item.length==0){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }

        $.ajax({
            url:'/lnn/admin/floor/findFloorByRoomTypeId',
            data:{id:item.roomTypeId},
            dataType:'json',
            async:false,
            success:function (data) {
                $('#hight_id').append('<option value='+data.hight+'>'+data.hight+'</option>');
                $('#hight_id').val(data.hight);
            }
        });
        $.ajax({
            url:'/lnn/admin/room_type/findRoomTypeById',
            data:{id:item.roomTypeId},
            dataType:'json',
            async:false,
            success:function (data) {
                $('#typeRoomName_id').val(data.name);
            }
        });

        $('#img_id').attr('src',item.photo);
        $('#photo_id').val(item.photo);
        $('#name_id').val(item.name);
        $('#sn_id').val(item.sn);
        $('#status_id').val(item.status);
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
        url:'/lnn/admin/room/list',
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
            { field:'photo',title:'房间预览',width:100,formatter:function (value,row,index) {
                    var img = "&nbsp;&nbsp;&nbsp;<img style='width: 50px;height: 50px' src="+value+"/>";
                    return img;
                }},
            { field:'name',title:'房间名',width:100,sortable:true},
            { field:'sn',title:'房间编号',width:100,sortable:true},
            { field:'roomTypeId',title:'房型',width:100,sortable:true,formatter:function (value,row,index) {
                var ret="&nbsp;&nbsp;";
                    $.ajax({
                        url:'/lnn/admin/floor/findFloorByRoomTypeId',
                        data:'id='+value,
                        dataType:'json',
                        async:false,
                        success:function (data) {
                            ret+="层数：&nbsp;"+data.hight+"&nbsp;&nbspF&nbsp;&nbsp;&nbsp;&nbsp;|";
                        }
                    });
                $.ajax({
                    url:'/lnn/admin/room_type/findRoomTypeById',
                    data:'id='+value,
                    dataType:'json',
                    async:false,
                    success:function (data) {
                        ret+="&nbsp;&nbsp;&nbsp;&nbsp;房型：&nbsp"+data.name;
                    }
                });
                    return ret;
            }},
            { field:'status',title:'状态',width:100,sortable:true,formatter:function (value) {
                    switch (value) {
                        case 0:return "可入住";
                        case 1:return "已预定";
                        case 2:return "已入住";
                        case 3:return "打扫中";
                        case 4:return "不可住";
                    }
                }},
            { field:'remark',title:'备注',width:100},
        ]]
    });
</script>
</html>
