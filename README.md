# SSM房间预订系统

#### 介绍
房间预定系统 包含两个平台
后台系统实现了的一级功能包含用户管理、楼层管理、房间管理、客户管理、预定管理、入住管理、营业统计等等，还以拦截器的方式实现了权限和角色管理。
前台系统实现了房间预定、订单查看、订单取消、用户注册等功能

**部分截图**

![输入图片说明](https://github.com/yzx66-net/ssm_lnn/blob/master/1.jpg "前台系统.png")

![输入图片说明](https://github.com/yzx66-net/ssm_lnn/blob/master/2.jpg "前台系统.png")

![输入图片说明](https://github.com/yzx66-net/ssm_lnn/blob/master/3.png "前台系统.png")

![输入图片说明](https://github.com/yzx66-net/ssm_lnn/blob/master/5.png "后台登录.png")

![输入图片说明](https://github.com/yzx66-net/ssm_lnn/blob/master/6.png "后台系统.png")

![输入图片说明](https://github.com/yzx66-net/ssm_lnn/blob/master/7.png "后台系统.png")

![输入图片说明](https://github.com/yzx66-net/ssm_lnn/blob/master/4.png "数据库.png")


#### 使用技术

* 后端：Spring + Spingmvc + Mybatis + 阿里云短信

* 前端：jsp + easyui + jquery + ajax + echarts

* 运行环境：阿里云 + Docker

#### 部署
* 运行 project_hotel.sql 
* 将 web / src / main / resource / db.properties 的数据库账号密码改对
* 在任何一个servlet服务器运行web模块
* 访问index.jsp即可

 
