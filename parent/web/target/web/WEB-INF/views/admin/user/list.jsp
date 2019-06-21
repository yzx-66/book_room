<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/views/admin/commen/header.jsp" %>

    <div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
        <div id="supperControllerId" style="display: none">${supperControllerId}</div>
        <div id="userRoleId" style="display:none;">${user.roleId}</div>
    <div class="wu-toolbar-button">
        <c:forEach items="${button }" var="b">
            <c:if test="${b.key== '管理员列表'}">
                <c:forEach items="${b.value }" var="m">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                </c:forEach>
            </c:if>
        </c:forEach>
    </div>
    <div class="wu-toolbar-search">
    <label>用户名：</label><input id="search-data" class="wu-text" style="width:100px">
    <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
    </div>
    </div>
        <table id="wu-datagrid-2"  toolbar="#wu-toolbar-2"></table>
    </div>
    <!-- Begin of easyui-dialog -->
    <div id="wu-dialog-2" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-2" method="post">
    <table>
        <tr>
            <td>头像预览</td>
            <td><img src="/lnn/resource/admin/easyui/images/user_photo.jpg" id="img_id" style="width: 100px;height:100px;">
                <input type="file" name="tempPhoto" style="width: 90px" onchange="subpic()"/>
                <input type="hidden" name="photo" id="photo_id">
            </td>
        </tr>
        <tr></tr>
        <tr>
        <td width="60" align="right">用户名:</td>
        <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写角色名称'"/></td>
        </tr>
        <tr id="edit-hide">
            <td align="right">密 码:</td>
            <td><input type="text" name="password" id="password_id" class="wu-text" /></td>
        </tr>
        <tr>
            <td align="right">角色:</td>
            <td><select id="roleId_id" name="roleId" class="easyui-combobox" panelHeight="auto" style="width: 268px">
                <c:forEach items="${roleList}" var="r">
                    <option value="${r.id}">${r.name}</option>
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td align="right">性 别:</td>
            <td><select id="sex_id" name="sex" class="easyui-combobox" panelHeight="auto" style="width: 268px">
                <option value="0">保密</option>
                <option value="1">男</option>
                <option value="2">女</option>
            </select></td>
        </tr>
        <tr>
            <td align="right">年龄:</td>
            <td><input type="text" name="age" id="age_id" class="wu-text" /></td>
        </tr>
        <tr>
            <td valign="top" align="right">地 址:</td>
            <td><textarea name="address" id="address_id" rows="6" class="wu-textarea" style="width:260px"></textarea></td>
        </tr>
    </table>
    </form>
    </div>

    <!-- 选择权限弹窗 -->
    <div id="authority-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:200px;height:300px; padding:10px;">
        <ul id="authority-tree"></ul>
    </div>

