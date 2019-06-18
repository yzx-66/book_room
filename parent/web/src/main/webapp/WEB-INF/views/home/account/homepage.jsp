<%--
  Created by IntelliJ IDEA.
  User: 霉偷煤南
  Date: 2019/6/17
  Time: 22:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>SSM房间预定</title>
    <link rel="stylesheet" href="/hotel/resource/home/css/index.css"/>

    <!--<link rel="stylesheet" href="css/myOrder.css"/>-->
    <style>
        #contain{
            padding: 10px 0;
        }
        .tabs{
            width:162px;
            float: left;
            padding: 10px 0;
            text-align: center;
            background: #EDEDED;
        }
        .tabs li{
            line-height: 36px;
        }
        .content{
            padding: 0 10px;
            float:left;
            width: 1000px;
        }
        .content>div{
            display: none;
            width: 1000px;
        }
        .content .details{
            float:left;
            display: block;
            width: 1000px;
            /*padding:0  10px;*/
        }
        table{
            border: 1px solid #dddddd;
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }
        table th{
            background: #F2F2F2;
        }
        #contain .content table td{
            /*width:163px;*/
            border: 1px solid #dddddd;
            text-align: center;
        }
        .details table td{
            width: 163px;
        }
        table td input[type='checkbox']{
            float:left;
        }
        table td div{
            display: inline-block;
            border:1px solid #dddddd;
            padding: 5px;
        }
        table img{
            width: 100px;
            height: 100px;
            vertical-align: middle;
        }
        h3{
            margin:10px 0;
        }
        .total{
            text-align: right;
            padding: 10px 0;
        }
        .totalPrice{
            color: #DD4C40;
            font-size: 18px;
            font-weight: bold;
            margin-right: 10px;
        }
        .price{
            color:#DD4C40;
            font-weight: bold;
        }
        .count{
            width: 30px;
            text-align: center;
        }
        .title{
            font-weight: bold;
        }
        .msg{
            color:#DD4C40;
            min-height: 200px;
            line-height: 200px;
            font-weight: bold;
            text-align: center;
            display: none;
        }
        .tabs>li>a.active{
            color: #dd0000;
        }
        .order>table th{
            text-align: left;
            padding:5px ;
        }

        #contain .content .order .product{
            max-width:110px;
        }
        #contain .content table th{
            text-align: center;
        }
        #contain .content tr.title td{
            height: 25px;
            text-align: left;
        }
        #contain .content table td{
            max-width:220px ;
        }
        #contain .content td.productImg{
            text-align: left;
        }
        .form-control {
            display: block;
            width: 700px;
            height: 20px;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        }
        .btn-success {
            color: #fff;
            background-color: #5cb85c;
            border-color: #4cae4c;
        }

        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: 400;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            -ms-touch-action: manipulation;
            touch-action: manipulation;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
        }

    </style>
