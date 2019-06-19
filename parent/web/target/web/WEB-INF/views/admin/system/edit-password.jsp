<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/views/admin/commen/header.jsp" %>
<div id="edit-dialog" class="easyui-dialog" data-options="closed:false,iconCls:'icon-save',modal:true,title:'修改密码',buttons:[{text:'确认修改',iconCls: 'icon-ok',handler:submitEdit}]" style="width:450px; padding:10px;">
    <form id="edit-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">用户名:</td>
                <td><input type="text" name="username" class="wu-text easyui-validatebox" readonly="readonly" value="${user.name }" /></td>
            </tr>
            <tr>
                <td width="60" align="right">原密码:</td>
                <td><input type="password" id="oldPassword" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写密码'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">新密码:</td>
                <td><input type="password" id="newPassword" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写密码'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">重复新密码:</td>
                <td><input type="password" id="reNewPassword" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写密码'" /></td>
            </tr>
        </table>
    </form>
</div>
<%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>
<script>
    function submitEdit() {
        var new_password=$('#newPassword').val();
        var re_new_password=$('#reNewPassword').val();
        if(new_password!=re_new_password){
            $.messager.alert('信息提示','两次密码输入不一致','info');
            return;
        }
        var old_password=$('#oldPassword').val();
        $.ajax({
            url:'/lnn/admin/system/edit-password',
            type:'post',
            dataType:'json',
            data:{old_password:old_password,new_password:new_password},
            success:function (data) {
                if(data.type=='success'){
                    $.messager.alert('信息提示','修改成功','info');
                    $('#edit-dialog').dialog('close');
                }else {
                    $.messager.alert('信息提示',data.msg,'info');
                }
            }
        })
    }
</script>
</html>
