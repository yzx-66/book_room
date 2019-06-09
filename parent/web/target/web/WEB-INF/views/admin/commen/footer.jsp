<%--
  Created by IntelliJ IDEA.
  User: 霉偷煤南
  Date: 2019/6/4
  Time: 21:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="loading" style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#F9F9F9;text-align :center;padding-top:10%">
    <img src="/resource/admin/easyui/images/load-page.gif" width="30%">
    <h1><font color="#15428B">加载中....</font></h1>
</div>
</body>
<script>
    var pc;
    //不要放在$(function(){});中
    $.parser.onComplete = function () {
        if (pc) clearTimeout(pc);
        pc = setTimeout(closes, 1000);
    }

    function closes() {
        $('#loading').fadeOut('normal', function () {
            $(this).remove();
        });
    }

    function subicon(icon) {
        var ter='icon-'+icon.substring(0,icon.lastIndexOf('.'))
        return ret;
    }
</script>

