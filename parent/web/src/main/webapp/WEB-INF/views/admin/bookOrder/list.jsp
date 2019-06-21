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
                <c:if test="${b.key== '预定订单列表'}">
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
            <label>入住起始日期：</label><input type="text" id="search-arriveTime" style="width:100px" class="wu-text easyui-datebox">
            <label>入住截至日期：</label><input id="search-leaveTime" type="text" class="easyui-datebox">
            <label>状态</label><select id="search-status">
                                    <option value="-1" selected="selected">全部</option>
                                    <option value="0">预定中</option>
                                    <option value="1">已入住</option>
                                    <option value="2">已离店</option>
                                    <option value="3">已违约</option>
                                </select>
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid-2" toolbar="#wu-toolbar-2"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="wu-dialog-2" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-2" method="post">
        <table id="tab">
                <td align="right">预定账号的手机:</td>
                <td><input type="text" id="accountPhone" name="accountPhone" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写账号的手机'"/></td>
            </tr>
            <tr>
                <td align="right">入住者姓名:</td>
                <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写入住者姓名'"/></td>
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
                </td>
            </tr>
            <tr>
                <td align="right">入住者身份证号:</td>
                <td><input type="text" id="idCard_id" name="idCard" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写身份证号'"/></td>
            </tr>
            <tr>
                <td align="right">入住者手机:</td>
                <td><input type="text" id="phoneNum_id" name="phoneNum" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写手机号'"/></td>
            </tr>
            <tr>
                <td align="right">入住日期:</td>
                <td><input type="text" id="arriveTime_id" name="arriveTime" class="wu-text easyui-datebox"/></td>
            </tr>
            <tr>
                <td align="right">退房日期:</td>
                <td><input type="text" id="leaveTime_id" name="leaveTime" class="wu-text easyui-datebox"/></td>
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
        if($('#arriveTime_id').datebox('getValue')==null || $('#arriveTime_id').datebox('getValue')==""){
            $.messager.alert('信息提示','入住时间不可以为空！','info');
            return false;
        }
        if($('#leaveTime_id').datebox('getValue')==null || $('#leaveTime_id').datebox('getValue')==""){
            $.messager.alert('信息提示','离店时间不可以为空！','info');
            return false;
        }
        var arrvieTime=$('#arriveTime_id').datebox('getValue');
        var leaveTime=$('#leaveTime_id').datebox('getValue');
        if(arrvieTime==leaveTime){
            $.messager.alert('信息提示','入住和离店不可以是同一天，至少入住一天，从零点起算','info');
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
        console.log($('#search-leaveTime').val());
        var option = {name:$("#search-name").val()};
        if($('#search-accountPhone').val()!=null && $('#search-accountPhonephoneNum').val()!=""){
            option.accountPhone=$('#search-accountPhone').val();
        }
        if($('#search-phoneNum').val()!=null && $('#search-phoneNum').val()!=""){
            option.phoneNum=$('#search-phoneNum').val();
        }
        if($('#search-arriveTime').datebox('getValue')!=null && $('#search-arriveTime').datebox('getValue')!=""){
            option.arriveTime=$('#search-arriveTime').datebox('getValue');
        }
        if($('#search-leaveTime').datebox('getValue')!=null && $('#search-leaveTime').datebox('getValue')!=""){
            option.leaveTime=$('#search-leaveTime').datebox('getValue');
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
            url:'/lnn/admin/bookOrder/add',
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
        var now=new Date();
        var arriveDate=new Date(item.arriveDate);
        if(now.getTime()>arriveDate.getTime()){
            $.messager.alert('信息提示','预定订单已经过了到店日期无法修改，只可删除，若不删除会占用房间，过了离店日期自动失效，且该客户将增加一次违约次数','info');
            return;
        }
        var data=$('#wu-form-2').serialize()+"&id="+item.id+"&oldRoomTypeId="+item.roomTypeId;
        $.ajax({
            url:'/lnn/admin/bookOrder/update',
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
             url:'/lnn/admin/floor/findFloorsByRoomTypeName',
             data:{name:$('#typeRoomName_id').val()},
             dataType:'json',
             success:function (data) {
                $('#hight_id').append("<option value=\"-1\">全部楼层随机分配！</option>");
                for(var i=0;i<data.length;i++){
                    $.ajax({
                        url:'/lnn/admin/room/getRoomNumsByTypeAndHight',
                        data:{roomTypeName:$('#typeRoomName_id').val(),hight:data[i]},
                        dataType:'json',
                        async:false,
                        success:function (size) {
                            if(size==0){
                                $('#hight_id').append("<option value="+data[i].hight+">"+data[i].hight+"&nbsp;层（该层已经预定全部 请勿选择，修改不受影响！）</option>");
                            }else {
                                $('#hight_id').append("<option value="+data[i].hight+">"+data[i].hight+"&nbsp;层（该层剩余："+size+"间）</option>");
                            }
                        }
                    })
                }
            }
        });
    }

    function formatDate(time, formatStr) {
        var date = new Date(time);
        var Y = date.getFullYear();
        var M = (date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1);
        var D = date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate();
        var h = date.getHours();
        var m = date.getMinutes();
        var s = date.getSeconds();
        formatStr = formatStr || 'YYYY-MM-DD H:m:s';
        return formatStr.replace(/YYYY|MM|DD|H|m|s/ig, function (matches) {
            return ({
                YYYY: Y,
                MM: M,
                DD: D,
                H: h,
                m: m,
                s: s
            })[matches];
        });
    }

    function remove(){
        var items = $('#wu-datagrid-2').datagrid('getSelections');
        if(items==null || items.length==0 ){
            $.messager.message('信息提示','请至少选择一条','info');
            return;
        }
        $.messager.confirm('信息提示','确定要删除这些记录？ 预定的与没按预定到店的将还原房间数，入住的无法在离店前删除，已经违约与离店的的不影响房间状态 ', function(result){
            if(result){
                var ids="";
                for(var i=0;i<items.length;i++){
                    ids+='id='+items[i].id+'&';
                }

                $.ajax({
                    url:'/lnn/admin/bookOrder/delete',
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
        $('#hight_id').empty();
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
        $('#hight_id').empty();
        if(item==null || item.length==0){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }
        $.ajax({
            url:'/lnn/admin/account/findaccountById',
            data:{id:item.accountId},
            dataType:'json',
            async:false,
            success:function (data) {
                $('#accountPhone').val(data.phoneNum);
            }
        });
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

        $('#name_id').val(item.name);
    //    $('#typeRoomName_id').val(null);
    //    $('#hight_id').val(null);
        $('#idCard_id').val(item.idCard);
        $('#phoneNum_id').val(item.phoneNum);
        $('#arriveTime_id').datebox('setValue',formatDate(item.arriveDate,'YYYY-MM-DD'));
        $('#leaveTime_id').datebox('setValue',formatDate(item.leaveDate,'YYYY-MM-DD'));
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


    init();
    function init() {
        setTimeout(refreshDic, 1);
    }
    function refreshDic() {
        $('#wu-datagrid-2').datagrid({
            url: '/lnn/admin/bookOrder/list',
            rownumbers: true,
            singleSelect: false,
            pageSize: 10,
            pageList: [10, 20, 30, 50],
            pagination: true,
            multiSort: true,
            fit: true,
            fitColumns: true,
            columns: [[
                {field: 'accountPhone', title: '账号所属手机', width: 143, sortable: true},
                {field: 'name', title: '入住者姓名', width: 143, sortable: true},
                {field: 'roomTypeAndFloor', title: '房型', width: 143, sortable: true},
                {field: 'idCard', title: '入住者身份证号', width: 143, sortable: true},
                {field: 'phoneNum', title: '入住者手机号', width: 143, sortable: true},
                {
                    field: 'arriveDate', title: '入住时间', width: 143, sortable: true, formatter: function (value) {
                        return new Date(value).toLocaleDateString();
                    }
                },
                {
                    field: 'leaveDate', title: '退房时间', width: 143, sortable: true, formatter: function (value) {
                        return new Date(value).toLocaleDateString();
                    }
                },
                {
                    field: 'status', title: '状态', width: 143, sortable: true, formatter: function (value) {
                        switch (value) {
                            case 0:
                                return "预定中";
                            case 1:
                                return "已入住";
                            case 2:
                                return "已结算离店";
                            case 3:
                                return "已违约";
                        }
                    }
                },
                {field: 'remark', title: '备注', width: 143},
            ]]
        });
    }
</script>
</html>
