<%--
  Created by IntelliJ IDEA.
  User: 霉偷煤南
  Date: 2019/6/17
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>SSM房间预定</title>
    <link href="/hotel/resource/home/css/reservation.css" type="text/css" rel="Stylesheet"/>
    <link href="/hotel/resource/home/css/index.css" type="text/css" rel="Stylesheet"/>
</head>
<style>
    .threed{
        color: #fafafa;
        letter-spacing: 0;
        text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135 ;
        font-size: 50px;
    }
</style>
<body style="background-image:url(http://localhost:8080/hotel/resource/home/images/homeIndex1.jpg); ">
<!--头部-->
<div>
<c:if test="${account != null}">
    <p style="float:right;height: 25px;color: black;margin-right: 165px;padding-top: 5px" ><font size="3px" color="white">嗨&nbsp;${account.name}！</font>&nbsp;&nbsp;<a href="/hotel/home/account/homepage?"><font size="3px" color="white">个人中心&nbsp</font></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/hotel/home/index/loginOut"><font size="3px" color="white">注销登陆&nbsp</font></a></p>
</c:if>
<c:if test="${account == null}">
<p style="float:right;height: 25px;margin-right: 165px;padding-top: 5px"><a href="/hotel/home/index/login"><font size="3px" color="white">登录</font></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/hotel/home/index/regist"><font size="3px" color="white">注册</font></a>&nbsp;</p>
</c:if>
<h1 class="threed" style="padding-left: 160px">SSM房间预定系统</h1>
</div>
    <!--主体内容-->
<section>

    <!---->
    <!---预订菜单--->
    <div id="due_menu" style="background-image:url(http://localhost:8080/hotel/resource/home/images/homeIndex.jpg);" >
        <!--关于-->
        <form style="display:none;" action="/hotel/home/index/homepage" method="get" id="search-form"><input type="hidden" name="name" id="search-name"></form>
        <!--客房-->
        <div id="guest_rooms">
            <p class="booking_tab"><span></span>房型列表</p>
            <div class="chioce">
                <input type="text" placeholder="关键字" id="kw"/>
                <input type="button" value="搜索" id="search"/>
            </div>
            <!--列表-->
            <table id="pro_list" >
                <thead>
                <tr>
                    <th width="150px">预览</th>
                    <th>房型</th>
                    <th>可住人数</th>
                    <th>床数</th>
                    <th>价格</th>
                    <th>已预定数</th>
                    <th>剩余房数</th>
                    <th>状态</th>
                    <th>预订</th>
                </tr>
                </thead>
                <tbody >
                <c:forEach items="${roomTypeList }" var="roomType">
                    <tr style="height: 100px">
                        <td><a href="#"><img src="${roomType.photo }" style="height: 120px;width: 120px" ></a>
                        </td>
                        <td align="center">
                            <p>${roomType.name }</p>
                            <p class="sub_txt">${roomType.remark }</p>
                        </td>
                        <td>${roomType.liveNum }个</td>
                        <td>${roomType.bedNum }个</td>
                        <td>￥${roomType.price }</td>
                        <td>${roomType.bookNum }间</td>
                        <td>${roomType.avilableNum }间</td>
                        <td>
                            <c:if test="${roomType.avilableNum > 0 }">
                                可预订
                            </c:if>
                            <c:if test="${roomType.avilableNum <= 0 }">
                                满房
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${roomType.avilableNum <= 0 }">
                                <input type="button" class="disable" value="满房" >
                            </c:if>
                            <c:if test="${roomType.avilableNum > 0 }">
                                <input type="button" value="预订" onclick="window.location.href='/hotel/home/account/bookOrder?showDoWhat=1&roomTypeId=${roomType.id }'" >
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div id="pages"></div>
            <!--  -列表菜单 -->
            <div></div>
        </div>
    </div>

</section>
</body>
<!--底部-->
<script src="/hotel/resource/home/js/jquery-1.11.3.js"></script>
<script>

    $(document).ready(function(){
        $("#search").click(function(){
            $("#search-name").val($("#kw").val());
            $("#search-form").submit();
        })
    });

</script>
