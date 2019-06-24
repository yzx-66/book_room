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
    <div id="dowhat" style="display: none">${dowhat}</div>
    <div id="editRoomType" style="display: none">${editRoomType}</div>
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
        <div class="wu-toolbar-button">
            <c:forEach items="${button }" var="b">
                <c:if test="${b.key== '房型管理'}">
                    <c:forEach items="${b.value }" var="m">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <div class="wu-toolbar-search">
            <label>房型名称：</label><select id="search-name" style="width:100px" >
                                        <option value="-1" selected="selected">全部房型</option>
                                        <c:forEach items="${roomTypeNames}" var="n">
                                            <option value="${n}">${n}</option>
                                        </c:forEach>
                                    </select>
            <label>房型楼层：</label><select id="search-floorId">
                                        <option value="-1" selected="selected">全部楼层</option>
                                        <c:forEach items="${floors}" var="f">
                                            <option value="${f.id}">${f.name}</option>
                                        </c:forEach>
                                     </select>
            <label>房型状态：</label> <select id="search-status">
                                        <option value="-1" selected="selected">全部状态</option>
                                        <option value="0">住满</option>
                                        <option value="1">可入住</option>
                                        <option value="2">不可住</option>
                                      </select>
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search" click="search()">开始检索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid-2" toolbar="#wu-toolbar-2"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="wu-dialog-2" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-2" method="post">
        <table id="tab">
            <tr>
                <td>房型预览</td>
                <td><img src="/lnn/resource/admin/easyui/images/user_photo.jpg" id="img_id" style="width: 100px;height:100px;">
                    <input type="file" name="tempPhoto" style="width: 90px" onchange="subpic()"/>
                    <input type="hidden" name="photo" id="photo_id">
                </td>
            </tr>
            <tr>
                <td align="right">房型名:</td>
                <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写房型名称'"/></td>
            </tr>
            <tr style="height: 30px" id="edit-hide1">
                <td align="right">选择楼层:</td>
                <td>
                    <select name="floorIds" id="floorId_id" style="width: 185px">
                        <option value="-1" selected = "selected">不存在 误加了（点此不增加）</option>
                        <c:forEach items="${floors}" var="f">
                            <option value="${f.id}">${f.name}</option>
                        </c:forEach>
                    </select>
                    <a href="#" id="herf_foorId" onclick="addFloorId()" class="easyui-linkbutton" style="width: 62px;" iconCls="icon-add1">增加</a>
                </td>
            </tr>
            <tr>
                <td align="right">价 格:</td>
                <td><input type="text" id="price_id" name="price" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写房型价格'"/></td>
            </tr>
            <tr>
                <td align="right">可住人数:</td>
                <td><input type="text" id="liveNum_id" name="liveNum" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写房型可住人数'"/></td>
            </tr>
            <tr>
                <td align="right">床 数:</td>
                <td><input type="text" id="bedNum_id" name="bedNum" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写房型床数'"/></td>
            </tr>