</head>
<body  style="background-image:url(http://localhost:8080/hotel/resource/home/images/ahomepage.jpg);">
<!--头部-->
<!--主体-->
<link rel="stylesheet" href="/hotel/resource/home/css/jquery-ui.min.css">
<div id="contain">
    <!--tab选项卡-->
    <ul class="tabs" style="background: #DACDBD">

        <li><a href="/hotel/home/index/homepage">回到首页</a></li>
        <li><a href="#order">我的订单</a></li>
        <li><a href="#info">我的资料</a></li>
        <li><a href="#pwd">修改密码</a></li>

    </ul>

    <div class="content">

        <form id="search-from" method="post" style="display: none" action="/hotel/home/account/homepage">
            <input name="status" id="status_id" type="hidden">
            <input name="arriveTime" id="arriveTime_id" type="hidden">
            <input name="leaveTime" id="leaveTime_id" type="hidden">
            <input name="name" id="name_id" type="hidden">
            <input name="phoneNum" id="phoneNum_id" type="hidden">
        </form>

        <div class="order" style="display: block;">
            <table>
                <div style="padding:3px 5px;">
                    <label>入住者姓名：</label><input type="text" id="search-name" class="wu-text" style="width:100px">
                    <label>入住者手机：</label><input type="text" id="search-phoneNum" class="wu-text" style="width:100px">
                    <label>入住时间：</label><input type="text" id="search-arriveTime" style="width:100px" class="datepicker">
                    <label>至退房时间：</label><input id="search-leaveTime" type="text" style="width:100px" class="datepicker">
                    <label>状态：</label><select id="search-status" style="height: 23px;width: 104px">
                    <option value="-1" selected="selected">全部</option>
                    <option value="0">预定中</option>
                    <option value="1">已入住</option>
                    <option value="2">已离店</option>
                    <option value="3">已违约</option>
                </select>
                    <a href="#" id="search-btn" class="but" style="margin-left: 17px">检索</a>
                </div>
                <div class="content">

                <thead>
                <tr>
                    <!--<th colspan="4">订单编号：</th>-->
                    <!--<th colspan="2" >订单时间:</th>-->
                    <th>房型图片</th>
                    <th>房型</th>
                    <th>楼层</th>
                    <th>入住人</th>
                    <th>手机号</th>
                    <th>身份证号</th>
                    <th>状态</th>
                    <th>下单时间</th>
                    <th>入住时间</th>
                    <th>退房时间</th>
                    <th>备注</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${bookOrderList }" var="bookOrder">
                    <tr>
                        <c:forEach items="${allRoomTypes }" var="roomType">
                            <c:if test="${roomType.id == bookOrder.roomTypeId }">
                                <td><img src="${roomType.photo }" width="100px" onclick="window.parent.location='/hotel/home/account/bookOrder?showDoWhat=1&roomTypeId=${roomType.id}'" style="cursor: pointer;"></td>
                                <td>${roomType.name }</td>
                                <c:forEach items="${allFloors}" var="floor">
                                    <c:if test="${floor.id == roomType.floorId}">
                                        <td>${floor.hight}</td>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                        <td>${bookOrder.name }</td>
                        <td>${bookOrder.phoneNum }</td>
                        <td>${bookOrder.idCard }</td>
                        <td>
                            <c:if test="${bookOrder.status == 0 }">
                                <font color="red">预定中</font>
                            </c:if>
                            <c:if test="${bookOrder.status == 1 }">
                                已入住
                            </c:if>
                            <c:if test="${bookOrder.status == 2 }">
                                已结算离店
                            </c:if>
                            <c:if test="${bookOrder.status == 3 }">
                                已结违约
                            </c:if>
                        </td>
                        <td><fmt:formatDate value="${bookOrder.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${bookOrder.arriveDate }" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatDate value="${bookOrder.leaveDate }" pattern="yyyy-MM-dd"/></td>
                        <td>${bookOrder.remark }</td>
                        <td><a href="#" id="edit" class="but"  onclick="edit(${bookOrder.id})">修改</a><br>
                            <a href="#" id="remove" class="but"  onclick="remove(${bookOrder.id})">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                </div>
            </table>
            

        </div>
        <div class="info" >
            <table style="border:0px;cellspacing:0px;">
                <tbody>
                <tr>
                    <td style="border:0px;">用户名：</td><td style="float:left;width:400px;max-width: 420px;border:0px;"><input class="form-control" type="text" name="name" id="info_name" value="${account.name}"/></td>
                </tr>
                <tr style="border:0px;">
                    <td style="border:0px;">手机号：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" readonly="readonly" value="${account.phoneNum}"/></td>
                </tr>
                <tr style="border:0px;">
                    <td style="border:0px;">真实姓名：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" name="realName" id="info_realName" value="${account.realName}" /></td>
                </tr>
                <tr>
                    <td style="border:0px;">身份证号：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" name="idCard" id="info_idCard"  value="${account.idCard}"/></td>
                </tr>
                <tr>
                    <td style="border:0px;">联系地址：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" name="address" id="info_address" value="${account.address}"/></td>
                </tr>
                <tr>
                    <td style="float:right"></td><td><button type="button" id="info_btn" class="btn btn-success" style="width:100px;margin-left: 500px;margin-top: 20px" onclick="editInfo()">提交</button></td>
                </tr>
                </tbody>
            </table>

        </div>
        <div class="pwd" >
            <table style="border:0px;cellspacing:0px;">
                <tbody>
                <tr>
                    <td style="border:0px;">原密码：</td><td style="float:left;width:400px;max-width: 420px;border:0px;"><input class="form-control" type="text" name="old_password" id="old_password"/></td>
                </tr>
                <tr style="border:0px;">
                    <td style="border:0px;">新密码：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" name="new_password" id="new_password1" /></td>
                </tr>
                <tr>
                    <td style="border:0px;">重复密码：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" id="new_password2" /></td>
                </tr>

                <tr>
                    <td style="border:0px;"></td><td style="float:left;margin-top:15px;width:400px;max-width: 820px;border:0px;"><button type="button" class="btn btn-success" style="width:100px;" onclick="editPassword()">提交</button></td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>

