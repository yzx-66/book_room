<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@include file="/WEB-INF/views/admin/commen/header.jsp" %>

    <div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
    <div class="wu-toolbar-button">
    <c:forEach items="${button }" var="b">
        <c:if test="${b.key== '菜单管理'}">
            <c:forEach items="${b.value }" var="m">
                <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
            </c:forEach>
        </c:if>
    </c:forEach>
    </div>
    <div class="wu-toolbar-search">
    <label>菜单名称：</label><input id="search-data" class="wu-text" style="width:100px">
    <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
    </div>
    </div>
    <!-- End of toolbar -->
    <table id="wu-datagrid" class="easyui-treegrid" toolbar="#wu-toolbar-2"></table>
    </div>
    <!-- Begin of easyui-dialog -->
    <div id="wu-dialog-addChildMenu" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-addChildMenu" method="post">
    <table>
    <tr>
    <td width="60" align="right">菜单名:</td>
    <td><input type="text" id="name_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'"/></td>
    </tr>
    <tr>
    <td align="right">上级菜单:</td>
    <td> <select id="parentId_id" name="parentId" class="easyui-combobox" panelHeight="auto" style="width:268px">
    <option value="0">没有父级</option>
    <c:forEach items="${menuTopList }" var="m">
        <option value=${m.id }>${m.name }</option>
    </c:forEach>
    </select></td>
    </tr>
    <tr>
    <td align="right">页面url:</td>
    <td><input type="text" id="url_id" name="url" class="wu-text" /></td>
    </tr>
    <tr>
    <td valign="top" align="right">图标:</td>
    <td><input type="text" name="icon" id="icon-id" onclick="selectIcons(1)" style="width:218px;">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="selectIcons(1)" plain="true">选择</a>
    </td>
    </tr>
    </table>
    </form>
    </div>

    <div id="wu-dialog-addChildButton" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
    <form id="wu-form-addChildButton" method="post">
    <table>
    <tr>
    <td width="60" align="right">按钮名:</td>
    <td><input type="text" id="name-button_id" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'"/>
    </td>
    </tr>
    <tr id="edit-hiden">
    <td align="right">上级菜单:</td>
    <td> <input type="text" id="parentName-button_id" readonly="readonly"style="width: 264px;"/>
         <input type="hidden" id="parentId-button_id" name="parentId" readonly="readonly"/>
    </td>
    </tr>
    <tr>
    <td align="right">调用方法:</td>
    <td><input type="text" id="url-button_id" name="url" class="wu-text" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写方法名'"/> </td>
    </tr>
    <tr>
    <td valign="top" align="right">图标:</td>
    <td><input type="text" name="icon" id="icon-button-id" onclick="selectIcons(2)" style="width:218px;">
    <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="selectIcons(2)" plain="true">选择</a>
    </td>
    </tr>
    </table>
    </form>
    </div>



    <!-- 选择图标弹窗 -->
    <div id="select-icon-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:700px;height:550px; padding:10px;">
    <table id="icons-table" cellspacing="8">

    </table>
    </div>

    <!--点击后验证图标弹窗-->
    <div id="select-icon-check" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:300px;height:150px; padding:10px;">
    <span style="align: center">确定选择这个吗？(带'_'的图标可能左侧显示不正常)</span>
    </div>

    <%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>

    <!-- End of easyui-dialog -->
    <script type="text/javascript">

    function subicon(icon) {
    var ter='icon-'+icon.substring(0,icon.lastIndexOf('.'))
    return ret;
    }
    /**
    * Name 添加记录
    */
    function add(data){
    $.ajax({
    url:'/admin/menu/add',
    type:'post',
    dataType:'json',
    data:data,
    success:function(data){
    console.log(data.type);
    if(data.type=='success'){
    $.messager.alert('信息提示','提交成功！','info');
    $('#wu-datagrid').treegrid('reload');
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
    function edit(item,chose){
    if(item.id==$('#parentId_id').combobox('getValue')){
    $.messager.alert('信息提示','父级菜单不可以和自己相同！','info');
    return;
    }
    var data;
    switch (chose) {
    case 1:
        data=$('#wu-form-addChildMenu').serialize()+"&id="+item.id;
        break;
    case 2:
        data=$('#wu-form-addChildButton').serialize()+"&id="+item.id;
    }
    $.ajax({
    url:'/admin/menu/update',
    type:'post',
    dataType:'json',
    data:data,
    success:function(data){
    if(data.type=='success'){
    $.messager.alert('信息提示','提交成功','info');
    $('#wu-datagrid').treegrid('reload');
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
    var items = $('#wu-datagrid').treegrid('getSelections');
    if(items==null || items.length==0){
    $.messager.message('信息提示','至少选择一条要删除的信息','info');
    }
    $.messager.confirm('信息提示','确定要删除该记录？', function(result){
    if(result){
    var ids="";
    for(var i=0;i<items.length;i++){
        ids+='id='+items[i].id+'&';
    }

    $.ajax({
    url:'/admin/menu/delete',
    data:ids,
    success:function(data){
    if(data.type=='success'){
    $.messager.alert('信息提示','删除成功！','info');
    $('#wu-datagrid').treegrid('reload');
    }
    else
    {
    $.messager.alert('信息提示',data.msg,'info');
    $('#wu-datagrid').treegrid('reload');
    }
    }
    });
    }
    });
    }

    function selectIcons(chose) {
    $.ajax({
    url:'/admin/menu/showIcons',
       dataType:'json',
       success:function(data) {
           var table='<tr>';
           for(var i=0;i<data.length;i++){
               var link="http://localhost:8080/resource/admin/easyui/css/icons/"+data[i];
               //console.log(link);
                if(i%12==0){
                   table=table+'</tr><tr>'
                }
               table=table+'<td>&nbsp;&nbsp;&nbsp;&nbsp;<img src='+link+' onclick=selectOneIcon(this.src,'+chose+')>&nbsp;&nbsp;&nbsp;&nbsp;</td>';
           }

           $('#icons-table').html(table);
           $('#select-icon-dialog').dialog({
                closed: false,
                 title:'选择图标'
            });
       }
    })
    }

    function selectOneIcon(icon,chose) {
        console.log(chose);
        $('#select-icon-check').dialog({
            closed:false,
            title:'确认图标',
            modal:'true',
            buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
                        var res=icon.substring(icon.lastIndexOf('/')+1,icon.lastIndexOf('.'));
                        if(chose==1){
                            $('#icon-id').val(res);
                        }else {
                            $('#icon-button-id').val(res);
                        }
                        $('#select-icon-check').dialog('close');
                        $('#select-icon-dialog').dialog('close');
                     }
            }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function () {
            $('#select-icon-check').dialog('close');
            }
            }]
        })
    }

    $('#search-btn').click(function() {
        $('#wu-datagrid').treegrid('reload',{name:$('#search-data').val()});
    })

    /**
    * Name 打开添加窗口
    */
    function openAdd(){
    var item = $('#wu-datagrid').treegrid('getSelected');
    if(item==null || item.length==0 ||item.parentId==0 ){
    $('#wu-form-addChildMenu').form('clear');
    $('#wu-dialog-addChildMenu').dialog({
    closed: false,
    modal:true,
    title: "添加信息",
    buttons: [{
    text: '确定',
    iconCls: 'icon-ok',
    handler: function (){
        var data=$('#wu-form-addChildMenu').serialize();
        add(data);
        $('#wu-dialog-addChildMenu').dialog('close');
    }
    }, {
    text: '取消',
    iconCls: 'icon-cancel',
    handler: function () {
    $('#wu-dialog-addChildMenu').dialog('close');
    }
    }]
    });
    }else {
    $('#wu-form-addChildButton').form('clear');
    $('#edit-hiden').show();
    $('#parentName-button_id').val(item.name);
    $('#parentId-button_id').val(item.id);
    $('#wu-dialog-addChildButton').dialog({
    closed: false,
    modal:true,
    title: "添加信息",
    buttons: [{
    text: '确定',
    iconCls: 'icon-ok',
    handler: function (){
    var url=$('#url-button_id').val();
    if(url==null || url=="" || url.indexOf('/')!=-1){
    $.messager.alert('信息提示','调用的方法必填且不能包含路径！','info');
    return;
    }else{
    var data=$('#wu-form-addChildButton').serialize();
    add(data);
    $('#wu-dialog-addChildButton').dialog('close');
    }
    }
    }, {
    text: '取消',
    iconCls: 'icon-cancel',
    handler: function () {
    $('#wu-form-addChildButton').dialog('close');
    }
    }]
    });
    }
    }

    /**
    * Name 打开修改窗口
    */
    function openEdit(){
    var item = $('#wu-datagrid').treegrid('getSelected');
    if(item==null || item.length==0){
    $.messager.alert('信息提示','请选择一条要修改的信息！','info');
       return;
    }
    if(item.url==null || item.url=="" || item.url.indexOf('/')!=-1){
    $('#wu-form-addChildMenu').form('clear');
    $('#name_id').val(item.name);
    $('#icon-id').val(item.icon);
    $('#url_id').val(item.url);
    $('#parentId_id').combobox('setValue',item.parentId);
    $('#wu-dialog-addChildMenu').dialog({
    closed: false,
    modal:true,
    title: "修改信息",
    buttons: [{
    text: '确定',
    iconCls: 'icon-ok',
    handler:function() {
    edit(item,1);
    $('#wu-dialog-addChildMenu').dialog('close');
    }
    },{
    text: '取消',
    iconCls: 'icon-cancel',
    handler: function () {
    $('#wu-dialog-addChildMenu').dialog('close');
    }
    }]
    });
    }else{
    $('#wu-form-addChildButton').form('clear');
    $('#name-button_id').val(item.name);
    $('#edit-hiden').hide();
    $('#icon-button-id').val(item.icon);
    $('#url-button_id').val(item.url);
    $('#parentId-button_id').val(item.parentId);
    $('#wu-dialog-addChildButton').dialog({
    closed: false,
    modal:true,
    title: "修改信息",
    buttons: [{
    text: '确定',
    iconCls: 'icon-ok',
    handler:function() {
    edit(item,2);
    $('#wu-dialog-addChildButton').dialog('close');
    }
    },{
    text: '取消',
    iconCls: 'icon-cancel',
    handler: function () {
    $('#wu-dialog-addChildButton').dialog('close');
    }
    }]
    });
    }
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
    var opts = dg.treegrid('options');
    var pager = dg.treegrid('getPager');
    pager.pagination({
    onSelectPage:function(pageNum, pageSize){
    opts.pageNumber = pageNum;
    opts.pageSize = pageSize;
    pager.pagination('refresh',{pageNumber:pageNum,pageSize:pageSize});
    dg.treegrid('loadData',data);
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
    $('#wu-datagrid').treegrid({
    url:'/admin/menu/list',
    rownumbers:true,
    singleSelect:false,
    pageSize:100,
    pageList:[10,20,30,50,100],
    pagination:true,
    multiSort:true,
    fit:true,
    fitColumns:true,
    idField:'id',
    treeField:'name',
    columns:[[
    { field:'name',title:'name',width:433,sortable:true},
    { field:'url',title:'url',width:433},
    { field:'icon',title:'icon',width:433,formatter:function(value,index,row){
    var img = "&nbsp;&nbsp;&nbsp;<img src=http://localhost:8080/resource/admin/easyui/css/icons/"+ value + ".png>&nbsp;&nbsp;&nbsp;</img>";
    return img + value;
    }},
    ]]
    });
    </script>
</html>