<%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

    <!-- End of easyui-dialog -->
    <script src="/lnn/resource/admin/easyui/js/jquery-form.js"></script>
    <script type="text/javascript">

        function checkAuthory() {
            if($('#roleId_id').combobox('getValue')==$('#supperControllerId').html()){
                if($('#userRoleId').html()!=$('#supperControllerId').html()){
                    $.messager.alert('信息提示','您没有权限变动超级管理员！','info');
                    return false;
                }
            }
            return true;
        }

    function add(){
        if(!checkAuthory()){
            console.log(2);
            return;
        }
        var data=$('#wu-form-2').serialize();
        $.ajax({
            url:'/lnn/admin/user/add',
            type:'post',
            dataType:'json',
            data:data,
            success:function(data){
                if(data.type=='success'){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog-2').dialog('close');
                    $('#wu-datagrid-2').datagrid('reload');
                } else {
                    $.messager.alert('信息提示',data.msg,'info');
                }
            }
        });
    }

    /**
    * Name 修改记录
    */
    function edit(id){
        if(!checkAuthory()){
            return;
        }
        var data=$('#wu-form-2').serialize()+"&id="+id;
        $.ajax({
            url:'/lnn/admin/user/update',
            type:'post',
            dataType:'json',
            data:data,
            success:function(data){
                if(data.type=='success'){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog-2').dialog('close');
                    $('#wu-datagrid-2').datagrid('reload');
                } else {
                    $.messager.alert('信息提示',data.msg,'info');
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
                    if(items[i].roleId==$('#supperControllerId').html()){
                        if($('#userRoleId').html()!=$('#supperControllerId').html()){
                            $.messager.alert('信息提示','您没有权限删除超级管理员！','info');
                            return;
                        }
                    }
                    ids+='id='+items[i].id+'&';
                }

                $.ajax({
                    url:'/lnn/admin/user/delete',
                    data:ids,
                    success:function(data){
                        if(data.type=='success'){
                            $.messager.alert('信息提示','删除成功！','info');
                            $('#wu-datagrid-2').datagrid('reload');
                        } else {
                            $.messager.alert('信息提示',data.msg,'info');
                            $('#wu-datagrid-2').datagrid('reload');
                        }
                        $('#wu-datagrid-2').datagrid('clearSelections');
                    }
                });
            }
        });
    }

    $('#search-btn').click(function() {
        $('#wu-datagrid-2').datagrid('reload',{name:$('#search-data').val()});
    });

    function subpic() {
        var options={
            url:'/lnn/admin/user/subpic',
            type:'post',
            dataType:'json',
            success:function (data) {
                if(data.type=='success'){
                    $('#img_id').attr('src',data.filepath)
                    $('#photo_id').val(data.filepath);
                }else{
                    alert(data.msg);
                }
            }
        };
        $('#wu-form-2').ajaxSubmit(options);
    }



    /**
    * Name 打开添加窗口
    */
    function openAdd(){
    $('#wu-form-2').form('clear');
    $('#edit-hide').show();
    $('#img_id').attr('src','/lnn/resource/admin/easyui/images/user_photo.jpg');
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
        $('#wu-form-2').form('clear');
        $('#edit-hide').hide();
        var item = $('#wu-datagrid-2').datagrid('getSelected');
        if(item==null || item.length==0){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }
        if(!checkAuthory()){
            return;
        }
        console.log(item);
        $('#img_id').attr('src',item.photo);
        $('#photo_id').val(item.photo);
        $('#name_id').val(item.name);
      //  $('#password_id').val(item.password);
        $('#roleId_id').combobox('setValue',item.roleId);
        $('#sex_id').combobox('setValue',item.sex);
        $('#age_id').val(item.age);
        $('#address_id').val(item.address);
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

    init();
    function init() {
        setTimeout(refreshDic, 1);
    }
    function refreshDic() {
        $('#wu-datagrid-2').datagrid({
            url: '/lnn/admin/user/list',
            rownumbers: true,
            singleSelect: false,
            pageSize: 20,
            pageList: [10, 20, 30, 50],
            pagination: true,
            multiSort: true,
            fit: true,
            fitColumns: true,
            idField: 'id',
            treeField: 'name',
            columns: [[
                {
                    field: 'photo', title: '头像', width: 100, formatter: function (value, row, index) {
                        var img = "&nbsp;&nbsp;&nbsp;<img style='width: 50px;height: 50px' src=" + value + "/>";
                        return img;
                    }
                },
                {field: 'name', title: '用户名', width: 100, sortable: true},
                //   { field:'password',title:'密码',width:100},
                {
                    field: 'roleId', title: '角色名', width: 100, formatter: function (value) {
                        var roleList = $('#roleId_id').combobox('getData');
                        for (var i = 0; i < roleList.length; i++) {
                            if (value == roleList[i].value) {
                                return roleList[i].text;
                            }
                        }
                    }
                },
                {
                    field: 'sex', title: '性别', width: 100, formatter: function (value) {
                        switch (value) {
                            case 0:
                                return '未知';
                            case 1:
                                return '男';
                            case 2:
                                return '女';
                        }
                    }
                },
                {field: 'age', title: '年龄', width: 100},
                {field: 'address', title: '地址', width: 100},
            ]]
        });
    }
    </script>
</html>
