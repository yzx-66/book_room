<%--
  Created by IntelliJ IDEA.
  User: 霉偷煤南
  Date: 2019/6/17
  Time: 22:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SSM房间预定</title>
    <link rel="stylesheet" href="/lnn/resource/home/css/index.css">
    <link rel="stylesheet" href="/lnn/resource/home/css/order.css">
    <link rel="stylesheet" href="/lnn/resource/home/css/jquery-ui.min.css">
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>
<body style="background-image:url(http://localhost:8080/lnn/resource/home/images/bookOrder.jpg);">
<div style="display: none" id="showDoWhat">${showDoWhat}</div>
<div style="display: none" id="choseBookOrder">${choseBookOrder}</div>
<div style="display: none" id="checkIdCard">${account.idCard}</div>
<!--- 页头--->
<!----主体-->
<div id="section" style="padding-top: 70px">
    <!--客房信息-->
    <div class="hotel_inf_w">

        <div class="hotel_roominfobox">
            <a href="#"><img src="${roomType.photo }" alt=""/></a>
            <div class="info">
                <h2>${roomType.name }</h2>
                <!--豪华双人房&#45;&#45;&#45;&#45;预定-->
            </div>
            <ul class="hotel_detail" style="padding-left: 50px;padding-top: 20px">
                <li><span>已预定数:</span>${roomType.bookNum }</li>
                <li><span>剩余可用数:</span>${roomType.avilableNum }</li>
                <li><span>房价:</span>${roomType.price }</li>
                <li><span>床位数:</span>${roomType.bedNum }</li>
                <li><span>可住:</span>${roomType.liveNum }人</li>
                <li><span>其他:</span>${roomType.remark }</li>
            </ul>
        </div>
        <div class="jump">

            <a href="/lnn/home/index/homepage">更多房型</a>
        </div>
    </div>
    <!--预定信息-->
    <div class="book_info" style="background-image:url(http://localhost:8080/lnn/resource/home/images/bookOrder1.jpg);">
        <form id="order_info">
            <ul>
                <li>
                    <h3>预定信息</h3>

                    <div class="info_group">
                        <label>入&nbsp;住&nbsp;时&nbsp;间：</label><input type="text" name="arriveTime" id="arriveTime" class="datepicker" style="width: 163px" onchange="setPrice()"/>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退&nbsp;房&nbsp;时&nbsp;间：</label><input type="text" name="leaveTime" id="leaveTime" class="datepicker" onchange="setPrice()" style="width: 163px"/>
                    </div>

                    <div class="info_group">
                        <label>选&nbsp;择&nbsp;楼&nbsp;层：</label><select id="hight" style="height: 30px"></select>
                        <input id="typeName" value="${roomType.name}"type="hidden">
                        <input id="accountPhone" value="${account.phoneNum}" type="hidden">
                        <input id="one_price" value="${roomType.price}" type="hidden">
                    </div>

                    <div class="info_group">
                        <label style="padding-left: 400px">房费总计：</label><span class="total" id="price" style="font-size: 30px">￥${roomType.price }</span>
                        <input type="hidden" value="0"/>
                    </div>
                </li>
                <li>
                    <h3>入住信息</h3>

                    <div class="info_group">
                        <label>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label><input type="text" name="name" id="name" value="${account.realName}" style="width: 163px"/><span class="msg"></span>
                    </div>
                    <div class="info_group">
                        <label>电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：</label><input type="text" maxlength="11" name="phoneNum" id="phoneNum" value="${account.phoneNum}" style="width: 163px"/><span class="msg"></span>
                    </div>
                    <div class="info_group">
                        <label>身&nbsp;份&nbsp;证&nbsp;号：</label><input type="text" name="idCard" id="idCard" value="${account.idCard}" style="width: 163px"/><span class="msg"></span>
                    </div>
                    <div class="info_group">
                        <label for="massage">留&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;言：</label>
                        <textarea id="remark" name="remark" style="width:200px;"></textarea>
                    </div>

                </li>
                <li>

                    <div id="btn_booking" style="margin-left:480px">确认预定</div>

                </li>
            </ul>
        </form>
    </div>

    <div class="malog">
        <div class="message">
            <p class="msgs"></p>
            <p>您可以在 <a href="/lnn/home/account/homepage">我的订单</a>查看详情</p>
            <p>系统会在<span class="num">5</span>秒后跳转会 <a href="/lnn/home/account/homepage">菜单列表</a></p>
        </div>
    </div>

