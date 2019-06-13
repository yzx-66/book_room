<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/views/admin/commen/header.jsp" %>

    <div class="easyui-layout" data-options="fit:true">
        <div id="supperControllerId" style="display: none">${supperControllerId}</div>
        <div id="userRoleId" style="display: none">${user.roleId}</div>
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
    <div class="wu-toolbar-button">
        <c:forEach items="${button }" var="b">
            <c:if test="${b.key== '角色管理'}">
                <c:forEach items="${b.value }" var="m">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                </c:forEach>
            </c:if>
        </c:forEach>
    </div>
    <div class="wu-toolbar-search">
    <label>角色名称：</label><input id="search-data" class="wu-text" style="width:100px">
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
    <td width="60" align="right">角色名:</td>
    <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写角色名称'"/></td>
    </tr>
    <tr>
        <td valign="top" align="right">内 容:</td>
        <td><textarea name="remark" id="remark_id" rows="6" class="wu-textarea" style="width:260px"></textarea></td>
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
    <script type="text/javascript">
    /**
    * Name 添加记录
    */
    function add(){
    var data=$('#wu-form-2').serialize();
    $.ajax({
    url:'/hotel/admin/role/add',
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
    function edit(oldname,id){
    if(oldname!=$('#name_id').val()){
        console.log($('#userRoleId').html()+"=="+$('#supperControllerId').html());
        if($('#userRoleId').html()!=$('#supperControllerId').html()){
            $.messager.alert('信息提示','只有超级管理员可以更该角色名！','info');
            return;
        }
    }
    var data=$('#wu-form-2').serialize()+"&id="+id;
    $.ajax({
    url:'/hotel/admin/role/update',
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
                url:'/hotel/admin/role/delete',
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

    $('#search-btn').click(function() {
        $('#wu-datagrid-2').datagrid('reload',{name:$('#search-data').val()});
    });

    function addAuthority(selectRoleId) {
        if($('#userRoleId').html()!=$('#supperControllerId').html()){
            $.messager.alert('信息提示','只有超级管理员可以修改,请点左上方修改填写备注，之后告知超级管理员！','info');
            return;
        }
        var ids="";
        var nodes1=$('#authority-tree').tree('getChecked');
        var nodes2=$('#authority-tree').tree('getChecked','indeterminate');
        for(var i=0;i<nodes1.length;i++){
            ids+="menuId="+nodes1[i].id+"&";
        }
        for(var i=0;i<nodes2.length;i++){
            ids+="menuId="+nodes2[i].id+"&";
        }
        ids+="roleId="+selectRoleId;
        
        $.ajax({
            url:'/hotel/admin/role/addAuthority',
            data:ids,
            dataType:'json',
            type:'post',
            success:function (data) {
                if(data.type=='success'){
                    $.messager.alert('信息提示','修改成功！','info');
                } else {
                    $.messager.alert('信息提示',data.msg,'info');
                }
                $('#authority-dialog').dialog('close');
            }
        });
    }

    function getAuthoritys(selectRoleId) {
        var authoritysList=[];
        $.ajax({
            url:'/hotel/admin/role/getAuthoritys',
            dataType:'json',
            data:{roleId:selectRoleId},
            async:false,
            success:function (data) {
                authoritysList=data;
            }
        });
        return authoritysList;
    }

    function formatTreeData(data, attributes,authoritysList) {
        var resData = data;
        var tree = [];
        for(var i = 0; i < resData.length; i++) {
            if(resData[i][attributes.parentId] === attributes.rootId) {
                var obj = {
                    id: resData[i][attributes.id],
                    text: resData[i][attributes.name],
                    children: [],
                };
                tree.push(obj);
                resData.splice(i, 1);
                i--;
            }
        }
        run(tree);

        function run(chiArr) {
            if(resData.length+1 !== 0) {
                for(var i = 0; i < chiArr.length; i++) {
                    for(var j = 0; j <resData.length; j++) {
                        if(chiArr[i].id == resData[j][attributes.parentId]) {
                            var obj = {
                                id: resData[j][attributes.id],
                                text: resData[j][attributes.name],
                                children: [],
                            };
                            chiArr[i].children.push(obj);
                            resData.splice(j, 1);
                            j--;
                        }
                    }
                    if(chiArr[i].children.length==0 || resData.length+1==0){
                        chiArr[i].checked=isChecked(chiArr[i][attributes.id])
                    }else{
                        run(chiArr[i].children);
                    }
                }
            }
        }

        function isChecked(menuId) {
             console.log(authoritysList);
             for(var i=0;i<authoritysList.length;i++){
                 console.log(menuId+'=='+authoritysList[i].menuId);
                 if(menuId==authoritysList[i].menuId){
                     return true;
                 }
             }
             return false;
        }

        return tree;
    }

    function selectAuthority(selectRoleId) {
        if(selectRoleId==null){
            $.messager.alert('信息提示','请选择一条要修改的信息！','info');
            return;
        }

        $('#authority-tree').tree({
            url:'/hotel/admin/menu/list',
            type:'post',
            checkbox:true,
            loadFilter: function(data){
                var attributes = {    //定义数据属性名称
                    id: 'id',
                    parentId: 'parentId',
                    name: 'name',
                    rootId: 0
                 };
                var authoritysList=getAuthoritys(selectRoleId);
                return formatTreeData(data.rows,attributes,authoritysList);
            }
        });

        $('#authority-dialog').dialog({
            closed:false,
            modal:true,
            title:'选择权限',
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler:function () {
                    addAuthority(selectRoleId);
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#authority-dialog').dialog('close');
                }
            }]
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
    $('#wu-form-2').form('clear');
    var item = $('#wu-datagrid-2').datagrid('getSelected');
    if(item==null || item.length==0){
    $.messager.alert('信息提示','请选择一条要修改的信息！','info');
       return;
    }

    var oldname=item.name;
    $('#name_id').val(oldname);
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
    edit(oldname,item.id);
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
        url:'/hotel/admin/role/list',
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
        { field:'name',title:'角色名',width:439,sortable:true},
        { field:'remark',title:'备注',width:439},
        { field:'icon',title:'编辑',width:441,formatter:function(value,row,index){
        var img = "&nbsp;&nbsp;&nbsp;<img src=/hotel/resource/admin/easyui/css/icons/edit.gif onclick=selectAuthority("+row.id+")>&nbsp;&nbsp;&nbsp;<a href='#' onclick=selectAuthority("+row.id+")>编辑权限</a></img>";
        return img;
        }},
        ]]
    });
    </script>
</html>
