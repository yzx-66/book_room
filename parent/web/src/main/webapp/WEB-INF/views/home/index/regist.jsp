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
    <title>SSM房间预定</title>
    <link href="/lnn/resource/home/css/login.css" type="text/css" rel="Stylesheet" />
    <link href="/lnn/resource/home/css/regsiter.css" type="text/css" rel="Stylesheet" />
    <link href="/lnn/resource/home/css/index.css" type="text/css" rel="Stylesheet" />
    <style>
        #ad>ul {
            margin:0;
        }
    </style>
</head>
<body>
<!--头部-->

<header>
    <div>
        <a href="index.html"><img src="images/logo-1.jpg" alt=""> </a> <span>注册</span>
    </div>

</header>
<!--中间部分-->
<div id="reg">
    <!---温馨提示-->
    <div class="msg">
        <div class="panel">
            <form id="user_info">
                <div class="form-group">
                    <label for="uname">用户名：</label>
                    <input required minlength="3" maxlength="9" type="text" placeholder="请输入用户名" autofocus name="name" id="uname"/>
                    <span class="msg-default">用户名长度在3到9位之间</span>
                </div>
                <div class="form-group">
                    <label for="upwd">密码：</label>
                    <input type="password" minlength="6" maxlength="12" placeholder="请输入密码" name="password" id="upwd"/>
                    <span class="msg-default hidden">密码长度在6到12位之间</span>
                </div>
                <div class="form-group">
                    <label for="upwd2">确认密码：</label>
                    <input type="password" placeholder="再次输入密码" name="upwd2" id="upwd2"/>
                    <span class="msg-default hidden">密码长度在6到12位之间</span>
                </div>
                <!--
                <div class="form-group">
                  <label for="uemail">邮箱：</label>
                  <input required type="email" placeholder="请输入邮箱地址" name="uemail" id="uemail"/>
                  <span class="msg-default hidden">请输入合法的邮箱地址</span>
                </div>
                -->
                <div class="form-group">
                    <label for="uphone">手机：</label>
                    <input required type="tel" placeholder="请输入手机号码" name="phoneNum" maxlength="11" id="uphone"/>
                    <span class="msg-default hidden">请输入合法的手机号码</span>
                </div>
                <div class="form-group">
                    <label >验证码：</label>
                    <input required type="text" placeholder="请输入验证码" name="cpacha_pic" maxlength="11" id="cpacha_pic" style="width: 125px"/>
                    <img id="cpachaPic" src="/lnn/home/index/get_cpacha?vc=4&w=100&h=30" title="点击切换验证码" style="cursor: pointer;border:1px solid black"  width="118px" height="32px" onclick="changeCpacha()"/>
                    <span class="msg-default hidden">请输入正确的验证码</span>
                </div>
                <div class="form-group">
                    <label>短信验证码：</label>
                    <input required type="text" placeholder="请输入短信验证码" name="cpacha_msg" maxlength="11" id="cpacha_msg" style="width: 125px"/>
                    <a href="#" id="send_msg" style="width: 120px">点击发送</a>
                    <span class="msg-default hidden">请输入正确短信验证码</span>
                </div>
                <div>
                    <div class="form-group">
                        <label></label>
                        <input type="button" value="提交注册信息" id="btn_reg" />
                    </div>
                </div>

            </form>
        </div>
        <div id="ad">
<%--            <p>注册会员后，你可以:</p>--%>
<%--            <ul>--%>
            <!--<li><b>1</b>查询，计划您的订单</li>-->
            <!--<li><b>2</b>预订美食，客房</li>-->
            <!--<li><b>3</b>享受超低优惠折扣</li>-->
            <!--</ul>-->
            <div class="login">
                已有账号，去 <a href="login.html">登陆</a>
            </div>
            <ul id="trigger">
                <li><img src="/lnn/resource/home/images/new1.png"></li>
            </ul>

        </div>
    </div>