</div>
</body>
<style>
    body{ padding-bottom:25px;}
    .fixed{ position:fixed; left:0px; bottom:0px; width:100%; height:25px; background-color:#F5E6C5; z-index:9999;}
</style>
<div id="c_footer" class="fixed">
    <p style="text-align: center;">
        <a href="/lnn/home/index/homepage">首页</a>|
        <a href="">关于我们</a>|
        <a href="/lnn/admin/system/index">登录后台</a>
    </p>
</div>

<!----页底--->
<script src="/lnn/resource/home/js/jquery-1.11.3.js"></script>
<script src="/lnn/resource/home/js/jquery-ui.min.js"></script>
<script>
    function fllowChangRoomType() {
        $('#hight_id').empty();
        $.ajax({
            url:'/lnn/admin/floor/findFloorsByRoomTypeName',
            data:{name:$('#typeName').val()},
            dataType:'json',
            type:'post',
            async:false,
            success:function (data) {
                $('#hight').append("<option value=\"-1\" selected=selected>全部楼层随机分配！</option>");
                for(var i=0;i<data.length;i++){
                    $.ajax({
                        url:'/lnn/admin/room/getRoomNumsByTypeAndHight',
                        type:'post',
                        data:{roomTypeName:$('#typeName').val(),hight:data[i].hight},
                        dataType:'json',
                        async:false,
                        success:function (size) {
                            if(size==0){
                                $('#hight').append("<option value="+data[i].hight+">"+data[i].hight+"&nbsp;层（该层已经预定全部！）</option>");
                            }else {
                                $('#hight').append("<option value="+data[i].hight+">"+data[i].hight+"&nbsp;层（该层剩余："+size+"间）</option>");
                            }
                        }
                    })
                }
            }
        });
        if($('#showDoWhat').html()==0){
            var item=JSON.parse($('#choseBookOrder').html());
            $.ajax({
                url:'/lnn/admin/floor/findFloorByRoomTypeId',
                data:{id:item.roomTypeId},
                dataType:'json',
                async:false,
                success:function (data) {
                    $('#hight').val(data.hight);
                }
            });
            $('#name').val(item.name);
            $('#idCard').val(item.idCard);
            $('#phoneNum').val(item.phoneNum);
            $('#arriveTime').val(formatDate(item.arriveDate,'YYYY-MM-DD'));
            $('#leaveTime').val(formatDate(item.leaveDate,'YYYY-MM-DD'));
            $('#remark').val(item.remark);
            alert('前台系统房型不可改变，若想改变房型请删除订单重新下单，或者联系客服后台系统修改房型，且各楼层剩余房间数为不含你目前预定的房间');
        }
    }
    window.onload=fllowChangRoomType;

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

    function DateMinus(date1,date2){//date1:小日期   date2:大日期
        var sdate = new Date(date1);
        var now = new Date(date2);
        var days = now.getTime() - sdate.getTime();
        var day = parseInt(days / (1000 * 60 * 60 * 24));
        return day;
    }

    function setPrice(){
        if($('#arriveTime').val()!=null && $('#arriveTime').val()!=""){
            if($('#leaveTime').val()!=null && $('#leaveTime').val()!=""){
                var price=$('#one_price').val()*DateMinus($('#arriveTime').val(),$('#leaveTime').val());
                $('#price').html('￥'+price);
            }
        }
    }

    $(".datepicker").datepicker({"dateFormat":"yy-mm-dd"});
    $("#btn_booking").click(function(){
        var arriveTime = $("#arriveTime").val();
        var leaveTime = $("#leaveTime").val();
        if(arriveTime == '' || leaveTime == ''){
            alert('请选择时间!');
            return;
        }
        var name = $("#name").val();
        if(name == ''){
            $("#name").next("span.msg").text('请填写入住人!');
            return;
        }
        $("#name").next("span.msg").text('');
        var phoneNum = $("#phoneNum").val();
        if(phoneNum == ''){
            $("#phoneNum").next("span.msg").text('请填写手机号!');
            return;
        }
        $("#phoneNum").next("span.msg").text('');
        var idCard = $("#idCard").val();
        if(idCard == ''){
            $("#idCard").next("span.msg").text('请填写身份证号!');
            return;
        }
        if($('#checkIdCard').html()==null || $('#checkIdCard').html()==''){
            var r=confirm("您还没有实名认证，无法进行预定，请先取个人中心完善资料，点击确定补全资料");
            if (r==true) {
                 window.parent.location='/lnn/home/account/homepage?#info';
            }return;
        }
        $("#idCard").next("span.msg").text('');
        var remark = $("#remark").val();
        if($('#showDoWhat').html()==1){
            $.ajax({
                url:'/lnn/admin/bookOrder/add',
                type:'post',
                dataType:'json',
                data:{accountPhone:$('#accountPhone').val(),roomTypeName:$('#typeName').val(),hight:$('#hight').val(),name:name,phoneNum:phoneNum,idCard:idCard,remark:remark,arriveTime:arriveTime,leaveTime:leaveTime},
                success:function(data){
                    if(data.type == 'success'){
                        $(".malog").show();
                        setTimeout(function(){
                            window.location.href = '/lnn/home/account/homepage';
                        },1000)
                    }else{
                        alert(data.msg);
                    }
                }
            });
        }else if($('#showDoWhat').html()==0){
            var item=JSON.parse($('#choseBookOrder').html());
            var data=$('#wu-form-2').serialize()+"&id="+item.id+"&oldRoomTypeId="+item.roomTypeId;
            $.ajax({
                url:'/lnn/admin/bookOrder/update',
                type:'post',
                dataType:'json',
                data:{accountPhone:$('#accountPhone').val(),roomTypeName:$('#typeName').val(),hight:$('#hight').val(),name:name,phoneNum:phoneNum,idCard:idCard,remark:remark,arriveTime:arriveTime,leaveTime:leaveTime,id:item.id,oldRoomTypeId:item.roomTypeId},
                success:function(data){
                    if(data.type=='success') {
                        alert('修改成功！');
                        window.parent.location = "/lnn/home/account/homepage";
                    } else{
                        alert(data.msg);
                        return;
                    }
                }
            });
        }
    })
</script>
