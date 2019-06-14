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
                <c:if test="${b.key== '客户列表'}">
                    <c:forEach items="${b.value }" var="m">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <div class="wu-toolbar-search">
            <label>用户名：</label><input id="search-name" class="wu-text" style="width:100px">
            <label>真实姓名：</label><input id="search-realName" class="wu-text" style="width:100px">
            <label>电话号码：</label><input id="search-phoneNum" class="wu-text" style="width:100px">
            <label>身份证号：</label><input id="search-idCard" class="wu-text" style="width:100px">
            <label>客户状态：</label> <select id="search-status" style="width:100px">
                                        <option value="-1" selected="selected">全部状态</option>
                                        <option value="0">被冻结</option>
                                        <option value="1">正常</option>
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
                <td>头像预览</td>
                <td><img src="/hotel/resource/admin/easyui/images/user_photo.jpg" id="img_id" style="width: 100px;height:100px;">
                    <input type="file" name="tempPhoto" style="width: 90px" onchange="subpic()"/>
                    <input type="hidden" name="photo" id="photo_id">
                </td>
            <tr>
                <td align="right">用户名:</td>
                <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写用户名'"/></td>
            </tr>
            <tr>
                <td align="right">手机号:</td>
                <td><input type="text" id="phoneNum_id" name="phoneNum" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写手机号'"/></td>
            </tr>
            <tr id="edit-hide">
                <td align="right">登陆密码:</td>
                <td><input type="text" id="password_id" name="password" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写登陆密码'"/></td>
            </tr>
            <tr>
                <td align="right">真实姓名:</td>
                <td><input type="text" id="realName_id" name="realName" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写真实姓名'"/></td>
            </tr>
            <tr>
                <td align="right">身份证号:</td>
                <td><input type="text" id="idCard_id" name="idCard" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写身份证号'"/></td>
            </tr>
            <tr>
                <td valign="top" align="right">地 址:</td>
                <td><textarea name="address" id="address_id" rows="6" class="wu-textarea" style="width:260px"></textarea></td>
            </tr>
        </table>
    </form>
</div>

<%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

<!-- End of easyui-dialog -->
<script src="/hotel/resource/admin/easyui/js/jquery-form.js"></script>
<script type="text/javascript">

    $('#search-btn').click(function search() {
        var option = {name:$("#search-name").val()};
        option.realName=$('#search-realName').val();
        option.phoneNum=$('#search-phoneNum').val();
        option.idCard=$('#search-idCard').val();
        if(!$('#search-status').val()==-1){
            option.status=$('#search-status').val();
        }
        $('#wu-datagrid-2').datagrid('reload',option);
    })

    /**
     * Name 添加记录
     */
    function add(){
        var data=$('#wu-form-2').serialize();
        $.ajax({
            url:'/hotel/admin/account/add',
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
        var data=$('#wu-form-2').serialize()+"&id="+item.id+"&status="+item.status;
        $.ajax({
            url:'/hotel/admin/account/update',
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
            url:'/hotel/admin/account/subpic',
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
                    url:'/hotel/admin/account/delete',
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
        $('#edit-hide').show();
        $('#img_id').attr('src','/hotel/resource/admin/easyui/images/user_photo.jpg');
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

        $('#edit-hide').hide();
        $('#img_id').attr('src',item.photo);
        $('#photo_id').val(item.photo);
        $('#name_id').val(item.name);
        $('#realName_id').val(item.realName);
        $('#phoneNum_id').val(item.phoneNum);
        $('#address_id').val(item.address);
        $('#idCard_id').val(item.idCard);

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
        url:'/hotel/admin/account/list',
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
            { field:'photo',title:'头像预览',width:100,formatter:function (value,row,index) {
                    var img = "&nbsp;&nbsp;&nbsp;<img style='width: 50px;height: 50px' src="+value+"/>";
                    return img;
                }},
            { field:'name',title:'用户名',width:100,sortable:true},
            { field:'phoneNum',title:'手机号',width:100,sortable:true},
            { field:'realName',title:'真实姓名',width:100,sortable:true},
            { field:'idCard',title:'身份证吗',width:100,sortable:true},
            { field:'status',title:'状态',width:100,sortable:true,formatter:function (value) {
                    switch (value) {
                        case 0:return "被冻结";
                        case 1:return "正常";
                    }
                }},
            { field:'address',title:'住址',width:100,sortable:true},
        ]]
    });
</script>
</html>
