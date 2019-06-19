<%--
  Created by IntelliJ IDEA.
  User: 霉偷煤南
  Date: 2019/6/19
  Time: 21:43
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
                <c:if test="${b.key== '营业额统计'}">
                    <c:forEach items="${b.value }" var="m">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-${m.icon}"  onclick="${m.url}" plain="true">${m.name}</a>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <div>
        <div class="easyui-accordion" style="width:960px;height:600px;">
            <div title="营业统计分析" iconCls="icon-chart-curve" style="overflow:auto;padding:10px;">
                <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
                <div id="charts-div" style="width: 800px;height:500px;"></div>
            </div>
        </div>
    </div>
    <!-- Begin of easyui-dialog -->

    <%@include file="/WEB-INF/views/admin/commen/footer.jsp" %>
    <script type="text/javascript" src="/lnn/resource/admin/echarts/js/echarts.common.min.js"></script>
    <!-- End of easyui-dialog -->
    <script type="text/javascript">
        $(document).ready(function(){
            statsByDay();
        });
        function statsByMonth(){
            getData('month');
        }
        function statsByDay(){
            getData('day');
        }
        function getData(type){
            $.ajax({
                url:'/lnn/admin/stats/get_stats',
                type:'post',
                dataType:'json',
                data:{type:type},
                success:function(data){
                    if(data.type == 'success'){
                        var title = '营业统计分析';
                        if(type == 'month'){
                            title = title + '(按月统计)';
                        }else{
                            title = title + '(按日统计)';
                        }
                        var option = {
                            title: {
                                text: title
                            },
                            xAxis: {
                                type: 'category',
                                boundaryGap: false,
                                data: data.content.keyList
                            },
                            tooltip : {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'cross',
                                    label: {
                                        backgroundColor: '#6a7985'
                                    }
                                }
                            },
                            yAxis: {
                                type: 'value'
                            },
                            series: [{
                                data: data.content.valueList,
                                type: 'line',
                                areaStyle: {}
                            }]
                        };
                        myChart.setOption(option);
                    }else{
                        alert(data.msg)
                    }
                }
            });
        }
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('charts-div'));

        // 指定图表的配置项和数据

        // 使用刚指定的配置项和数据显示图表。

    </script>