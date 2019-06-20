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
                <c:if test="${b.key== '入住与退房'}">
                    <c:forEach items="${b.value }" var="m">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <div class="wu-toolbar-search">
            <label>入住账号的手机：</label><input type="text" id="search-accountPhone" class="wu-text" style="width:100px">
            <label>入住者姓名：</label><input type="text" id="search-name" class="wu-text" style="width:100px">
            <label>入住者手机：</label><input type="text" id="search-phoneNum" class="wu-text" style="width:100px">
            <label>入住起始日期：</label><input type="text" id="search-arriveTime" style="width:100px" class="wu-text easyui-datebox">
            <label>入住截至日期：</label><input id="search-leaveTime" type="text" class="easyui-datebox">
            <label>状态</label><select id="search-status">
                                    <option value="-1" selected="selected">全部</option>
                                    <option value="0">入住中</option>
                                    <option value="1">已离店</option>
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
                <td align="right">入住账号（非预定不选）:</td>
                <td><input type="text" id="accountPhone_id" name="accountPhone" style="width: 175px" class="wu-text" readonly="readonly" />
                    <a href="#" id="herf_foorId" onclick="showBookOrders()" class="easyui-linkbutton" style="width: 62px;" iconCls="icon-add1">订单</a>
                    <input type="hidden" id="bookOrderId_id" name="bookOrderId"/>
                </td>
            </tr>
            <tr>
                <td align="right">入住者姓名:</td>
                <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写入住者姓名'"/></td>
            </tr>
            <tr id="order_hide">
                <td align="right">选择房型:</td>
                <td>
                    <select id="typeRoomName_id" onchange="fllowChangRoomType()" name="roomTypeName" style="width: 268px;" class="easyui-validatebox" data-options="required:true, missingMessage:'请选择房型'">
                        <c:forEach items="${roomTypeNames}" var="n">
                            <option value=${n}>${n}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr id="notOrder_hide" style="display:none;">
                <td align="right">选择房型:</td>
                <td>
                    <select id="orderRoomTypeName_id" name="roomTypeName" style="width: 268px;" class="easyui-validatebox" data-options="required:true, missingMessage:'请选择房型'">

                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">楼 层:</td>
                <td>
                    <select id="hight_id" onchange="fllowChangHight()" name="hight" style="width: 268px;" class="easyui-validatebox" data-options="required:true, missingMessage:'请选择楼层'">

                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">房 间:</td>
                <td>
                    <select id="room_id" name="roomId" style="width: 268px;" class="easyui-validatebox" data-options="required:true, missingMessage:'请选择房间'">
                        <option>请先选择房型和楼层！</option>");
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">入住价格:</td>
                <td><input type="text" id="checkinPrice_id" name="checkinPrice" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写身份证号'"/></td>
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
                <td><input type="text" id="arriveTime_id" name="arriveTime" class="wu-text easyui-datebox easyui-validatebox"/></td>
            </tr>
            <tr>
                <td align="right">退房日期:</td>
                <td><input type="text" id="leaveTime_id" name="leaveTime" class="wu-text easyui-datebox easyui-validatebox"/></td>
            </tr>
            <tr>
                <td valign="top" align="right">备 注:</td>
                <td><textarea name="remark" id="remark_id" rows="6" class="wu-textarea" style="width:260px"></textarea></td>
            </tr>
        </table>
    </form>
</div>

<div id="orders_dialog_id" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:750px;height:500px; padding:10px;">
    <table id="order_table_id"></table>
</div>

<%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

