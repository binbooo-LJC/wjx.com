/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : think_admin

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2018-07-30 16:12:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for think_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `think_admin_user`;
CREATE TABLE `think_admin_user` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(50) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of think_admin_user
-- ----------------------------
INSERT INTO `think_admin_user` VALUES ('1', 'admin', 'c28c76b1ba7b150ce0cd878e4b22f639', '1', '2016-10-18 15:28:37', '2018-07-30 10:08:48', '127.0.0.1');

-- ----------------------------
-- Table structure for think_article
-- ----------------------------
DROP TABLE IF EXISTS `think_article`;
CREATE TABLE `think_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `cid` smallint(5) unsigned NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `introduction` varchar(255) DEFAULT '' COMMENT '简介',
  `content` longtext COMMENT '内容',
  `author` varchar(20) DEFAULT '' COMMENT '作者',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 0 待审核  1 审核',
  `reading` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '阅读量',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `photo` text COMMENT '图集',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶  0 不置顶  1 置顶',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `publish_time` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of think_article
-- ----------------------------

-- ----------------------------
-- Table structure for think_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `think_auth_group`;
CREATE TABLE `think_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL COMMENT '权限规则ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='权限组表';

-- ----------------------------
-- Records of think_auth_group
-- ----------------------------
INSERT INTO `think_auth_group` VALUES ('1', '超级管理组', '1', '1,2,3,73,74,5,6,7,8,9,10,11,12,39,40,41,42,43,14,13,20,21,22,23,24,15,25,26,27,28,29,30,16,17,44,45,46,47,48,18,49,50,51,52,53,19,31,32,33,34,35,36,37,54,55,58,59,60,61,62,56,63,64,65,66,67,57,68,69,70,71,72');

-- ----------------------------
-- Table structure for think_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `think_auth_group_access`;
CREATE TABLE `think_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限组规则表';

-- ----------------------------
-- Records of think_auth_group_access
-- ----------------------------
INSERT INTO `think_auth_group_access` VALUES ('1', '1');

-- ----------------------------
-- Table structure for think_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `think_auth_rule`;
CREATE TABLE `think_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(20) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `pid` smallint(5) unsigned NOT NULL COMMENT '父级ID',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `sort` tinyint(4) unsigned NOT NULL COMMENT '排序',
  `condition` char(100) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of think_auth_rule