</div>
</body>
<style>
    body{ padding-bottom:25px;}
    .fixed{ position:fixed; left:0px; bottom:0px; width:100%; height:25px; background-color:#FFFFFF; z-index:9999;}
</style>
<div id="c_footer" class="fixed">
    <p style="text-align: center;">
        <a href="/lnn/home/index/homepage">首页</a>|
        <a href="">关于我们</a>|
        <a href="/lnn/admin/system/index">登录后台</a>
    </p>
</div>
<!--底部-->
<script src="/lnn/resource/home/js/jquery-1.11.3.js"></script>
<link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script>
    function changeCpacha(){
        $('#cpachaPic').attr('src','/lnn/home/index/get_cpacha?vc=4&w=100&h=30&d='+new Date().getTime());
    };

    $(function() {
        $( "#send_msg" )
            .button()
            .click(function( event ) {
                if(login!=1){
                    alert('请先检查其他所有信息！')
                    return;
                }
                $.ajax({
                    url:'/lnn/home/index/checkCpachaMsg',
                    data:{cpacha:$('#cpacha_pic').val()},
                    dataType:'json',
                    type:'post',
                    success:function (data) {
                        if(data.type=='success') {
                            changeCpacha();
                           $.ajax({
                               url:'/lnn/home/index/sendMsg',
                               data:{phoneNum:$('#uphone').val()},
                               type:'post',
                               dataType:'json',
                               success:function (data) {
                                   if(data.type=='success') {
                                       alert('短信验证码发送成功！请注意查收');
                                   }else {
                                       alert(data.msg);
                                   }
                               }
                           })
                        } else {
                            alert(data.msg)
                            return;
                        }
                    }
                })
            });
    });


    /*1.对用户名进行验证*/
    var login=0;
    uname.onblur = function(){
        var val=this.value;
        console.log(this.value);
        var result=test(val);
        console.log(test(val));
        if(this.validity.valueMissing){
            this.nextElementSibling.innerHTML = '用户名不能为空';
            this.nextElementSibling.className = 'msg-error';
            login=0;
            this.setCustomValidity('用户名不能为空');
        }else if(this.validity.tooShort){
            this.nextElementSibling.innerHTML = '用户名不能少于3位';
            this.nextElementSibling.className = 'msg-error';
            login=0;
            this.setCustomValidity('用户名不能少于3位');
        }else {
            this.nextElementSibling.innerHTML = '用户名格式正确';
            this.nextElementSibling.className = 'msg-success';
            login=1;
            this.setCustomValidity('');
        }

    }


    //2.对密码进行验证
    upwd.onfocus = function(){
        this.nextElementSibling.innerHTML = '密码至少为6位数字或者字符';
        this.nextElementSibling.className = 'msg-default';
        login=0;
    }
    upwd.onblur = function(){
        if(upwd.value == '' || upwd.value.length < 6){
            this.nextElementSibling.innerHTML = '密码至少为6位数字或者字符';
            this.nextElementSibling.className = 'msg-default';
            login=0;
        }else{
            this.nextElementSibling.innerHTML = '输入正确';
            this.nextElementSibling.className = 'msg-success';
            login=1;
            this.setCustomValidity('');
        }

    }

    uphone.onblur = function(){
        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
        if(this.validity.valueMissing){
            this.nextElementSibling.innerHTML = '电话号码不能为空';
            this.nextElementSibling.className = 'msg-error';
            login=0;
            this.setCustomValidity('电话号码不能为空');
        }else if(this.validity.typeMismatch){
            this.nextElementSibling.innerHTML = '电话号码格式不正确';
            this.nextElementSibling.className = 'msg-error';
            login=0;
            this.setCustomValidity('电话号码格式不正确');
        }else if(!myreg.test(uphone.value)){
            this.nextElementSibling.innerHTML = '电话号码格式不正确';
            this.nextElementSibling.className = 'msg-error';
            login=0;
            this.setCustomValidity('电话号码格式不正确');
        }
        else {
            this.nextElementSibling.innerHTML = '格式正确';
            this.nextElementSibling.className = 'msg-success';
            login=1;
            this.setCustomValidity('');
        }
    }
    uphone.onfocus = function(){
        this.nextElementSibling.innerHTML = '请输入合法的手机号码';
        this.nextElementSibling.className = 'msg-default';
        login=0;
    }
    //确认密码
    upwd2.onblur=function() {
        if (upwd2.value != upwd.value) {
            this.nextElementSibling.innerHTML = '两次密码输入不一致';
            login=0;
            this.nextElementSibling.className = 'msg-error';
        } else if (upwd2.value == upwd.value) {
            this.nextElementSibling.innerHTML = '输入正确';
            this.nextElementSibling.className = 'msg-success';
            login=1;
        }
    }
    $('#btn_reg').click(function(){
        //表单序列化，获得所有的用户输入
        var data = $('#user_info').serialize();
        if(login==1){
            $.ajax({
                type: 'POST',
                url: '/lnn/home/index/registUp',
                data: data,
                success: function(data){
                    if(data.type=='success') {
                        alert('注册成功！请在订房前完成实名认证');
                        location.href = '/lnn/home/index/login';
                    } else {
                        alert(data.msg)
                        return;
                    }
                }
            });
        }else {
            alert('请先检查所有注册信息');
            return;
        }
    })

    /*功能点2：轮播*/
    var pic = {
        intr: function () {
            var i = 1;
            var str1 = $("#trigger img").attr("src");
            var str = str1.toString();
            var timer = setInterval(function () {
                i++;
                if (i > 3) {
                    i = 1;
                }
                str = str.replace(/[1-3]/, i);
                $("#trigger img").attr("src", str);
            }, 2000);
        }
    }
    pic.intr();
</script>