<!-- End of easyui-dialog -->
<script src="/lnn/resource/admin/easyui/js/jquery-form.js"></script>
<script type="text/javascript">

    var chose=0;//判断是预定订单还是现场入住订单

    function check(){
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
        if($('#room_id').val()==0){
            $.messager.alert('信息提示','必须选择一间房','info');
            return;
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

    function add(){
        if(!check()){
            return;
        }
        var data=$('#wu-form-2').serialize()+'&chose='+chose;
        $.ajax({
            url:'/lnn/admin/checkIn/add',
            type:'post',
            dataType:'json',
            data:data,
            success:function(data){
                if(data.type=='success'){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog-2').dialog('close');
                    $('#wu-datagrid-2').datagrid('reload');
                }
                else {
                    $.messager.alert('信息提示',data.msg,'info');
                }
            }
        });
    }

    function back() {
        var item = $('#wu-datagrid-2').datagrid('getSelected');
        if(item==null || item.length==0 ){
            $.messager.alert('信息提示','请选择一条入住记录','info');
            return;
        }
        if(item.status==1){
            $.messager.alert('信息提示','该订单已经结算','info');
            return;
        }
        $.messager.confirm('信息提示','请确定是否结清房款？房款为：'+item.liveDays*item.checkinPrice, function(result){
            if(result){
                $.ajax({
                    url:'/lnn/admin/checkIn/back',
                    data:{id:item.id},
                    success:function(data){
                        if(data.type=='success'){
                            $.messager.alert('信息提示','退房成功！房间现在为打扫中，请打扫完后将房间状态调成可入住','info');
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

    function remove(){
        var item = $('#wu-datagrid-2').datagrid('getSelected');
        if(item==null || item.length==0){
            $.messager.message('信息提示','请选择一条入住记录','info');
            return;
        }
        $.messager.confirm('信息提示','确定要删除该条记录？该条记录将不计入营业额，但是会记录在营业日志中,且房间状态立刻变为可用', function(result){
            $.ajax({
                url:'/lnn/admin/checkIn/delete',
                data:{id:item.id},
                success:function(data){
                    if(data.type=='success'){
                        if(item.bookOrderId!=null || item.bookOrderId!=null){
                            $.messager.alert('信息提示','删除成功！该订单重新变为预定中','info');
                        }else{
                            $.messager.alert('信息提示','删除成功！','info');
                        }
                        $('#wu-datagrid-2').datagrid('reload');
                    }
                    else {
                        $.messager.alert('信息提示',data.msg,'info');
                        $('#wu-datagrid-2').datagrid('reload');
                    }
                }
            });
        });
    }

    function fllowChangRoomType() {
        $('#hight_id').empty();
        $.ajax({
            url:'/lnn/admin/floor/findFloorsByRoomTypeName',
            data:{name:$('#typeRoomName_id').val()},
            dataType:'json',
            success:function (data) {
                $('#hight_id').append("<option>请选择！</option>");
                for(var i=0;i<data.length;i++){
                    $.ajax({
                        url:'/lnn/admin/room/getRoomNumsByTypeAndHight',
                        data:{roomTypeName:$('#typeRoomName_id').val(),hight:data[i].hight},
                        dataType:'json',
                        async:false,
                        success:function (size) {
                            if(size!=0){
                                $('#hight_id').append("<option value="+data[i].hight+">"+data[i].hight+"&nbsp;层（该层剩余："+size+"间）</option>");
                            }else {
                                $('#hight_id').append("<option value=0>"+data[i].hight+"&nbsp;层（该层剩余："+size+"间）</option>");
                            }
                        }
                    })
                }
            }
        });
    }

    function fllowChangHight() {
        $('#room_id').empty();
        var roomTypeName=$('#typeRoomName_id').val();
        if(roomTypeName==null || roomTypeName==""){
            roomTypeName=$('#orderRoomTypeName_id').val();
        }
        var hight=$('#hight_id').val();
        $.ajax({
            url:'/lnn/admin/room/findRoomsByRTAndHAndS',
            data:{roomTypeName:roomTypeName,hight:hight,status:chose},
            dataType:'json',
            async:false,
            success:function (data) {
                for(var i=0;i<data.length;i++){
                    $('#room_id').append("<option value="+data[i].id+">房间编号："+data[i].sn+"</option>");
                }
            }
        })
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

    function showBookOrders() {
        $('#order_table_id').datagrid({
            url:'/lnn/admin/bookOrder/list?status=0',
            rownumbers:true,
            singleSelect:false,
            pageSize:100,
            pageList:[10,20,30,50,100],
            pagination:true,
            multiSort:true,
            fit:true,
            fitColumns:true,
            columns:[[
                { field:'chk',checkbox:true},
                { field:'accountId',title:'账号所属手机',width:100,sortable:true,formatter:function (value) {
                        var ret="";
                        $.ajax({
                            url:'/lnn/admin/account/findaccountById',
                            data:{id:value},
                            dataType:'json',
                            async:false,
                            success:function (data) {
                                ret+="&nbsp;"+data.phoneNum;
                            }
                        })
                        return ret;
                    }},
                { field:'name',title:'入住者姓名',width:100,sortable:true},
                { field:'roomTypeId',title:'房型',width:100,sortable:true,formatter:function (value,row,index) {
                        var ret="";
                        $.ajax({
                            url:'/lnn/admin/floor/findFloorByRoomTypeId',
                            data:'id='+value,
                            dataType:'json',
                            async:false,
                            success:function (data) {
                                ret+="&nbsp;&nbsp;"+data.hight+"&nbsp;F：";
                            }
                        });
                        $.ajax({
                            url:'/lnn/admin/room_type/findRoomTypeById',
                            data:'id='+value,
                            dataType:'json',
                            async:false,
                            success:function (data) {
                                ret+="&nbsp;"+data.name;
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
                            case 3:return "已违约";
                        }
                    }},
                { field:'remark',title:'备注',width:100},
            ]]
        });
        $('#orders_dialog_id').dialog({
            closed: false,
            modal:true,
            title: "添加信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function () {
                    chose=1;
                    $('#wu-form-2').form('clear');
                    setvalue();
                    $('#orders_dialog_id').dialog('close');
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#orders_dialog_id').dialog('close');
                }
            }]
        });
    }

    function setvalue() {
        item = $('#order_table_id').datagrid('getSelected');
        if(item==null || item.length==0){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }
        $('#order_hide').hide();
        $('#notOrder_hide').show();
        $('#orderRoomTypeName_id').empty();
        $('#hight_id').empty();
        $.ajax({
            url:'/lnn/admin/account/findaccountById',
            data:{id:item.accountId},
            dataType:'json',
            async:false,
            success:function (data) {
                $('#accountPhone_id').val(data.phoneNum);
            }
        })
        $.ajax({
            url:'/lnn/admin/room_type/findRoomTypeById',
            data:{id:item.roomTypeId},
            dataType:'json',
            async:false,
            success:function (data) {
                $('#orderRoomTypeName_id').append('<option value='+data.name+'>'+data.name+'</option>')
                $('#orderRoomTypeName_id').val(data.name);
            }
        })
        $.ajax({
            url:'/lnn/admin/floor/findFloorByRoomTypeId',
            data:{id:item.roomTypeId},
            dataType:'json',
            async:false,
            success:function (data) {
                $('#hight_id').append('<option value='+data.hight+'>'+data.hight+'</option>')
                $('#hight_id').val(data.hight);
            }
        })

        $('#bookOrderId_id').val(item.id);
        $('#name_id').val(item.name);
        $('#idCard_id').val(item.idCard);
        $('#phoneNum_id').val(item.phoneNum);
        $('#arriveTime_id').datebox('setValue',formatDate(item.arriveDate,'YYYY-MM-DD'));
        $('#leaveTime_id').datebox('setValue',formatDate(item.leaveDate,'YYYY-MM-DD'));
        $('#remark_id').val(item.remark);

        fllowChangHight();
    }

    function openAdd(){
        $('#wu-form-2').form('clear');
        $('#order_hide').show();
        $('#notOrder_hide').hide();
        $('#hight_id').empty();
        chose=0;
        $('#wu-dialog-2').dialog({
            closed: false,
            modal:true,
            title: "添加信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: add,
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
     * Name 载入数据
     */
    $('#wu-datagrid-2').datagrid({
        url:'/lnn/admin/checkIn/list',
        rownumbers:true,
        singleSelect:true,
        pageSize:100,
        pageList:[10,20,30,50,100],
        pagination:true,
        multiSort:true,
        fit:true,
        fitColumns:true,
        columns:[[
            { field:'accountId',title:'入住账号',width:100,sortable:true,formatter:function (value) {
                    var ret="";
                    if(value==null || value=="")   {
                        ret="现场入住"
                    }
                    else{
                        $.ajax({
                            url:'/lnn/admin/account/findaccountById',
                            data:{id:value},
                            dataType:'json',
                            async:false,
                            success:function (data) {
                                ret+="&nbsp;"+data.phoneNum;
                            }
                        })
                    }
                    return ret;
                }},
            { field:'name',title:'入住者姓名',width:100,sortable:true},
            { field:'roomId',title:'房型',width:100,sortable:true,formatter:function (value,row,index) {
                var ret="";
                var floor="";
                    $.ajax({
                        url:'/lnn/admin/room_type/findRoomTypeByRoomId',
                        data:'id='+value,
                        dataType:'json',
                        async:false,
                        success:function (data) {
                            value=data.id;
                            ret+="&nbsp;"+data.name;
                        }
                    });
                    return ret;
            }},
            { field:'idCard',title:'入住者身份证号',width:100,sortable:true},
            { field:'phoneNum',title:'入住者手机号',width:100,sortable:true},
            { field:'liveDays',title:'入住者天数',width:100,sortable:true},
            { field:'arriveDate',title:'入住时间',width:100,sortable:true,formatter:function (value) {
                    return new Date(value).toLocaleDateString();
                }},
            { field:'leaveDate',title:'退房时间',width:100,sortable:true,formatter:function (value) {
                    return new Date(value).toLocaleDateString();
                }},
            { field:'status',title:'状态',width:100,sortable:true,formatter:function (value) {
                    switch (value) {
                        case 0:return "入住中";
                        case 1:return "已结算离店";
                    }
                }},
            { field:'remark',title:'备注',width:100},
        ]]
    });
</script>
</html>