-- ----------------------------
INSERT INTO `think_auth_rule` VALUES ('1', 'admin/System/default', '系统配置', '1', '1', '0', 'fa fa-gears', '0', '');
INSERT INTO `think_auth_rule` VALUES ('5', 'admin/Menu/default', '菜单管理', '1', '1', '0', 'fa fa-bars', '0', '');
INSERT INTO `think_auth_rule` VALUES ('6', 'admin/Menu/index', '后台菜单', '1', '1', '5', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('7', 'admin/Menu/add', '添加菜单', '1', '0', '6', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('8', 'admin/Menu/save', '保存菜单', '1', '0', '6', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('9', 'admin/Menu/edit', '编辑菜单', '1', '0', '6', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('10', 'admin/Menu/update', '更新菜单', '1', '0', '6', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('11', 'admin/Menu/delete', '删除菜单', '1', '0', '6', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('13', 'admin/project/index', '项目列表', '1', '1', '14', 'fa fa-sitemap', '0', '');
INSERT INTO `think_auth_rule` VALUES ('14', 'admin/Content/default', '项目管理', '1', '1', '0', 'fa fa-file-text', '56', '');
INSERT INTO `think_auth_rule` VALUES ('15', 'admin/deposit/index', '套餐管理', '1', '1', '14', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('16', 'admin/User/default', '用户管理', '1', '1', '0', 'fa fa-users', '99', '');
INSERT INTO `think_auth_rule` VALUES ('17', 'admin/User/index', '会员vip', '1', '1', '16', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('18', 'admin/AdminUser/index', '管理员', '1', '0', '16', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('19', 'admin/AuthGroup/index', '权限组', '1', '0', '16', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('20', 'admin/Category/add', '添加栏目', '1', '0', '13', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('21', 'admin/Category/save', '保存栏目', '1', '0', '13', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('22', 'admin/Category/edit', '编辑栏目', '1', '0', '13', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('23', 'admin/Category/update', '更新栏目', '1', '0', '13', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('24', 'admin/Category/delete', '删除栏目', '1', '0', '13', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('25', 'admin/Article/add', '添加文章', '1', '0', '15', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('26', 'admin/Article/save', '保存文章', '1', '0', '15', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('27', 'admin/Article/edit', '编辑文章', '1', '0', '15', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('28', 'admin/Article/update', '更新文章', '1', '0', '15', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('29', 'admin/Article/delete', '删除文章', '1', '0', '15', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('30', 'admin/Article/toggle', '文章审核', '1', '0', '15', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('31', 'admin/AuthGroup/add', '添加权限组', '1', '0', '19', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('32', 'admin/AuthGroup/save', '保存权限组', '1', '0', '19', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('33', 'admin/AuthGroup/edit', '编辑权限组', '1', '0', '19', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('34', 'admin/AuthGroup/update', '更新权限组', '1', '0', '19', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('35', 'admin/AuthGroup/delete', '删除权限组', '1', '0', '19', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('36', 'admin/AuthGroup/auth', '授权', '1', '0', '19', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('37', 'admin/AuthGroup/updateAuthGroupRule', '更新权限组规则', '1', '0', '19', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('44', 'admin/User/add', '添加用户', '1', '0', '17', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('45', 'admin/User/save', '保存用户', '1', '0', '17', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('46', 'admin/User/edit', '编辑用户', '1', '0', '17', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('47', 'admin/User/update', '更新用户', '1', '0', '17', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('48', 'admin/User/delete', '删除用户', '1', '0', '17', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('49', 'admin/AdminUser/add', '添加管理员', '1', '0', '18', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('50', 'admin/AdminUser/save', '保存管理员', '1', '0', '18', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('51', 'admin/AdminUser/edit', '编辑管理员', '1', '0', '18', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('52', 'admin/AdminUser/update', '更新管理员', '1', '0', '18', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('53', 'admin/AdminUser/delete', '删除管理员', '1', '0', '18', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('54', 'admin/Slide/default', '流水账单', '1', '1', '0', 'fa fa-wrench', '55', '');
INSERT INTO `think_auth_rule` VALUES ('55', 'admin/consume/sms', '短信通知', '1', '1', '54', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('56', 'admin/recharge/index', '充值记录', '1', '1', '54', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('57', 'admin/Consume/index', '账单统计', '1', '1', '54', 'fa fa-link', '0', '');
INSERT INTO `think_auth_rule` VALUES ('58', 'admin/SlideCategory/add', '添加分类', '1', '0', '55', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('59', 'admin/SlideCategory/save', '保存分类', '1', '0', '55', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('60', 'admin/SlideCategory/edit', '编辑分类', '1', '0', '55', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('61', 'admin/SlideCategory/update', '更新分类', '1', '0', '55', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('62', 'admin/SlideCategory/delete', '删除分类', '1', '0', '55', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('63', 'admin/Slide/add', '添加轮播', '1', '0', '56', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('64', 'admin/Slide/save', '保存轮播', '1', '0', '56', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('65', 'admin/Slide/edit', '编辑轮播', '1', '0', '56', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('66', 'admin/Slide/update', '更新轮播', '1', '0', '56', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('67', 'admin/Slide/delete', '删除轮播', '1', '0', '56', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('68', 'admin/Link/add', '添加链接', '1', '0', '57', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('69', 'admin/Link/save', '保存链接', '1', '0', '57', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('70', 'admin/Link/edit', '编辑链接', '1', '0', '57', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('71', 'admin/Link/update', '更新链接', '1', '0', '57', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('72', 'admin/Link/delete', '删除链接', '1', '0', '57', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('73', 'admin/ChangePassword/index', '修改密码', '1', '1', '1', '', '0', '');

-- ----------------------------
-- Table structure for think_category
-- ----------------------------
DROP TABLE IF EXISTS `think_category`;
CREATE TABLE `think_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `alias` varchar(50) DEFAULT '' COMMENT '导航别名',
  `content` longtext COMMENT '分类内容',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `icon` varchar(20) DEFAULT '' COMMENT '分类图标',
  `list_template` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `detail_template` varchar(50) DEFAULT '' COMMENT '分类详情模板',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '分类类型  1  列表  2 单页',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `path` varchar(255) DEFAULT '' COMMENT '路径',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of think_category
-- ----------------------------
INSERT INTO `think_category` VALUES ('1', '分类一', '', '', '', '', '', '', '1', '0', '0', '0,', '2016-12-22 18:22:24');

-- ----------------------------
-- Table structure for think_consume
-- ----------------------------
DROP TABLE IF EXISTS `think_consume`;
CREATE TABLE `think_consume` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '外键 user表',
  `project` int(2) NOT NULL COMMENT '外键 project',
  `no_bill` int(1) NOT NULL COMMENT 'no_bill 0 免单 1：不免单',
  `creat_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mark` char(50) DEFAULT NULL COMMENT '备注',
  `cyctime` date NOT NULL COMMENT '下去需要做项目时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `creat_time` (`creat_time`),
  CONSTRAINT `think_consume_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `think_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_consume
-- ----------------------------
INSERT INTO `think_consume` VALUES ('91', '56', '2', '1', '2018-07-20 16:27:11', null, '2018-04-26');
INSERT INTO `think_consume` VALUES ('92', '57', '1', '0', '2018-07-20 16:27:26', null, '2018-07-27');
INSERT INTO `think_consume` VALUES ('93', '58', '2', '0', '2018-07-20 16:27:34', null, '2018-07-28');
INSERT INTO `think_consume` VALUES ('94', '60', '1', '0', '2018-07-20 16:27:44', null, '2018-03-14');
INSERT INTO `think_consume` VALUES ('95', '60', '2', '1', '2018-07-20 17:03:19', null, '2018-07-11');
INSERT INTO `think_consume` VALUES ('96', '63', '2', '0', '2018-07-20 17:29:54', null, '2018-08-03');

-- ----------------------------
-- Table structure for think_deposit_type
-- ----------------------------
DROP TABLE IF EXISTS `think_deposit_type`;
CREATE TABLE `think_deposit_type` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  `premoney` int(5) NOT NULL COMMENT '原本金额',
  `money` int(6) NOT NULL,
  `statue` int(1) DEFAULT '1' COMMENT '1:启用 0 弃用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_deposit_type
-- ----------------------------
INSERT INTO `think_deposit_type` VALUES ('1', '充值500送首次小奇泡免单', '500', '500', '0');
INSERT INTO `think_deposit_type` VALUES ('2', '充值1000送200', '1000', '1200', '1');

-- ----------------------------
-- Table structure for think_link
-- ----------------------------
DROP TABLE IF EXISTS `think_link`;
CREATE TABLE `think_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '链接名称',
  `link` varchar(255) DEFAULT '' COMMENT '链接地址',
  `image` varchar(255) DEFAULT '' COMMENT '链接图片',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 显示  2 隐藏',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of think_link
-- ----------------------------

-- ----------------------------
-- Table structure for think_nav
-- ----------------------------
DROP TABLE IF EXISTS `think_nav`;
CREATE TABLE `think_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL COMMENT '父ID',
  `name` varchar(20) NOT NULL COMMENT '导航名称',
  `alias` varchar(20) DEFAULT '' COMMENT '导航别称',
  `link` varchar(255) DEFAULT '' COMMENT '导航链接',
  `icon` varchar(255) DEFAULT '' COMMENT '导航图标',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态  0 隐藏  1 显示',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='导航表';

-- ----------------------------
-- Records of think_nav
-- ----------------------------

-- ----------------------------
-- Table structure for think_pay
-- ----------------------------
DROP TABLE IF EXISTS `think_pay`;
CREATE TABLE `think_pay` (
  `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_pay
-- ----------------------------
INSERT INTO `think_pay` VALUES ('1', '微信');
INSERT INTO `think_pay` VALUES ('2', '支付宝');
INSERT INTO `think_pay` VALUES ('3', '现金');

-- ----------------------------
-- Table structure for think_project
-- ----------------------------
DROP TABLE IF EXISTS `think_project`;
CREATE TABLE `think_project` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '项目名称',
  `money` char(4) NOT NULL COMMENT '金额',
  `cyc` int(2) DEFAULT '0' COMMENT '项目周期',
  `statue` int(1) NOT NULL DEFAULT '1' COMMENT '1:启用 0 弃用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_project
-- ----------------------------
INSERT INTO `think_project` VALUES ('1', '小气泡', '68', '7', '0');
INSERT INTO `think_project` VALUES ('2', '美白亮肤', '88', '14', '1');

-- ----------------------------
-- Table structure for think_recharge
-- ----------------------------
DROP TABLE IF EXISTS `think_recharge`;
CREATE TABLE `think_recharge` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `user_id` int(5) NOT NULL,
  `money` int(5) NOT NULL,
  `type` int(1) DEFAULT '0' COMMENT '充值类型',
  `pay` int(11) DEFAULT '1' COMMENT '付款方式',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `oder_time` (`time`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `think_recharge_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `think_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_recharge
-- ----------------------------
INSERT INTO `think_recharge` VALUES ('4', '56', '1000', '0', '0', '2018-07-16 16:30:18');
INSERT INTO `think_recharge` VALUES ('5', '57', '1000', '2', '1', '2018-07-16 16:46:45');
INSERT INTO `think_recharge` VALUES ('6', '58', '1000', '2', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('8', '58', '101', '0', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('9', '58', '1000', '2', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('10', '58', '1000', '2', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('11', '58', '1000', '2', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('12', '58', '100', '0', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('13', '58', '100', '0', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('14', '59', '1000', '0', '1', '2018-07-17 14:50:37');
INSERT INTO `think_recharge` VALUES ('15', '60', '20', '0', '1', '2018-07-17 15:14:27');
INSERT INTO `think_recharge` VALUES ('16', '62', '1000', '0', '1', '2018-07-17 15:25:39');
INSERT INTO `think_recharge` VALUES ('17', '63', '1000', '0', '1', '2018-07-17 15:26:36');
INSERT INTO `think_recharge` VALUES ('18', '63', '1000', '0', '1', '2018-07-17 15:27:14');
INSERT INTO `think_recharge` VALUES ('19', '63', '1000', '0', '1', '2018-07-17 15:27:14');
INSERT INTO `think_recharge` VALUES ('20', '63', '1000', '2', '1', '2018-07-17 15:28:39');
INSERT INTO `think_recharge` VALUES ('21', '63', '1000', '2', '1', '2018-07-17 15:28:39');
INSERT INTO `think_recharge` VALUES ('22', '63', '1000', '0', '1', '2018-07-17 15:29:09');
INSERT INTO `think_recharge` VALUES ('23', '63', '1000', '0', '1', '2018-07-17 15:29:10');
INSERT INTO `think_recharge` VALUES ('24', '63', '1000', '2', '1', '2018-07-17 15:29:20');
INSERT INTO `think_recharge` VALUES ('25', '63', '1000', '2', '1', '2018-07-17 15:29:20');
INSERT INTO `think_recharge` VALUES ('26', '63', '1000', '0', '1', '2018-07-17 15:41:48');
INSERT INTO `think_recharge` VALUES ('27', '63', '1000', '0', '1', '2018-07-17 15:41:48');
INSERT INTO `think_recharge` VALUES ('28', '63', '1000', '2', '1', '2018-06-13 15:42:10');
INSERT INTO `think_recharge` VALUES ('29', '63', '1000', '2', '1', '2018-07-17 15:42:10');

-- ----------------------------
-- Table structure for think_slide
-- ----------------------------
DROP TABLE IF EXISTS `think_slide`;
CREATE TABLE `think_slide` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '轮播图名称',
  `description` varchar(255) DEFAULT '' COMMENT '说明',
  `link` varchar(255) DEFAULT '' COMMENT '链接',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `image` varchar(255) DEFAULT '' COMMENT '轮播图片',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态  1 显示  0  隐藏',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='轮播图表';

-- ----------------------------
-- Records of think_slide
-- ----------------------------

-- ----------------------------
-- Table structure for think_slide_category
-- ----------------------------
DROP TABLE IF EXISTS `think_slide_category`;
CREATE TABLE `think_slide_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '轮播图分类',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='轮播图分类表';

-- ----------------------------
-- Records of think_slide_category
-- ----------------------------
INSERT INTO `think_slide_category` VALUES ('1', '首页轮播');

-- ----------------------------
-- Table structure for think_sms
-- ----------------------------
DROP TABLE IF EXISTS `think_sms`;
CREATE TABLE `think_sms` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `consumeId` int(5) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `statue` int(1) DEFAULT '1',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_sms
-- ----------------------------

-- ----------------------------
-- Table structure for think_system
-- ----------------------------
DROP TABLE IF EXISTS `think_system`;
CREATE TABLE `think_system` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '配置项名称',
  `value` text NOT NULL COMMENT '配置项值',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of think_system
-- ----------------------------
INSERT INTO `think_system` VALUES ('1', 'site_config', 'a:7:{s:10:\"site_title\";s:30:\"Think Admin 后台管理系统\";s:9:\"seo_title\";s:0:\"\";s:11:\"seo_keyword\";s:0:\"\";s:15:\"seo_description\";s:0:\"\";s:14:\"site_copyright\";s:0:\"\";s:8:\"site_icp\";s:0:\"\";s:11:\"site_tongji\";s:0:\"\";}');

-- ----------------------------
-- Table structure for think_user
-- ----------------------------
DROP TABLE IF EXISTS `think_user`;
CREATE TABLE `think_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `mobile` varchar(12) DEFAULT '' COMMENT '手机',
  `wx_code` char(50) DEFAULT NULL COMMENT '微信号',
  `balance` smallint(5) DEFAULT NULL COMMENT '余额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后消费时间',
  `mark` char(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `mobile` (`mobile`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of think_user
-- ----------------------------
INSERT INTO `think_user` VALUES ('56', '王金显', '18146538675', '', '1112', '2018-07-16 16:30:18', '2018-07-24 14:24:12', '');
INSERT INTO `think_user` VALUES ('57', '13366659939', '18539981367', '', '1200', '2018-07-16 16:46:44', '2018-07-16 16:46:44', '');
INSERT INTO `think_user` VALUES ('58', 'li', '18539981367', '', '2500', '2018-07-16 16:48:06', '2018-07-17 11:49:04', '');
INSERT INTO `think_user` VALUES ('59', '3294814380@qq.com', '18539981367', '', '1000', '2018-07-17 14:50:37', '2018-07-17 14:50:37', '');
INSERT INTO `think_user` VALUES ('60', '李金城', '133666599399', '', '20', '2018-07-17 15:14:26', '2018-07-24 16:16:45', '');
INSERT INTO `think_user` VALUES ('62', '91xiaoxuesheng91', '18539981367', '', '1000', '2018-07-17 15:25:39', '2018-07-17 15:25:39', '');
INSERT INTO `think_user` VALUES ('63', '18637626031', '18539981367', '', '7600', '2018-07-17 15:26:36', '2018-07-17 15:42:10', '');
