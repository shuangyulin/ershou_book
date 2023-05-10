-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_bookClass` (
  `bookClassId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别编号',
  `bookClassName` varchar(20)  NOT NULL COMMENT '类别名称',
  PRIMARY KEY (`bookClassId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_bookSeek` (
  `seekId` int(11) NOT NULL AUTO_INCREMENT COMMENT '求购id',
  `bookPhoto` varchar(60)  NOT NULL COMMENT '图书主图',
  `bookName` varchar(20)  NOT NULL COMMENT '图书名称',
  `bookClassObj` int(11) NOT NULL COMMENT '图书类别',
  `publish` varchar(50)  NOT NULL COMMENT '出版社',
  `author` varchar(20)  NOT NULL COMMENT '作者',
  `price` float NOT NULL COMMENT '求购价格',
  `xjcd` varchar(20)  NOT NULL COMMENT '新旧程度',
  `seekDesc` varchar(5000)  NOT NULL COMMENT '求购说明',
  `userObj` varchar(30)  NOT NULL COMMENT '发布用户',
  `addTime` varchar(20)  NULL COMMENT '用户发布时间',
  PRIMARY KEY (`seekId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_bookSell` (
  `sellId` int(11) NOT NULL AUTO_INCREMENT COMMENT '出售id',
  `bookPhoto` varchar(60)  NOT NULL COMMENT '图书主图',
  `bookName` varchar(20)  NOT NULL COMMENT '图书名称',
  `bookClassObj` int(11) NOT NULL COMMENT '图书类别',
  `publish` varchar(20)  NOT NULL COMMENT '出版社',
  `author` varchar(20)  NOT NULL COMMENT '作者',
  `sellPrice` float NOT NULL COMMENT '出售价格',
  `xjcd` varchar(20)  NOT NULL COMMENT '新旧程度',
  `sellDesc` varchar(5000)  NOT NULL COMMENT '出售说明',
  `userObj` varchar(30)  NOT NULL COMMENT '发布用户',
  `addTime` varchar(20)  NULL COMMENT '用户发布时间',
  PRIMARY KEY (`sellId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_bookOrder` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `bookSellObj` int(11) NOT NULL COMMENT '图书信息',
  `userObj` varchar(30)  NOT NULL COMMENT '意向用户',
  `price` float NOT NULL COMMENT '意向出价',
  `orderMemo` varchar(500)  NULL COMMENT '用户备注',
  `addTime` varchar(20)  NULL COMMENT '下单时间',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(30)  NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20)  NULL COMMENT '留言时间',
  `replyContent` varchar(1000)  NULL COMMENT '管理回复',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80)  NOT NULL COMMENT '标题',
  `content` varchar(5000)  NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_bookSeek ADD CONSTRAINT FOREIGN KEY (bookClassObj) REFERENCES t_bookClass(bookClassId);
ALTER TABLE t_bookSeek ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_bookSell ADD CONSTRAINT FOREIGN KEY (bookClassObj) REFERENCES t_bookClass(bookClassId);
ALTER TABLE t_bookSell ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_bookOrder ADD CONSTRAINT FOREIGN KEY (bookSellObj) REFERENCES t_bookSell(sellId);
ALTER TABLE t_bookOrder ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