<%--            <tr>--%>
<%--                <td align="right">房型总数:</td>--%>
<%--                <td><input type="text" id="roomNum_id" name="roomNum" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写该房型总数'"/></td>--%>
<%--            </tr>--%>
            <tr id="edit-hide2">
                <td align="right">状 态:</td>
                <td>
                    <select name="status" style="width: 268px;" id="status_id">
                        <option value="0">住满</option>
                        <option value="1">可入住</option>
                        <option value="2">不可住</option>
                    </select>
                </td>
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
        if($('#floorId_id').val()==null || $('#floorId_id').val()==""){
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

    var times=1;
    function addFloorId() {
        var select='<tr style="height: 30px"><td align="right">选择楼层:</td><td><select name="floorIds" style="width: 187px"><option value="-1" selected = "selected">不存在 误加了（点此不增加）</option><c:forEach items="${floors}" var="f"><option value="${f.id}">${f.name}</option></c:forEach></select><a href="#" onclick="addFloorId()" class="easyui-linkbutton l-btn" style="width: 62px;" iconcls="icon-add1"><span class="l-btn-left"><span class="l-btn-text icon-add1 l-btn-icon-left">增加</span></span></a></td></tr>';
        $("#tab tr:eq("+times+")").after(select);
        times++;
    }

    $('#search-btn').click(function search() {
        var option={};
        if($('#search-name').val()!=-1){
            option.name=$("#search-name").val()
        }
        var floorId=$('#search-floorId').val();
        if(floorId != -1){
            option.floorId = floorId;
        }
        var status = $("#search-status").val();
        if(status != -1){
            option.status = status;
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
            url:'/lnn/admin/room_type/add',
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
        var data=$('#wu-form-2').serialize()+"&id="+item.id+"&bookNum="+item.bookNum+"&livedNum="+item.livedNum+'&roomNum='+item.roomNum;
        $.ajax({
            url:'/lnn/admin/room_type/update',
            type:'post',
            dataType:'json',
            data:data,
            success:function(data){
                if(data.type=='success'){
                    if($('#status_id').val()==2){
                        $.messager.alert('信息提示','提交成功,将在预定列表不可见！','info');
                    }else{
                        $.messager.alert('信息提示','提交成功！','info');
                    }
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
            url:'/lnn/admin/room_type/subpic',
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
     * Name 删除记录
     */
    function remove(){
        var item = $('#wu-datagrid-2').datagrid('getSelected');
        if(item==null || item.length==0 ){
            $.messager.alert('信息提示','请至少选择一条','info');
            return;
        }
        $.messager.confirm('信息提示','确定要删除该记录？', function(result){
            if(result){
                $.ajax({
                    url:'/lnn/admin/room_type/delete',
                    data:"id="+item.id,
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

    function clearFloorIdSelects() {
        for(;times!=1;times--){
            console.log(times);
            $("#tab tr:eq("+times+")").hide();
        }
    }


    /**
     * Name 打开添加窗口
     */
    function openAdd(){
        clearFloorIdSelects();
        $('#img_id').attr('src','/lnn/resource/admin/easyui/images/user_photo.jpg');
        $('#edit-hide1').show();
        $('#edit-hide2').show();

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
    function openEdit(item){
        $.messager.show({showType:'slide', showSpeed:'600',msg:'修改房型图片、名字或者价格，同一房型将一起改变',title:'小提示'});
        if(item==null){
            item = $('#wu-datagrid-2').datagrid('getSelected');
            console.log(111);
        }
        clearFloorIdSelects();
        $('#wu-form-2').form('clear');
        if(item==null || item.length==0){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }

        $('#edit-hide1').hide();
   //     $('#edit-hide2').hide();
        $('#img_id').attr('src',item.photo);
        $('#photo_id').val(item.photo);
        $('#name_id').val(item.name);
        $('#floorId_id').val(item.floorId);
        $('#price_id').val(item.price);
        $('#liveNum_id').val(item.liveNum);
        $('#bedNum_id').val(item.bedNum);
        $('#roomNum_id').val(item.roomNum);
        $('#status_id').val(item.status);
        $('#remark_id').val(item.remark);

        //alert(item.productid);return;
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
            rownumbers: true,
            singleSelect: true,
            pageSize: 10,
            pageList: [10, 20],
            pagination: true,
            multiSort: true,
            fit: true,
            fitColumns: false,
            url: '/lnn/admin/room_type/list',
            columns: [[
                {
                    field: 'photo', title: '房型预览', width: 100, formatter: function (value, row, index) {
                        var img = "&nbsp;&nbsp;&nbsp;<img style='width: 50px;height: 50px' src=" + value + "/>";
                        return img;
                    }
                },
                {field: 'name', title: '房型名', width: 100, sortable: true},
                {field: 'floorName', title: '层名', width: 100, sortable: true},
                {field: 'price', title: '价格', width: 100, sortable: true},
                {field: 'liveNum', title: '可住人数', width: 100, sortable: true},
                {field: 'bedNum', title: '床数', width: 100, sortable: true},
                {
                    field: 'roomNum', title: '该型房数', width: 100, sortable: true, formatter: function (value) {
                        return "<span style=\"color:orange;font-size:17px\" >" + value + "</span>";
                    }
                },
                {
                    field: 'avilableNum', title: '可使用房数', width: 100, sortable: true, formatter: function (value) {
                        return "<span style=\"color:blue;font-size:20px\" >" + value + "</span>";
                    }
                },
                {
                    field: 'bookNum', title: '已预定房数', width: 100, sortable: true, formatter: function (value) {
                        return "<span style=\"color:green;font-size:17px\" >" + value + "</span>";
                    }
                },
                {
                    field: 'livedNum', title: '已入住房数', width: 100, sortable: true, formatter: function (value) {
                        return "<span style=\"color:red;font-size:17px\" >" + value + "</span>";
                    }
                },
                {
                    field: 'canNotLiveNum', title: '不可用房数', width: 100, sortable: true, formatter: function (value) {
                        return "<span style=\"color:grey;font-size:17px\" >" + value + "</span>";
                    }
                },
                {
                    field: 'status', title: '状态', width: 100, sortable: true, formatter: function (value) {
                        switch (value) {
                            case 0:
                                return "住满";
                            case 1:
                                return "可入住";
                            case 2:
                                return "不可住";
                        }
                    }
                },
                {field: 'remark', title: '备注', width: 100},
            ]]
        });
    }

    if($('#dowhat').html()!=null){
        if($('#dowhat').html()=='add'){
            openAdd();
        }
        if($('#dowhat').html()=='edit'){
        //    openEdit(JSON.parse($('#editRoomType').html()));
            var item=JSON.parse($('#editRoomType').html());
            var option={};
            $('#search-name').val(item.name);
            option.name=item.name;
            $('#search-floorId').val(item.floorId);
            option.floorId = item.floorId;
            $("#search-status").val(item.status);
            option.status = item.status;
            $('#wu-datagrid-2').datagrid('reload',option);
        }
    }
</script>


</html>
