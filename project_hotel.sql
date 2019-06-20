/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : project_hotel

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2019-06-20 17:47:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phoneNum` varchar(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `realName` varchar(255) DEFAULT NULL,
  `idCard` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `monthBreakTimes` int(11) DEFAULT NULL,
  `sumBreakTimes` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('2', 'test', 'test', '', 'test', 'test', '/lnn/upload/upload_accountPhoto/pic_b832e45c-2399-4261-b36d-8e1a81c0519e_timg.jpg', '', '1', '0', '0');
INSERT INTO `account` VALUES ('4', 'test1', 'test1', '', 'test1', 'test1', '/lnn/upload/upload_accountPhoto/pic_e48e2c73-56df-4ee8-a1eb-f1506826543e_timg693QSEY4.jpg', '', '0', '3', '3');
INSERT INTO `account` VALUES ('5', 'test2', 'test2', '', 'test2', 'test2', '/lnn/upload/upload_accountPhoto/pic_d15076e6-e9dd-486d-8748-17155c52519e_boy.png', '', '0', '2', '20');
INSERT INTO `account` VALUES ('6', 'test3', 'test3', '', 'test3', 'test3', '/lnn/upload/upload_accountPhoto/pic_7eb7ca1c-beea-4ece-a5ae-1665550c3a10_Receipt.png', '', '0', '0', '16');
INSERT INTO `account` VALUES ('7', 'test4', 'test4', '', 'test4', 'test4', '/lnn/upload/upload_accountPhoto/pic_8bf43e80-2032-4189-b5d5-295c22de5386_buqian.png', '', '1', '0', '0');
INSERT INTO `account` VALUES ('9', 'test5', 'test5', '', 'test5', 'test5', '/lnn/upload/upload_accountPhoto/pic_d9792fab-0126-44c9-b74e-b3ce0e9808df_icon-test.png', '', '1', '0', '0');
INSERT INTO `account` VALUES ('14', 'lastTest', '15656321639', '123123', '测试', 'test', '/lnn/upload/upload_accountPhoto/pic_185c9b43-6fce-40a2-8ce9-7b1f70c8f323_timg693QSEY4.jpg', '', '1', '0', '0');

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menuId` (`menuId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `authority_ibfk_1` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`),
  CONSTRAINT `authority_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1722 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES ('1589', '80', '7');
INSERT INTO `authority` VALUES ('1590', '95', '7');
INSERT INTO `authority` VALUES ('1591', '97', '7');
INSERT INTO `authority` VALUES ('1592', '98', '7');
INSERT INTO `authority` VALUES ('1593', '99', '7');
INSERT INTO `authority` VALUES ('1594', '107', '7');
INSERT INTO `authority` VALUES ('1595', '96', '7');
INSERT INTO `authority` VALUES ('1596', '101', '7');
INSERT INTO `authority` VALUES ('1597', '81', '7');
INSERT INTO `authority` VALUES ('1598', '82', '7');
INSERT INTO `authority` VALUES ('1599', '83', '7');
INSERT INTO `authority` VALUES ('1600', '85', '7');
INSERT INTO `authority` VALUES ('1601', '86', '7');
INSERT INTO `authority` VALUES ('1602', '84', '7');
INSERT INTO `authority` VALUES ('1603', '87', '7');
INSERT INTO `authority` VALUES ('1604', '88', '7');
INSERT INTO `authority` VALUES ('1605', '89', '7');
INSERT INTO `authority` VALUES ('1606', '91', '7');
INSERT INTO `authority` VALUES ('1607', '92', '7');
INSERT INTO `authority` VALUES ('1608', '93', '7');
INSERT INTO `authority` VALUES ('1609', '94', '7');
INSERT INTO `authority` VALUES ('1610', '102', '7');
INSERT INTO `authority` VALUES ('1611', '103', '7');
INSERT INTO `authority` VALUES ('1612', '104', '7');
INSERT INTO `authority` VALUES ('1613', '105', '7');
INSERT INTO `authority` VALUES ('1614', '106', '7');
INSERT INTO `authority` VALUES ('1615', '108', '7');
INSERT INTO `authority` VALUES ('1616', '109', '7');
INSERT INTO `authority` VALUES ('1617', '110', '7');
INSERT INTO `authority` VALUES ('1618', '111', '7');
INSERT INTO `authority` VALUES ('1619', '57', '7');
INSERT INTO `authority` VALUES ('1620', '59', '7');
INSERT INTO `authority` VALUES ('1621', '57', '2');
INSERT INTO `authority` VALUES ('1622', '60', '2');
INSERT INTO `authority` VALUES ('1623', '62', '2');
INSERT INTO `authority` VALUES ('1624', '63', '2');
INSERT INTO `authority` VALUES ('1625', '66', '2');
INSERT INTO `authority` VALUES ('1626', '64', '2');
INSERT INTO `authority` VALUES ('1627', '65', '2');
INSERT INTO `authority` VALUES ('1628', '67', '2');
INSERT INTO `authority` VALUES ('1629', '68', '2');
INSERT INTO `authority` VALUES ('1630', '80', '2');
INSERT INTO `authority` VALUES ('1631', '59', '2');
INSERT INTO `authority` VALUES ('1632', '69', '2');
INSERT INTO `authority` VALUES ('1633', '70', '2');
INSERT INTO `authority` VALUES ('1634', '71', '2');
INSERT INTO `authority` VALUES ('1635', '72', '2');
INSERT INTO `authority` VALUES ('1636', '95', '2');
INSERT INTO `authority` VALUES ('1637', '97', '2');
INSERT INTO `authority` VALUES ('1638', '98', '2');
INSERT INTO `authority` VALUES ('1639', '99', '2');
INSERT INTO `authority` VALUES ('1640', '107', '2');
INSERT INTO `authority` VALUES ('1641', '96', '2');
INSERT INTO `authority` VALUES ('1642', '101', '2');
INSERT INTO `authority` VALUES ('1643', '75', '2');
INSERT INTO `authority` VALUES ('1644', '76', '2');
INSERT INTO `authority` VALUES ('1645', '78', '2');
INSERT INTO `authority` VALUES ('1646', '115', '2');
INSERT INTO `authority` VALUES ('1647', '116', '2');
INSERT INTO `authority` VALUES ('1648', '117', '2');
INSERT INTO `authority` VALUES ('1649', '118', '2');
INSERT INTO `authority` VALUES ('1650', '81', '2');
INSERT INTO `authority` VALUES ('1651', '82', '2');
INSERT INTO `authority` VALUES ('1652', '83', '2');
INSERT INTO `authority` VALUES ('1653', '85', '2');
INSERT INTO `authority` VALUES ('1654', '86', '2');
INSERT INTO `authority` VALUES ('1655', '84', '2');
INSERT INTO `authority` VALUES ('1656', '87', '2');
INSERT INTO `authority` VALUES ('1657', '88', '2');
INSERT INTO `authority` VALUES ('1658', '89', '2');
INSERT INTO `authority` VALUES ('1659', '91', '2');
INSERT INTO `authority` VALUES ('1660', '92', '2');
INSERT INTO `authority` VALUES ('1661', '93', '2');
INSERT INTO `authority` VALUES ('1662', '94', '2');
INSERT INTO `authority` VALUES ('1663', '102', '2');
INSERT INTO `authority` VALUES ('1664', '103', '2');
INSERT INTO `authority` VALUES ('1665', '104', '2');
INSERT INTO `authority` VALUES ('1666', '105', '2');
INSERT INTO `authority` VALUES ('1667', '106', '2');
INSERT INTO `authority` VALUES ('1668', '108', '2');
INSERT INTO `authority` VALUES ('1669', '109', '2');
INSERT INTO `authority` VALUES ('1670', '110', '2');
INSERT INTO `authority` VALUES ('1671', '111', '2');
INSERT INTO `authority` VALUES ('1672', '112', '2');
INSERT INTO `authority` VALUES ('1673', '113', '2');
INSERT INTO `authority` VALUES ('1674', '114', '2');
INSERT INTO `authority` VALUES ('1675', '65', '3');
INSERT INTO `authority` VALUES ('1676', '68', '3');
INSERT INTO `authority` VALUES ('1677', '80', '3');
INSERT INTO `authority` VALUES ('1678', '59', '3');
INSERT INTO `authority` VALUES ('1679', '69', '3');
INSERT INTO `authority` VALUES ('1680', '70', '3');
INSERT INTO `authority` VALUES ('1681', '71', '3');
INSERT INTO `authority` VALUES ('1682', '72', '3');
INSERT INTO `authority` VALUES ('1683', '95', '3');
INSERT INTO `authority` VALUES ('1684', '97', '3');
INSERT INTO `authority` VALUES ('1685', '98', '3');
INSERT INTO `authority` VALUES ('1686', '99', '3');
INSERT INTO `authority` VALUES ('1687', '107', '3');
INSERT INTO `authority` VALUES ('1688', '96', '3');
INSERT INTO `authority` VALUES ('1689', '101', '3');
INSERT INTO `authority` VALUES ('1690', '115', '3');
INSERT INTO `authority` VALUES ('1691', '116', '3');
INSERT INTO `authority` VALUES ('1692', '117', '3');
INSERT INTO `authority` VALUES ('1693', '118', '3');
INSERT INTO `authority` VALUES ('1694', '81', '3');
INSERT INTO `authority` VALUES ('1695', '82', '3');
INSERT INTO `authority` VALUES ('1696', '83', '3');
INSERT INTO `authority` VALUES ('1697', '85', '3');
INSERT INTO `authority` VALUES ('1698', '86', '3');
INSERT INTO `authority` VALUES ('1699', '84', '3');
INSERT INTO `authority` VALUES ('1700', '87', '3');
INSERT INTO `authority` VALUES ('1701', '88', '3');
INSERT INTO `authority` VALUES ('1702', '89', '3');
INSERT INTO `authority` VALUES ('1703', '91', '3');
INSERT INTO `authority` VALUES ('1704', '92', '3');
INSERT INTO `authority` VALUES ('1705', '93', '3');
INSERT INTO `authority` VALUES ('1706', '94', '3');
INSERT INTO `authority` VALUES ('1707', '102', '3');
INSERT INTO `authority` VALUES ('1708', '103', '3');
INSERT INTO `authority` VALUES ('1709', '104', '3');
INSERT INTO `authority` VALUES ('1710', '105', '3');
INSERT INTO `authority` VALUES ('1711', '106', '3');
INSERT INTO `authority` VALUES ('1712', '108', '3');
INSERT INTO `authority` VALUES ('1713', '109', '3');
INSERT INTO `authority` VALUES ('1714', '110', '3');
INSERT INTO `authority` VALUES ('1715', '111', '3');
INSERT INTO `authority` VALUES ('1716', '112', '3');
INSERT INTO `authority` VALUES ('1717', '113', '3');
INSERT INTO `authority` VALUES ('1718', '114', '3');
INSERT INTO `authority` VALUES ('1719', '57', '3');
INSERT INTO `authority` VALUES ('1720', '64', '3');
INSERT INTO `authority` VALUES ('1721', '75', '3');

-- ----------------------------
-- Table structure for blacklist
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) DEFAULT NULL,
  `inTime` datetime DEFAULT NULL,
  `outTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `blacklist_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blacklist
-- ----------------------------
INSERT INTO `blacklist` VALUES ('82', '6', '2019-06-15 06:20:20', '1970-01-01 00:00:00');
INSERT INTO `blacklist` VALUES ('85', '5', '2019-06-15 07:43:35', '1970-01-01 00:00:00');
INSERT INTO `blacklist` VALUES ('86', '7', '2019-06-15 07:54:34', '1970-01-01 00:00:00');
INSERT INTO `blacklist` VALUES ('89', '4', '2019-06-20 02:08:58', '2019-07-20 02:08:58');

-- ----------------------------
-- Table structure for bookorder
-- ----------------------------
DROP TABLE IF EXISTS `bookorder`;
CREATE TABLE `bookorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) DEFAULT NULL,
  `roomTypeId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `idCard` varchar(255) DEFAULT NULL,
  `phoneNum` varchar(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `arriveDate` datetime DEFAULT NULL,
  `leaveDate` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accountId` (`accountId`),
  KEY `roomTypeId` (`roomTypeId`),
  CONSTRAINT `bookorder_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`),
  CONSTRAINT `bookorder_ibfk_2` FOREIGN KEY (`roomTypeId`) REFERENCES `room_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bookorder
-- ----------------------------
INSERT INTO `bookorder` VALUES ('14', '5', '22', '3333', '1', '1', '3', '2019-06-07 00:00:00', '2019-06-11 00:00:00', '2019-06-16 22:12:42', '');
INSERT INTO `bookorder` VALUES ('15', '9', '21', '3333', '1', '100', '3', '2019-06-15 00:00:00', '2019-06-16 00:00:00', '2019-06-16 23:43:44', '');
INSERT INTO `bookorder` VALUES ('20', '9', '20', '3333', '1', '1', '3', '2019-06-16 00:00:00', '2019-06-17 00:00:00', '2019-06-17 00:03:37', '');
INSERT INTO `bookorder` VALUES ('21', '9', '20', '3333', '1', '1', '3', '2019-06-17 00:00:00', '2019-06-17 00:00:00', '2019-06-17 00:03:58', '');
INSERT INTO `bookorder` VALUES ('22', '9', '20', 'admin', '1', '100', '2', '2019-06-29 00:00:00', '2019-06-30 00:00:00', '2019-06-17 00:06:23', '');
INSERT INTO `bookorder` VALUES ('23', '9', '21', '3333', '1', '1', '2', '2019-06-17 00:00:00', '2019-06-18 00:00:00', '2019-06-17 15:08:35', '');
INSERT INTO `bookorder` VALUES ('24', '9', '22', '3333', '1', '100', '2', '2019-06-29 00:00:00', '2019-06-30 00:00:00', '2019-06-17 18:26:12', '');
INSERT INTO `bookorder` VALUES ('25', '9', '21', '3333', '1', '1', '2', '2019-06-17 00:00:00', '2019-06-30 00:00:00', '2019-06-17 20:19:51', '');
INSERT INTO `bookorder` VALUES ('26', '9', '22', 'admin', 'aaaa', '1', '3', '2019-06-17 00:00:00', '2019-06-18 00:00:00', '2019-06-17 20:20:06', '');
INSERT INTO `bookorder` VALUES ('31', '9', '20', '09', '1', '123', '2', '2019-06-20 00:00:00', '2019-06-20 00:00:00', '2019-06-18 05:23:52', '');
INSERT INTO `bookorder` VALUES ('32', '9', '20', '09', '1', '123', '2', '2019-06-21 00:00:00', '2019-06-30 00:00:00', '2019-06-18 14:38:31', '99999');
INSERT INTO `bookorder` VALUES ('33', '9', '21', '09', '1', '123', '2', '2019-06-29 00:00:00', '2019-06-30 00:00:00', '2019-06-18 14:40:35', '890');
INSERT INTO `bookorder` VALUES ('38', '9', '24', '09', '1', '123', '2', '2019-06-27 00:00:00', '2019-06-30 00:00:00', '2019-06-18 14:43:37', '99999');
INSERT INTO `bookorder` VALUES ('39', '9', '22', '09', '1', '123', '2', '2019-06-24 00:00:00', '2019-06-30 00:00:00', '2019-06-18 17:01:29', '');
INSERT INTO `bookorder` VALUES ('40', '9', '20', '09', '1', '123', '2', '2019-06-18 00:00:00', '2019-06-19 00:00:00', '2019-06-18 17:05:51', 'aaa');
INSERT INTO `bookorder` VALUES ('64', '14', '25', '测试', '610103200006203613', '15656321639', '1', '2019-06-20 00:00:00', '2019-06-22 00:00:00', '2019-06-20 06:49:51', '');
INSERT INTO `bookorder` VALUES ('65', '14', '20', '测试', '610103200006203613', '15656321639', '1', '2019-06-20 00:00:00', '2019-06-29 00:00:00', '2019-06-20 07:20:55', '');
INSERT INTO `bookorder` VALUES ('66', '14', '38', '测试', '610103200006203613', '15656321639', '0', '2019-06-20 00:00:00', '2019-06-29 00:00:00', '2019-06-20 07:51:15', '');

-- ----------------------------
-- Table structure for checkin
-- ----------------------------
DROP TABLE IF EXISTS `checkin`;
CREATE TABLE `checkin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roomId` int(11) NOT NULL,
  `checkinPrice` float DEFAULT NULL,
  `liveDays` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `idCard` varchar(255) DEFAULT NULL,
  `phoneNum` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `arriveDate` datetime DEFAULT NULL,
  `leaveDate` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  `bookOrderId` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roomId` (`roomId`),
  KEY `bookOrderId` (`bookOrderId`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `checkin_ibfk_1` FOREIGN KEY (`roomId`) REFERENCES `room` (`id`),
  CONSTRAINT `checkin_ibfk_2` FOREIGN KEY (`bookOrderId`) REFERENCES `bookorder` (`id`),
  CONSTRAINT `checkin_ibfk_3` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of checkin
-- ----------------------------
INSERT INTO `checkin` VALUES ('1', '11', '90', '0', '3333', '1', '100', '1', '2019-06-29 00:00:00', '2019-06-30 00:00:00', '2019-06-17 18:27:14', null, '24', '');
INSERT INTO `checkin` VALUES ('4', '11', '90', '8', 'admin', '1', '100', '1', '2019-06-22 00:00:00', '2019-06-30 00:00:00', '2019-06-17 19:41:55', null, null, '');
INSERT INTO `checkin` VALUES ('5', '9', '90', '1', 'admin', '1', '100', '1', '2019-06-29 00:00:00', '2019-06-30 00:00:00', '2019-06-17 19:53:49', '9', '22', '');
INSERT INTO `checkin` VALUES ('8', '9', '90', '13', 'admin', '1', '100', '1', '2019-06-17 00:00:00', '2019-06-30 00:00:00', '2019-06-17 20:18:26', null, null, '');
INSERT INTO `checkin` VALUES ('9', '10', '90', '13', '3333', '1', '1', '1', '2019-06-17 00:00:00', '2019-06-30 00:00:00', '2019-06-17 20:20:16', '9', '25', '');
INSERT INTO `checkin` VALUES ('11', '12', '80', '4', '09', '1', '123', '1', '2019-06-18 00:00:00', '2019-06-22 00:00:00', '2019-06-18 05:25:12', '9', '31', '');
INSERT INTO `checkin` VALUES ('12', '9', '120', '1', '09', '1', '123', '1', '2019-06-18 00:00:00', '2019-06-19 00:00:00', '2019-06-18 17:07:58', '9', '40', 'aaa');
INSERT INTO `checkin` VALUES ('14', '14', '90', '4', 'admin', '234', '1', '1', '2019-06-19 00:00:00', '2019-06-23 00:00:00', '2019-06-19 01:36:18', null, null, '');
INSERT INTO `checkin` VALUES ('18', '9', '90', '10', '一样', '610103200006203613', '13325456805', '1', '2019-06-19 00:00:00', '2019-06-29 00:00:00', '2019-06-19 19:41:19', null, null, '');
INSERT INTO `checkin` VALUES ('19', '12', '90', '10', '一样', '610103200006203613', '13325456805', '1', '2019-06-19 00:00:00', '2019-06-29 00:00:00', '2019-06-19 19:55:05', null, null, '');
INSERT INTO `checkin` VALUES ('20', '14', '1000', '10', '一样', '610103200006203613', '13325456805', '1', '2019-06-19 00:00:00', '2019-06-29 00:00:00', '2019-06-19 21:57:08', null, null, '');
INSERT INTO `checkin` VALUES ('21', '15', '1000', '10', '一样', '610103200006203613', '13325456805', '1', '2019-06-19 00:00:00', '2019-06-29 00:00:00', '2019-06-19 21:59:50', null, null, '');
INSERT INTO `checkin` VALUES ('27', '14', '1782', '9', '测试', '610103200006203613', '15656321639', '1', '2019-06-20 00:00:00', '2019-06-29 00:00:00', '2019-06-20 02:56:54', '9', null, '');
INSERT INTO `checkin` VALUES ('28', '12', '990', '9', '测试', '610103200006203613', '15656321639', '1', '2019-06-20 00:00:00', '2019-06-29 00:00:00', '2019-06-20 05:40:17', '14', null, '');
INSERT INTO `checkin` VALUES ('29', '15', '90', '1', '测试', '610103200006203613', '15656321639', '1', '2019-06-20 00:00:00', '2019-06-21 00:00:00', '2019-06-20 06:09:39', '14', null, '');
INSERT INTO `checkin` VALUES ('30', '12', '180', '2', '测试', '610103200006203613', '15656321639', '1', '2019-06-20 00:00:00', '2019-06-22 00:00:00', '2019-06-20 06:35:17', '14', null, '');
INSERT INTO `checkin` VALUES ('31', '15', '180', '2', '测试', '610103200006203613', '15656321639', '0', '2019-06-20 00:00:00', '2019-06-22 00:00:00', '2019-06-20 06:50:14', '14', '64', '');
INSERT INTO `checkin` VALUES ('32', '14', '810', '9', '测试', '610103200006203613', '15656321639', '0', '2019-06-20 00:00:00', '2019-06-29 00:00:00', '2019-06-20 07:21:40', '14', '65', '');
INSERT INTO `checkin` VALUES ('33', '10', '180', '2', 'admin', '610103200006203613', '15656321639', '0', '2019-06-20 00:00:00', '2019-06-22 00:00:00', '2019-06-20 07:42:17', null, null, '');
INSERT INTO `checkin` VALUES ('35', '31', '180', '2', '3333', '1', '1', '0', '2019-06-20 00:00:00', '2019-06-22 00:00:00', '2019-06-20 09:22:17', null, null, '');

-- ----------------------------
-- Table structure for floor
-- ----------------------------
DROP TABLE IF EXISTS `floor`;
CREATE TABLE `floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hight` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of floor
-- ----------------------------
INSERT INTO `floor` VALUES ('2', '1', '第一层：普客房', '');
INSERT INTO `floor` VALUES ('3', '2', '第二层：普客房', null);
INSERT INTO `floor` VALUES ('4', '3', '第三层：普客房+商务房', null);
INSERT INTO `floor` VALUES ('5', '4', '第四层：商务房+豪华房', null);
INSERT INTO `floor` VALUES ('6', '5', '第五层：总统套房', null);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tittle` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('385', '后台登陆', '用户名为：admin 退出登陆', '2019-06-19 23:58:57', '1');
INSERT INTO `log` VALUES ('386', '后台登陆', '用户名为：admin 登陆成功', '2019-06-19 23:59:00', '1');
INSERT INTO `log` VALUES ('387', '管理修改密码', '用户名为：admin 修改密码失败（新旧密码不一致）', '2019-06-19 23:59:41', '1');
INSERT INTO `log` VALUES ('388', '管理修改密码', '用户名为：admin 修改密码失败（新旧密码不一致）', '2019-06-19 23:59:43', '1');
INSERT INTO `log` VALUES ('389', '管理修改密码', '用户名为：admin 修改密码失败（新旧密码不一致）', '2019-06-19 23:59:44', '1');
INSERT INTO `log` VALUES ('390', '管理修改密码', '用户名为：admin 修改密码成功', '2019-06-19 23:59:56', '1');
INSERT INTO `log` VALUES ('391', '管理修改密码', '用户名为：admin 修改密码成功', '2019-06-20 00:03:10', '1');
INSERT INTO `log` VALUES ('392', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 00:05:46', '1');
INSERT INTO `log` VALUES ('393', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 00:05:46', '1');
INSERT INTO `log` VALUES ('394', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 00:06:55', '1');
INSERT INTO `log` VALUES ('395', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 00:09:40', '1');
INSERT INTO `log` VALUES ('396', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 00:11:52', '1');
INSERT INTO `log` VALUES ('397', '登陆信息', '手机号为13325456805登陆成功', '2019-06-20 01:03:53', '3');
INSERT INTO `log` VALUES ('398', '后台登陆', '用户名为：13325456805 不存在', '2019-06-20 01:04:04', '1');
INSERT INTO `log` VALUES ('399', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 01:04:08', '1');
INSERT INTO `log` VALUES ('400', '实名认证', '用户名：一样实名认证成功', '2019-06-20 01:04:34', '1');
INSERT INTO `log` VALUES ('401', '实名认证', '用户名：一样实名认证成功', '2019-06-20 01:04:42', '1');
INSERT INTO `log` VALUES ('402', '预定成功', '手机号为13325456805预定成功', '2019-06-20 01:04:42', '2');
INSERT INTO `log` VALUES ('403', '实名认证', '用户名：一样实名认证成功', '2019-06-20 01:05:05', '1');
INSERT INTO `log` VALUES ('404', '预定成功', '手机号为13325456805预定修改成功', '2019-06-20 01:05:05', '2');
INSERT INTO `log` VALUES ('405', '入住记录', '手机号为13325456805入住成功', '2019-06-20 01:06:21', '2');
INSERT INTO `log` VALUES ('406', '删除入住', '手机号为13325456805入住记录被删除', '2019-06-20 01:06:54', '2');
INSERT INTO `log` VALUES ('407', '入住记录', '手机号为13325456805入住成功', '2019-06-20 01:08:54', '2');
INSERT INTO `log` VALUES ('408', '删除入住', '手机号为13325456805入住记录被删除', '2019-06-20 01:08:58', '2');
INSERT INTO `log` VALUES ('409', '入住记录', '手机号为1入住成功', '2019-06-20 01:09:30', '2');
INSERT INTO `log` VALUES ('410', '退房记录', '手机号为1退房成功', '2019-06-20 01:09:34', '2');
INSERT INTO `log` VALUES ('411', '入住记录', '手机号为13325456805入住成功', '2019-06-20 01:10:02', '2');
INSERT INTO `log` VALUES ('412', '删除入住', '手机号为13325456805入住记录被删除', '2019-06-20 01:10:07', '2');
INSERT INTO `log` VALUES ('413', '修改信息', '手机号为100信息修改成功', '2019-06-20 02:02:17', '3');
INSERT INTO `log` VALUES ('414', '修改信息', '手机号为test信息修改成功', '2019-06-20 02:02:40', '3');
INSERT INTO `log` VALUES ('415', '修改信息', '手机号为test1信息修改成功', '2019-06-20 02:02:52', '3');
INSERT INTO `log` VALUES ('416', '修改信息', '手机号为test2信息修改成功', '2019-06-20 02:03:27', '3');
INSERT INTO `log` VALUES ('417', '修改信息', '手机号为test3信息修改成功', '2019-06-20 02:03:53', '3');
INSERT INTO `log` VALUES ('418', '修改信息', '手机号为test4信息修改成功', '2019-06-20 02:04:13', '3');
INSERT INTO `log` VALUES ('419', '修改信息', '手机号为test5信息修改成功', '2019-06-20 02:05:46', '3');
INSERT INTO `log` VALUES ('420', '修改信息', '手机号为13325456805信息修改成功', '2019-06-20 02:06:58', '3');
INSERT INTO `log` VALUES ('421', '修改信息', '手机号为13325456805信息修改成功', '2019-06-20 02:07:35', '3');
INSERT INTO `log` VALUES ('422', '黑名单', '手机号为test1的用户违约次数达月上限被加黑一月', '2019-06-20 02:08:58', '3');
INSERT INTO `log` VALUES ('423', '发送验证码', '发送短信验证码回调：', '2019-06-20 02:34:09', '1');
INSERT INTO `log` VALUES ('424', '发送验证码', '发送短信验证码回调：SendBack{Message=\'OK\', RequestId=\'27A3A357-B64F-406D-90A7-19B84EF7CE81\', BizId=\'765010260969248844^0\', Code=\'OK\'}', '2019-06-20 02:34:11', '1');
INSERT INTO `log` VALUES ('425', '注册信息', '手机号为15656321639注册成功', '2019-06-20 02:34:32', '3');
INSERT INTO `log` VALUES ('426', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 02:34:48', '3');
INSERT INTO `log` VALUES ('427', '修改信息', '手机号为15656321639修改信息成功', '2019-06-20 02:44:38', '3');
INSERT INTO `log` VALUES ('428', '实名认证', '手机号为15656321639实名认证失败', '2019-06-20 02:44:47', '3');
INSERT INTO `log` VALUES ('429', '实名认证', '用户名：测试实名认证失败，原因：请输入正确的15或18位身份证', '2019-06-20 02:44:56', '1');
INSERT INTO `log` VALUES ('430', '实名认证', '手机号为15656321639实名认证失败', '2019-06-20 02:44:56', '3');
INSERT INTO `log` VALUES ('431', '实名认证', '用户名：测试实名认证成功', '2019-06-20 02:45:10', '1');
INSERT INTO `log` VALUES ('432', '实名认证', '手机号为15656321639实名认证成功', '2019-06-20 02:45:10', '3');
INSERT INTO `log` VALUES ('433', '修改信息', '手机号为15656321639修改信息成功', '2019-06-20 02:45:10', '3');
INSERT INTO `log` VALUES ('434', '实名认证', '用户名：测试实名认证成功', '2019-06-20 02:46:25', '1');
INSERT INTO `log` VALUES ('435', '预定成功', '手机号为15656321639预定成功', '2019-06-20 02:46:25', '2');
INSERT INTO `log` VALUES ('436', '实名认证', '用户名：测试实名认证成功', '2019-06-20 02:46:56', '1');
INSERT INTO `log` VALUES ('437', '预定成功', '手机号为15656321639预定修改成功', '2019-06-20 02:46:56', '2');
INSERT INTO `log` VALUES ('438', '登陆信息', '手机号为15656321639退出', '2019-06-20 02:52:54', '3');
INSERT INTO `log` VALUES ('439', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 02:53:32', '3');
INSERT INTO `log` VALUES ('440', '后台登陆', '用户名为：15656321639 输入验证码错误', '2019-06-20 02:53:54', '1');
INSERT INTO `log` VALUES ('441', '后台登陆', '用户名为：admin3 输入验证码错误', '2019-06-20 02:54:04', '1');
INSERT INTO `log` VALUES ('442', '后台登陆', '用户名为：admin3 不存在', '2019-06-20 02:54:10', '1');
INSERT INTO `log` VALUES ('443', '后台登陆', '用户名为：test 登陆成功', '2019-06-20 02:54:27', '1');
INSERT INTO `log` VALUES ('444', '后台登陆', '用户名为：test 退出登陆', '2019-06-20 02:55:02', '1');
INSERT INTO `log` VALUES ('445', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 02:55:10', '1');
INSERT INTO `log` VALUES ('446', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 02:56:10', '3');
INSERT INTO `log` VALUES ('447', '实名认证', '用户名：测试实名认证成功', '2019-06-20 02:56:19', '1');
INSERT INTO `log` VALUES ('448', '预定成功', '手机号为15656321639预定成功', '2019-06-20 02:56:19', '2');
INSERT INTO `log` VALUES ('449', '实名认证', '用户名：测试实名认证成功', '2019-06-20 02:56:28', '1');
INSERT INTO `log` VALUES ('450', '预定成功', '手机号为15656321639预定修改成功', '2019-06-20 02:56:28', '2');
INSERT INTO `log` VALUES ('451', '入住记录', '手机号为15656321639入住成功', '2019-06-20 02:56:54', '2');
INSERT INTO `log` VALUES ('452', '淇敼淇℃伅', '鎵嬫満鍙蜂负15656321639淇℃伅淇敼鎴愬姛', '2019-06-20 02:57:55', '3');
INSERT INTO `log` VALUES ('453', '退房记录', '手机号为15656321639退房成功', '2019-06-20 02:58:46', '2');
INSERT INTO `log` VALUES ('454', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 05:38:53', '3');
INSERT INTO `log` VALUES ('455', '实名认证', '用户名：测试实名认证成功', '2019-06-20 05:39:17', '1');
INSERT INTO `log` VALUES ('456', '预定成功', '手机号为15656321639预定成功', '2019-06-20 05:39:17', '2');
INSERT INTO `log` VALUES ('457', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 05:39:50', '1');
INSERT INTO `log` VALUES ('458', '鍏ヤ綇璁板綍', '鎵嬫満鍙蜂负15656321639鍏ヤ綇鎴愬姛', '2019-06-20 05:40:17', '2');
INSERT INTO `log` VALUES ('459', '閫�鎴胯褰�', '鎵嬫満鍙蜂负15656321639閫�鎴挎垚鍔�', '2019-06-20 05:40:31', '2');
INSERT INTO `log` VALUES ('460', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 05:46:48', '1');
INSERT INTO `log` VALUES ('461', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 05:54:36', '1');
INSERT INTO `log` VALUES ('462', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 06:08:32', '1');
INSERT INTO `log` VALUES ('463', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 06:09:04', '3');
INSERT INTO `log` VALUES ('464', '实名认证', '用户名：测试实名认证成功', '2019-06-20 06:09:22', '1');
INSERT INTO `log` VALUES ('465', '预定成功', '手机号为15656321639预定成功', '2019-06-20 06:09:22', '2');
INSERT INTO `log` VALUES ('466', '鍏ヤ綇璁板綍', '鎵嬫満鍙蜂负15656321639鍏ヤ綇鎴愬姛', '2019-06-20 06:09:39', '2');
INSERT INTO `log` VALUES ('467', '閫�鎴胯褰�', '鎵嬫満鍙蜂负15656321639閫�鎴挎垚鍔�', '2019-06-20 06:09:49', '2');
INSERT INTO `log` VALUES ('468', '实名认证', '用户名：测试实名认证成功', '2019-06-20 06:34:26', '1');
INSERT INTO `log` VALUES ('469', '预定成功', '手机号为15656321639预定成功', '2019-06-20 06:34:26', '2');
INSERT INTO `log` VALUES ('470', '预定删除失败', '房间正在入住', '2019-06-20 06:34:29', '2');
INSERT INTO `log` VALUES ('471', '预定删除失败', '房间正在入住', '2019-06-20 06:34:35', '2');
INSERT INTO `log` VALUES ('472', '鍏ヤ綇璁板綍', '鎵嬫満鍙蜂负15656321639鍏ヤ綇鎴愬姛', '2019-06-20 06:35:17', '2');
INSERT INTO `log` VALUES ('473', '閫�鎴胯褰�', '鎵嬫満鍙蜂负15656321639閫�鎴挎垚鍔�', '2019-06-20 06:35:24', '2');
INSERT INTO `log` VALUES ('474', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 06:49:38', '3');
INSERT INTO `log` VALUES ('475', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 06:49:38', '3');
INSERT INTO `log` VALUES ('476', '实名认证', '用户名：测试实名认证成功', '2019-06-20 06:49:51', '1');
INSERT INTO `log` VALUES ('477', '预定成功', '手机号为15656321639预定成功', '2019-06-20 06:49:51', '2');
INSERT INTO `log` VALUES ('478', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 06:50:01', '1');
INSERT INTO `log` VALUES ('479', '入住记录', '手机号为15656321639入住成功', '2019-06-20 06:50:14', '2');
INSERT INTO `log` VALUES ('480', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 07:20:16', '3');
INSERT INTO `log` VALUES ('481', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 07:20:17', '3');
INSERT INTO `log` VALUES ('482', '实名认证', '用户名：测试实名认证成功', '2019-06-20 07:20:55', '1');
INSERT INTO `log` VALUES ('483', '预定成功', '手机号为15656321639预定成功', '2019-06-20 07:20:55', '2');
INSERT INTO `log` VALUES ('484', '后台登陆', '用户名为：admin 输入验证码错误', '2019-06-20 07:21:12', '1');
INSERT INTO `log` VALUES ('485', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 07:21:23', '1');
INSERT INTO `log` VALUES ('486', 'test', '0', '2019-06-20 07:21:40', '1');
INSERT INTO `log` VALUES ('487', 'test', '1', '2019-06-20 07:21:40', '1');
INSERT INTO `log` VALUES ('488', 'test', '2', '2019-06-20 07:21:40', '1');
INSERT INTO `log` VALUES ('489', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 07:41:42', '1');
INSERT INTO `log` VALUES ('490', '登陆信息', '手机号为15656321639登陆成功', '2019-06-20 07:50:53', '3');
INSERT INTO `log` VALUES ('491', '实名认证', '用户名：测试实名认证成功', '2019-06-20 07:51:15', '1');
INSERT INTO `log` VALUES ('492', '预定成功', '手机号为15656321639预定成功', '2019-06-20 07:51:15', '2');
INSERT INTO `log` VALUES ('493', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 09:15:24', '1');
INSERT INTO `log` VALUES ('494', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 09:15:24', '1');
INSERT INTO `log` VALUES ('495', 'test', '0', '2019-06-20 09:15:53', '1');
INSERT INTO `log` VALUES ('496', '后台登陆', '用户名为：admin 输入验证码错误', '2019-06-20 09:17:53', '1');
INSERT INTO `log` VALUES ('497', '后台登陆', '用户名为：admin 输入验证码错误', '2019-06-20 09:18:00', '1');
INSERT INTO `log` VALUES ('498', '后台登陆', '用户名为：admin 输入验证码错误', '2019-06-20 09:18:05', '1');
INSERT INTO `log` VALUES ('499', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 09:18:12', '1');
INSERT INTO `log` VALUES ('500', 'test', '0', '2019-06-20 09:18:35', '1');
INSERT INTO `log` VALUES ('501', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 09:21:59', '1');
INSERT INTO `log` VALUES ('502', 'test', '0', '2019-06-20 09:22:17', '1');
INSERT INTO `log` VALUES ('503', '后台登陆', '用户名为：admin 输入验证码错误', '2019-06-20 10:06:06', '1');
INSERT INTO `log` VALUES ('504', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 10:06:13', '1');
INSERT INTO `log` VALUES ('505', '后台登陆', '用户名为：admin 输入验证码错误', '2019-06-20 10:13:31', '1');
INSERT INTO `log` VALUES ('506', '后台登陆', '用户名为：admin 登陆成功', '2019-06-20 10:13:37', '1');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` mediumtext,
  `_parentId` mediumtext,
  `name` varchar(50) DEFAULT NULL,
  `url` varchar(225) DEFAULT NULL,
  `icon` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('57', '0', null, '系统设置', '', 'cog');
INSERT INTO `menu` VALUES ('59', '0', null, '用户管理', '', 'user');
INSERT INTO `menu` VALUES ('60', '57', null, '菜单管理', '/admin/menu/list', 'application');
INSERT INTO `menu` VALUES ('62', '60', null, '添加', 'openAdd()', 'add');
INSERT INTO `menu` VALUES ('63', '60', null, '删除', 'remove()', 'delete3');
INSERT INTO `menu` VALUES ('64', '57', null, '角色管理', '/admin/role/list', 'group');
INSERT INTO `menu` VALUES ('65', '64', null, '添加', 'openAdd()', 'add1');
INSERT INTO `menu` VALUES ('66', '60', null, '修改', 'openEdit()', 'pencil');
INSERT INTO `menu` VALUES ('67', '64', null, '删除', 'remove()', 'delete3');
INSERT INTO `menu` VALUES ('68', '64', null, '修改', 'openEdit()', 'pencil');
INSERT INTO `menu` VALUES ('69', '59', null, '管理员列表', '/admin/user/list', 'users');
INSERT INTO `menu` VALUES ('70', '69', null, '添加', 'openAdd()', 'add1');
INSERT INTO `menu` VALUES ('71', '69', null, '删除', 'remove()', 'delete3');
INSERT INTO `menu` VALUES ('72', '69', null, '修改', 'openEdit()', 'wand');
INSERT INTO `menu` VALUES ('75', '0', null, '日志管理', '', 'theme');
INSERT INTO `menu` VALUES ('76', '75', null, '系统日志', '/admin/log/system/list', 'script');
INSERT INTO `menu` VALUES ('78', '76', null, '删除', 'remove()', 'delete3');
INSERT INTO `menu` VALUES ('80', '57', null, '修改密码', '/admin/system/edit-password', 'lock');
INSERT INTO `menu` VALUES ('81', '0', null, '楼房管理', '', 'building');
INSERT INTO `menu` VALUES ('82', '81', null, '楼层列表', '/admin/floor/list', 'bell');
INSERT INTO `menu` VALUES ('83', '82', null, '添加', 'openAdd()', 'add1');
INSERT INTO `menu` VALUES ('84', '81', null, '房型管理', '/admin/room_type/list', 'star');
INSERT INTO `menu` VALUES ('85', '82', null, '删除', 'remove()', 'delete3');
INSERT INTO `menu` VALUES ('86', '82', null, '修改', 'openEdit()', 'pencil');
INSERT INTO `menu` VALUES ('87', '84', null, '添加', 'openAdd()', 'add1');
INSERT INTO `menu` VALUES ('88', '84', null, '删除', 'remove()', 'delete3');
INSERT INTO `menu` VALUES ('89', '84', null, '修改', 'openEdit()', 'pencil');
INSERT INTO `menu` VALUES ('91', '81', null, '房间管理', '/admin/room/list', 'house');
INSERT INTO `menu` VALUES ('92', '91', null, '添加', 'openAdd()', 'add1');
INSERT INTO `menu` VALUES ('93', '91', null, '删除', 'remove()', 'delete');
INSERT INTO `menu` VALUES ('94', '91', null, '修改', 'openEdit()', 'disconnect');
INSERT INTO `menu` VALUES ('95', '59', null, '客户列表', '/admin/account/list', 'tux');
INSERT INTO `menu` VALUES ('96', '59', null, '黑名单列表', '/admin/blackList/list', 'anchor');
INSERT INTO `menu` VALUES ('97', '95', null, '添加', 'openAdd()', 'add1');
INSERT INTO `menu` VALUES ('98', '95', null, '删除', 'remove()', 'delete');
INSERT INTO `menu` VALUES ('99', '95', null, '修改', 'openEdit()', 'connect');
INSERT INTO `menu` VALUES ('101', '96', null, '删除', 'remove()', 'delete');
INSERT INTO `menu` VALUES ('102', '0', null, '订单管理', '', 'disk');
INSERT INTO `menu` VALUES ('103', '102', null, '预定订单列表', '/admin/bookOrder/list', 'textfield');
INSERT INTO `menu` VALUES ('104', '103', null, '添加', 'openAdd()', 'add1');
INSERT INTO `menu` VALUES ('105', '103', null, '删除', 'remove()', 'cross');
INSERT INTO `menu` VALUES ('106', '103', null, '修改', 'openEdit()', 'pencil');
INSERT INTO `menu` VALUES ('107', '95', null, '加入黑名单', 'deleteForever()', 'stop');
INSERT INTO `menu` VALUES ('108', '102', null, '入住与退房', '/admin/checkIn/list', 'script');
INSERT INTO `menu` VALUES ('109', '108', null, '入住', 'openAdd()', 'cart');
INSERT INTO `menu` VALUES ('110', '108', null, '删除', 'remove()', 'delete');
INSERT INTO `menu` VALUES ('111', '108', null, '退房', 'back()', 'coins');
INSERT INTO `menu` VALUES ('112', '102', null, '营业额统计', '/admin/stats/list', 'note');
INSERT INTO `menu` VALUES ('113', '112', null, '按日统计', 'statsByDay()', 'plugin');
INSERT INTO `menu` VALUES ('114', '112', null, '按月统计', 'statsByMonth()', 'shading');
INSERT INTO `menu` VALUES ('115', '75', null, '营业记录', '/admin/log/bussiness/list', 'eye');
INSERT INTO `menu` VALUES ('116', '115', null, '删除', 'remove()', 'delete');
INSERT INTO `menu` VALUES ('117', '75', null, '客户记录', '/admin/log/account/list', 'note');
INSERT INTO `menu` VALUES ('118', '117', null, '删除', 'remove()', 'delete3');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('2', '超级管理员', '开发人员维护使用，有百分百功能');
INSERT INTO `role` VALUES ('3', '一般管理员', '领导使用，屏蔽部分功能，防止破坏系统设置');
INSERT INTO `role` VALUES ('7', '工作人员', '普通员工使用，比领导再屏蔽一些管理功能与房间记录日志');

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `sn` varchar(50) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `roomTypeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roomTypeId` (`roomTypeId`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`roomTypeId`) REFERENCES `room_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('9', '1号房-101', 's1-101', '/lnn/upload/upload_roomType/pic_45711b61-7f9a-46cf-a98c-4446d8c11762_timg.jpg', '0', '', '20');
INSERT INTO `room` VALUES ('10', '2号房-201', 's2-201', '/lnn/upload/upload_roomType/pic_bb5fa1b5-e9b5-46ca-893b-6288dcdebbbf_timg3.jpg', '2', '', '21');
INSERT INTO `room` VALUES ('11', '3号房-301', 's3-301', '/lnn/upload/upload_roomType/pic_cf45a6b6-c5ec-4864-bc0e-f0898079579d_timg1.jpg', '2', '', '22');
INSERT INTO `room` VALUES ('12', '1号房-102', 's1-102', '/lnn/upload/upload_roomType/pic_45711b61-7f9a-46cf-a98c-4446d8c11762_timg.jpg', '0', '', '20');
INSERT INTO `room` VALUES ('13', '4号房-401', 's4-101', '/lnn/upload/upload_roomType/pic_d6fe56db-7ef3-4a65-afd8-34ecc76a964e_timg2.jpg', '0', '', '24');
INSERT INTO `room` VALUES ('14', '1号房-103', 's1-103', '/lnn/upload/upload_roomType/pic_45711b61-7f9a-46cf-a98c-4446d8c11762_timg.jpg', '2', '', '20');
INSERT INTO `room` VALUES ('15', '1号房-301', 's1-301', '/lnn/upload/upload_roomType/pic_45711b61-7f9a-46cf-a98c-4446d8c11762_timg.jpg', '2', '', '25');
INSERT INTO `room` VALUES ('16', '3号房-305', 's3-305', '/lnn/upload/upload_roomType/pic_cf45a6b6-c5ec-4864-bc0e-f0898079579d_timg1.jpg', '0', '', '22');
INSERT INTO `room` VALUES ('17', '3号房-302', 's3-302', '/lnn/upload/upload_roomType/pic_cf45a6b6-c5ec-4864-bc0e-f0898079579d_timg1.jpg', '0', '', '22');
INSERT INTO `room` VALUES ('18', '4号房-101', 's4-101', '/lnn/upload/upload_roomType/pic_d6fe56db-7ef3-4a65-afd8-34ecc76a964e_timg2.jpg', '0', '', '24');
INSERT INTO `room` VALUES ('19', '5号房-101', 's5-101', '/lnn/upload/upload_roomType/pic_bf385680-0c55-4746-975b-37b00cb1c5ac_room1.jpg', '0', '', '26');
INSERT INTO `room` VALUES ('20', '5号房-201', 's5-201', '/lnn/upload/upload_roomType/pic_bf385680-0c55-4746-975b-37b00cb1c5ac_room1.jpg', '0', '', '27');
INSERT INTO `room` VALUES ('21', '5号房-301', 's5-301', '/lnn/upload/upload_roomType/pic_bf385680-0c55-4746-975b-37b00cb1c5ac_room1.jpg', '0', '', '28');
INSERT INTO `room` VALUES ('22', '6号房-101', 's6-101', '/lnn/upload/upload_roomType/pic_de8ee991-7e3d-4fdf-a795-4860329ae674_room2.jpg', '0', '', '29');
INSERT INTO `room` VALUES ('23', '6号房-301', 's6-301', '/lnn/upload/upload_roomType/pic_de8ee991-7e3d-4fdf-a795-4860329ae674_room2.jpg', '0', '', '30');
INSERT INTO `room` VALUES ('24', '7号房-201', 's7-201', '/lnn/upload/upload_roomType/pic_9c029636-fd31-49b9-b188-ab224f866d6f_room3.jpg', '0', '', '32');
INSERT INTO `room` VALUES ('25', '7号房-301', 's7-301', '/lnn/upload/upload_roomType/pic_9c029636-fd31-49b9-b188-ab224f866d6f_room3.jpg', '0', '', '31');
INSERT INTO `room` VALUES ('26', '8号房-401', 's8-401', '/lnn/upload/upload_roomType/pic_0d156c3c-ea32-46cf-a253-fa51fa15f305_room4.jpg', '0', '', '33');
INSERT INTO `room` VALUES ('27', '8号房-501', 's8-501', '/lnn/upload/upload_roomType/pic_0d156c3c-ea32-46cf-a253-fa51fa15f305_room4.jpg', '0', '', '35');
INSERT INTO `room` VALUES ('28', '9号房-401', 's9-401', '/lnn/upload/upload_roomType/pic_d36c981a-43ae-40a3-82cb-a4c83493e1f4_room6.jpg', '0', '', '37');
INSERT INTO `room` VALUES ('29', '9号房-501', 's9-501', '/lnn/upload/upload_roomType/pic_d36c981a-43ae-40a3-82cb-a4c83493e1f4_room6.jpg', '0', '', '36');
INSERT INTO `room` VALUES ('30', '10号房-501', 's10-501', '/lnn/upload/upload_roomType/pic_021860da-a6f2-4b38-b828-cc3a7f4b3bd4_room5.jpg', '1', '', '38');
INSERT INTO `room` VALUES ('31', '2号房-203', 's2-203', '/lnn/upload/upload_roomType/pic_bb5fa1b5-e9b5-46ca-893b-6288dcdebbbf_timg3.jpg', '2', '', '21');
INSERT INTO `room` VALUES ('32', '2号房-204', 's2-204', '/lnn/upload/upload_roomType/pic_bb5fa1b5-e9b5-46ca-893b-6288dcdebbbf_timg3.jpg', '2', '', '21');
INSERT INTO `room` VALUES ('33', '3号房-303', 's3-303', '/lnn/upload/upload_roomType/pic_cf45a6b6-c5ec-4864-bc0e-f0898079579d_timg1.jpg', '0', '', '22');
INSERT INTO `room` VALUES ('34', '4号房-403', 's4-403', '/lnn/upload/upload_roomType/pic_d6fe56db-7ef3-4a65-afd8-34ecc76a964e_timg2.jpg', '0', '', '24');

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `floorId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `liveNum` int(11) DEFAULT NULL,
  `bedNum` int(11) DEFAULT NULL,
  `roomNum` int(11) DEFAULT NULL,
  `avilableNum` int(11) DEFAULT NULL,
  `canNotLiveNum` int(11) DEFAULT NULL,
  `bookNum` int(11) DEFAULT NULL,
  `livedNum` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room-type_ibfk_1` (`floorId`),
  CONSTRAINT `room-type_ibfk_1` FOREIGN KEY (`floorId`) REFERENCES `floor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES ('20', '2', '1号房', '/lnn/upload/upload_roomType/pic_45711b61-7f9a-46cf-a98c-4446d8c11762_timg.jpg', '111', '1', '1', '3', '2', '0', '0', '1', '1', '');
INSERT INTO `room_type` VALUES ('21', '3', '2号房', '/lnn/upload/upload_roomType/pic_bb5fa1b5-e9b5-46ca-893b-6288dcdebbbf_timg3.jpg', '222', '2', '2', '3', '1', '0', '0', '2', '1', '');
INSERT INTO `room_type` VALUES ('22', '4', '3号房', '/lnn/upload/upload_roomType/pic_cf45a6b6-c5ec-4864-bc0e-f0898079579d_timg1.jpg', '333', '3', '3', '4', '3', '0', '0', '1', '1', '');
INSERT INTO `room_type` VALUES ('24', '2', '4号房', '/lnn/upload/upload_roomType/pic_d6fe56db-7ef3-4a65-afd8-34ecc76a964e_timg2.jpg', '444', '3', '3', '3', '3', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('25', '4', '1号房', '/lnn/upload/upload_roomType/pic_45711b61-7f9a-46cf-a98c-4446d8c11762_timg.jpg', '111', '3', '3', '1', '0', '0', '0', '1', '0', '');
INSERT INTO `room_type` VALUES ('26', '2', '5号房', '/lnn/upload/upload_roomType/pic_bf385680-0c55-4746-975b-37b00cb1c5ac_room1.jpg', '555', '5', '5', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('27', '3', '5号房', '/lnn/upload/upload_roomType/pic_bf385680-0c55-4746-975b-37b00cb1c5ac_room1.jpg', '555', '5', '5', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('28', '4', '5号房', '/lnn/upload/upload_roomType/pic_bf385680-0c55-4746-975b-37b00cb1c5ac_room1.jpg', '555', '5', '5', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('29', '2', '6号房', '/lnn/upload/upload_roomType/pic_de8ee991-7e3d-4fdf-a795-4860329ae674_room2.jpg', '666', '6', '6', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('30', '4', '6号房', '/lnn/upload/upload_roomType/pic_de8ee991-7e3d-4fdf-a795-4860329ae674_room2.jpg', '666', '6', '6', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('31', '4', '7号房', '/lnn/upload/upload_roomType/pic_9c029636-fd31-49b9-b188-ab224f866d6f_room3.jpg', '777', '7', '7', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('32', '3', '7号房', '/lnn/upload/upload_roomType/pic_6e01c487-48d0-4ad1-a98b-9d2d29724193_room3.jpg', '777', '7', '7', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('33', '5', '8号房', '/lnn/upload/upload_roomType/pic_0d156c3c-ea32-46cf-a253-fa51fa15f305_room4.jpg', '888', '8', '8', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('35', '6', '8号房', '/lnn/upload/upload_roomType/pic_a6a65411-9a5c-4bee-99d4-8406554de4f6_room4.jpg', '888', '8', '8', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('36', '6', '9号房', '/lnn/upload/upload_roomType/pic_d36c981a-43ae-40a3-82cb-a4c83493e1f4_room6.jpg', '999', '9', '9', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('37', '5', '9号房', '/lnn/upload/upload_roomType/pic_d36c981a-43ae-40a3-82cb-a4c83493e1f4_room6.jpg', '999', '9', '9', '1', '1', '0', '0', '0', '1', '');
INSERT INTO `room_type` VALUES ('38', '6', '10号房', '/lnn/upload/upload_roomType/pic_021860da-a6f2-4b38-b828-cc3a7f4b3bd4_room5.jpg', '1000', '10', '10', '1', '0', '0', '1', '0', '0', '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `roleId` int(11) DEFAULT NULL,
  `photo` varchar(225) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('9', 'admin', 'admin', '2', '/lnn/upload/upload_userPhoto/pic_3b767f65-03d7-418b-94c5-8edc68817fd5_nightlife.png', '0', '0', 'hfut');
INSERT INTO `user` VALUES ('10', 'admin2', 'admin2', '3', '/lnn/upload/upload_userPhoto/pic_e38c1906-99b5-43a8-b194-71e19ad42423_shui.png', '1', '18', 'hfut');
INSERT INTO `user` VALUES ('48', 'test', 'test', '7', '/hotel/upload/upload_userPhoto/pic_944dc388-d5f0-49c1-83ca-fe9ef84ce895_duanxin.png', '2', '0', 'hfut');