</div>
<!--底部-->
</body>
<style>
    body{ padding-bottom:25px;}
    .fixed{ position:fixed; left:0px; bottom:0px; width:100%; height:25px; background-color:#DDD0BF; z-index:9999;}
</style>
<div id="c_footer" class="fixed">
    <p style="text-align: center;">
        <a href="/hotel/home/index/homepage">首页</a>|
        <a href="">关于我们</a>|
        <a href="/hotel/admin/system/index">登录后台</a>
    </p>
</div>
<%--<link rel="stylesheet" type="text/css" href="/hotel/resource/admin/easyui/easyui/1.3.4/themes/default/easyui.css" />--%>
<script src="/hotel/resource/home/js/jquery-1.11.3.js"></script>
<script src="/hotel/resource/home/js/jquery-ui.min.js"></script>

<link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jqueryui/style.css">
<script>
    $(".datepicker").datepicker({"dateFormat":"yy-mm-dd"});
    $(function() {
        $( "#search-btn" )
            .button()
            .click(function( event ) {
                $('#name_id').val($('#search-name').val());
                if($('#search-status').val()!=-1){
                    $('#status_id').val($('#search-status').val());
                }
                $('#arriveTime_id').val($('#search-arriveTime').val());
                $('#leaveTime_id').val($('#search-leaveTime').val());
                $('#phoneNum_id').val($('#search-phoneNum').val());
                $('#search-from').submit();
            });
    });
    $(function() {
        $( "a.but" )
            .button()
    });

    function edit(item){
        window.parent.location = "/hotel/home/account/bookOrder?showDoWhat=0&bookOrderId="+item;
    }

    function remove(item){
        var flag=1;
        var id;
        $.ajax({
            url:'/hotel/admin/bookOrder/findbookOrderById',
            data:{id:item},
            dataType:'json',
            type:'post',
            async:false,
            success:function (data) {
                var now=new Date();
                var arriveDate=new Date(item.arriveDate);
                if(now.getTime()>arriveDate.getTime()){
                    alert('预定订单已经过了到店日期无法删除，请联系客服说明，否则增加一次违约次数');
                    flag=0;
                    return;
                }
                id=data.id;
            }
        })
        if (flag=0) {
            return;
        }
        $.ajax({
            url:'/hotel/admin/bookOrder/delete',
            data:{id:id},
            success:function(data){
                if(data.type=='success'){
                    alert('删除成功！');
                    window.parent.location='/hotel/home/account/homepage'
                } else {
                    alert(data.msg);
                }
            }
        });
    }

    function mark(){
        if($('#info_idCard').val()!="" && $('#info_idCard').val()!=null){
            $('#info_idCard').attr('readonly','readonly');
            $('#info_realName').attr('readonly','readonly');
            var ret="";
            ret+=$('#info_idCard').val().substring(0,3);
            ret+="********";
            ret+=$('#info_idCard').val().substring(14,18)
            $('#info_idCard').val(ret);
        }
    }
    window.onload=mark;

    function editInfo(){
        $.ajax({
            url:'/hotel/home/account/editInfo',
            data:{name:$('#info_name').val(),realName:$('#info_realName').val(),idCard:$('#info_idCard').val(),address:$('#info_address').val()},
            dataType:'json',
            type:'post',
            success:function (data) {
                if(data.type=='success'){
                    alert('修改成功');
                    window.location.reload();
                }else {
                    alert(data.msg);
                }
            }
        })
    }
    function editPassword(){
        if($('#new_password1').val()!=$('#new_password2').val()){
            alert('两次密码输入不一致');
            return;
        }
        if($('#new_password1').val()==''){
            alert('新密码为空');
            return;
        }
        if($('#old_password').val()==''){
            alert('旧密码为空');
            return;
        }
        $.ajax({
            url:'/hotel/home/account/editPassword',
            data:{old_password:$('#old_password').val(),new_password:$('#new_password1').val()},
            dataType:'json',
            type:'post',
            success:function (data) {
                if(data.type=='success'){
                    alert('修改成功,请重新登陆');
                    window.parent.location="/hotel/home/index/login";
                }else {
                    alert(data.msg);
                }
            }
        })
    }

    $(".tabs").on("click","li a",function(){
        $(this).addClass("active").parents().siblings().children(".active").removeClass("active");
        var href=$(this).attr("href");
        href=href.slice(1);
        var $div=$("div.content>div."+href);
        $div.show().siblings().hide();
    });

</script>
                                                                                                                                                                                              </div>
