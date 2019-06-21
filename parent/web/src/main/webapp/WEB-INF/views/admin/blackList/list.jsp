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
                <c:if test="${b.key== '黑名单列表'}">
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
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search" click="search()">开始检索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid-2" toolbar="#wu-toolbar-2"></table>
</div>
<!-- Begin of easyui-dialog -->
<%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

<!-- End of easyui-dialog -->
<script src="/lnn/resource/admin/easyui/js/jquery-form.js"></script>
<script type="text/javascript">

    $('#search-btn').click(function search() {
        var option = {name:$("#search-name").val()};
        option.realName=$('#search-realName').val();
        option.phoneNum=$('#search-phoneNum').val();
        option.idCard=$('#search-idCard').val();
        $('#wu-datagrid-2').datagrid('reload',option);
    });


    /**
     * Name 删除记录
     */
    function remove(){
        var items = $('#wu-datagrid-2').datagrid('getSelections');
        if(items==null || items.length==0 ){
            $.messager.message('信息提示','请至少选择一条','info');
            return;
        }
        $.messager.confirm('信息提示','该用户违约总数不变 本月清零 确定要删除该记录？', function(result){
            if(result){
                var ids="";
                for(var i=0;i<items.length;i++){
                    ids+='accountId='+items[i].id+'&';
                }

                $.ajax({
                    url:'/lnn/admin/blackList/delete',
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

    init();
    function init() {
        setTimeout(refreshDic, 1);
    }

    function refreshDic(){
        $('#wu-datagrid-2').datagrid({
            url:'/lnn/admin/account/list?status=0',
            rownumbers:true,
            singleSelect:false,
            pageSize:10,
            pageList:[10,20],
            pagination:true,
            multiSort:true,
            fit:true,
            fitColumns:true,
            columns:[[
                { field:'photo',title:'头像预览',width:5,formatter:function (value,row,index) {
                        var img = "&nbsp;&nbsp;&nbsp;<img style='width: 50px;height: 50px' src="+value+"/>";
                        return img;
                    }},
                { field:'name',title:'用户名',width:3,sortable:true},
                { field:'phoneNum',title:'手机号',width:5,sortable:true},
                { field:'realName',title:'真实姓名',width:3,sortable:true},
                { field:'idCard',title:'身份证吗',width:5,sortable:true},
                { field:'monthBreakTimes',title:'本月违约次数',width:3,sortable:true},
                { field:'sumBreakTimes',title:'总违约次数',width:3,sortable:true},
                { field:'id',title:'解除时间',width:9,sortable:true,formatter:function (value){
                        var ret="";
                        $.ajax({
                            url:'/lnn/admin/blackList/findBlackListByAccountId?accountId='+value,
                            dataType:'json',
                            async:false,
                            success:function (data) {
                                ret+=new Date(data.inTime).toLocaleString()+" --- ";
                                if(data.outTime==-28800000){
                                    ret+="永不解除";
                                }else {
                                    ret += new Date(data.outTime).toLocaleString();
                                }
                            }
                        })
                        return ret;
                    }},
            ]]
        });
    }
</script>
</html>
