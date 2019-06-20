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
    <link href="/lnn/resource/home/css/index.css" type="text/css" rel="Stylesheet" />
    <link href="/lnn/resource/home/css/login.css" type="text/css" rel="Stylesheet" />
</head>
<style>
.vintage{
background: #EEE url(data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAIAAAAmkwkpAAAAHklEQVQImWNkYGBgYGD4//8/A5wF5SBYyAr+//8PAPOCFO0Q2zq7AAAAAElFTkSuQmCC) repeat;
text-shadow: 5px -5px black, 4px -4px white;
font-weight: bold;
-webkit-text-fill-color: transparent;
-webkit-background-clip: text ;
font-size: 30px;
}
</style>
<body style="background-image:url(http://106.14.125.136:80/lnn/resource/home/images/login.jpg);">

<header>
    <div style="padding-top: 80px;" class="vintage">
        <span>SSM房间预定&nbsp;&nbsp;|&nbsp;&nbsp;  会员登录</span>
    </div>

</header>
<section>
    <div class="left">
        <img src="/lnn/resource/home/images/index.jpg">
    </div>
    <div class="login" style="background-image:url(http://106.14.125.136:80/lnn/resource/home/images/login1.jpg);">


        <div id="normal">
            <ul id="nor_log">
                <li class="name" style="margin-top:25px;">
                    <input name="phoneNum" id="phoneNum" type="text" placeholder="请输入手机号">
                    <span class="icon"></span>
                </li>
                <li class="pwd" style="margin-top:25px;">
                    <input  name="password" id="password" type="password" placeholder="密码">
                    <span class="icon"></span>
                </li>
            </ul>

            <div class="codes" style="margin-top:25px;">
                <input type="text" name="cpacha" id="cpacha" class="blur" placeholder="请输入验证码" style="width: 193px"/>
                <img id="cpachaPic" src="/lnn/home/index/get_cpacha?vc=4&w=100&h=30" title="点击切换验证码" style="cursor: pointer;"  width="100px" height="32px"/>
            </div>

        </div>

        <div class="log" id="bt_login" style="margin-top:25px;cursor: pointer;">登 录</div>
        <a href="/lnn/home/index/regist" style="margin-left: 250px;cursor: pointer;"><font color="black">立即注册</font></a>
    </div>
    <div class="reg">
        <a href="/lnn/home/index/homepage" style="cursor: pointer;color: black;font-size: 15px">先不登陆 &gt;&gt;</a>
    </div>
</section>
<script src="/lnn/resource/home/js/jquery-1.11.3.js"></script>
<script>
    $('#cpachaPic').click(function changeCpacha(){
        $('#cpachaPic').attr('src','/lnn/home/index/get_cpacha?vc=4&w=100&h=30&d='+new Date().getTime());
    });

    $('#bt_login').click(function () {
        var phoneNum = $('#phoneNum').val();
        var password = $('#password').val();
        var cpacha = $('#cpacha').val();

        if (phoneNum == '' || phoneNum == 'undefined') {
            alert("请输入用户名");
            return;
        }
        if (password == '' || password == 'undefined') {
            alert("请输入密码");
            return;
        }
        if (cpacha == '' || cpacha == 'undefined') {
            alert("请输入验证码");
            return;
        }

        $.ajax({
            url: '/lnn/home/index/loginUp',
            data: {phoneNum: phoneNum, password: password, cpacha: cpacha},
            dataType: 'json',
            type: 'post',
            success: function (data) {
                if (data.type == 'success') {
                    window.parent.location = "/lnn/home/index/homepage";
                } else {
                    alert(data.msg);
                    return;
                }
            }
        })
    })
</script>
<%@include file="/WEB-INF/views/home/commen/footer.jsp" %>

