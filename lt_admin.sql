/*
Navicat MySQL Data Transfer

Source Server         : lison
Source Server Version : v1.66
Source Host           : localhost:3306
Source Database       : lantu03.com

Target Server Type    : MYSQL
Target Server Version : v1.66
File Encoding         : 65001

Date: 2020 07-07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for lt_admin
-- ----------------------------
DROP TABLE IF EXISTS `lt_admin`;
CREATE TABLE `lt_admin` (
  `userid` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `excel_out_password` varchar(50) DEFAULT NULL,
  `roleid` smallint(5) DEFAULT '0',
  `encrypt` varchar(6) DEFAULT NULL,
  `lastloginip` varchar(15) DEFAULT NULL,
  `lastlogintime` int(10) unsigned DEFAULT '0',
  `email` varchar(40) DEFAULT NULL,
  `realname` varchar(50) NOT NULL DEFAULT '',
  `card` varchar(255) NOT NULL,
  `lang` varchar(6) NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_admin
-- ----------------------------
INSERT INTO `lt_admin` VALUES ('1', 'lantu', '668d96f84af54f5b610d4c61c2f34728', '4567', '1', '56Baw4', '127.0.0.1', '1594051200', 'kk@haook.cn', '', '', '');

-- ----------------------------
-- Table structure for lt_admin_panel
-- ----------------------------
DROP TABLE IF EXISTS `lt_admin_panel`;
CREATE TABLE `lt_admin_panel` (
  `menuid` mediumint(8) unsigned NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` char(32) DEFAULT NULL,
  `url` char(255) DEFAULT NULL,
  `datetime` int(10) unsigned DEFAULT '0',
  UNIQUE KEY `userid` (`menuid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_admin_panel
-- ----------------------------

-- ----------------------------
-- Table structure for lt_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `lt_admin_role`;
CREATE TABLE `lt_admin_role` (
  `roleid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleid`),
  KEY `listorder` (`listorder`),
  KEY `disabled` (`disabled`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_admin_role
-- ----------------------------
INSERT INTO `lt_admin_role` VALUES ('1', '超级管理员', '超级管理员', '0', '0');
INSERT INTO `lt_admin_role` VALUES ('2', '站点管理员', '站点管理员', '0', '0');
INSERT INTO `lt_admin_role` VALUES ('3', '运营总监', '运营总监', '1', '0');
INSERT INTO `lt_admin_role` VALUES ('4', '总编', '总编', '5', '0');
INSERT INTO `lt_admin_role` VALUES ('5', '编辑', '编辑', '1', '0');
INSERT INTO `lt_admin_role` VALUES ('7', '发布人员', '发布人员', '0', '0');

-- ----------------------------
-- Table structure for lt_admin_role_priv
-- ----------------------------
DROP TABLE IF EXISTS `lt_admin_role_priv`;
CREATE TABLE `lt_admin_role_priv` (
  `roleid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `c` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(30) NOT NULL DEFAULT '',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  KEY `roleid` (`roleid`,`m`,`c`,`a`,`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_admin_role_priv
-- ----------------------------

-- ----------------------------
-- Table structure for lt_attachment
-- ----------------------------
DROP TABLE IF EXISTS `lt_attachment`;
CREATE TABLE `lt_attachment` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` char(15) NOT NULL,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `filename` char(50) NOT NULL,
  `filepath` char(200) NOT NULL,
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  `fileext` char(10) NOT NULL,
  `isimage` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isthumb` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `downloads` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `uploadtime` int(10) unsigned NOT NULL DEFAULT '0',
  `uploadip` char(15) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `authcode` char(32) NOT NULL,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`),
  KEY `authcode` (`authcode`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_attachment
-- ----------------------------
INSERT INTO `lt_attachment` VALUES ('5', 'content', '17', 'u=113506771,4128433448&fm=27&gp=0.jpg', '2018/0915/20180915041234153.jpg', '31325', 'jpg', '1', '0', '0', '1', '1536999154', '127.0.0.1', '1', 'd83d2c331c5495b801fe9f222f0faee9', '1');
INSERT INTO `lt_attachment` VALUES ('4', 'content', '10', 'u=3672253645,2131276989&fm=27&gp=0.jpg', '2018/0914/20180914105012493.jpg', '22818', 'jpg', '1', '0', '0', '1', '1536893412', '127.0.0.1', '1', '665f58d674bda007add14ad409c1fe1a', '1');
INSERT INTO `lt_attachment` VALUES ('6', 'content', '17', 'u=4061074895,3777553965&fm=27&gp=0.jpg', '2018/0915/20180915041526838.jpg', '36022', 'jpg', '1', '0', '0', '1', '1536999326', '127.0.0.1', '1', '989a2bc587e99feb2322dae1337b737c', '1');
INSERT INTO `lt_attachment` VALUES ('7', 'content', '17', 'u=4161996240,3340840262&fm=27&gp=0.jpg', '2018/0915/20180915045054781.jpg', '36604', 'jpg', '1', '0', '0', '1', '1537001454', '127.0.0.1', '1', '5d064b38780a2968f428bd8867f8e80b', '1');
INSERT INTO `lt_attachment` VALUES ('8', 'content', '24', 'u=1228624792,841862921&fm=27&gp=0.jpg', '2018/0915/20180915062056777.jpg', '28805', 'jpg', '1', '0', '0', '1', '1537006856', '127.0.0.1', '1', '493c9bc47c869367a1e5d79c483fbf13', '1');
INSERT INTO `lt_attachment` VALUES ('9', 'content', '24', 'u=2222653863,2925694844&fm=27&gp=0.jpg', '2018/0915/20180915062111400.jpg', '21870', 'jpg', '1', '0', '0', '1', '1537006871', '127.0.0.1', '1', '61824a2dbd18302bd92dcc34f53e3098', '1');
INSERT INTO `lt_attachment` VALUES ('10', 'link', '0', 'u=3672253645,2131276989&fm=27&gp=0.jpg', '2018/0915/20180915065416780.jpg', '22818', 'jpg', '1', '0', '0', '1', '1537008856', '127.0.0.1', '0', '41a9ffb507f0b1b6bee5f26da7e52909', '1');
INSERT INTO `lt_attachment` VALUES ('11', 'content', '27', 'u=3672253645,2131276989&fm=27&gp=0.jpg', '2018/0917/20180917023154821.jpg', '22818', 'jpg', '1', '0', '0', '1', '1537165914', '127.0.0.1', '1', '4d5edd736d5009ad18766106aa6d46de', '1');
INSERT INTO `lt_attachment` VALUES ('12', 'content', '27', 'u=1650804996,667577038&fm=27&gp=0.jpg', '2018/0917/20180917023346832.jpg', '49940', 'jpg', '1', '0', '0', '1', '1537166026', '127.0.0.1', '1', 'b1dcd9f2b47d9d228568c1fd836246f9', '1');
INSERT INTO `lt_attachment` VALUES ('14', 'content', '0', '20180918094019881.jpg', '2018/0918/20180918094019881.jpg', '47764', 'jpg', '1', '0', '0', '0', '1537234819', '127.0.0.1', '1', 'c90abc9304100efbe8c3d7ce17a492d7', '1');
INSERT INTO `lt_attachment` VALUES ('17', 'content', '17', 'u=4061074895,3777553965&fm=27&gp=0.jpg', '2018/0918/20180918043300220.jpg', '36022', 'jpg', '1', '0', '0', '1', '1537259580', '127.0.0.1', '1', '3df01008452d1cecf9ed08b84efe7430', '1');
INSERT INTO `lt_attachment` VALUES ('18', 'content', '27', 'u=3777711509,3928682622&fm=27&gp=0.jpg', '2018/0922/20180922021020622.jpg', '30136', 'jpg', '1', '0', '0', '1', '1537596620', '127.0.0.1', '1', 'f888858f54272e4ce4e6b23c5230527f', '1');
INSERT INTO `lt_attachment` VALUES ('20', 'content', '27', '屏幕截图(1).png', '2019/0321/20190321094648375.png', '591599', 'png', '1', '0', '0', '1', '1553132808', '127.0.0.1', '1', '3ef3c1798dbb09cc5ab7c89a80e68429', '1');

-- ----------------------------
-- Table structure for lt_attachment_index
-- ----------------------------
DROP TABLE IF EXISTS `lt_attachment_index`;
CREATE TABLE `lt_attachment_index` (
  `keyid` char(30) NOT NULL,
  `aid` char(10) NOT NULL,
  KEY `keyid` (`keyid`),
  KEY `aid` (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_attachment_index
-- ----------------------------
INSERT INTO `lt_attachment_index` VALUES ('c-17-1', '5');
INSERT INTO `lt_attachment_index` VALUES ('c-10-3', '4');
INSERT INTO `lt_attachment_index` VALUES ('c-17-2', '6');
INSERT INTO `lt_attachment_index` VALUES ('c-17-3', '7');
INSERT INTO `lt_attachment_index` VALUES ('c-24-4', '8');
INSERT INTO `lt_attachment_index` VALUES ('c-24-5', '9');
INSERT INTO `lt_attachment_index` VALUES ('c-27-7', '11');
INSERT INTO `lt_attachment_index` VALUES ('c-27-7', '12');
INSERT INTO `lt_attachment_index` VALUES ('c-31-8', '8');
INSERT INTO `lt_attachment_index` VALUES ('c-31-9', '14');
INSERT INTO `lt_attachment_index` VALUES ('c-24-12', '12');
INSERT INTO `lt_attachment_index` VALUES ('c-17-13', '17');
INSERT INTO `lt_attachment_index` VALUES ('c-27-14', '18');
INSERT INTO `lt_attachment_index` VALUES ('c-27-6', '20');

-- ----------------------------
-- Table structure for lt_badword
-- ----------------------------
DROP TABLE IF EXISTS `lt_badword`;
CREATE TABLE `lt_badword` (
  `badid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `badword` char(20) NOT NULL,
  `level` tinyint(5) NOT NULL DEFAULT '1',
  `replaceword` char(20) NOT NULL DEFAULT '0',
  `lastusetime` int(10) unsigned NOT NULL DEFAULT '0',
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`badid`),
  UNIQUE KEY `badword` (`badword`),
  KEY `usetimes` (`replaceword`,`listorder`),
  KEY `hits` (`listorder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_badword
-- ----------------------------

-- ----------------------------
-- Table structure for lt_block
-- ----------------------------
DROP TABLE IF EXISTS `lt_block`;
CREATE TABLE `lt_block` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `name` char(50) DEFAULT NULL,
  `pos` char(30) DEFAULT NULL,
  `type` tinyint(1) DEFAULT '0',
  `data` text,
  `template` text,
  PRIMARY KEY (`id`),
  KEY `pos` (`pos`),
  KEY `type` (`type`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_block
-- ----------------------------
INSERT INTO `lt_block` VALUES ('5', '1', 'pc-底部版权信息', 'copyright', '1', '版权所有：©2019 广州昱晟科技有限公司. All rights reserved.&nbsp;<a style=\"color: rgb(188, 188, 188);\" href=\"http://beian.miit.gov.cn\" target=\"_blank\" _href=\"http://beian.miit.gov.cn\">备案号：粤ICP备19041562号-11</a>', null);
INSERT INTO `lt_block` VALUES ('6', '1', 'pc和wap的首页-banner图', 'banner', '1', '<img alt=\"\" src=\"/statics/pc/img/banner.jpg\" />', null);
INSERT INTO `lt_block` VALUES ('14', '1', 'pc-底部二维码', 'ercode', '1', '<p><img src=\"/statics/pc/image/er.png\" title=\"1563088569135842.png\" alt=\"1563088643.png\"/></p>', null);
INSERT INTO `lt_block` VALUES ('10', '1', 'pc客服代码', 'pc_kf', '1', null, null);
INSERT INTO `lt_block` VALUES ('13', '1', '其他js代码', 'otherjs', '1', null, null);
INSERT INTO `lt_block` VALUES ('12', '1', 'pc-底部电话号码', 'rphone', '1', '<p>联系电话：13026881934</p><p>地址：广州市白云区北太路1627号敏捷科创中心3栋422</p><p>网址：http://www.gzushine.com/</p>', null);
INSERT INTO `lt_block` VALUES ('15', '1', '底部LOGO', 'downlogo', '1', '<img src=\"/statics/pc/image/logo2.png\" alt=\"\"/>', null);

-- ----------------------------
-- Table structure for lt_block_history
-- ----------------------------
DROP TABLE IF EXISTS `lt_block_history`;
CREATE TABLE `lt_block_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blockid` int(10) unsigned DEFAULT '0',
  `data` text,
  `creat_at` int(10) unsigned DEFAULT '0',
  `userid` mediumint(8) unsigned DEFAULT '0',
  `username` char(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for lt_block_priv
-- ----------------------------
DROP TABLE IF EXISTS `lt_block_priv`;
CREATE TABLE `lt_block_priv` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` tinyint(3) unsigned DEFAULT '0',
  `siteid` smallint(5) unsigned DEFAULT '0',
  `blockid` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `blockid` (`blockid`),
  KEY `roleid` (`roleid`,`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_block_priv
-- ----------------------------

-- ----------------------------
-- Table structure for lt_cache
-- ----------------------------
DROP TABLE IF EXISTS `lt_cache`;
CREATE TABLE `lt_cache` (
  `filename` char(50) NOT NULL,
  `path` char(50) NOT NULL,
  `data` mediumtext NOT NULL,
  PRIMARY KEY (`filename`,`path`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for lt_category
-- ----------------------------
DROP TABLE IF EXISTS `lt_category`;
CREATE TABLE `lt_category` (
  `catid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `module` varchar(15) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `parentid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `arrparentid` varchar(255) NOT NULL,
  `child` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `arrchildid` mediumtext NOT NULL,
  `catname` varchar(30) NOT NULL,
  `style` varchar(5) NOT NULL,
  `image` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  `parentdir` varchar(100) NOT NULL,
  `catdir` varchar(30) NOT NULL,
  `url` varchar(100) NOT NULL,
  `items` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `setting` mediumtext NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `sethtml` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `letter` varchar(30) NOT NULL,
  `usable_type` varchar(255) NOT NULL,
  `subtitle` mediumtext COMMENT '副标题',
  `descriptions` mediumtext COMMENT '描述2',
  PRIMARY KEY (`catid`),
  KEY `module` (`module`,`parentid`,`listorder`,`catid`),
  KEY `siteid` (`siteid`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_category
-- ----------------------------
INSERT INTO `lt_category` VALUES ('28', '1', 'content', '0', '1', '0', '0', '1', '28,45,47,61,62,63,64,46', '商数云', '', '', '', '', 'ssy', '/ssy/', '0', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\\u52a0\\u76df\\u76f8\\u5173\\u6807\\u9898\",\"meta_keywords\":\"\\u52a0\\u76df\\u76f8\\u5173\\u5173\\u952e\\u8bcd\",\"meta_description\":\"\\u52a0\\u76df\\u76f8\\u5173\\u63cf\\u8ff0\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '95', '1', '1', 'shangshuyun', '', '', '');
INSERT INTO `lt_category` VALUES ('39', '1', 'content', '1', '0', '0', '0', '1', '39,43,56,57,44,58,59,60', '广告服务', '', '', '', '', 'ads', '/ads/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '94', '1', '0', 'guanggaofuwu', '', 'ABOUT US', null);
INSERT INTO `lt_category` VALUES ('41', '1', 'content', '0', '12', '15', '0,15', '0', '41', '图banner', '', '', '', 'homeindex/', 'pcbanner', '/pcbanner/', '3', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '41', '1', '1', 'tubanner', '', '', '');
INSERT INTO `lt_category` VALUES ('15', '1', 'content', '1', '0', '0', '0', '1', '15,41,48,18,36', '首页各栏目', '', '', '', '', 'homeindex', '/homeindex/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"\",\"page_template\":\"page\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '85', '0', '0', 'shouyegelanmu', '', null, null);
INSERT INTO `lt_category` VALUES ('48', '1', 'content', '1', '0', '15', '0,15', '0', '48', '精准的营销服务', '', '', '', 'homeindex/', 'indexthree', '/indexthree/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '48', '1', '0', 'jingzhundeyingxiaofuwu', '', null, null);
INSERT INTO `lt_category` VALUES ('18', '1', 'content', '1', '0', '15', '0,15', '0', '18', '昱晟优势', '', '', '', 'homeindex/', 'indexone', '/indexone/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '86', '1', '0', 'zuozuoyoushi', '', null, null);
INSERT INTO `lt_category` VALUES ('53', '1', 'content', '0', '1', '30', '0,30', '1', '53,65,66', '新闻动态', '', '/statics/pc/image/qysl-banner.jpg', '', 'about/', 'newsInformation', '/newsInformation/', '6', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '52', '1', '1', 'xinwendongtai', '', '', '');
INSERT INTO `lt_category` VALUES ('27', '1', 'content', '0', '13', '0', '0', '0', '27', '成功案例', '', '/statics/pc/image/cgal-banner.jpg', '您身边的智能营销专家', '', 'success-cases', '/success-cases/', '5', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list_successcase\",\"show_template\":\"show_successcase\",\"meta_title\":\"\\u4ea7\\u54c1\\u5c55\\u793a\\u6807\\u9898\",\"meta_keywords\":\"\\u4ea7\\u54c1\\u5c55\\u793a\\u5173\\u952e\\u8bcd\",\"meta_description\":\"\\u4ea7\\u54c1\\u5c55\\u793a\\u63cf\\u8ff0\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '96', '1', '1', 'chenggonganli', '', '品效共赢，众多客户的选择', '');
INSERT INTO `lt_category` VALUES ('30', '1', 'content', '0', '1', '0', '0', '1', '30,51,53,65,66,52,67,68,69,70', '关于我们', '', '', '', '', 'about', '/about/', '0', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\\u65b0\\u95fb\\u4e2d\\u5fc3\\u6807\\u9898\",\"meta_keywords\":\"\\u65b0\\u95fb\\u4e2d\\u5fc3\\u5173\\u952e\\u8bcd\",\"meta_description\":\"\\u65b0\\u95fb\\u4e2d\\u5fc3\\u63cf\\u8ff0\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '97', '1', '1', 'guanyuwomen', '', '', '');
INSERT INTO `lt_category` VALUES ('51', '1', 'content', '1', '0', '30', '0,30', '0', '51', '关于我们', '', '/statics/pc/image/gywm-banner.jpg', '精准营销，您身边的智能营销专家', 'about/', 'about-us', '/about-us/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_about\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '51', '1', '1', 'guanyuwomen', '', null, null);
INSERT INTO `lt_category` VALUES ('52', '1', 'content', '1', '0', '30', '0,30', '1', '52,67,68,69,70', '加入我们', '', '', '', 'about/', 'join-us', '/join-us/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_about\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '53', '1', '1', 'jiaruwomen', '', null, null);
INSERT INTO `lt_category` VALUES ('35', '1', 'content', '1', '0', '0', '0', '0', '35', '首      页', '', '', '', '', 'indexhome', '/indexhome/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"\",\"meta_title\":\"\\u4e3b\\u9875\\u6807\\u9898\",\"meta_keywords\":\"\\u4e3b\\u9875\\u5173\\u952e\\u8bcd\",\"meta_description\":\"\\u4e3b\\u9875\\u63cf\\u8ff0\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '93', '0', '0', 'shou      ye', '', null, null);
INSERT INTO `lt_category` VALUES ('34', '1', 'content', '1', '0', '0', '0', '0', '34', '联系我们', '', '/statics/pc/image/lxwm-banner.jpg', '联系我们', '', 'contact', '/contact/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_contact\",\"meta_title\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u6807\\u9898\",\"meta_keywords\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u5173\\u952e\\u8bcd\",\"meta_description\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u63cf\\u8ff0\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '99', '1', '0', 'lianxiwomen', '', null, null);
INSERT INTO `lt_category` VALUES ('36', '1', 'content', '1', '0', '15', '0,15', '0', '36', '客户案例', '', '', '', 'homeindex/', 'indextwo', '/indextwo/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '88', '1', '0', 'kehuanli', '', null, null);
INSERT INTO `lt_category` VALUES ('43', '1', 'content', '1', '0', '39', '0,39', '1', '43,56,57', '媒介开户', '', '', '', 'ads/', 'openorigin', '/openorigin/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ads_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '43', '1', '0', 'meijiekaihu', '', null, null);
INSERT INTO `lt_category` VALUES ('56', '1', 'content', '1', '0', '43', '0,39,43', '0', '56', '搜索广告', '', '/statics/pc/image/ssgg-banner.jpg', '广告资源平台深度合作 高效开户', 'ads/openorigin/', 'search-ads', '/search-ads/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ads_one\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '56', '1', '0', 'sousuoguanggao', '', null, null);
INSERT INTO `lt_category` VALUES ('44', '1', 'content', '1', '0', '39', '0,39', '1', '44,58,59', '广告运营', '', '', '', 'ads/', 'ads-operative', '/ads-operative/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ads_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '44', '1', '0', 'guanggaoyunying', '', null, null);
INSERT INTO `lt_category` VALUES ('57', '1', 'content', '1', '0', '43', '0,39,43', '0', '57', '信息流广告', '', '/statics/pc/image/xxgg-banner.jpg', '聚合主流资源的流量平台', 'ads/openorigin/', 'info-ads', '/info-ads/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ads_one\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '57', '1', '0', 'xinxiliuguanggao', '', null, null);
INSERT INTO `lt_category` VALUES ('45', '1', 'content', '1', '0', '28', '0,28', '1', '45,47,61,62,63,64', '产品中心', '', '/statics/pc/image/cp-banner.jpg', '让营销更智能，让效果更突出', 'ssy/', 'product', '/product/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ssy_one\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '45', '1', '1', 'chanpinzhongxin', '', null, null);
INSERT INTO `lt_category` VALUES ('46', '1', 'content', '1', '0', '28', '0,28', '0', '46', '解决方案', '', '/statics/pc/image/jjfa-banner.jpg', '高效，从提高销售质量开始', 'ssy/', 'solution', '/solution/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ssy_three\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '46', '1', '1', 'jiejuefangan', '', null, null);
INSERT INTO `lt_category` VALUES ('47', '1', 'content', '1', '0', '45', '0,28,45', '0', '47', '商数云CRM', '', '/statics/pc/image/ssy-banner.jpg', '汇聚各路商机，高效转化业绩', 'ssy/product/', 'ssy-crm', '/ssy-crm/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ssy_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '47', '1', '1', 'shangshuyuncrm', '', null, null);
INSERT INTO `lt_category` VALUES ('65', '1', 'content', '0', '1', '53', '0,30,53', '0', '65', '新闻资讯', '', '/statics/pc/image/xw-banner.jpg', '精准营销，您身边的智能营销专家', 'about/newsInformation/', 'news-info', '/news-info/', '15', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '65', '0', '1', 'xinwenzixun', '', '', '');
INSERT INTO `lt_category` VALUES ('58', '1', 'content', '1', '0', '44', '0,39,44', '0', '58', '营销产品', '', '/statics/pc/image/yxzx-banner.jpg', '精准营销 品效双赢', 'ads/ads-operative/', 'market-center', '/market-center/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ads_three\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '58', '1', '0', 'yingxiaochanpin', '', null, null);
INSERT INTO `lt_category` VALUES ('59', '1', 'content', '1', '0', '44', '0,39,44', '0', '59', '信息流推广', '', '/statics/pc/image/xxltg-banner.jpg', '主流媒体 全面覆盖', 'ads/ads-operative/', 'tips-spread', '/tips-spread/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ads_three\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '59', '1', '0', 'xinxiliutuiguang', '', null, null);
INSERT INTO `lt_category` VALUES ('60', '1', 'content', '1', '0', '39', '0,39', '0', '60', '营销策划', '', '/statics/pc/image/yxch-banner.jpg', '好的营销策划，是创意+策略的黄金组合', 'ads/', 'market-plan', '/market-plan/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ads_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '60', '1', '0', 'yingxiaocehua', '', null, null);
INSERT INTO `lt_category` VALUES ('61', '1', 'content', '1', '0', '45', '0,28,45', '0', '61', '商数云智能建站', '', '/statics/pc/image/znjz-banner.jpg', '专业的技术，简单的操作', 'ssy/product/', 'ssy-znjz', '/ssy-znjz/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ssy_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '61', '1', '1', 'shangshuyunzhinengjianzhan', '', null, null);
INSERT INTO `lt_category` VALUES ('62', '1', 'content', '1', '0', '45', '0,28,45', '0', '62', '商数云呼叫中心', '', '/statics/pc/image/hj-banner.jpg', '智能外呼，全面追踪数据', 'ssy/product/', 'ssy-call-center', '/ssy-call-center/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ssy_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '62', '1', '1', 'shangshuyunhujiaozhongxin', '', null, null);
INSERT INTO `lt_category` VALUES ('63', '1', 'content', '1', '0', '45', '0,28,45', '0', '63', '进率客服工具', '', '/statics/pc/image/kf-banner.jpg', '智能客服 高效咨询', 'ssy/product/', 'ssy-kf', '/ssy-kf/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ssy_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '63', '1', '1', 'jinlvkefugongju', '', null, null);
INSERT INTO `lt_category` VALUES ('64', '1', 'content', '1', '0', '45', '0,28,45', '0', '64', '进率网页回呼', '', '/statics/pc/image/hh-banner.jpg', '精准分析，效果翻倍', 'ssy/product/', 'ssy-hh', '/ssy-hh/', '0', '0', '{\"ishtml\":\"1\",\"template_list\":\"default\",\"page_template\":\"page_ssy_two\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"1\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}', '64', '1', '1', 'jinlvwangyehuihu', '', null, null);
INSERT INTO `lt_category` VALUES ('66', '1', 'content', '0', '1', '53', '0,30,53', '0', '66', '行业新闻', '', '/statics/pc/image/xw-banner.jpg', '精准营销，您身边的智能营销专家', 'about/newsInformation/', 'news-industry', '/news-industry/', '0', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '66', '0', '1', 'xingyexinwen', '', '', '');
INSERT INTO `lt_category` VALUES ('67', '1', 'content', '0', '15', '52', '0,30,52', '0', '67', '精准事业部', '', '/statics/pc/image/jrwm-banner.jpg', '我们要<strong>招人</strong>', 'about/join-us/', 'prebusiness', '/prebusiness/', '2', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list_prebusiness\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '67', '0', '1', 'jingzhunshiyebu', '', '你要<strong>赚钱</strong>吗？', '有梦想一起拼');
INSERT INTO `lt_category` VALUES ('68', '1', 'content', '0', '15', '52', '0,30,52', '0', '68', '产品管理事业部', '', '/statics/pc/image/jrwm-banner.jpg', '我们要<strong>招人</strong>', 'about/join-us/', 'productbusiness', '/productbusiness/', '0', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list_prebusiness\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '68', '0', '1', 'chanpinguanlishiyebu', '', '你要<strong>赚钱</strong>吗？', '有梦想一起拼');
INSERT INTO `lt_category` VALUES ('69', '1', 'content', '0', '15', '52', '0,30,52', '0', '69', '客服部', '', '/statics/pc/image/jrwm-banner.jpg', '我们要<strong>招人</strong>', 'about/join-us/', 'kefupart', '/kefupart/', '0', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list_prebusiness\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '69', '0', '1', 'kefubu', '', '你要<strong>赚钱</strong>吗？', '有梦想一起拼');
INSERT INTO `lt_category` VALUES ('70', '1', 'content', '0', '15', '52', '0,30,52', '0', '70', '人力与行政部', '', '/statics/pc/image/jrwm-banner.jpg', '我们要<strong>招人</strong>', 'about/join-us/', 'humanmanagement', '/humanmanagement/', '0', '0', '{\"workflowid\":\"\",\"ishtml\":\"1\",\"content_ishtml\":\"1\",\"create_to_html_root\":\"1\",\"template_list\":\"default\",\"category_template\":\"category\",\"list_template\":\"list_prebusiness\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"1\",\"show_ruleid\":\"18\"}', '70', '0', '1', 'renliyuxingzhengbu', '', '你要<strong>赚钱</strong>吗？', '有梦想一起拼');

-- ----------------------------
-- Table structure for lt_category_priv
-- ----------------------------
DROP TABLE IF EXISTS `lt_category_priv`;
CREATE TABLE `lt_category_priv` (
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `roleid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `action` char(30) NOT NULL,
  KEY `catid` (`catid`,`roleid`,`is_admin`,`action`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_category_priv
-- ----------------------------

-- ----------------------------
-- Table structure for lt_content_check
-- ----------------------------
DROP TABLE IF EXISTS `lt_content_check`;
CREATE TABLE `lt_content_check` (
  `checkid` char(15) NOT NULL,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `title` char(80) NOT NULL,
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `username` (`username`),
  KEY `checkid` (`checkid`),
  KEY `status` (`status`,`inputtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_content_check
-- ----------------------------

-- ----------------------------
-- Table structure for lt_copyfrom
-- ----------------------------
DROP TABLE IF EXISTS `lt_copyfrom`;
CREATE TABLE `lt_copyfrom` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sitename` varchar(30) NOT NULL,
  `siteurl` varchar(100) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_copyfrom
-- ----------------------------

-- ----------------------------
-- Table structure for lt_datacall
-- ----------------------------
DROP TABLE IF EXISTS `lt_datacall`;
CREATE TABLE `lt_datacall` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(40) DEFAULT NULL,
  `dis_type` tinyint(1) unsigned DEFAULT '0',
  `type` tinyint(1) DEFAULT '0',
  `module` char(20) DEFAULT NULL,
  `action` char(20) DEFAULT NULL,
  `data` text,
  `template` text,
  `cache` mediumint(8) DEFAULT NULL,
  `num` smallint(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_datacall
-- ----------------------------

-- ----------------------------
-- Table structure for lt_dbsource
-- ----------------------------
DROP TABLE IF EXISTS `lt_dbsource`;
CREATE TABLE `lt_dbsource` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `host` varchar(20) NOT NULL,
  `port` int(5) NOT NULL DEFAULT '3306',
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `dbname` varchar(50) NOT NULL,
  `dbtablepre` varchar(30) NOT NULL,
  `charset` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_dbsource
-- ----------------------------

-- ----------------------------
-- Table structure for lt_domain
-- ----------------------------
DROP TABLE IF EXISTS `lt_domain`;
CREATE TABLE `lt_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL COMMENT '发送请求过来的站点域名',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0别人请求过来的,1发送过去的请求',
  `tplcode` int(11) DEFAULT NULL COMMENT '模板识别码，因为每套模板不一样导致',
  `tplname` varchar(255) DEFAULT NULL COMMENT '这套模板的名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_domain
-- ----------------------------
INSERT INTO `lt_domain` VALUES ('1', 'versioncms.blueto.net', '1', '6', '待定6');

-- ----------------------------
-- Table structure for lt_extend_setting
-- ----------------------------
DROP TABLE IF EXISTS `lt_extend_setting`;
CREATE TABLE `lt_extend_setting` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `key` char(30) NOT NULL,
  `data` mediumtext,
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_extend_setting
-- ----------------------------

-- ----------------------------
-- Table structure for lt_favorite
-- ----------------------------
DROP TABLE IF EXISTS `lt_favorite`;
CREATE TABLE `lt_favorite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` char(100) NOT NULL,
  `url` char(100) NOT NULL,
  `adddate` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for lt_hits
-- ----------------------------
DROP TABLE IF EXISTS `lt_hits`;
CREATE TABLE `lt_hits` (
  `hitsid` char(30) NOT NULL,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `yesterdayviews` int(10) unsigned NOT NULL DEFAULT '0',
  `dayviews` int(10) unsigned NOT NULL DEFAULT '0',
  `weekviews` int(10) unsigned NOT NULL DEFAULT '0',
  `monthviews` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`hitsid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for lt_ipbanned
-- ----------------------------
DROP TABLE IF EXISTS `lt_ipbanned`;
CREATE TABLE `lt_ipbanned` (
  `ipbannedid` smallint(5) NOT NULL AUTO_INCREMENT,
  `ip` char(15) NOT NULL,
  `expires` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipbannedid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_ipbanned
-- ----------------------------

-- ----------------------------
-- Table structure for lt_jobinfo
-- ----------------------------
DROP TABLE IF EXISTS `lt_jobinfo`;
CREATE TABLE `lt_jobinfo` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` char(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_jobinfo
-- ----------------------------
INSERT INTO `lt_jobinfo` VALUES ('3', '67', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');
INSERT INTO `lt_jobinfo` VALUES ('4', '67', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');
INSERT INTO `lt_jobinfo` VALUES ('5', '67', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');
INSERT INTO `lt_jobinfo` VALUES ('6', '67', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');
INSERT INTO `lt_jobinfo` VALUES ('7', '67', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');
INSERT INTO `lt_jobinfo` VALUES ('8', '68', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');
INSERT INTO `lt_jobinfo` VALUES ('9', '68', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');
INSERT INTO `lt_jobinfo` VALUES ('10', '68', '0', '高级广告营销师', '', '', '', '', '0', '', '0', '99', '1', 'lantu', '1564624777', '1564624815');

-- ----------------------------
-- Table structure for lt_jobinfo_data
-- ----------------------------
DROP TABLE IF EXISTS `lt_jobinfo_data`;
CREATE TABLE `lt_jobinfo_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `jobsrequire` mediumtext NOT NULL,
  `jobsduty` mediumtext NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_jobinfo_data
-- ----------------------------
INSERT INTO `lt_jobinfo_data` VALUES ('3', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');
INSERT INTO `lt_jobinfo_data` VALUES ('4', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');
INSERT INTO `lt_jobinfo_data` VALUES ('5', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');
INSERT INTO `lt_jobinfo_data` VALUES ('6', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');
INSERT INTO `lt_jobinfo_data` VALUES ('7', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');
INSERT INTO `lt_jobinfo_data` VALUES ('8', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');
INSERT INTO `lt_jobinfo_data` VALUES ('9', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');
INSERT INTO `lt_jobinfo_data` VALUES ('10', '', '0', '0', '', '0', '<p>1、热爱互联网行业，积极向上，具有强烈的团队精神；</p><p>2、具有一定的营销意识；</p><p>3、大专（含）及以上学历，男女不限，专业不限，行业不限；</p><p>4、熟悉互联网广告，至少2年以上的SEM相关工作经验；</p><p>5、逻辑性强，积极主动，责任心强，能独立分析和解决问题；</p><p>6、对数据敏感，具备较强数据分析能力；</p>', '<p>1、熟练综合运用主流搜索引擎广告投放系统分析广告数据，制定投放策略，跟踪优化广告投放效果，达成投放目标；</p><p>2、不断优化投放物料，推广页面等，提升转化率；</p><p>3、关注市场与竞争对手变化，并根据市场与竞争对手变化结合公司情况做出相应调整；</p><p>4、岗位相关的其他工作或流程；</p>');

-- ----------------------------
-- Table structure for lt_keylink
-- ----------------------------
DROP TABLE IF EXISTS `lt_keylink`;
CREATE TABLE `lt_keylink` (
  `keylinkid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `word` char(40) NOT NULL,
  `url` char(100) NOT NULL,
  PRIMARY KEY (`keylinkid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_keylink
-- ----------------------------

-- ----------------------------
-- Table structure for lt_keyword
-- ----------------------------
DROP TABLE IF EXISTS `lt_keyword`;
CREATE TABLE `lt_keyword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `keyword` char(100) NOT NULL,
  `pinyin` char(100) NOT NULL,
  `videonum` int(11) NOT NULL DEFAULT '0',
  `searchnums` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `keyword` (`keyword`,`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_keyword
-- ----------------------------
INSERT INTO `lt_keyword` VALUES ('1', '1', 'dfg', 'dfg', '1', '0');
INSERT INTO `lt_keyword` VALUES ('2', '1', 'dddd', 'dddd', '1', '0');
INSERT INTO `lt_keyword` VALUES ('3', '1', 'fffffff', 'fffffff', '1', '0');
INSERT INTO `lt_keyword` VALUES ('4', '1', 'aaa', 'aaa', '2', '0');
INSERT INTO `lt_keyword` VALUES ('5', '1', '加盟优势', 'jiamengyoushi', '1', '0');
INSERT INTO `lt_keyword` VALUES ('6', '1', '舒芙蕾', 'shuzuolei', '5', '0');
INSERT INTO `lt_keyword` VALUES ('7', '1', '优势', 'youshi', '1', '0');
INSERT INTO `lt_keyword` VALUES ('8', '1', '', '', '41', '0');
INSERT INTO `lt_keyword` VALUES ('9', '1', 'bbb', 'bbb', '1', '0');
INSERT INTO `lt_keyword` VALUES ('10', '1', 'mfg', 'mfg', '1', '0');
INSERT INTO `lt_keyword` VALUES ('11', '1', 'dsfgdf', 'dsfgdf', '1', '0');
INSERT INTO `lt_keyword` VALUES ('12', '1', '啊', 'a', '1', '0');

-- ----------------------------
-- Table structure for lt_keyword_data
-- ----------------------------
DROP TABLE IF EXISTS `lt_keyword_data`;
CREATE TABLE `lt_keyword_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagid` int(10) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `contentid` char(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tagid` (`tagid`,`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_keyword_data
-- ----------------------------
INSERT INTO `lt_keyword_data` VALUES ('1', '1', '1', '1-1');
INSERT INTO `lt_keyword_data` VALUES ('2', '2', '1', '2-1');
INSERT INTO `lt_keyword_data` VALUES ('3', '3', '1', '3-1');
INSERT INTO `lt_keyword_data` VALUES ('4', '4', '1', '4-1');
INSERT INTO `lt_keyword_data` VALUES ('5', '5', '1', '5-1');
INSERT INTO `lt_keyword_data` VALUES ('6', '6', '1', '5-1');
INSERT INTO `lt_keyword_data` VALUES ('7', '6', '1', '6-1');
INSERT INTO `lt_keyword_data` VALUES ('8', '6', '1', '7-1');
INSERT INTO `lt_keyword_data` VALUES ('9', '7', '1', '8-1');
INSERT INTO `lt_keyword_data` VALUES ('10', '6', '1', '8-1');
INSERT INTO `lt_keyword_data` VALUES ('11', '8', '1', '9-1');
INSERT INTO `lt_keyword_data` VALUES ('12', '4', '1', '10-1');
INSERT INTO `lt_keyword_data` VALUES ('13', '9', '1', '11-1');
INSERT INTO `lt_keyword_data` VALUES ('14', '10', '1', '12-1');
INSERT INTO `lt_keyword_data` VALUES ('15', '11', '1', '13-1');
INSERT INTO `lt_keyword_data` VALUES ('16', '12', '1', '14-1');
INSERT INTO `lt_keyword_data` VALUES ('17', '8', '1', '15-1');
INSERT INTO `lt_keyword_data` VALUES ('18', '8', '1', '16-1');
INSERT INTO `lt_keyword_data` VALUES ('19', '8', '1', '17-1');
INSERT INTO `lt_keyword_data` VALUES ('20', '8', '1', '18-1');
INSERT INTO `lt_keyword_data` VALUES ('21', '8', '1', '19-1');
INSERT INTO `lt_keyword_data` VALUES ('22', '8', '1', '20-1');
INSERT INTO `lt_keyword_data` VALUES ('23', '8', '1', '21-1');
INSERT INTO `lt_keyword_data` VALUES ('24', '8', '1', '22-1');
INSERT INTO `lt_keyword_data` VALUES ('25', '8', '1', '23-1');
INSERT INTO `lt_keyword_data` VALUES ('26', '8', '1', '24-1');
INSERT INTO `lt_keyword_data` VALUES ('27', '8', '1', '25-1');
INSERT INTO `lt_keyword_data` VALUES ('28', '8', '1', '26-1');
INSERT INTO `lt_keyword_data` VALUES ('29', '8', '1', '27-1');
INSERT INTO `lt_keyword_data` VALUES ('30', '8', '1', '28-1');
INSERT INTO `lt_keyword_data` VALUES ('31', '8', '1', '29-1');
INSERT INTO `lt_keyword_data` VALUES ('32', '8', '1', '30-1');
INSERT INTO `lt_keyword_data` VALUES ('33', '8', '1', '31-1');
INSERT INTO `lt_keyword_data` VALUES ('34', '8', '1', '32-1');
INSERT INTO `lt_keyword_data` VALUES ('35', '8', '1', '33-1');
INSERT INTO `lt_keyword_data` VALUES ('36', '8', '1', '34-1');
INSERT INTO `lt_keyword_data` VALUES ('37', '8', '1', '35-1');
INSERT INTO `lt_keyword_data` VALUES ('38', '8', '1', '36-1');
INSERT INTO `lt_keyword_data` VALUES ('39', '8', '1', '37-1');
INSERT INTO `lt_keyword_data` VALUES ('40', '8', '1', '1-13');
INSERT INTO `lt_keyword_data` VALUES ('41', '8', '1', '38-1');
INSERT INTO `lt_keyword_data` VALUES ('42', '8', '1', '39-1');
INSERT INTO `lt_keyword_data` VALUES ('43', '8', '1', '40-1');
INSERT INTO `lt_keyword_data` VALUES ('44', '8', '1', '41-1');
INSERT INTO `lt_keyword_data` VALUES ('45', '8', '1', '42-1');
INSERT INTO `lt_keyword_data` VALUES ('46', '8', '1', '43-1');
INSERT INTO `lt_keyword_data` VALUES ('47', '8', '1', '44-1');
INSERT INTO `lt_keyword_data` VALUES ('48', '8', '1', '45-1');
INSERT INTO `lt_keyword_data` VALUES ('49', '8', '1', '46-1');
INSERT INTO `lt_keyword_data` VALUES ('50', '8', '1', '47-1');
INSERT INTO `lt_keyword_data` VALUES ('51', '8', '1', '48-1');
INSERT INTO `lt_keyword_data` VALUES ('52', '8', '1', '49-1');
INSERT INTO `lt_keyword_data` VALUES ('53', '8', '1', '50-1');
INSERT INTO `lt_keyword_data` VALUES ('54', '8', '1', '51-1');
INSERT INTO `lt_keyword_data` VALUES ('55', '8', '1', '52-1');

-- ----------------------------
-- Table structure for lt_link
-- ----------------------------
DROP TABLE IF EXISTS `lt_link`;
CREATE TABLE `lt_link` (
  `linkid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `linktype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `logo` varchar(255) DEFAULT '',
  `introduce` text,
  `username` varchar(30) DEFAULT '',
  `listorder` smallint(5) unsigned DEFAULT '0',
  `nofollow` tinyint(1) unsigned DEFAULT '0',
  `passed` tinyint(1) unsigned DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  KEY `typeid` (`typeid`,`passed`,`listorder`,`linkid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_link
-- ----------------------------
INSERT INTO `lt_link` VALUES ('3', '1', '0', '0', '百度一下', 'http://www.baidu.com', '', '', '', '0', '0', '0', '1537008013');

-- ----------------------------
-- Table structure for lt_log
-- ----------------------------
DROP TABLE IF EXISTS `lt_log`;
CREATE TABLE `lt_log` (
  `logid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field` varchar(15) NOT NULL,
  `value` int(10) unsigned NOT NULL DEFAULT '0',
  `module` varchar(15) NOT NULL,
  `file` varchar(20) NOT NULL,
  `action` varchar(20) NOT NULL,
  `querystring` varchar(255) NOT NULL,
  `data` mediumtext NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` varchar(20) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `time` datetime NOT NULL DEFAULT '2020-07-07 00:00:00',
  PRIMARY KEY (`logid`),
  KEY `module` (`module`,`file`,`action`),
  KEY `username` (`username`,`action`)
) ENGINE=MyISAM AUTO_INCREMENT=5961 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_log
-- ----------------------------

-- ----------------------------
-- Table structure for lt_member
-- ----------------------------
DROP TABLE IF EXISTS `lt_member`;
CREATE TABLE `lt_member` (
  `userid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `phpssouid` mediumint(8) unsigned NOT NULL,
  `username` char(20) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `encrypt` char(6) NOT NULL,
  `nickname` char(20) NOT NULL,
  `regdate` int(10) unsigned NOT NULL DEFAULT '0',
  `lastdate` int(10) unsigned NOT NULL DEFAULT '0',
  `regip` char(15) NOT NULL DEFAULT '',
  `lastip` char(15) NOT NULL DEFAULT '',
  `loginnum` smallint(5) unsigned NOT NULL DEFAULT '0',
  `email` char(32) NOT NULL DEFAULT '',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `areaid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `amount` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `point` smallint(5) unsigned NOT NULL DEFAULT '0',
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `message` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `vip` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `overduedate` int(10) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  `connectid` char(40) NOT NULL DEFAULT '',
  `from` char(10) NOT NULL DEFAULT '',
  `mobile` char(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`(20)),
  KEY `phpssouid` (`phpssouid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_member
-- ----------------------------

-- ----------------------------
-- Table structure for lt_member_detail
-- ----------------------------
DROP TABLE IF EXISTS `lt_member_detail`;
CREATE TABLE `lt_member_detail` (
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `birthday` date DEFAULT NULL,
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_member_detail
-- ----------------------------

-- ----------------------------
-- Table structure for lt_member_group
-- ----------------------------
DROP TABLE IF EXISTS `lt_member_group`;
CREATE TABLE `lt_member_group` (
  `groupid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(15) NOT NULL,
  `issystem` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `starnum` tinyint(2) unsigned NOT NULL,
  `point` smallint(6) unsigned NOT NULL,
  `allowmessage` smallint(5) unsigned NOT NULL DEFAULT '0',
  `allowvisit` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allowpost` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allowpostverify` tinyint(1) unsigned NOT NULL,
  `allowsearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allowupgrade` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `allowsendmessage` tinyint(1) unsigned NOT NULL,
  `allowpostnum` smallint(5) unsigned NOT NULL DEFAULT '0',
  `allowattachment` tinyint(1) NOT NULL,
  `price_y` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `price_m` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `price_d` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `icon` char(30) NOT NULL,
  `usernamecolor` char(7) NOT NULL,
  `description` char(100) NOT NULL,
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `disabled` (`disabled`),
  KEY `listorder` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_member_group
-- ----------------------------
INSERT INTO `lt_member_group` VALUES ('8', '游客', '1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '', '', '', '0', '0');
INSERT INTO `lt_member_group` VALUES ('2', '新手上路', '1', '1', '50', '100', '1', '1', '0', '0', '0', '1', '0', '0', '50.00', '10.00', '1.00', '', '', '', '2', '0');
INSERT INTO `lt_member_group` VALUES ('6', '注册会员', '1', '2', '100', '150', '0', '1', '0', '0', '1', '1', '0', '0', '300.00', '30.00', '1.00', '', '', '', '6', '0');
INSERT INTO `lt_member_group` VALUES ('4', '中级会员', '1', '3', '150', '500', '1', '1', '0', '1', '1', '1', '0', '0', '500.00', '60.00', '1.00', '', '', '', '4', '0');
INSERT INTO `lt_member_group` VALUES ('5', '高级会员', '1', '5', '300', '999', '1', '1', '0', '1', '1', '1', '0', '0', '360.00', '90.00', '5.00', '', '', '', '5', '0');
INSERT INTO `lt_member_group` VALUES ('1', '禁止访问', '1', '0', '0', '0', '1', '1', '0', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '', '', '0', '0', '0');
INSERT INTO `lt_member_group` VALUES ('7', '邮件认证', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0.00', '0.00', '0.00', 'images/group/vip.jpg', '#000000', '', '7', '0');

-- ----------------------------
-- Table structure for lt_member_menu
-- ----------------------------
DROP TABLE IF EXISTS `lt_member_menu`;
CREATE TABLE `lt_member_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL DEFAULT '',
  `c` char(20) NOT NULL DEFAULT '',
  `a` char(20) NOT NULL DEFAULT '',
  `data` char(100) NOT NULL DEFAULT '',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0',
  `display` enum('1','0') NOT NULL DEFAULT '1',
  `isurl` varchar(10) NOT NULL DEFAULT '0',
  `url` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`),
  KEY `module` (`m`,`c`,`a`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_member_menu
-- ----------------------------
INSERT INTO `lt_member_menu` VALUES ('1', 'member_init', '0', 'member', 'index', 'init', 't=0', '0', '1', '', '');
INSERT INTO `lt_member_menu` VALUES ('2', 'account_manage', '0', 'member', 'index', 'account_manage', 't=1', '0', '1', '', '');
INSERT INTO `lt_member_menu` VALUES ('3', 'favorite', '0', 'member', 'index', 'favorite', 't=2', '0', '1', '', '');

-- ----------------------------
-- Table structure for lt_member_verify
-- ----------------------------
DROP TABLE IF EXISTS `lt_member_verify`;
CREATE TABLE `lt_member_verify` (
  `userid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `password` char(32) NOT NULL,
  `encrypt` char(6) NOT NULL,
  `nickname` char(20) NOT NULL,
  `regdate` int(10) unsigned NOT NULL,
  `regip` char(15) NOT NULL,
  `email` char(32) NOT NULL,
  `modelid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `point` smallint(5) unsigned NOT NULL DEFAULT '0',
  `amount` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `modelinfo` char(255) NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siteid` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `message` char(100) DEFAULT NULL,
  `mobile` char(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`(20))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_member_verify
-- ----------------------------

-- ----------------------------
-- Table structure for lt_member_vip
-- ----------------------------
DROP TABLE IF EXISTS `lt_member_vip`;
CREATE TABLE `lt_member_vip` (
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_member_vip
-- ----------------------------

-- ----------------------------
-- Table structure for lt_menu
-- ----------------------------
DROP TABLE IF EXISTS `lt_menu`;
CREATE TABLE `lt_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `beizhu` varchar(50) DEFAULT NULL,
  `parentid` smallint(6) NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL DEFAULT '',
  `c` char(20) NOT NULL DEFAULT '',
  `a` char(20) NOT NULL DEFAULT '',
  `data` char(100) NOT NULL DEFAULT '',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0',
  `display` enum('1','0') NOT NULL DEFAULT '1',
  `project1` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project2` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project3` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project4` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project5` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`),
  KEY `module` (`m`,`c`,`a`)
) ENGINE=MyISAM AUTO_INCREMENT=1520 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_menu
-- ----------------------------
INSERT INTO `lt_menu` VALUES ('1', 'sys_setting', null, '0', 'admin', 'setting', 'init', '', '1', '1', '0', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('2', 'module', null, '0', 'admin', 'module', 'init', '', '2', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('872', 'sync_release_point', null, '873', 'release', 'index', 'init', '', '3', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('4', 'content', null, '0', 'content', 'content', 'init', '', '6', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('5', 'members', null, '0', 'member', 'member', 'init', '', '5', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('6', 'userinterface', null, '0', 'template', 'style', 'init', '', '4', '0', '0', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('30', 'correlative_setting', null, '1', 'admin', 'admin', 'admin', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('31', 'menu_manage', null, '49', 'admin', 'menu', 'init', '', '8', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('32', 'posid_manage', null, '975', 'admin', 'position', 'init', '', '7', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('29', 'module_list', null, '2', 'admin', 'module', '', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('82', 'module_manage', null, '2', 'admin', 'module', '', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('10', 'panel', null, '0', 'admin', 'index', 'public_main', '', '0', '1', '0', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('35', 'menu_add', null, '31', 'admin', 'menu', 'add', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('826', 'template_manager', null, '6', '', '', '', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('54', 'admin_manage', null, '49', 'admin', 'admin_manage', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('43', 'category_manage', null, '975', 'admin', 'category', 'init', 'module=admin', '4', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('42', 'add_category', null, '43', 'admin', 'category', 'add', 's=0', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('44', 'edit_category', null, '43', 'admin', 'category', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('45', 'badword_manage', null, '977', 'admin', 'badword', 'init', '', '10', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('46', 'posid_add', null, '32', 'admin', 'position', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('49', 'admin_setting', null, '1', 'admin', '', '', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('50', 'role_manage', null, '49', 'admin', 'role', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('51', 'role_add', null, '50', 'admin', 'role', 'add', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('52', 'category_cache', null, '43', 'admin', 'category', 'public_cache', 'module=admin', '4', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('55', 'manage_member', null, '5', 'member', 'member', 'manage', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('58', 'admin_add', null, '54', 'admin', 'admin_manage', 'add', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('59', 'model_manage', null, '49', 'content', 'sitemodel', 'init', '', '5', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('64', 'site_management', null, '30', 'admin', 'site', 'init', '', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('81', 'member_add', null, '72', 'member', 'member', 'add', '', '2', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('62', 'add_model', null, '59', 'content', 'sitemodel', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('65', 'release_point_management', null, '30', 'admin', 'release_point', 'init', '', '3', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('66', 'badword_export', null, '45', 'admin', 'badword', 'export', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('67', 'add_site', null, '64', 'admin', 'site', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('68', 'badword_import', null, '45', 'admin', 'badword', 'import', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('812', 'member_group_manage', null, '76', 'member', 'member_group', 'manage', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('74', 'member_verify', null, '55', 'member', 'member_verify', 'manage', 's=0', '3', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('76', 'manage_member_group', null, '5', 'member', 'member_group', 'manage', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('77', 'manage_member_model', null, '5', 'member', 'member_model', 'manage', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('78', 'member_group_add', null, '812', 'member', 'member_group', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('79', 'member_model_add', null, '813', 'member', 'member_model', 'add', '', '1', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('80', 'member_model_import', null, '77', 'member', 'member_model', 'import', '', '2', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('72', 'member_manage', null, '55', 'member', 'member', 'manage', '', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('813', 'member_model_manage', null, '77', 'member', 'member_model', 'manage', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('814', 'site_edit', null, '64', 'admin', 'site', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('815', 'site_del', null, '64', 'admin', 'site', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('816', 'release_point_add', null, '65', 'admin', 'release_point', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('817', 'release_point_del', null, '65', 'admin', 'release_point', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('818', 'release_point_edit', null, '65', 'admin', 'release_point', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('821', 'content_publish', null, '4', 'content', 'content', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('822', 'content_manage', null, '821', 'content', 'content', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('867', 'linkage', null, '977', 'admin', 'linkage', 'init', '', '13', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('827', 'template_style', null, '821', 'template', 'style', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('828', 'import_style', null, '827', 'template', 'style', 'import', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('831', 'template_export', null, '827', 'template', 'style', 'export', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('830', 'template_file', null, '827', 'template', 'file', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('832', 'template_onoff', null, '827', 'template', 'style', 'disable', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('833', 'template_updatename', null, '827', 'template', 'style', 'updatename', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('834', 'member_lock', null, '72', 'member', 'member', 'lock', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('835', 'member_unlock', null, '72', 'member', 'member', 'unlock', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('836', 'member_move', null, '72', 'member', 'member', 'move', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('837', 'member_delete', null, '72', 'member', 'member', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('842', 'verify_ignore', null, '74', 'member', 'member_verify', 'manage', 's=2', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('839', 'member_setting', null, '55', 'member', 'member_setting', 'manage', '', '4', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('841', 'verify_pass', null, '74', 'member', 'member_verify', 'manage', 's=1', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('843', 'verify_delete', null, '74', 'member', 'member_verify', 'manage', 's=3', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('844', 'verify_deny', null, '74', 'member', 'member_verify', 'manage', 's=4', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('845', 'never_pass', null, '74', 'member', 'member_verify', 'manage', 's=5', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('846', 'template_file_list', null, '827', 'template', 'file', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('847', 'template_file_edit', null, '827', 'template', 'file', 'edit_file', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('848', 'file_add_file', null, '827', 'template', 'file', 'add_file', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('850', 'listorder', null, '76', 'member', 'member_group', 'sort', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('852', 'priv_setting', null, '50', 'admin', 'role', 'priv_setting', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('853', 'role_priv', null, '50', 'admin', 'role', 'role_priv', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('857', 'attachment_manage', null, '821', 'attachment', 'manage', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('868', 'special', null, '821', 'special', 'special', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('869', 'template_editor', null, '827', 'template', 'file', 'edit_file', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('870', 'template_visualization', null, '827', 'template', 'file', 'visualization', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('871', 'pc_tag_edit', null, '827', 'template', 'file', 'edit_pc_tag', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('873', 'release_manage', null, '4', 'release', 'html', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('874', 'type_manage', null, '975', 'content', 'type_manage', 'init', '', '6', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('875', 'add_type', null, '874', 'content', 'type_manage', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('876', 'linkageadd', null, '867', 'admin', 'linkage', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('877', 'failure_list', null, '872', 'release', 'index', 'failed', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('879', 'member_search', null, '72', 'member', 'member', 'search', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('880', 'queue_del', null, '872', 'release', 'index', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('881', 'member_model_delete', null, '813', 'member', 'member_model', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('882', 'member_model_edit', null, '813', 'member', 'member_model', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('885', 'workflow', null, '977', 'content', 'workflow', 'init', '', '15', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('888', 'add_workflow', null, '885', 'content', 'workflow', 'add', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('889', 'member_modelfield_add', null, '813', 'member', 'member_modelfield', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('890', 'member_modelfield_edit', null, '813', 'member', 'member_modelfield', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('891', 'member_modelfield_delete', null, '813', 'member', 'member_modelfield', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('892', 'member_modelfield_manage', null, '813', 'member', 'member_modelfield', 'manage', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('895', 'sitemodel_import', null, '59', 'content', 'sitemodel', 'import', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('896', 'pay', null, '29', 'pay', 'payment', 'pay_list', 's=3', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('897', 'payments', null, '896', 'pay', 'payment', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('898', 'paylist', null, '896', 'pay', 'payment', 'pay_list', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('899', 'add_content', null, '822', 'content', 'content', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('900', 'modify_deposit', null, '896', 'pay', 'payment', 'modify_deposit', 's=1', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('901', 'check_content', null, '822', 'content', 'content', 'pass', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('902', 'dbsource', null, '29', 'dbsource', 'data', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('905', 'create_content_html', '批量更新内容页', '873', 'content', 'create_html', 'show', '', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('904', 'external_data_sources', null, '902', 'dbsource', 'dbsource_admin', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('906', 'update_urls', null, '49', 'content', 'create_html', 'update_urls', '', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('960', 'node_add', null, '957', 'collection', 'node', 'add', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('909', 'fulltext_search', null, '29', 'search', 'search_type', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('910', 'manage_type', null, '909', 'search', 'search_type', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('911', 'search_setting', null, '909', 'search', 'search_admin', 'setting', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('912', 'createindex', null, '909', 'search', 'search_admin', 'createindex', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('913', 'add_search_type', null, '909', 'search', 'search_type', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('914', 'database_toos', null, '49', 'admin', 'database', 'export', '', '6', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('915', 'database_export', null, '914', 'admin', 'database', 'export', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('916', 'database_import', null, '914', 'admin', 'database', 'import', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('917', 'dbsource_add', null, '902', 'dbsource', 'dbsource_admin', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('918', 'dbsource_edit', null, '902', 'dbsource', 'dbsource_admin', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('919', 'dbsource_del', null, '902', 'dbsource', 'dbsource_admin', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('920', 'dbsource_data_add', null, '902', 'dbsource', 'data', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('921', 'dbsource_data_edit', null, '902', 'dbsource', 'data', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('922', 'dbsource_data_del', null, '902', 'dbsource', 'data', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('926', 'add_special', null, '868', 'special', 'special', 'add', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('927', 'edit_special', null, '868', 'special', 'special', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('928', 'special_list', null, '868', 'special', 'special', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('929', 'special_elite', null, '868', 'special', 'special', 'elite', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('930', 'delete_special', null, '868', 'special', 'special', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('931', 'badword_add', null, '45', 'admin', 'badword', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('932', 'badword_edit', null, '45', 'admin', 'badword', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('933', 'badword_delete', null, '45', 'admin', 'badword', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('934', 'special_listorder', null, '868', 'special', 'special', 'listorder', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('935', 'special_content_list', null, '868', 'special', 'content', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('936', 'special_content_add', null, '935', 'special', 'content', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('937', 'special_content_list', null, '935', 'special', 'content', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('938', 'special_content_edit', null, '935', 'special', 'content', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('939', 'special_content_delete', null, '935', 'special', 'content', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('940', 'special_content_listorder', null, '935', 'special', 'content', 'listorder', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('941', 'special_content_import', null, '935', 'special', 'special', 'import', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('942', 'history_version', null, '827', 'template', 'template_bak', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('943', 'restore_version', null, '827', 'template', 'template_bak', 'restore', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('944', 'del_history_version', null, '827', 'template', 'template_bak', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('945', 'block', null, '821', 'block', 'block_admin', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('946', 'block_add', null, '945', 'block', 'block_admin', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('950', 'block_edit', null, '945', 'block', 'block_admin', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('951', 'block_del', null, '945', 'block', 'block_admin', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('952', 'block_update', null, '945', 'block', 'block_admin', 'block_update', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('953', 'block_restore', null, '945', 'block', 'block_admin', 'history_restore', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('954', 'history_del', null, '945', 'block', 'block_admin', 'history_del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('978', 'urlrule_manage', null, '977', 'admin', 'urlrule', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('957', 'collection_node', null, '821', 'collection', 'node', 'manage', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('979', 'safe_config', null, '30', 'admin', 'setting', 'init', '&tab=2', '11', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('959', 'basic_config', null, '30', 'admin', 'setting', 'init', '', '10', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('961', 'position_edit', null, '32', 'admin', 'position', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('962', 'collection_node_edit', null, '957', 'collection', 'node', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('963', 'collection_node_delete', null, '957', 'collection', 'node', 'del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('990', 'col_url_list', null, '957', 'collection', 'node', 'col_url_list', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('965', 'collection_node_publish', null, '957', 'collection', 'node', 'publist', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('966', 'collection_node_import', null, '957', 'collection', 'node', 'node_import', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('967', 'collection_node_export', null, '957', 'collection', 'node', 'export', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('968', 'collection_node_collection_content', null, '957', 'collection', 'node', 'col_content', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('969', 'googlesitemap', null, '977', 'admin', 'googlesitemap', 'set', '', '11', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('970', 'admininfo', null, '10', 'admin', 'admin_manage', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('971', 'editpwd', null, '970', 'admin', 'admin_manage', 'public_edit_pwd', '', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('972', 'editinfo', null, '970', 'admin', 'admin_manage', 'public_edit_info', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('973', 'keylink', null, '977', 'admin', 'keylink', 'init', '', '12', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('974', 'add_keylink', null, '973', 'admin', 'keylink', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('975', 'content_settings', null, '4', 'content', 'content_settings', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('7', 'extend', null, '0', 'admin', 'extend', 'init_extend', '', '7', '0', '0', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('977', 'extend_all', null, '7', 'admin', 'extend_all', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('980', 'sso_config', null, '30', 'admin', 'setting', 'init', '&tab=3', '12', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('981', 'email_config', null, '30', 'admin', 'setting', 'init', '&tab=4', '13', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('982', 'module_manage', null, '82', 'admin', 'module', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('983', 'ipbanned', null, '977', 'admin', 'ipbanned', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('984', 'add_ipbanned', null, '983', 'admin', 'ipbanned', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('993', 'collection_content_import', null, '957', 'collection', 'node', 'import', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('991', 'copy_node', null, '957', 'collection', 'node', 'copy', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('992', 'content_del', null, '957', 'collection', 'node', 'content_del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('989', 'downsites', null, '977', 'admin', 'downservers', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('994', 'import_program_add', null, '957', 'collection', 'node', 'import_program_add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('995', 'import_program_del', null, '957', 'collection', 'node', 'import_program_del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('996', 'import_content', null, '957', 'collection', 'node', 'import_content', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('997', 'log', null, '970', 'admin', 'log', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('998', 'add_page', null, '43', 'admin', 'category', 'add', 's=1', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('999', 'add_cat_link', null, '43', 'admin', 'category', 'add', 's=2', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1000', 'count_items', null, '43', 'admin', 'category', 'count_items', '', '5', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1001', 'cache_all', null, '977', 'admin', 'cache_all', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1002', 'create_list_html', '批量更新栏目页', '873', 'content', 'create_html', 'category', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1003', 'create_html_quick', null, '10', 'content', 'create_html_opt', 'index', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1004', 'create_index', null, '1003', 'content', 'create_html', 'public_index', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1005', 'scan', null, '977', 'scan', 'index', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1006', 'scan_report', null, '1005', 'scan', 'index', 'scan_report', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1007', 'md5_creat', null, '1005', 'scan', 'index', 'md5_creat', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1008', 'album_import', null, '868', 'special', 'album', 'import', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('8', 'phpsso', null, '0', 'admin', 'phpsso', 'menu', '', '7', '0', '0', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1011', 'edit_content', null, '822', 'content', 'content', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1012', 'push_to_special', null, '822', 'content', 'push', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1023', 'delete_log', null, '997', 'admin', 'log', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1024', 'delete_ip', null, '983', 'admin', 'ipbanned', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1026', 'delete_keylink', null, '973', 'admin', 'keylink', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1027', 'edit_keylink', null, '973', 'admin', 'keylink', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1034', 'operation_pass', null, '74', 'member', 'member_verify', 'pass', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1035', 'operation_delete', null, '74', 'member', 'member_verify', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1039', 'operation_ignore', null, '74', 'member', 'member_verify', 'ignore', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1038', 'settingsave', null, '30', 'admin', 'setting', 'save', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1040', 'admin_edit', null, '54', 'admin', 'admin_manage', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1041', 'operation_reject', null, '74', 'member', 'member_verify', 'reject', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1042', 'admin_delete', null, '54', 'admin', 'admin_manage', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1043', 'card', null, '54', 'admin', 'admin_manage', 'card', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1044', 'creat_card', null, '54', 'admin', 'admin_manage', 'creat_card', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1045', 'remove_card', null, '54', 'admin', 'admin_manage', 'remove_card', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1049', 'member_group_edit', null, '812', 'member', 'member_group', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1048', 'member_edit', null, '72', 'member', 'member', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1050', 'role_edit', null, '50', 'admin', 'role', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1051', 'member_group_delete', null, '812', 'member', 'member_group', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1052', 'member_manage', null, '50', 'admin', 'role', 'member_manage', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1053', 'role_delete', null, '50', 'admin', 'role', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1054', 'member_model_export', null, '77', 'member', 'member_model', 'export', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1055', 'member_model_sort', null, '77', 'member', 'member_model', 'sort', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1056', 'member_model_move', null, '77', 'member', 'member_model', 'move', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1057', 'payment_add', null, '897', 'pay', 'payment', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1058', 'payment_delete', null, '897', 'pay', 'payment', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1059', 'payment_edit', null, '897', 'pay', 'payment', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1060', 'spend_record', null, '896', 'pay', 'spend', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1061', 'pay_stat', null, '896', 'pay', 'payment', 'pay_stat', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1062', 'fields_manage', null, '59', 'content', 'sitemodel_field', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1063', 'edit_model_content', null, '59', 'content', 'sitemodel', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1064', 'disabled_model', null, '59', 'content', 'sitemodel', 'disabled', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1065', 'delete_model', null, '59', 'content', 'sitemodel', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1066', 'export_model', null, '59', 'content', 'sitemodel', 'export', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1067', 'delete', null, '874', 'content', 'type_manage', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1068', 'edit', null, '874', 'content', 'type_manage', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1069', 'add_urlrule', null, '978', 'admin', 'urlrule', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1070', 'edit_urlrule', null, '978', 'admin', 'urlrule', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1071', 'delete_urlrule', null, '978', 'admin', 'urlrule', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1072', 'edit_menu', null, '31', 'admin', 'menu', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1073', 'delete_menu', null, '31', 'admin', 'menu', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1074', 'edit_workflow', null, '885', 'content', 'workflow', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1075', 'delete_workflow', null, '885', 'content', 'workflow', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1076', 'creat_html', null, '868', 'special', 'special', 'html', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1093', 'connect_config', null, '30', 'admin', 'setting', 'init', '&tab=5', '14', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1102', 'view_modelinfo', null, '74', 'member', 'member_verify', 'modelinfo', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1202', 'create_special_list', null, '868', 'special', 'special', 'create_special_list', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1240', 'view_memberlinfo', null, '72', 'member', 'member', 'memberinfo', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1239', 'copyfrom_manage', null, '977', 'admin', 'copyfrom', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1241', 'move_content', null, '822', 'content', 'content', 'remove', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1242', 'poster_template', null, '56', 'poster', 'space', 'poster_template', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1243', 'create_index', null, '873', 'content', 'create_html', 'public_index', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1244', 'add_othors', null, '822', 'content', 'content', 'add_othors', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1295', 'attachment_manager_dir', null, '857', 'attachment', 'manage', 'dir', '', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1296', 'attachment_manager_db', null, '857', 'attachment', 'manage', 'init', '', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1346', 'attachment_address_replace', null, '857', 'attachment', 'address', 'init', '', '3', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1347', 'attachment_address_update', null, '857', 'attachment', 'address', 'update', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1348', 'delete_content', null, '822', 'content', 'content', 'delete', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1349', 'member_menu_manage', null, '977', 'member', 'member_menu', 'manage', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1350', 'member_menu_add', null, '1349', 'member', 'member_menu', 'add', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1351', 'member_menu_edit', null, '1349', 'member', 'member_menu', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1352', 'member_menu_delete', null, '1349', 'member', 'member_menu', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1353', 'batch_show', null, '822', 'content', 'create_html', 'batch_show', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1354', 'pay_delete', null, '898', 'pay', 'payment', 'pay_del', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1355', 'pay_cancel', null, '898', 'pay', 'payment', 'pay_cancel', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1356', 'discount', null, '898', 'pay', 'payment', 'discount', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1360', 'category_batch_edit', null, '43', 'admin', 'category', 'batch_edit', '', '6', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1500', 'listorder', null, '822', 'content', 'content', 'listorder', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1501', 'a_clean_data', null, '873', 'content', 'content', 'clear_data', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `lt_menu` VALUES ('1502', 'link', null, '821', 'link', 'link', 'init', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1503', 'add_link', null, '1502', 'link', 'link', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1504', 'edit_link', null, '1502', 'link', 'link', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1505', 'delete_link', null, '1502', 'link', 'link', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1506', 'link_setting', null, '1502', 'link', 'link', 'setting', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1507', 'add_type', null, '1502', 'link', 'link', 'add_type', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1508', 'list_type', null, '1502', 'link', 'link', 'list_type', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1509', 'check_register', null, '1502', 'link', 'link', 'check_register', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1510', 'wap', null, '29', 'wap', 'wap_admin', 'init', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1511', 'wap_add', null, '1510', 'wap', 'wap_admin', 'add', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1512', 'wap_edit', null, '1510', 'wap', 'wap_admin', 'edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1513', 'wap_delete', null, '1510', 'wap', 'wap_admin', 'delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1514', 'wap_type_manage', null, '1510', 'wap', 'wap_admin', 'type_manage', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1515', 'wap_type_edit', null, '1510', 'wap', 'wap_admin', 'type_edit', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1516', 'wap_type_delete', null, '1510', 'wap', 'wap_admin', 'type_delete', '', '0', '0', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1518', 'content_messbook', null, '4', 'content', 'messbook', 'messadd', '', '0', '1', '1', '1', '1', '1', '1');
INSERT INTO `lt_menu` VALUES ('1519', 'messbook_list', null, '1518', 'content', 'messbook', 'messbook', '', '0', '1', '1', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for lt_messbook
-- ----------------------------
DROP TABLE IF EXISTS `lt_messbook`;
CREATE TABLE `lt_messbook` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` char(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `qq` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `tel` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `channel` varchar(255) NOT NULL DEFAULT '',
  `ziops` varchar(255) NOT NULL DEFAULT '',
  `sheng` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(255) NOT NULL DEFAULT '',
  `shi` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_messbook
-- ----------------------------
INSERT INTO `lt_messbook` VALUES ('30', '999999', '0', 'fff', '', '', '', '', '0', '', '0', '99', '0', '', '1564639144', '0', '', 'test', '16874531234', '', '', '', '', '', '');
INSERT INTO `lt_messbook` VALUES ('29', '999999', '0', '对所有用户登录各个系统后收集用户的浏览器指纹对所有用户登录各', '', '', '', '', '0', '', '0', '99', '0', '', '1564580811', '0', 'a', 'b', '13812341234', 'c', '', 'd', '', '', '');

-- ----------------------------
-- Table structure for lt_messbook_data
-- ----------------------------
DROP TABLE IF EXISTS `lt_messbook_data`;
CREATE TABLE `lt_messbook_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_messbook_data
-- ----------------------------
INSERT INTO `lt_messbook_data` VALUES ('30', 'fff', '0', '0', '', '0');
INSERT INTO `lt_messbook_data` VALUES ('29', '对所有用户登录各个系统后收集用户的浏览器指纹对所有用户登录各个系统后收集用户的浏览器指纹对所有用户登录各个系统后收集用户的浏览器指纹对所有用户登录各个系统后收集用户的浏览器指纹', '0', '0', '', '0');

-- ----------------------------
-- Table structure for lt_model
-- ----------------------------
DROP TABLE IF EXISTS `lt_model`;
CREATE TABLE `lt_model` (
  `modelid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` char(30) NOT NULL,
  `description` char(100) NOT NULL,
  `tablename` char(20) NOT NULL,
  `setting` text NOT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `items` smallint(5) unsigned NOT NULL DEFAULT '0',
  `enablesearch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default_style` char(30) NOT NULL,
  `category_template` char(30) NOT NULL,
  `list_template` char(30) NOT NULL,
  `show_template` char(30) NOT NULL,
  `js_template` varchar(30) NOT NULL,
  `admin_list_template` char(30) NOT NULL,
  `member_add_template` varchar(30) NOT NULL,
  `member_list_template` varchar(30) NOT NULL,
  `sort` tinyint(3) NOT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`modelid`),
  KEY `type` (`type`,`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_model
-- ----------------------------
INSERT INTO `lt_model` VALUES ('1', '1', '文章模型', '', 'news', '', '0', '0', '1', '0', 'default', 'category', 'list', 'show', '', '', '', '', '0', '0');
INSERT INTO `lt_model` VALUES ('12', '1', '图片模型', '', 'picture', '', '0', '0', '1', '0', 'default', 'category', 'list', 'show', '', '', '', '', '0', '0');
INSERT INTO `lt_model` VALUES ('10', '1', '普通会员', '普通会员', 'member_detail', '', '0', '0', '1', '0', '', '', '', '', '', '', '', '', '0', '2');
INSERT INTO `lt_model` VALUES ('13', '1', '成功案例模型', '', 'successcase', '', '0', '0', '1', '0', 'default', 'category', 'list_successcase', 'show_successcase', '', '', '', '', '0', '0');
INSERT INTO `lt_model` VALUES ('14', '1', '留言模型', '', 'messbook', '', '0', '0', '1', '0', 'default', 'category', 'list', 'show', '', '', '', '', '0', '0');
INSERT INTO `lt_model` VALUES ('15', '1', '招聘模型', '', 'jobinfo', '', '0', '0', '1', '0', 'default', 'category', 'list', 'show', '', '', '', '', '0', '0');

-- ----------------------------
-- Table structure for lt_model_field
-- ----------------------------
DROP TABLE IF EXISTS `lt_model_field`;
CREATE TABLE `lt_model_field` (
  `fieldid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `field` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `tips` text NOT NULL,
  `css` varchar(30) NOT NULL,
  `minlength` int(10) unsigned NOT NULL DEFAULT '0',
  `maxlength` int(10) unsigned NOT NULL DEFAULT '0',
  `pattern` varchar(255) NOT NULL,
  `errortips` varchar(255) NOT NULL,
  `formtype` varchar(20) NOT NULL,
  `setting` mediumtext NOT NULL,
  `formattribute` varchar(255) NOT NULL,
  `unsetgroupids` varchar(255) NOT NULL,
  `unsetroleids` varchar(255) NOT NULL,
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issystem` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isunique` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isbase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isfulltext` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isposition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `listorder` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isomnipotent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fieldid`),
  KEY `modelid` (`modelid`,`disabled`),
  KEY `field` (`field`,`modelid`)
) ENGINE=MyISAM AUTO_INCREMENT=216 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_model_field installdate
-- ----------------------------
INSERT INTO `lt_model_field` VALUES ('1', '1', '1', 'catid', '栏目', '', '', '1', '6', '/^[0-9]{1,6}$/', '请选择栏目', 'catid', 'array (\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '0', '0', '1', '0', '0');
INSERT INTO `lt_model_field` VALUES ('2', '1', '1', 'typeid', '类别', '', '', '0', '0', '', '', 'typeid', 'array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '', '', '0', '1', '0', '1', '1', '1', '0', '0', '2', '0', '0');
INSERT INTO `lt_model_field` VALUES ('3', '1', '1', 'title', '标题', '', 'inputtitle', '1', '80', '', '请输入标题', 'title', '', '', '', '', '0', '1', '0', '1', '1', '1', '1', '1', '4', '0', '0');
INSERT INTO `lt_model_field` VALUES ('4', '1', '1', 'thumb', '缩略图', '', '', '0', '100', '', '', 'image', 'array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)', '', '', '', '0', '1', '0', '0', '0', '1', '0', '1', '14', '0', '0');
INSERT INTO `lt_model_field` VALUES ('5', '1', '1', 'keywords', '关键词', '多关键词之间用空格或者“,”隔开', '', '0', '40', '', '', 'keyword', 'array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '1', '0', '7', '0', '0');
INSERT INTO `lt_model_field` VALUES ('6', '1', '1', 'description', '摘要', '', '', '0', '255', '', '', 'textarea', 'array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)', '', '', '', '0', '1', '0', '1', '0', '1', '1', '1', '10', '0', '0');
INSERT INTO `lt_model_field` VALUES ('7', '1', '1', 'updatetime', '更新时间', '', '', '0', '0', '', '', 'datetime', 'array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '12', '0', '0');
INSERT INTO `lt_model_field` VALUES ('8', '1', '1', 'content', '内容', '<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>', '', '1', '999999', '', '内容不能为空', 'editor', 'array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '13', '0', '0');
INSERT INTO `lt_model_field` VALUES ('110', '12', '1', 'title', '标题', '', 'inputtitle', '1', '80', '', '请输入标题', 'title', '', '', '', '', '0', '1', '0', '1', '1', '1', '1', '1', '4', '0', '0');
INSERT INTO `lt_model_field` VALUES ('111', '12', '1', 'keywords', '关键词', '多关键词之间用空格或者“,”隔开', '', '0', '40', '', '', 'keyword', 'array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '1', '0', '7', '1', '0');
INSERT INTO `lt_model_field` VALUES ('112', '12', '1', 'description', '摘要', '', '', '0', '255', '', '', 'textarea', 'array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)', '', '', '', '0', '1', '0', '1', '0', '1', '1', '1', '10', '1', '0');
INSERT INTO `lt_model_field` VALUES ('113', '12', '1', 'updatetime', '更新时间', '', '', '0', '0', '', '', 'datetime', 'array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '12', '0', '0');
INSERT INTO `lt_model_field` VALUES ('11', '1', '1', 'inputtime', '发布时间', '', '', '0', '0', '', '', 'datetime', 'array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)', '', '', '', '0', '1', '0', '0', '0', '0', '0', '1', '17', '0', '0');
INSERT INTO `lt_model_field` VALUES ('12', '1', '1', 'posids', '推荐位', '', '', '0', '0', '', '', 'posid', 'array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)', '', '', '', '0', '1', '0', '1', '0', '0', '0', '0', '18', '1', '0');
INSERT INTO `lt_model_field` VALUES ('13', '1', '1', 'url', 'URL', '', '', '0', '100', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '50', '0', '0');
INSERT INTO `lt_model_field` VALUES ('14', '1', '1', 'listorder', '排序', '', '', '0', '6', '', '', 'number', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '51', '0', '0');
INSERT INTO `lt_model_field` VALUES ('15', '1', '1', 'status', '状态', '', '', '0', '2', '', '', 'box', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '55', '0', '0');
INSERT INTO `lt_model_field` VALUES ('16', '1', '1', 'template', '内容页模板', '', '', '0', '30', '', '', 'template', 'array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '0', '0', '0', '0', '0', '0', '0', '53', '0', '0');
INSERT INTO `lt_model_field` VALUES ('108', '12', '1', 'catid', '栏目', '', '', '1', '6', '/^[0-9]{1,6}$/', '请选择栏目', 'catid', 'array (\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '0', '0', '1', '0', '0');
INSERT INTO `lt_model_field` VALUES ('109', '12', '1', 'typeid', '类别', '', '', '0', '0', '', '', 'typeid', 'array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '', '', '0', '1', '0', '1', '1', '1', '0', '0', '2', '0', '0');
INSERT INTO `lt_model_field` VALUES ('19', '1', '1', 'relation', '相关文章', '', '', '0', '0', '', '', 'omnipotent', 'array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)', '', '2,6,4,5,1,17,18,7', '', '0', '0', '0', '0', '0', '0', '1', '0', '15', '1', '0');
INSERT INTO `lt_model_field` VALUES ('114', '12', '1', 'content', '内容', '<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>', '', '1', '999999', '', '内容不能为空', 'editor', 'array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '13', '1', '0');
INSERT INTO `lt_model_field` VALUES ('21', '1', '1', 'copyfrom', '来源', '', '', '0', '100', '', '', 'copyfrom', 'array (\n  \'defaultvalue\' => \'\',\n)', '', '', '', '0', '0', '0', '1', '0', '1', '0', '0', '8', '1', '0');
INSERT INTO `lt_model_field` VALUES ('80', '1', '1', 'username', '用户名', '', '', '0', '20', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '98', '0', '0');
INSERT INTO `lt_model_field` VALUES ('125', '12', '1', 'status', '状态', '', '', '0', '2', '', '', 'box', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '55', '0', '0');
INSERT INTO `lt_model_field` VALUES ('127', '12', '1', 'username', '用户名', '', '', '0', '20', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '98', '0', '0');
INSERT INTO `lt_model_field` VALUES ('129', '12', '1', 'links', '我要合作网址：', '(可选)例如：http://www.baidu.com', '', '0', '0', '', '', 'text', '{\"size\":\"\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '99', '0', '0');
INSERT INTO `lt_model_field` VALUES ('121', '12', '1', 'url', 'URL', '', '', '0', '100', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '50', '0', '0');
INSERT INTO `lt_model_field` VALUES ('122', '12', '1', 'listorder', '排序', '', '', '0', '6', '', '', 'number', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '51', '0', '0');
INSERT INTO `lt_model_field` VALUES ('123', '12', '1', 'template', '内容页模板', '', '', '0', '30', '', '', 'template', 'array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '0', '0', '0', '0', '0', '0', '0', '53', '0', '0');
INSERT INTO `lt_model_field` VALUES ('118', '12', '1', 'inputtime', '发布时间', '', '', '0', '0', '', '', 'datetime', 'array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)', '', '', '', '0', '1', '0', '0', '0', '0', '0', '1', '17', '0', '0');
INSERT INTO `lt_model_field` VALUES ('119', '12', '1', 'posids', '推荐位', '', '', '0', '0', '', '', 'posid', 'array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)', '', '', '', '0', '1', '0', '1', '0', '0', '0', '0', '18', '1', '0');
INSERT INTO `lt_model_field` VALUES ('115', '12', '1', 'thumb', '缩略图', '', '', '0', '100', '', '', 'image', '{\"size\":\"50\",\"defaultvalue\":\"\",\"show_type\":\"1\",\"upload_maxsize\":\"8024\",\"upload_allowext\":\"jpg|jpeg|gif|png|bmp\",\"watermark\":\"0\",\"isselectimage\":\"1\",\"images_width\":\"\",\"images_height\":\"\"}', '', '', '', '0', '1', '0', '1', '0', '1', '0', '1', '14', '0', '0');
INSERT INTO `lt_model_field` VALUES ('73', '1', '1', 'islink', '转向链接', '', '', '0', '0', '', '', 'islink', '', '', '', '', '0', '1', '0', '0', '0', '1', '0', '0', '30', '1', '0');
INSERT INTO `lt_model_field` VALUES ('83', '10', '1', 'birthday', '生日', '', '', '0', '0', '', '生日格式错误', 'datetime', 'array (\n  \'fieldtype\' => \'date\',\n  \'format\' => \'Y-m-d\',\n  \'defaulttype\' => \'0\',\n)', '', '', '', '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '0');
INSERT INTO `lt_model_field` VALUES ('130', '1', '1', 'author', '作者', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '5', '1', '0');
INSERT INTO `lt_model_field` VALUES ('131', '13', '1', 'catid', '栏目', '', '', '1', '6', '/^[0-9]{1,6}$/', '请选择栏目', 'catid', 'array (\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '0', '0', '1', '0', '0');
INSERT INTO `lt_model_field` VALUES ('132', '13', '1', 'typeid', '类别', '', '', '0', '0', '', '', 'typeid', 'array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '', '', '0', '1', '0', '1', '1', '1', '0', '0', '2', '1', '0');
INSERT INTO `lt_model_field` VALUES ('133', '13', '1', 'title', '标题', '', 'inputtitle', '1', '80', '', '请输入标题', 'title', '', '', '', '', '0', '1', '0', '1', '1', '1', '1', '1', '4', '0', '0');
INSERT INTO `lt_model_field` VALUES ('134', '13', '1', 'keywords', '关键词', '多关键词之间用空格或者“,”隔开', '', '0', '40', '', '', 'keyword', 'array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '1', '0', '5', '0', '0');
INSERT INTO `lt_model_field` VALUES ('163', '14', '1', 'title', '标题', '', 'inputtitle', '1', '80', '', '请输入标题', 'title', '', '', '', '', '0', '1', '0', '1', '1', '1', '1', '1', '3', '0', '0');
INSERT INTO `lt_model_field` VALUES ('136', '13', '1', 'updatetime', '更新时间', '', '', '0', '0', '', '', 'datetime', 'array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '45', '0', '0');
INSERT INTO `lt_model_field` VALUES ('137', '13', '1', 'content', '内容', '<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>', '', '1', '999999', '', '内容不能为空', 'editor', 'array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '46', '0', '0');
INSERT INTO `lt_model_field` VALUES ('138', '13', '1', 'thumb', '缩略图', '', '', '0', '100', '', '', 'image', 'array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)', '', '', '', '0', '1', '0', '0', '0', '1', '0', '1', '47', '0', '0');
INSERT INTO `lt_model_field` VALUES ('157', '13', '1', 'mainkeywordstop', '核心关键词排名top:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '11', '0', '0');
INSERT INTO `lt_model_field` VALUES ('158', '13', '1', 'mainkeywordstxt', '核心关键词排名:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '12', '0', '0');
INSERT INTO `lt_model_field` VALUES ('159', '13', '1', 'description', '摘要：', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '0', '1', '0');
INSERT INTO `lt_model_field` VALUES ('160', '1', '1', 'newstype', '新闻类型：', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '6', '0', '0');
INSERT INTO `lt_model_field` VALUES ('161', '14', '1', 'catid', '栏目', '', '', '1', '6', '/^[0-9]{1,6}$/', '请选择栏目', 'catid', 'array (\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '0', '0', '1', '0', '0');
INSERT INTO `lt_model_field` VALUES ('141', '13', '1', 'inputtime', '发布时间', '', '', '0', '0', '', '', 'datetime', 'array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)', '', '', '', '0', '1', '0', '0', '0', '0', '0', '1', '48', '0', '0');
INSERT INTO `lt_model_field` VALUES ('142', '13', '1', 'posids', '推荐位', '', '', '0', '0', '', '', 'posid', 'array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)', '', '', '', '0', '1', '0', '1', '0', '0', '0', '0', '49', '1', '0');
INSERT INTO `lt_model_field` VALUES ('162', '14', '1', 'typeid', '类别', '', '', '0', '0', '', '', 'typeid', 'array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '', '', '0', '1', '0', '1', '1', '1', '0', '0', '2', '1', '0');
INSERT INTO `lt_model_field` VALUES ('156', '13', '1', 'newstoptxt', '新闻榜:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '10', '0', '0');
INSERT INTO `lt_model_field` VALUES ('144', '13', '1', 'url', 'URL', '', '', '0', '100', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '50', '0', '0');
INSERT INTO `lt_model_field` VALUES ('145', '13', '1', 'listorder', '排序', '', '', '0', '6', '', '', 'number', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '51', '0', '0');
INSERT INTO `lt_model_field` VALUES ('146', '13', '1', 'template', '内容页模板', '', '', '0', '30', '', '', 'template', 'array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '0', '0', '0', '0', '0', '0', '0', '53', '1', '0');
INSERT INTO `lt_model_field` VALUES ('153', '13', '1', 'appmarket', '应用市场推广:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '7', '0', '0');
INSERT INTO `lt_model_field` VALUES ('154', '13', '1', 'getusers', '获取用户:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '8', '0', '0');
INSERT INTO `lt_model_field` VALUES ('155', '13', '1', 'newstop', '新闻榜top:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '9', '0', '0');
INSERT INTO `lt_model_field` VALUES ('148', '13', '1', 'status', '状态', '', '', '0', '2', '', '', 'box', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '55', '0', '0');
INSERT INTO `lt_model_field` VALUES ('152', '13', '1', 'facenews', '封面新闻：', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '6', '0', '0');
INSERT INTO `lt_model_field` VALUES ('150', '13', '1', 'username', '用户名', '', '', '0', '20', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '98', '0', '0');
INSERT INTO `lt_model_field` VALUES ('164', '14', '1', 'keywords', '关键词', '多关键词之间用空格或者“,”隔开', '', '0', '40', '', '', 'keyword', 'array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '1', '0', '43', '1', '0');
INSERT INTO `lt_model_field` VALUES ('165', '14', '1', 'description', '摘要', '', '', '0', '255', '', '', 'textarea', 'array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)', '', '', '', '0', '1', '0', '1', '0', '1', '1', '1', '44', '1', '0');
INSERT INTO `lt_model_field` VALUES ('166', '14', '1', 'updatetime', '更新时间', '', '', '0', '0', '', '', 'datetime', 'array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '45', '0', '0');
INSERT INTO `lt_model_field` VALUES ('167', '14', '1', 'content', '内容', '<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>', '', '1', '999999', '', '内容不能为空', 'editor', 'array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '13', '0', '0');
INSERT INTO `lt_model_field` VALUES ('168', '14', '1', 'thumb', '缩略图', '', '', '0', '100', '', '', 'image', 'array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)', '', '', '', '0', '1', '0', '0', '0', '1', '0', '1', '47', '1', '0');
INSERT INTO `lt_model_field` VALUES ('188', '15', '1', 'catid', '栏目', '', '', '1', '6', '/^[0-9]{1,6}$/', '请选择栏目', 'catid', 'array (\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '0', '0', '1', '0', '0');
INSERT INTO `lt_model_field` VALUES ('189', '15', '1', 'typeid', '类别', '', '', '0', '0', '', '', 'typeid', 'array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '', '', '0', '1', '0', '1', '1', '1', '0', '0', '2', '0', '0');
INSERT INTO `lt_model_field` VALUES ('190', '15', '1', 'title', '标题', '', 'inputtitle', '1', '80', '', '请输入标题', 'title', '', '', '', '', '0', '1', '0', '1', '1', '1', '1', '1', '4', '0', '0');
INSERT INTO `lt_model_field` VALUES ('191', '15', '1', 'keywords', '关键词', '多关键词之间用空格或者“,”隔开', '', '0', '40', '', '', 'keyword', 'array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '1', '0', '7', '1', '0');
INSERT INTO `lt_model_field` VALUES ('192', '15', '1', 'description', '摘要', '', '', '0', '255', '', '', 'textarea', 'array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)', '', '', '', '0', '1', '0', '1', '0', '1', '1', '1', '10', '1', '0');
INSERT INTO `lt_model_field` VALUES ('187', '14', '1', 'ziops', '咨询业务:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '9', '0', '0');
INSERT INTO `lt_model_field` VALUES ('171', '14', '1', 'inputtime', '发布时间', '', '', '0', '0', '', '', 'datetime', 'array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)', '', '', '', '0', '1', '0', '0', '0', '0', '0', '1', '48', '0', '0');
INSERT INTO `lt_model_field` VALUES ('172', '14', '1', 'posids', '推荐位', '', '', '0', '0', '', '', 'posid', 'array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)', '', '', '', '0', '1', '0', '1', '0', '0', '0', '0', '49', '1', '0');
INSERT INTO `lt_model_field` VALUES ('186', '14', '1', 'channel', '渠道:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '8', '0', '0');
INSERT INTO `lt_model_field` VALUES ('174', '14', '1', 'url', 'URL', '', '', '0', '100', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '50', '0', '0');
INSERT INTO `lt_model_field` VALUES ('175', '14', '1', 'listorder', '排序', '', '', '0', '6', '', '', 'number', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '51', '0', '0');
INSERT INTO `lt_model_field` VALUES ('176', '14', '1', 'template', '内容页模板', '', '', '0', '30', '', '', 'template', 'array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '0', '0', '0', '0', '0', '0', '0', '53', '0', '0');
INSERT INTO `lt_model_field` VALUES ('182', '14', '1', 'qq', '公司名称/qq：', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '7', '0', '0');
INSERT INTO `lt_model_field` VALUES ('183', '14', '1', 'name', '姓名', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '4', '0', '0');
INSERT INTO `lt_model_field` VALUES ('178', '14', '1', 'status', '状态', '', '', '0', '2', '', '', 'box', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '55', '0', '0');
INSERT INTO `lt_model_field` VALUES ('184', '14', '1', 'tel', '手机:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '5', '0', '0');
INSERT INTO `lt_model_field` VALUES ('185', '14', '1', 'email', '邮件:', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '6', '0', '0');
INSERT INTO `lt_model_field` VALUES ('180', '14', '1', 'username', '用户名', '', '', '0', '20', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '98', '0', '0');
INSERT INTO `lt_model_field` VALUES ('193', '15', '1', 'updatetime', '更新时间', '', '', '0', '0', '', '', 'datetime', 'array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '12', '0', '0');
INSERT INTO `lt_model_field` VALUES ('194', '15', '1', 'content', '内容', '<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>', '', '1', '999999', '', '内容不能为空', 'editor', 'array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '13', '1', '0');
INSERT INTO `lt_model_field` VALUES ('195', '15', '1', 'thumb', '缩略图', '', '', '0', '100', '', '', 'image', 'array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)', '', '', '', '0', '1', '0', '0', '0', '1', '0', '1', '14', '1', '0');
INSERT INTO `lt_model_field` VALUES ('213', '14', '1', 'sheng', '省', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '10', '0', '0');
INSERT INTO `lt_model_field` VALUES ('214', '14', '1', 'ip', 'IP', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '12', '0', '0');
INSERT INTO `lt_model_field` VALUES ('215', '14', '1', 'shi', '市', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '11', '0', '0');
INSERT INTO `lt_model_field` VALUES ('198', '15', '1', 'inputtime', '发布时间', '', '', '0', '0', '', '', 'datetime', 'array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)', '', '', '', '0', '1', '0', '0', '0', '0', '0', '1', '17', '0', '0');
INSERT INTO `lt_model_field` VALUES ('199', '15', '1', 'posids', '推荐位', '', '', '0', '0', '', '', 'posid', 'array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)', '', '', '', '0', '1', '0', '1', '0', '0', '0', '0', '18', '1', '0');
INSERT INTO `lt_model_field` VALUES ('212', '12', '1', 'futitle', '副标题', '', '', '0', '0', '', '', 'text', '{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '0', '5', '0', '0');
INSERT INTO `lt_model_field` VALUES ('201', '15', '1', 'url', 'URL', '', '', '0', '100', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '50', '0', '0');
INSERT INTO `lt_model_field` VALUES ('202', '15', '1', 'listorder', '排序', '', '', '0', '6', '', '', 'number', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '51', '0', '0');
INSERT INTO `lt_model_field` VALUES ('203', '15', '1', 'template', '内容页模板', '', '', '0', '30', '', '', 'template', 'array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)', '', '-99', '-99', '0', '0', '0', '0', '0', '0', '0', '0', '53', '0', '0');
INSERT INTO `lt_model_field` VALUES ('211', '15', '1', 'jobsduty', '岗位职责：', '', '', '0', '0', '', '', 'editor', '{\"toolbar\":\"basic\",\"defaultvalue\":\"\",\"enablekeylink\":\"0\",\"replacenum\":\"1\",\"link_mode\":\"0\",\"enablesaveimage\":\"0\",\"height\":\"200\"}', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '5', '0', '0');
INSERT INTO `lt_model_field` VALUES ('210', '15', '1', 'jobsrequire', '岗位要求：', '', '', '0', '0', '', '', 'editor', '{\"toolbar\":\"basic\",\"defaultvalue\":\"\",\"enablekeylink\":\"0\",\"replacenum\":\"1\",\"link_mode\":\"0\",\"enablesaveimage\":\"0\",\"height\":\"200\"}', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '6', '0', '0');
INSERT INTO `lt_model_field` VALUES ('205', '15', '1', 'status', '状态', '', '', '0', '2', '', '', 'box', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '55', '0', '0');
INSERT INTO `lt_model_field` VALUES ('207', '15', '1', 'username', '用户名', '', '', '0', '20', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '98', '0', '0');

-- ----------------------------
-- Table structure for lt_module
-- ----------------------------
DROP TABLE IF EXISTS `lt_module`;
CREATE TABLE `lt_module` (
  `module` varchar(15) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(50) NOT NULL,
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `version` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL,
  `setting` mediumtext NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `installdate` date NOT NULL DEFAULT '2020-07-07',
  `updatedate` date NOT NULL DEFAULT '2020-07-07',
  PRIMARY KEY (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_module
-- ----------------------------
INSERT INTO `lt_module` VALUES ('admin', 'admin', '', '1', '1.0', '', '{\"admin_email\":\"kk@haook.cn\",\"maxloginfailedtimes\":\"8\",\"minrefreshtime\":\"2\",\"mail_type\":\"1\",\"mail_server\":\"smtp.qq.com\",\"mail_port\":\"25\",\"category_ajax\":\"0\",\"mail_user\":\"phpcms.cn@foxmail.com\",\"mail_auth\":\"1\",\"mail_from\":\"phpcms.cn@foxmail.com\",\"mail_password\":\"\",\"errorlog_size\":\"20\"}', '0', '0', '2010-10-18', '2010-10-18');
INSERT INTO `lt_module` VALUES ('member', '会员', '', '1', '1.0', '', 'array (\n  \'allowregister\' => \'1\',\n  \'choosemodel\' => \'1\',\n  \'enablemailcheck\' => \'0\',\n  \'registerverify\' => \'0\',\n  \'showapppoint\' => \'0\',\n  \'rmb_point_rate\' => \'10\',\n  \'defualtpoint\' => \'0\',\n  \'defualtamount\' => \'0\',\n  \'showregprotocol\' => \'0\',\n  \'regprotocol\' => \'		 欢迎您注册成为phpcms用户\r\n请仔细阅读下面的协议，只有接受协议才能继续进行注册。 \r\n1．服务条款的确认和接纳\r\n　　phpcms用户服务的所有权和运作权归phpcms拥有。phpcms所提供的服务将按照有关章程、服务条款和操作规则严格执行。用户通过注册程序点击“我同意” 按钮，即表示用户与phpcms达成协议并接受所有的服务条款。\r\n2． phpcms服务简介\r\n　　phpcms通过国际互联网为用户提供新闻及文章浏览、图片浏览、软件下载、网上留言和BBS论坛等服务。\r\n　　用户必须： \r\n　　1)购置设备，包括个人电脑一台、调制解调器一个及配备上网装置。 \r\n　　2)个人上网和支付与此服务有关的电话费用、网络费用。\r\n　　用户同意： \r\n　　1)提供及时、详尽及准确的个人资料。 \r\n　　2)不断更新注册资料，符合及时、详尽、准确的要求。所有原始键入的资料将引用为注册资料。 \r\n　　3)用户同意遵守《中华人民共和国保守国家秘密法》、《中华人民共和国计算机信息系统安全保护条例》、《计算机软件保护条例》等有关计算机及互联网规定的法律和法规、实施办法。在任何情况下，phpcms合理地认为用户的行为可能违反上述法律、法规，phpcms可以在任何时候，不经事先通知终止向该用户提供服务。用户应了解国际互联网的无国界性，应特别注意遵守当地所有有关的法律和法规。\r\n3． 服务条款的修改\r\n　　phpcms会不定时地修改服务条款，服务条款一旦发生变动，将会在相关页面上提示修改内容。如果您同意改动，则再一次点击“我同意”按钮。 如果您不接受，则及时取消您的用户使用服务资格。\r\n4． 服务修订\r\n　　phpcms保留随时修改或中断服务而不需知照用户的权利。phpcms行使修改或中断服务的权利，不需对用户或第三方负责。\r\n5． 用户隐私制度\r\n　　尊重用户个人隐私是phpcms的 基本政策。phpcms不会公开、编辑或透露用户的注册信息，除非有法律许可要求，或phpcms在诚信的基础上认为透露这些信息在以下三种情况是必要的： \r\n　　1)遵守有关法律规定，遵从合法服务程序。 \r\n　　2)保持维护phpcms的商标所有权。 \r\n　　3)在紧急情况下竭力维护用户个人和社会大众的隐私安全。 \r\n　　4)符合其他相关的要求。 \r\n6．用户的帐号，密码和安全性\r\n　　一旦注册成功成为phpcms用户，您将得到一个密码和帐号。如果您不保管好自己的帐号和密码安全，将对因此产生的后果负全部责任。另外，每个用户都要对其帐户中的所有活动和事件负全责。您可随时根据指示改变您的密码，也可以结束旧的帐户重开一个新帐户。用户同意若发现任何非法使用用户帐号或安全漏洞的情况，立即通知phpcms。\r\n7． 免责条款\r\n　　用户明确同意网站服务的使用由用户个人承担风险。 　　 \r\n　　phpcms不作任何类型的担保，不担保服务一定能满足用户的要求，也不担保服务不会受中断，对服务的及时性，安全性，出错发生都不作担保。用户理解并接受：任何通过phpcms服务取得的信息资料的可靠性取决于用户自己，用户自己承担所有风险和责任。 \r\n8．有限责任\r\n　　phpcms对任何直接、间接、偶然、特殊及继起的损害不负责任。\r\n9． 不提供零售和商业性服务 \r\n　　用户使用网站服务的权利是个人的。用户只能是一个单独的个体而不能是一个公司或实体商业性组织。用户承诺不经phpcms同意，不能利用网站服务进行销售或其他商业用途。\r\n10．用户责任 \r\n　　用户单独承担传输内容的责任。用户必须遵循： \r\n　　1)从中国境内向外传输技术性资料时必须符合中国有关法规。 \r\n　　2)使用网站服务不作非法用途。 \r\n　　3)不干扰或混乱网络服务。 \r\n　　4)不在论坛BBS或留言簿发表任何与政治相关的信息。 \r\n　　5)遵守所有使用网站服务的网络协议、规定、程序和惯例。\r\n　　6)不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益。\r\n　　7)不得利用本站制作、复制和传播下列信息： \r\n　　　1、煽动抗拒、破坏宪法和法律、行政法规实施的；\r\n　　　2、煽动颠覆国家政权，推翻社会主义制度的；\r\n　　　3、煽动分裂国家、破坏国家统一的；\r\n　　　4、煽动民族仇恨、民族歧视，破坏民族团结的；\r\n　　　5、捏造或者歪曲事实，散布谣言，扰乱社会秩序的；\r\n　　　6、宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；\r\n　　　7、公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；\r\n　　　8、损害国家机关信誉的；\r\n　　　9、其他违反宪法和法律行政法规的；\r\n　　　10、进行商业广告行为的。\r\n　　用户不能传输任何教唆他人构成犯罪行为的资料；不能传输长国内不利条件和涉及国家安全的资料；不能传输任何不符合当地法规、国家法律和国际法 律的资料。未经许可而非法进入其它电脑系统是禁止的。若用户的行为不符合以上的条款，phpcms将取消用户服务帐号。\r\n11．网站内容的所有权\r\n　　phpcms定义的内容包括：文字、软件、声音、相片、录象、图表；在广告中全部内容；电子邮件的全部内容；phpcms为用户提供的商业信息。所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在phpcms和广告商授权下才能使用这些内容，而不能擅自复制、篡改这些内容、或创造与内容有关的派生产品。\r\n12．附加信息服务\r\n　　用户在享用phpcms提供的免费服务的同时，同意接受phpcms提供的各类附加信息服务。\r\n13．解释权\r\n　　本注册协议的解释权归phpcms所有。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。 \',\n  \'registerverifymessage\' => \' 欢迎您注册成为phpcms用户，您的账号需要邮箱认证，点击下面链接进行认证：{click}\r\n或者将网址复制到浏览器：{url}\',\n  \'forgetpassword\' => \' phpcms密码找回，请在一小时内点击下面链接进行操作：{click}\r\n或者将网址复制到浏览器：{url}\',\n)', '0', '0', '2010-09-06', '2010-09-06');
INSERT INTO `lt_module` VALUES ('pay', '支付', '', '1', '1.0', '', '', '0', '0', '2010-09-06', '2010-09-06');
INSERT INTO `lt_module` VALUES ('digg', '顶一下', '', '0', '1.0', '', '', '0', '0', '2010-09-06', '2010-09-06');
INSERT INTO `lt_module` VALUES ('special', '专题', '', '0', '1.0', '', '', '0', '0', '2010-09-06', '2010-09-06');
INSERT INTO `lt_module` VALUES ('content', '内容模块', '', '1', '1.0', '', '', '0', '0', '2010-09-06', '2010-09-06');
INSERT INTO `lt_module` VALUES ('search', '全站搜索', '', '0', '1.0', '', 'array (\n  \'fulltextenble\' => \'1\',\n  \'relationenble\' => \'1\',\n  \'suggestenable\' => \'1\',\n  \'sphinxenable\' => \'0\',\n  \'sphinxhost\' => \'10.228.134.102\',\n  \'sphinxport\' => \'9312\',\n)', '0', '0', '2010-09-06', '2010-09-06');
INSERT INTO `lt_module` VALUES ('scan', '木马扫描', 'scan', '0', '1.0', '', '', '0', '0', '2010-09-01', '2010-09-06');
INSERT INTO `lt_module` VALUES ('attachment', '附件', 'attachment', '1', '1.0', '', '', '0', '0', '2010-09-01', '2010-09-06');
INSERT INTO `lt_module` VALUES ('block', '碎片', '', '1', '1.0', '', '', '0', '0', '2010-09-01', '2010-09-06');
INSERT INTO `lt_module` VALUES ('collection', '采集模块', 'collection', '1', '1.0', '', '', '0', '0', '2010-09-01', '2010-09-06');
INSERT INTO `lt_module` VALUES ('dbsource', '数据源', '', '1', '', '', '', '0', '0', '2010-09-01', '2010-09-06');
INSERT INTO `lt_module` VALUES ('template', '模板风格', '', '1', '1.0', '', '', '0', '0', '2010-09-01', '2010-09-06');
INSERT INTO `lt_module` VALUES ('release', '发布点', '', '1', '1.0', '', '', '0', '0', '2010-09-01', '2010-09-06');
INSERT INTO `lt_module` VALUES ('video', '视频库', '', '0', '1.0', '', '', '0', '0', '2012-09-28', '2012-09-28');
INSERT INTO `lt_module` VALUES ('link', '友情链接', '', '0', '1.0', '', 'array (\n  1 => \n  array (\n    \'is_post\' => \'1\',\n    \'enablecheckcode\' => \'0\',\n  ),\n)', '0', '0', '2010-09-06', '2010-09-06');
INSERT INTO `lt_module` VALUES ('wap', '手机门户', 'wap/', '0', '1.0', '手机门户', '', '0', '0', '2018-09-07', '2018-09-07');

-- ----------------------------
-- Table structure for lt_news
-- ----------------------------
DROP TABLE IF EXISTS `lt_news`;
CREATE TABLE `lt_news` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` varchar(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` varchar(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `author` varchar(255) NOT NULL DEFAULT '',
  `newstype` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_news
-- ----------------------------
INSERT INTO `lt_news` VALUES ('7', '65', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-info/7.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('8', '66', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-industry	/8.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('6', '65', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-info/6.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('9', '66', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-industry	/9.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('5', '65', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-info/5.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('10', '66', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-industry	/10.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('4', '65', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-info/4.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('3', '65', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-info/3.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('39', '65', '0', 'rwar', '', '', '', 'asdf', '0', 'http://www.lantu02.com/news-info/39.html', '0', '99', '1', '0', 'lantu', '1565338184', '1565338192', '', '');
INSERT INTO `lt_news` VALUES ('40', '65', '0', 'test', '', '', '', 'asdf', '0', 'http://www.lantu02.com/news-info/40.html', '0', '99', '1', '0', 'lantu', '1565338194', '1565338198', '', '');
INSERT INTO `lt_news` VALUES ('2', '65', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-info/2.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('41', '65', '0', 'asdfas', '', '', '', 'asdfasd', '0', 'http://www.lantu02.com/news-info/41.html', '0', '99', '1', '0', 'lantu', '1565338202', '1565338206', '', '');
INSERT INTO `lt_news` VALUES ('1', '65', '0', 'App Growing高盛峰会发布独家洞察：广告就是用钱投票1', '', '/statics/pc/image/xw-1.jpg', '', '看得清才能投的准', '0', 'http://www.lantu02.com/news-info/1.html', '0', '99', '1', '0', 'lantu', '1564563176', '1564563280', '', '新闻报道');
INSERT INTO `lt_news` VALUES ('42', '65', '0', 'asdfasd', '', '', '', 'asdfasd', '0', 'http://www.lantu02.com/news-info/42.html', '0', '99', '1', '0', 'lantu', '1565338207', '1565338210', '', '');
INSERT INTO `lt_news` VALUES ('43', '65', '0', 'asdfasd', '', '', '', 'gsdfgsd', '0', 'http://www.lantu02.com/news-info/43.html', '0', '99', '1', '0', 'lantu', '1565338212', '1565338216', '', '');
INSERT INTO `lt_news` VALUES ('44', '65', '0', 'wetras', '', '', '', 'sdfw', '0', 'http://www.lantu02.com/news-info/44.html', '0', '99', '1', '0', 'lantu', '1565338217', '1565338221', '', '');
INSERT INTO `lt_news` VALUES ('45', '65', '0', 'gaerfs', '', '', '', 'sdfwe', '0', 'http://www.lantu02.com/news-info/45.html', '0', '99', '1', '0', 'lantu', '1565338229', '1565338233', '', '');
INSERT INTO `lt_news` VALUES ('46', '65', '0', 'dfgawefs', '', '', '', 'sdf', '0', 'http://www.lantu02.com/news-info/46.html', '0', '99', '1', '0', 'lantu', '1565338234', '1565338237', '', '');
INSERT INTO `lt_news` VALUES ('47', '65', '0', 'aergad', '', '', '', 'sdfsd', '0', 'http://www.lantu02.com/news-info/47.html', '0', '99', '1', '0', 'lantu', '1565338239', '1565338241', '', '');
INSERT INTO `lt_news` VALUES ('48', '65', '0', 'asdfwef', '', '', '', 'asdfs', '0', 'http://www.lantu02.com/news-info/48.html', '0', '99', '1', '0', 'lantu', '1565338243', '1565338246', '', '');
INSERT INTO `lt_news` VALUES ('49', '65', '0', 'asetsd', '', '', '', 'sdfs', '0', 'http://www.lantu02.com/news-info/49.html', '0', '99', '1', '0', 'lantu', '1565338261', '1565338265', '', '');
INSERT INTO `lt_news` VALUES ('50', '65', '0', 'asdgwe', '', '', '', 'sdfwe', '0', 'http://www.lantu02.com/news-info/50.html', '0', '99', '1', '0', 'lantu', '1565338267', '1565338270', '', '');
INSERT INTO `lt_news` VALUES ('51', '65', '0', 'wefasdf', '', '', '', 'wefsd', '0', 'http://www.lantu02.com/news-info/51.html', '0', '99', '1', '0', 'lantu', '1565338272', '1565338275', '', '');
INSERT INTO `lt_news` VALUES ('52', '65', '0', 'wwwgd', '', '', '', 'asdf', '0', 'http://www.lantu02.com/news-info/52.html', '0', '99', '1', '0', 'lantu', '1565338276', '1565338280', '', '');

-- ----------------------------
-- Table structure for lt_news_data
-- ----------------------------
DROP TABLE IF EXISTS `lt_news_data`;
CREATE TABLE `lt_news_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` mediumtext NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `relation` varchar(255) NOT NULL DEFAULT '',
  `copyfrom` varchar(100) NOT NULL DEFAULT '',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_news_data
-- ----------------------------
INSERT INTO `lt_news_data` VALUES ('1', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('2', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('3', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('4', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('5', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('6', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('7', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('8', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('9', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('10', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('39', '<p>asdf</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('40', '<p>asdf</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('41', '<p>asdfasd</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('42', '<p>asdfasd</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('43', '<p>gsdfgsd</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('44', '<p>sdfw</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('45', '<p>sdfwe</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('46', '<p>sdf</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('47', '<p>sdfsd</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('48', '<p>asdfs</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('49', '<p>sdfs</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('50', '<p>sdfwe</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('51', '<p>wefsd</p>', '0', '0', '', '0', '', '');
INSERT INTO `lt_news_data` VALUES ('52', '<p>asdf</p>', '0', '0', '', '0', '', '');

-- ----------------------------
-- Table structure for lt_page
-- ----------------------------
DROP TABLE IF EXISTS `lt_page`;
CREATE TABLE `lt_page` (
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `title` varchar(160) NOT NULL,
  `style` varchar(24) NOT NULL,
  `keywords` varchar(40) NOT NULL,
  `content` text NOT NULL,
  `template` varchar(30) NOT NULL,
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_page
-- ----------------------------
INSERT INTO `lt_page` VALUES ('11', 'adfgd', ';', 'adfgd', 'aa44', '20181409', '1536915615');
INSERT INTO `lt_page` VALUES ('9', 'zxcvxc', ';', 'zxcvxc', '444e', '20181409', '1536920512');
INSERT INTO `lt_page` VALUES ('16', '关于我们', ';', '关于我们', '<div class=\"sy\">\r\n<div class=\"container\">\r\n<p class=\"agileits_w3layouts_head\"><a href=\"/about/\">品牌介绍&mdash;<span>ABOUT</span></a></p>\r\n<div class=\"w3_agile_image\"><img alt=\" 芝芝舒芙蕾标题图\" class=\"img-responsive\" src=\"/statics/pc/img/1.png\" /></div>\r\n<div class=\"gy\">\r\n<div class=\"tu\"><img alt=\" 芝芝舒芙蕾首页介绍左边图\" src=\"/statics/pc/img/zuo.jpg\" /></div>\r\n<div class=\"zt\">\r\n<p class=\"dz\">人海拥挤&mdash;--芝芝舒芙蕾，芝是为你</p>\r\n<div class=\"ys\">\r\n<p>芝芝舒芙蕾创立于2018年的广州，包容性极强的一座城市，也是美食之都。舒芙蕾是一道通过名字就能调动起全身浪漫细胞的法式甜品。就发音来说，又叫做梳乎厘，也有蛋奶酥这种听起来一点都不文艺的名字。他的名字据说是法语动词souffler的过去分词，意思是&ldquo;蓬松地胀起来&rdquo;。</p>\r\n<p>十二道锋味里，谢霆锋说：舒芙蕾就像女人一样，超难搞，我搜寻秘方，向高手讨教，却始终欠缺一些火候。芝芝舒芙蕾的魅力之所以如女人那样捉摸不定，是将材料放入烤箱开始的。</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<br />\r\n', '20181509', '1536997223');
INSERT INTO `lt_page` VALUES ('18', '昱晟优势', ';', '', '<h3 class=\"sec-title wow fadeInUp\">昱晟优势</h3><div class=\"ys-list\"><a class=\"wow flip\" href><div class=\"advantage-img\"><img src=\"/statics/pc/image/ys-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"advantage-txt\"><h3><span>01</span><strong>创新产品</strong></h3><p>具备完备的移动应用、云计算、大数据等技术手段，助力企业向智能营销转型升级，用技术驱动商业革新，让商业变得更智慧。</p></div></a><a class=\"wow flip\" href><div class=\"advantage-img\"><img src=\"/statics/pc/image/ys-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"advantage-txt\"><h3><span>02</span><strong>精细运营</strong></h3><p>垂直行业解决方案，精细化运营，用数据说话，实时监控广告效果及数据分析，让转化率不断升高。</p></div></a><a class=\"wow flip\" href><div class=\"advantage-img\"><img src=\"/statics/pc/image/ys-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"advantage-txt\"><h3><span>03</span><strong>技术领先</strong></h3><p>自主研发多款应用工具，从运营到管理多方位涵盖，专业一站式服务轻松获得效果。</p></div></a></div>', '20193007', '1564458646');
INSERT INTO `lt_page` VALUES ('39', '关于我们', ';', '关于我们', '<p><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a><a href=\"http://www.lantucms2.com/index.php?m=content&c=content&a=add&menuid=822&catid=39&pc_hash=3Q5lHD\" target=\"right\" style=\"color: rgb(68, 68, 68); font-family: tahoma, arial, 宋体, sans-serif; font-size: 12px;\">关于我们</a></p>', '20192103', '1553130757');
INSERT INTO `lt_page` VALUES ('22', '加盟招商', ';', '加盟招商', '<div class=\"news\">\r\n<p class=\"about\">加盟招商JOIN INVESTMENT</p>\r\n<a href=\"/support/\">了解更多</a> <!-- <a href=\"jmxg.php.htm\" >了解更多</a> --></div>\r\n<div class=\"gywz\">\r\n<div class=\"xg\"><img src=\"/statics/pc/img/xg.jpg\" /></div>\r\n<p class=\"gsjs\">加盟优势</p>\r\n<p>1、芝芝舒芙蕾总部将提供招募标准及人力资源管理的相关信息，专业部门将协助招募及人员的确定。</p>\r\n<p>2、芝芝舒芙蕾总部为品牌加盟商、餐厅经理、管理组及员工分别开设相应的培训课程及实际操作的培训，全程指导，手把手开店。</p>\r\n<p>3、芝芝舒芙蕾总部将结合店铺所在城市及商圈特殊性，制定节日优惠，下午茶优惠等开业推广及宣传促销活动计划。</p>\r\n<p>4、芝芝舒芙蕾总部会结合店铺相关情况对店铺进行线上线下的指导培训。品牌合作方若有额外人力需求，经协调后总部将提供有偿支持。</p>\r\n<p>5、芝芝舒芙蕾总部还将持续对店铺各职级人员开设相应培训课程，不定期举办共识会，加强与品牌合作方之间的沟通，协助宣传与促销。</p>\r\n</div>\r\n', '20181509', '1537005886');
INSERT INTO `lt_page` VALUES ('23', '品牌新闻', ';', '品牌新闻', '<p class=\"aboutt\">品牌新闻 PRESS CENTER</p>\r\n<a href=\"/news/\">更多新闻</a>', '20181509', '1537005993');
INSERT INTO `lt_page` VALUES ('26', '关于我们', ';', '关于我们', '<p style=\"text-align: center;\"><span style=\"font-size:16px;\"><span background-color:=\"\" open=\"\" style=\"color: rgb(51, 51, 51); font-family: \"><img alt=\"\" src=\"http://www.zzsfljm.cn/uploads/allimg/180616/1-1P6161134194V.jpg\" style=\"width: 90%;\"/></span></span></p><p><br/><span style=\"font-size:16px;\"><span background-color:=\"\" open=\"\" style=\"color: rgb(51, 51, 51); font-family: \">&nbsp; &nbsp; &nbsp; &nbsp; ZZ-SOUFFLER芝芝舒芙蕾源自美食之都广州，全国首创网红舒芙蕾的餐饮品牌。想了解芝芝舒芙蕾加盟费，芝芝梳乎厘加盟条件，芝芝梳乎厘加盟详情请联系</span>189-3396-6254</span><span font-size:=\"\" open=\"\" style=\"background-color: rgb(251, 249, 249); color: rgb(51, 51, 51); font-family: \">。芝芝舒芙蕾创立于2018年的广州，包容性极强的一座城市，也是美食之都。舒芙蕾是一道通过名字就能调动起全身浪漫细胞的法式甜品。就发音来说，又叫做梳乎厘，也有蛋奶酥这种听起来一点都不文艺的名字。他的名字据说是法语动词souffler的过去分词，意思是“蓬松地胀起来”。十二道锋味里，谢霆锋说：舒芙蕾就像女人一样，超难搞，我搜寻秘方，向高手讨教，却始终欠缺一些火候。芝芝舒芙蕾的魅力之所以如女人那样捉摸不定，是将材料放入烤箱开始的。</span></p><p>&nbsp;</p>', '20182010', '1540031473');
INSERT INTO `lt_page` VALUES ('34', '联系我们', ';', '联系我们', '<!-- 联系我们 --><section class=\"contact-us\"><div class=\"container\"><div class=\"tips wow flip\"><div class=\"item\"><h3 class=\"contact-us-ti\">广告服务合作</h3><p class=\"contact-us-ms\">联系邮箱：alex@gzushine.com</p><p class=\"contact-us-ms\">联系电话：13026881934</p></div><div class=\"item\"><h3 class=\"contact-us-ti\">广告开户合作</h3><p class=\"contact-us-ms\">联系邮箱：alex@gzushine.com</p><p class=\"contact-us-ms\">联系电话：13026881934</p></div><div class=\"item\"><h3 class=\"contact-us-ti\">其他业务合作</h3><p class=\"contact-us-ms\">联系邮箱：alex@gzushine.com</p><p class=\"contact-us-ms\">联系电话：13026881934</p></div></div><div class=\"map-main set-bg1 wow slideInUp\"><div class=\"ti\"><h3 class=\"contact-us-ti\">公司地址</h3><p class=\"contact-us-ms\">广东省广州市白云区北太路1627号敏捷科创中心3栋422</p><p class=\"contact-us-ms\">邮编：510540</p></div><div class=\"map\" id=\"map\"></div></div></div></section>', '20193007', '1564478755');
INSERT INTO `lt_page` VALUES ('36', '客户案例', ';', '', '<h3 class=\"sec-title\">客户案例</h3><div class=\"al-list\"><a href><img src=\"/statics/pc/image/als_1.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_2.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_3.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_4.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_5.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_6.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_7.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_8.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_9.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_10.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_11.png\" alt=\"\" srcset=\"\"/></a></div>', '20193007', '1564458688');
INSERT INTO `lt_page` VALUES ('43', '市场解读', ';', '', '<div class=\"title\"><img class=\"logoDesign-1\" src=\"/statics/pc/image/scqj-h1.png\" alt=\"\" srcset=\"\"/></div><div class=\"cont\"><div class=\"item item1\"><div class=\"text wow slideInLeft\"><h2><p>火爆钱景</p><p>又一个千亿市场</p></h2><p>据美团联合“餐饮老板内参”发布的《中国餐饮报告》最新数据显示，我国饮品、糖水店铺达到43.7万家，稳坐餐饮第三的品类供求。但从国内消费者的人均甜食消费量来看，国内市场具有巨大的发展潜力。&nbsp;</p></div><div class=\"img wow slideInRight\"><img src=\"/statics/pc/image/scqj-1.png\" alt=\"\" srcset=\"\"/></div></div><div class=\"item item1\"><div class=\"text wow slideInRight\"><h2><p>时尚男女</p><p>享受美食养颜</p></h2><p>时尚男女们从享受甜品冷饮的美味，到追求果品的健康养颜；从享受美食，到追求情调和惬意；嘿优引进Smoothie Bowl概念，创新中西甜食的共鸣、椰碗鲜炖——兼具高颜值与食疗功效。&nbsp;</p></div><div class=\"img wow slideInLeft\"><img src=\"/statics/pc/image/scqj-2.png\" alt=\"\" srcset=\"\"/></div></div><div class=\"item item1 clear\"><div class=\"text wow slideInLeft\"><h2><p>超全产品</p><p>打造商街火爆店铺</p></h2><p>主打低卡椰子碗，高颜值低热量，网红级糖水。同时囊括谷物椰奶、手工芋圆、水果茶、水果刨冰等13个系列。复合式经营一店满足消费者多样需求，吸引年轻人打卡</p></div><div class=\"img wow slideInRight\"><img src=\"/statics/pc/image/scqj-3.png\" alt=\"\" srcset=\"\"/></div></div><div class=\"item item1 clear\"><div class=\"text wow slideInRight\"><h2><p>深化营销</p><p>国潮视觉成主流</p></h2><p>嘿优，鲜椰糖水以融合西式美学结合中国传统养生的饮食之道，原创了东方特定养生元素的潮品糖水，以鲜明的特色和文化态度，吸引年轻人的关注，引领他们，而不是向其讨好</p></div><div class=\"img wow slideInLeft\"><img src=\"/statics/pc/image/scqj-4.png\" alt=\"\" srcset=\"\"/></div></div></div>', '20191407', '1563070162');
INSERT INTO `lt_page` VALUES ('43', '市场解读', ';', '', '<div class=\"title\"><img class=\"logoDesign-1\" src=\"/statics/pc/image/scqj-h1.png\" alt=\"\" srcset=\"\"/></div><div class=\"cont\"><div class=\"item item1\"><div class=\"text wow slideInLeft\"><h2><p>火爆钱景</p><p>又一个千亿市场</p></h2><p>据美团联合“餐饮老板内参”发布的《中国餐饮报告》最新数据显示，我国饮品、糖水店铺达到43.7万家，稳坐餐饮第三的品类供求。但从国内消费者的人均甜食消费量来看，国内市场具有巨大的发展潜力。&nbsp;</p></div><div class=\"img wow slideInRight\"><img src=\"/statics/pc/image/scqj-1.png\" alt=\"\" srcset=\"\"/></div></div><div class=\"item item1\"><div class=\"text wow slideInRight\"><h2><p>时尚男女</p><p>享受美食养颜</p></h2><p>时尚男女们从享受甜品冷饮的美味，到追求果品的健康养颜；从享受美食，到追求情调和惬意；嘿优引进Smoothie Bowl概念，创新中西甜食的共鸣、椰碗鲜炖——兼具高颜值与食疗功效。&nbsp;</p></div><div class=\"img wow slideInLeft\"><img src=\"/statics/pc/image/scqj-2.png\" alt=\"\" srcset=\"\"/></div></div><div class=\"item item1 clear\"><div class=\"text wow slideInLeft\"><h2><p>超全产品</p><p>打造商街火爆店铺</p></h2><p>主打低卡椰子碗，高颜值低热量，网红级糖水。同时囊括谷物椰奶、手工芋圆、水果茶、水果刨冰等13个系列。复合式经营一店满足消费者多样需求，吸引年轻人打卡</p></div><div class=\"img wow slideInRight\"><img src=\"/statics/pc/image/scqj-3.png\" alt=\"\" srcset=\"\"/></div></div><div class=\"item item1 clear\"><div class=\"text wow slideInRight\"><h2><p>深化营销</p><p>国潮视觉成主流</p></h2><p>嘿优，鲜椰糖水以融合西式美学结合中国传统养生的饮食之道，原创了东方特定养生元素的潮品糖水，以鲜明的特色和文化态度，吸引年轻人的关注，引领他们，而不是向其讨好</p></div><div class=\"img wow slideInLeft\"><img src=\"/statics/pc/image/scqj-4.png\" alt=\"\" srcset=\"\"/></div></div></div>', '20191407', '1563070162');
INSERT INTO `lt_page` VALUES ('44', '品牌档案', ';', '', '<div class=\"title\"><img class=\"logoDesign-1\" src=\"/statics/pc/image/ppda-h1.png\" alt=\"\" srcset=\"\"/></div><div class=\"cont\"><div class=\"list\"><p>品牌名称嘿优·鲜椰糖水铺</p><p>项目定位椰碗鲜炖好清润</p><p>Slogan椰爷嘢耶！吃碗好椰</p><p>主营产品糖水、小吃</p><p>产品亮点高颜椰碗、营养鲜炖</p><p>适用场景下午茶、饭后甜点</p></div><img src=\"/statics/pc/image/ppda-1.png\" alt=\"嘿优·鲜椰糖水铺\"/></div>', '20191407', '1563070150');
INSERT INTO `lt_page` VALUES ('45', '产品中心', ';', '', '<section class=\"product-main\"><div class=\"sea-tibox\"><h3 class=\"sec-title\" data-title=\"PRODUCT MATRIX\">产品矩阵</h3></div><div class=\"product-main-list\"><div class=\"product-item\"><div class=\"product-item-show\"><img src=\"/statics/pc/image/cpjz-1-1.png\" alt=\"\" srcset=\"\"/><div class=\"mock-browser\"><!--<div class=\"mock-browser-nav\"></div>--><div class=\"mock-browser-window\"><img src=\"/statics/pc/image/cpjz-1-2.jpg\" alt=\"\" srcset=\"\"/></div></div></div><div class=\"product-item-content\"><h2><img src=\"/statics/pc/image/cpjz-1-t.png\" alt=\"\" srcset=\"\"/></h2><h3>帮助企业倍增销售效率,全面提升营销力</h3><p>集客户、资源线索、商机合同、财务运营数据报表分析、一体的专业CRM系统。根据业务流程有效地助力企业业绩增长和销售协同问题，让企业主专注于提升销售业绩。</p><ul class=\" list-paddingleft-2\"><li><p>客户档案管理</p></li><li><p>合同管理</p></li><li><p>销售报表</p></li><li><p>预测销售业绩</p></li><li><p>智能外呼电话</p></li></ul><a class=\"ani btn btn-default\" href><span>我要合作</span></a></div></div><div class=\"product-item\"><div class=\"product-item-show\"><img src=\"/statics/pc/image/cpjz-2-1.png\" alt=\"\" srcset=\"\"/><div class=\"mock-browser\"><!--<div class=\"mock-browser-nav\"></div>--><div class=\"mock-browser-window\"><img src=\"/statics/pc/image/cpjz-2-2.jpg\" alt=\"\" srcset=\"\"/></div></div></div><div class=\"product-item-content\"><h2><img src=\"/statics/pc/image/cpjz-2-t.png\" alt=\"\" srcset=\"\"/></h2><h3>专业的技术，简单的操作</h3><p>商数云智能建站系统，不需要通过技术人员，营销人员可以直接挂网页，大大减少企业消耗，提高工作效率。</p><ul class=\" list-paddingleft-2\"><li><p>一键生成页面场景</p></li><li><p>域名管理指向场景</p></li><li><p>用户体系场景</p></li></ul><a class=\"ani btn btn-default\" href><span>我要合作</span></a></div></div><div class=\"product-item\"><div class=\"product-item-show\"><img src=\"/statics/pc/image/cpjz-3-1.png\" alt=\"\" srcset=\"\"/><div class=\"mock-browser\"><!--<div class=\"mock-browser-nav\"></div>--><div class=\"mock-browser-window\"><img src=\"/statics/pc/image/cpjz-3-2.jpg\" alt=\"\" srcset=\"\"/></div></div></div><div class=\"product-item-content\"><h2><img src=\"/statics/pc/image/cpjz-3-t.png\" alt=\"\" srcset=\"\"/></h2><h3>智能外呼 数据追踪</h3><p>可以自助开通呼叫中心，轻松设置IVR流程，管理并追踪客服绩效，无需具备专业技能，无需管理任何设备。基于云端呼叫中心平台的全部优势，实现更大的灵活性，更高的可靠性和更低的成本。</p><ul class=\" list-paddingleft-2\"><li><p>呼出漏接全面追回，把握商机</p></li><li><p>无效电话全面分析，精准投放</p></li><li><p>枯燥样式全面创新，激发咨询欲望</p></li></ul><a class=\"ani btn btn-default\" href><span>我要合作</span></a></div></div><div class=\"product-item\"><div class=\"product-item-show\"><img src=\"/statics/pc/image/cpjz-4-1.png\" alt=\"\" srcset=\"\"/><div class=\"mock-browser\"><!--<div class=\"mock-browser-nav\"></div>--><div class=\"mock-browser-window\"><img src=\"/statics/pc/image/cpjz-4-2.jpg\" alt=\"\" srcset=\"\"/></div></div></div><div class=\"product-item-content\"><h2><img src=\"/statics/pc/image/cpjz-4-t.png\" alt=\"\" srcset=\"\"/></h2><h3>智能客服 高效咨询</h3><p>可帮每一个企业建立企业大数据管理，高效的智能客服，人工客服+智能机器人客服，智能机器人，语义识别，可帮您无限接近人工客服，实现高效率的智能客服。</p><ul class=\" list-paddingleft-2\"><li><p>电商行、业教育行业、金融行业、汽车行业、家用电器、消费电子、医疗行业等</p></li><li><p>B2B、O2O全面适用</p></li></ul><a class=\"ani btn btn-default\" href><span>我要合作</span></a></div></div><div class=\"product-item\"><div class=\"product-item-show\"><img src=\"/statics/pc/image/cpjz-5-1.png\" alt=\"\" srcset=\"\"/><div class=\"mock-browser\"><!--<div class=\"mock-browser-nav\"></div>--><div class=\"mock-browser-window\"><img src=\"/statics/pc/image/cpjz-5-2.jpg\" alt=\"\" srcset=\"\"/></div></div></div><div class=\"product-item-content\"><h2><img src=\"/statics/pc/image/cpjz-5-t.png\" alt=\"\" srcset=\"\"/></h2><h3>精准分析，效果翻倍</h3><p>快速建立起访客与网站主之间的电话连接,让访客更加轻松的与网站主进行对话、咨询、洽谈等。</p><ul class=\" list-paddingleft-2\"><li><p>精准统计出了网站访客与商家、会员的有效通话数据</p></li><li><p>轻松体现网站的媒体营销价值及广告效果</p></li></ul><a class=\"ani btn btn-default\" href><span>我要合作</span></a></div></div></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title\">平台优势</h3></div><div class=\"server-adv-list\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/ptys-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>领先技术</h3><p>人群重定向、素材优化学习、大数据智能处理。</p></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/ptys-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>数据驱动</h3><p>百万级线索及标签，让每一步决策都由数据决定。</p></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/ptys-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>全链服务</h3><p>投前洞察分析、投时营销管理、投后效果跟踪，全链条打通营销服务</p></div></div></div></section><section class=\"case\"><div class=\"container\"><h3 class=\"sec-title\">客户案例</h3><div class=\"al-list\"><a href><img src=\"/statics/pc/image/als_1.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_2.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_3.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_4.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_5.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_6.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_7.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_8.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_9.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_10.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_11.png\" alt=\"\" srcset=\"\"/></a></div></div></section>', '20190108', '1564629773');
INSERT INTO `lt_page` VALUES ('46', '解决方案', ';', '', '<section class=\"advantage advantage-j\"><h3 class=\"sec-title wow slideInUp\">为什么销售越来越难？</h3><div class=\"ys-list\"><a class=\"wow flip\" href><div class=\"advantage-img\"><img src=\"/statics/pc/image/ys-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"advantage-txt\"><h3><strong>传统销售模式效果越来越差</strong></h3><p>随着电话接听率的下降和人力成本的提高，靠人力电话筛客难以为继，传统的工业化销售效果越来越差。</p></div></a><a class=\"wow flip\" href><div class=\"advantage-img\"><img src=\"/statics/pc/image/ys-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"advantage-txt\"><h3><strong>营销方法过时，获客越来越难</strong></h3><p>移动互联网不断深入生活，营销环境发生变化，搜索引擎中效果越来越差，广告效果正在往社交网络迁移。</p></div></a><a class=\"wow flip\" href><div class=\"advantage-img\"><img src=\"/statics/pc/image/ys-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"advantage-txt\"><h3><strong>管理正在失效，效率提升难</strong></h3><p>客户沟通工具越来越多样化，传统的客户登记表格如同虚设，管理出现断裂，效率难以提升。</p></div></a></div></section><section class=\"solution-lc\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">商数CRM 解决方案</h3><p class=\"tips wow slideInUp\">为企业搭建海量客户实时连接的互动营销体系</p></div><div class=\"img wow slideInUp\"><img src=\"/statics/pc/image/jjfa-lc.png\" alt=\"\" srcset=\"\"/></div></section><section class=\"sec-ads-tips set-bg1 solution-tips\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">社交化网络精准拓客</h3><p class=\"tips wow slideInUp\">打通微信社交圈，助力企业做好社交化营销</p></div><div class=\"gg-nav\"><span class=\"hover\">智能名片</span><span>微表单</span><span>连接微信</span><span>工作手机</span></div><div class=\"container\"><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>微信人脉扩展利器</h3><div><p>小程序轻量化呈现</p><p>智能回流客户互动与数据</p><p>支持电子名、微信对话窗口、微主页等多场景</p><p>让每个销售都能便捷地在微信拓客</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>微信商机收集器</h3><div><p>操作简单的H5微海报制作工具</p><p>帮助从社交网络挖掘商机</p><p>客户感兴趣点击填写信息后</p><p>分来源保存，并动态提醒销售</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>连接微信中的客户</h3><div><p>通过企业微信</p><p>将微信客户批量导入</p><p>并与微信保持连接</p><p>真正实现客户关系有效管理</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>自动同步和存储微信记录</h3><div><p>销售随时随地跟进客户</p><p>不错过任何一个成交机会</p><p>工作量自动记录和统计</p><p>实时同步，方便随时查看</p></div></div></div></ul></div></section><section class=\"sec-ads-tips solution-tips\"><div class=\"sea-tibox\"><h3 class=\"sec-title\">智能电销提升成交率</h3><p class=\"tips\">将简单群呼变为有效沟通</p></div><div class=\"gg-nav\"><span class=\"hover\">电话前</span><span>电话中</span><span>电话后</span></div><div class=\"container\"><ul class=\"medium-advantage-list solu-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>提前探知客户接听意向度</h3><div><p>亿级号码数据积累和沉淀</p><p>精准分析、识别号码接听和意向</p><p>提升电话命中率</p></div></div></div></ul><ul class=\"medium-advantage-list solu-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>全面提升电话效率</h3><div><p>连接电话，在CRM库中一键拨号</p><p>沟通记录自动保存并录音</p><p>实时同步和更新客户信息和轨迹</p></div></div></div></ul><ul class=\"medium-advantage-list solu-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-7.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>挂机短信保持连接</h3><div><p>电话结束自动推送短信，让销售不断档</p><p>短信可带微名片，99%的短信打开率</p><p>多一次点击，多一次成交机会</p></div></div></div></ul></div></section><section class=\"sec-ads-tips set-bg1 solution-tips\"><div class=\"sea-tibox\"><h3 class=\"sec-title\">智能客户库激活生意</h3><p class=\"tips\">有效推进每一个商机，直至成交</p></div><div class=\"gg-nav\"><span class=\"hover\">智能化客户库</span><span>客户经营经理</span><span>自动营销系统</span></div><div class=\"container\"><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-8.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>数据化客户资产</h3><div><p>连接QQ、微信、电话、邮件、H5微营销等</p><p>多渠道客户沟通汇总，将客户信息统一管理</p><p>打造企业自己的客户大数据体系</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-9.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>系统化经营每一个客户</h3><div><p>每个客户都有专属信息卡</p><p>客户沟通记录、客阶段、来源、分组、标签等</p><p>构建详细客户画像，实现精细化管理和分析</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-10.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>激活沉默客户并挖掘新商机</h3><div><p>连接腾讯社交资源</p><p>自定义设置投放，反复曝光</p><p>客户查看广告，动态提醒销售</p></div></div></div></ul></div></section><section class=\"sec-ads-tips solution-tips\"><div class=\"sea-tibox\"><h3 class=\"sec-title\">让管理变得简单有效</h3><p class=\"tips\">客观、真实、数据化，提升销售业绩</p></div><div class=\"gg-nav\"><span class=\"hover\">行为管理</span><span>业绩管理</span></div><div class=\"container\"><ul class=\"medium-advantage-list solu-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-11.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>自动生成销售报</h3><div><p>销售电话统计实时可查</p><p>通话数量、时长、排名一目了然</p><p>随时了解员工工作与勤奋度</p><p>优提升全团队销售能力</p></div></div></div></ul><ul class=\"medium-advantage-list solu-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/jjfa-12.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>销售漏斗科学管理商机与订单</h3><div><p>实时查看订单金额、销售目标完成情况</p><p>用图表自动呈现商机和订单管理</p><p>科学的预测成交金额走势</p><p>有效管理</p></div></div></div></ul></div></section><!-- 焦点图 --><section class=\"focus-map\" style=\"background: url(\" center=\"\"><div class=\"focus-bx\"><p>商数智能营销为企业搭建全新销售模式</p></div></section>', '20193007', '1564476423');
INSERT INTO `lt_page` VALUES ('47', '商数云CRM', ';', '', '<section class=\"d-tit\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">商数云CRM</h3><p class=\"tips wow slideInUp\">集客户、资源线索、商机合同、财务运营、数据报表分析、一体的专业CRM系统。根据业务流程有效地助力企业业绩增长和销售协同问题，让企业主专注于提升销售业绩，帮助企业倍增销售效率,全面提升营销力。</p></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">产品优势</h3></div><div class=\"server-adv-list\"><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/c1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>多渠道营销触达</h3><p>通过短信、朋友圈H5、电销、语音外呼机器人，多渠道营销获客。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/c2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>线索高效利用</h3><p>对接有效线索，助力精准定位目标客户，多维度分析客情。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/c3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>精准客户转化</h3><p>制定销售计划、拜访计划、回款计划，时刻推动销售转化高价值客户。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/c4.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>数据统计报表</h3><p>灵活匹配公司业务，通过部门回款、销售排名、业绩统计等报表，提升销售管理时效。</p></div></div></div></section><section class=\"market-tips market-tips-pro\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title\">产品功能</h3></div><div class=\"market-tips-list\"><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/c5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">连接电话，一键跟进客户</h3><div><p class=\"bf\">让拓客效率倍增</p><p class=\"bf\">打通了CRM和电话大数据</p><p class=\"bf\">智能识别空号和接听率，拒绝盲打拓客</p><p class=\"bf\">通话录音和统计方便管理</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/c6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">精准社交广告</h3><div><p class=\"bf\">让沉默客户回流</p><p class=\"bf\">通过大数据自动投放精准社交广告</p><p class=\"bf\">反复曝光，激活CRM库的沉默客户</p><p class=\"bf\">只要客户点击，系统实时提醒，不错过最佳跟进机会</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/c7.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">全面、客观的实时统计</h3><div><p class=\"bf\">随时掌控销售业绩</p><p class=\"bf\">可以随时在后台查看员工的工作数据</p><p class=\"bf\">员工勤奋度一目了然</p><p class=\"bf\">客户数量、订单管理实时报表呈现</p><p class=\"bf\">公司业绩随时掌握</p></div></div></div></div></div></section>', '20190808', '1565251758');
INSERT INTO `lt_page` VALUES ('48', '精准的营销服务', ';', '', '<h3 class=\"sec-title wow fadeInUp\">精准的营销服务, 覆盖85%移动互联网用户</h3><p class=\"wow fadeInUp\"><span>昱晟科技已成功为数百企业提供+互联网解决方案和服务。业务遍布全国，为客户提供广告代运营，主流媒体资源整合，广告账户开通，营销型网页制作等专业服务，满足各个行业客户的不同需求。</span><span>通过昱晟科技的全方位服务，您可以轻松获得精准效果营销。</span></p><div class=\"map wow fadeInUp\"><picture><source srcset=\"/statics/pc/image/map-phone.jpg\" media=\"(max-width: 1200px)\"/><source srcset=\"/statics/pc/image/map.png\"/><img src=\"/statics/pc/image/map.png\" alt=\"\" class=\"img-responsive\"/></picture><div class=\"dot dot1\"><span></span>北京</div><div class=\"dot dot2\"><span></span>天津</div><div class=\"dot dot3\"><span></span>太原</div><div class=\"dot dot4\"><span></span>济南</div><div class=\"dot dot5\"><span></span>临沂</div><div class=\"dot dot6\"><span></span>苏州</div><div class=\"dot dot7\"><span></span>上海</div><div class=\"dot dot8\"><span></span>西安</div><div class=\"dot dot9\"><span></span>郑州</div><div class=\"dot dot10\"><span></span>洛阳</div><div class=\"dot dot11\"><span></span>南京</div><div class=\"dot dot12\"><span></span>武汉</div><div class=\"dot dot13\"><span></span>芜湖</div><div class=\"dot dot14\"><span></span>荆州</div><div class=\"dot dot15\"><span></span>杭州</div><div class=\"dot dot16\"><span></span>温州</div><div class=\"dot dot17\"><span></span>福州</div><div class=\"dot dot18\"><span></span>厦门</div><div class=\"dot dot19\"><span></span>广州</div><div class=\"dot dot20\"><span></span>深圳</div><div class=\"dot dot21\"><span></span>大理</div><div class=\"dot dot22\"><span></span>昆明</div><div class=\"dot dot23\"><span></span>桂林</div><div class=\"dot dot24\"><span></span>南宁</div><div class=\"dot dot25\"><span></span>贵州</div><div class=\"dot dot26\"><span></span>张家界</div><div class=\"dot dot27\"><span></span>重庆</div><div class=\"dot dot28\"><span></span>成都</div><div class=\"dot dot29\"><span></span>白贡</div><div class=\"dot dot30\"><span></span>绵阳</div><div class=\"dot dot31\"><span></span>长沙</div><div class=\"dot dot32\"><span></span>南昌</div><div class=\"dot dot33\"><span></span>郴州</div></div>', '20193007', '1564458130');
INSERT INTO `lt_page` VALUES ('49', '产品优势', ';', '', '<div class=\"title\"><img class=\"logoDesign-1\" src=\"/statics/pc/image/cpys-h1.png\" alt=\"\" srcset=\"\"/></div><div class=\"cont\"><div class=\"item item1 clear\"><div class=\"text wow slideInLeft\"><h2>精选取材，用料感人</h2><p>甄选新鲜优质好原料，绿色无添加，用料丰富十足，软糯又营养，每一口都能满足消费者对糖水所拥有的幻想</p></div><div class=\"img wow slideInRight\"><img src=\"/statics/pc/image/cpys-1.png\" alt=\"精选取材，用料感人\" srcset=\"\"/></div></div><div class=\"item item1 clear\"><div class=\"text  wow slideInRight\"><h2>热带风味，鲜炖更健康</h2><p>椰香四溢，一口就嗅到了夏威夷海滩咸湿的海风；以功效、时令之区小火鲜炖百余种食材，不仅营养更有补气补血，生津止渴等功效，风味绝妙，食客络绎不绝</p></div><div class=\"img  wow slideInLeft\"><img src=\"/statics/pc/image/cpys-2.png\" alt=\"热带风味，鲜炖更健康\" srcset=\"\"/></div></div><div class=\"item item1 clear\"><div class=\"text  wow slideInLeft\"><h2>手工现做，百年传承</h2><p>秉承传统手工制作工艺，现做、现煮、现卖，以美味口感取胜，赢的每一位消费者的赞誉与热爱</p></div><div class=\"img  wow slideInRight\"><img src=\"/statics/pc/image/cpys-3.png\" alt=\"手工现做，百年传承\" srcset=\"\"/></div></div><div class=\"item item1 clear\"><div class=\"text  wow slideInRight\"><h2>款式多样，任君挑选</h2><p>糖水款式花样繁多，囊括液体半固体固体等质地，进店顾客挑花眼，成为2019年最值得期待的投资项目</p></div><div class=\"img  wow slideInLeft\"><img src=\"/statics/pc/image/cpys-4.png\" alt=\"款式多样，任君挑选\" srcset=\"\"/></div></div></div>', '20191407', '1563073432');
INSERT INTO `lt_page` VALUES ('50', '人气爆品', ';', '', '<div class=\"item item1 wow slideInLeft\"><div class=\"tips\">专治颜控</div><div class=\"text\"><h2><span>jiao man feng fang yi zi wan</span><span>蕉芒芬芳椰子碗</span></h2><p>颜值超高的一款，天然椰子碗，盛满热带的水果香，和用心熬炖的糖水一起碰撞激爽！</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-1.png\" alt=\"蕉芒芬芳椰子碗\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInRight\"><div class=\"tips\">甜蜜诱惑</div><div class=\"text\"><h2><span>bin fen mei mei yi zi wan</span><span>缤纷莓莓椰子碗</span></h2><p>新鲜的草莓，舌头轻轻一抿，甜蜜味道在口腔中迸发，与酸甜蓝莓结合，就像把“莓”好时光吃进了嘴里！</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-2.png\" alt=\"甜蜜诱惑\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInLeft\"><div class=\"tips\">理想CP</div><div class=\"text\"><h2><span>zi shu yu ni yi zi wan</span><span>紫薯芋泥椰子碗</span></h2><p>紫薯与芋泥炖煮得细腻软糯，一口甜味让人印象深刻！</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-3.png\" alt=\"紫薯芋泥椰子碗\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInRight\"><div class=\"tips\">润心润肺</div><div class=\"text\"><h2><span>ye zhi xi mi lu</span><span>椰汁西米露</span></h2><p>满口QQ弹弹，甜蜜俏皮得像青春的时光，加上养颜桃胶、搭配时令水果，衬托出满满清新滋味！</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-4.png\" alt=\"椰汁西米露\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInLeft\"><div class=\"tips\">润颜霜</div><div class=\"text\"><h2><span>chen pi hong dou sha</span><span>桃胶燕麦椰奶</span></h2><p>仙女们都爱的养颜桃胶，加上浓香的热带椰奶，每一口都是浓度极高的润颜滋味！</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-5.png\" alt=\"桃胶燕麦椰奶\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInRight\"><div class=\"tips\">消暑佳品</div><div class=\"text\"><h2><span>chen pi hong dou sha</span><span>宝岛烧仙草</span></h2><p>没有烧仙草的夏天不完整，味蕾与食物的相濡以沫，更让一份甜美中达到时令养生的效果。</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-6.png\" alt=\"宝岛烧仙草\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInLeft\"><div class=\"tips\">黑白绝配</div><div class=\"text\"><h2><span>chen pi hong dou sha</span><span>椰汁西米白凉粉</span></h2><p>每一次唇舌的碰撞，都解锁Q弹的新质感，一口嫩滑之中，层次分明口感奇妙，足够玩味！</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-7.png\" alt=\"椰汁西米白凉粉\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInRight\"><div class=\"tips\">滋养容颜</div><div class=\"text\"><h2><span>chen pi hong dou sha</span><span>桃胶银耳木瓜雪哈</span></h2><p>养颜的桃胶、银耳，加入滋润身心的雪蛤，细品功效糖水的清香甘甜，焕发容颜甜美。</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-8.png\" alt=\"桃胶银耳木瓜雪哈\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInLeft\"><div class=\"tips\">黑白绝配</div><div class=\"text\"><h2><span>chen pi hong dou sha</span><span>黑糖波波椰奶</span></h2><p>黑与白，永恒的经典！黑糖的焦香，椰奶的浓甜，各具特色又相融合！</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-9.png\" alt=\"黑糖波波椰奶\" srcset=\"\"/></div></div><div class=\"item item1 wow slideInRight\"><div class=\"tips\">甜过初恋</div><div class=\"text\"><h2><span>chen pi hong dou sha</span><span>五彩芋圆芝麻奶</span></h2><p>细火炒香、去衣碾碎，慢熬出散发浓香的芝麻奶，加上清甜的芋圆，甜蜜暴击MAX。</p></div><div class=\"img\"><img src=\"/statics/pc/image/rqbp-10.png\" alt=\"五彩芋圆芝麻奶\" srcset=\"\"/></div></div>', '20191507', '1563152666');
INSERT INTO `lt_page` VALUES ('51', '关于我们', ';', '', '<section class=\"enterprise-archives lr\"><div class=\"item img wow slideInRight\"><img src=\"/statics/pc/image/gywm-1.jpg\" alt=\"\"/></div><div class=\"item txt wow slideInLeft\"><h3 class=\"ea-tit\" data-title=\"Enterprise archives\">企业档案</h3><p><span>公司名</span>：广州昱晟科技有限公司</p><p><span>英文</span>：Guangzhou Ushine Technology Co., Ltd.</p><p><span>简称</span>：昱晟科技</p><p><span>英文简称</span>：Ushine</p><p><span>品牌slogan</span>：您身边的移动营销专家</p></div></section><section class=\"company-profile set-bg1\"><div class=\"txt\"><h3 class=\"ea-tit wow slideInUp\" data-title=\"Enterprise archives\">公司简介</h3><p class=\"wow slideInUp\">广州昱晟科技有限公司是一家立足大数据时代下智能互联网营销服务商，公司致力于为企业提供一体化的全渠道、全场景营销解决方案，帮助企业实现营销升级。昱晟科技已成功为数百企业提供+互联网解决方案和服务。凭借对互联网营销+互联网产品的实践经验，以及完备的移动应用、云计算、大数据等技术手段，助力企业向智能营销转型升级，用技术驱动商业革新，让商业变得更智慧。</p></div></section><!-- 焦点图 --><section class=\"focus-map\" style=\"background: url(/statics/pc/image/gywm-3.jpg) no-repeat center;\"><div class=\"focus-bx\"><p>梦想、责任、分享、变化、成长</p><p>商数智能营销为企业搭建全新销售模式</p></div></section><section class=\"enterprise-archives\"><div class=\"item img wow slideInLeft\"><img src=\"/statics/pc/image/gywm-2.jpg\" alt=\"\"/></div><div class=\"item txt wow slideInRight\"><h3 class=\"ea-tit\" data-title=\"corporate culture\">企业文化</h3><p><span>核心价值观</span>：梦想、责任、分享、变化、成长</p><p><span>梦想</span>：满怀梦想，斗志昂扬，一朝得成功</p><p><span>责任</span>：天下大事，必作于细，细心耕耘，精心享责</p><p><span>分享</span>：分享乐事，悦于他人；分享技能，益于他人；时时分享，倾心谋业</p><p><span>变化</span>：变则通，通则久；拥抱变化，砥砺前行</p><p><span>成长</span>：年与时驰，意与岁去，与时俱进，心之所向，身之所往</p><p><span>满怀梦想，肩扛已责，乐于分享，拥抱变化，学会成长</span></p></div></section>', '20193007', '1564477400');
INSERT INTO `lt_page` VALUES ('52', '加入我们', ';', '', '<!-- 加入我们 --><section class=\"join-us set-bg1\"><div class=\"container\"><h3 class=\"sec-title wow fadeInUp\">加入我们</h3><div class=\"main\"><h3 class=\"wow fadeInUp\">人才观点<p class=\"wow fadeInUp\">一起成为更优秀的人</p><p class=\"wow fadeInUp\">昱晟科技是一个崇尚强者的企业，遇强则强，遇坚愈坚，人才就是我们的追求，共同带领企业走向更好的未来。如果你觉得自己怀才不遇，如果你觉得自己的才能无处施展，如果你觉得你的责任心无处安放，那么欢迎加入我们，领导会成为你的伯乐，舞台交给你，随你施展。最重要的是，与优秀的人一起共事，与杰出的人一起欢乐，让自己不断成长，变得更优秀，成为一个强者！</p></h3><h3 class=\"wow fadeInUp\">晋升方式<p class=\"wow fadeInUp\">员工皆平等杰出即真理</p><p class=\"wow fadeInUp\">在昱晟科技没有传统刻板的等级制度和观念，员工之间没有等级称谓，有的只是名字，每个人的正确意见和美好创意都会被重视，我们致力于为每一位员工提供广阔的事业发展空间和学习机会，这里不仅是一个工作场所，更是一个气氛融洽的家庭，昱晟科技的团队致力于推动创新，客户成就，多元共赢，我们期待着新的声音让我们一起变得更好。</p></h3></div></div></section><!-- 焦点图 --><section class=\"focus-map\" style=\"background: url(&quot;/statics/pc/image/jrwm-1.jpg&quot;) center center no-repeat;\"><div class=\"focus-bx\"><p>成功者拥有一流的态度、能力和技巧</p></div></section>', '20190108', '1564623003');
INSERT INTO `lt_page` VALUES ('54', '联系方式', ';', '', '<p class=\"wow slideInUp\">华东运营中心：上海市松江区九泾路655号嘉南红塔广场六号楼三楼</p><p class=\"wow slideInUp\">华南运营中心：广州市白云区嘉禾望岗润林商业中心4楼</p><p class=\"wow slideInUp\">西南运营中心：成都市金牛区蜀西路48号西城国际10楼</p>', '20191407', '1563075231');
INSERT INTO `lt_page` VALUES ('55', '在线留言', ';', '', '', '20191407', '1563075326');
INSERT INTO `lt_page` VALUES ('56', '搜索广告', ';', '', '<!-- 搜索广告媒介矩阵 --><section class=\"sea-ads\"><h3 class=\"sec-title wow slideInUp\">搜索广告媒介矩阵</h3><div class=\"sea-ads-list\"><div class=\"item item1 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-1.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">百度每天数十亿次搜索请求、 超过1亿用户浏览百度信息流、800亿次定位服务请求，超过200万种特征的精准用户画像，帮助广告主精</div></div><div class=\"item item2 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-2.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">搜狗是中国用户活跃用户数排名第四的互联网公司，旗下聚集搜狐、搜狗以及众多优质网络媒体资源为平台，根据用户行为特征及潜在兴趣和需求，以关键词、图片等多种展现形式帮助广告主实现精准推广。</div></div><div class=\"item item3 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-3.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">360搜索平台每日有数亿次的网民搜索行为，拥有海量的优质流量，其中一部分搜索词具有明确的商业需求信息，企业通过匹配关键词技术进行精细化投放，帮助广告主准确快速的锁定用户群体。</div></div><div class=\"item item4 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-4.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">神马搜索是阿里巴巴旗下的专注移动互联网的搜索引擎，致力于与用户创造方便、快捷、开放的移动搜索新体验。2018年8月，神马搜索一站式生活服务平台全新上线，致力于合作伙伴互动互通，搭建移动搜索交互产品模式。</div></div></div></section><!-- 媒介优势及展现形式 --><section class=\"sec-ads-tips set-bg1 medium-advantage\"><h3 class=\"sec-title\">媒介优势及展现形式</h3><div class=\"gg-nav\"><span class=\"hover\">百度推广</span><span>搜狗推广</span><span>360推广</span><span>神马推广</span></div><div class=\"container\"><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-11.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>三大优势：</h3><div><p>1. <strong>全系列多场景用户顶级流量</strong>：每天数十亿次搜索请求,超过1亿 用户浏览 百度信息流、800亿次定位服务请求,覆盖用户生活十大场景</p><p>2. <strong>把广告展现给精准用户</strong>：借助行业领先的百度搜索和资讯流推荐，超过200万种特征识别每一位用户真实需求及兴趣爱好。</p><p>3. <strong>通过AI技术让投放更简单</strong>：通过实时捕捉用户行为，智能推荐创意，自动根据内容追投广告，为广告主节省成本。</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-12.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>三大形式：</h3><div><p>1. <strong>标准推广</strong>：操作简单、效果快速，支持多个显著位置展现按点击收费，展示免费。</p><p>2. <strong>图片凤巢</strong>：一图胜千言，图文更具更吸引力；图片智能匹配，推广效果更佳。</p><p>3. <strong>线索通</strong>：线索通能直接在搜索结果页通过电话、表单、咨询组件直接展现服务功能使需求明确的网民减少跳转，直接联系，留下销售线索。</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-13.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>四大优势：</h3><div><p>1. <strong>独有微信、QQ、知乎搜索资源</strong>：当用户在使用微信头条、QQ聊天等腾讯系列产品时，可随时随地的用搜狗搜索检索信息，快捷便利。</p><p>2. <strong>移动搜索，基数庞大</strong>：2017年9月搜狗移动搜索量的市场份额为17.8%，基于移动搜索量，搜狗搜索是中国第二大搜索引擎。</p><p>3. <strong>搜狗输入法强势引流</strong>：搜狗输入法PC端和移动端都是国内名列前茅的中文输入软件。</p><p>4. <strong>移动搜索流量不断增长</strong>：搜狗移动搜索月活跃用户数据5.11亿，2014至2017搜狗移动搜索流量增长率为71.9%，带动整体搜索流量增长率为28.0%。</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-14.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>四大形式：</h3><div><p>1. <strong>PC端搜狗推广</strong>：包含PC搜索推广和PC图文推。</p><p>2. <strong>移动端搜狗推广</strong>：包含PC搜索推广和PC图文推广。</p><p>3. <strong>品牌专区</strong>：主要为品牌推广。</p><p>4. <strong>输入法直通车</strong>输入法推广，主要是通过用户输入行为的分析，识别用户检索意图，实现精准展现的网络推广模式。</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-15.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>三大优势：</h3><div><p>1. <strong>流量引导 </strong>：新颖图片样式吸引更多点击；辅助子链有效扩展推广信息，展示信息更丰富 。</p><p>2. <strong>高效转化</strong>：左侧第一位优质展现资源；排他性展现吸引更多流量转化。</p><p>3. <strong>品牌效应</strong>：优质推广位体现品牌实力；加深用户对品牌/产品的记忆。</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-16.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>三大形式：</h3><div><p>1. <strong>搜索文字链</strong>：搜索推广最常见最基础的一种推广方式，也是用户最熟悉的广告样式。</p><p>2. <strong>凤舞样式</strong>通过360强大的数据挖掘、机器学习方法从推广结果落地页、凤舞物料等数据中挖崛与用户搜索行为相关的数据，并展现在搜索结果中，形成凤舞创意样式。</p><p>3. <strong>比翼图片</strong>是依托于比翼子链的产品，可以为客户带来更多的展示样式，凸显品牌地位，加深用户对品牌/产品的记忆，让客户在同等预算下获得更高回报。</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-17.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>三大优势：</h3><div><p>1. <strong>第二大移动搜索平台</strong>：1亿移动搜索用户和5亿UC浏览器用户，市场份额超15%，国内移动搜索市场用户渗透率突破25.3%。</p><p>2. <strong>覆盖60%的优质用户人群</strong>：中高端消费群体的覆盖率超过60%，且属于高学历人群，消费能力高。</p><p>3. <strong>阿里大数据资源支撑</strong>：拥有阿里大数据的资源支持，未来将实现挖掘大数据潜在的价值并进行再加工，用大数据放大“小数据”的价值。</p><p>4. <strong>移动化交互方式，直击用户所想</strong>：具备搜索app、购物搜索功能，交互方式更移动，了解用户内心所需，广告触达目标用户。</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-18.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>两大形式：</h3><div><p>1. <strong>CPC广告</strong>无线端广阔流量，每日亿级PV流量，日均访问UV过千万。主要包括经典样式、app推广和子链&amp;电话。</p><p>2. <strong>品牌专区</strong>黄金首屏位展示，提升品牌曝光，树立品牌形象。</p></div></div></div></ul></div></section>', '20190108', '1564645148');
INSERT INTO `lt_page` VALUES ('57', '信息流广告', ';', '', '<!-- 搜索广告媒介矩阵 --><section class=\"sea-ads\"><h3 class=\"sec-title wow slideInUp\">信息流广告媒介矩阵</h3><div class=\"sea-ads-list\"><div class=\"item item1 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-5.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">一款基于数据挖掘的推荐引擎产品，是国内移动互联网领域成长最快的产品服务之一，国内第一的个性化资讯推送平台，覆盖4800万+日活用户，产生13亿文章阅读，960万+收藏。200万+标签分析，通过兴趣标签个性化推送，实现千人千面展示。</div></div><div class=\"item item2 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-6.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">一款可以拍短视频的音乐创意短视频社交软件，国内月活跃用户突破5亿，日活跃用户达到2.5亿，220万+用户标签精细化触达，抖音用视屏呈现的信息流广告，后台灵活操作，实现精准投放。</div></div><div class=\"item item3 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-7.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">搜狐汇算拥有搜狐门户、手机搜狐网等多渠道优质媒体资源，汇聚搜狐月度触达95.58%的网民数据，覆盖广泛的互联网及移动互联网人群。搜狐汇算进行多种创意表现形式的网络广告投放，综合多种优化技术为客户提供精准服务。</div></div><div class=\"item item4 wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/gg-8.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">UC头条广告平台主打基于大数据分析用户兴趣标签的信息流广告投放，一方面由UC提供海量流量资源，另一方面则由阿里妈妈提供专业的广告后台和服务支持，其用户已达到5亿+，目前月活跃用户突破1亿。</div></div></div></section><!-- 媒介优势及展现形式 --><section class=\"sec-ads-tips set-bg1 medium-advantage\"><h3 class=\"sec-title\">媒介优势及展现形式</h3><div class=\"gg-nav\"><span class=\"hover\">今日头条</span><span>抖音推广</span><span>搜狐汇算推广</span><span>UC推广</span></div><div class=\"container\"><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-21.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>四大优势：</h3><div><p>1. <strong>高质量用户群体</strong>：覆盖24-40岁中高端核心用户群体，累计激活用户数4.8亿，月活动活跃用户1.25亿，用户每日时长超过62分钟，消费能力强。</p><p>2. <strong>5秒快速推广，锁定目标用户</strong>：5秒内通过算法掌握你的新闻阅读兴趣点，10秒更新用户模型，越用越懂用户。</p><p>3. <strong>新闻类应用</strong>：用户量过2.6亿的新闻阅读客户端，稳居新闻资讯类app第二，长期占据APPStore的新闻类下载榜首。</p><p>4. <strong>后台操作灵活，实时数据报表</strong>：直接在今日头条的广告投放后台上制定广告投放策略，随时查数据，及时点击广告用户画像。</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-22.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>四大形式：</h3><div><p>1. <strong>开屏广告</strong>：结合用户需求，全天根据不同时段、用户场景变化，切换开屏广告素材。</p><p>2. <strong>开屏联播广告</strong>：联合多领域强势APP平台打造开屏联投曝光类产品，精选媒体、优化投放、细化人群的一站式开屏投放服务。</p><p>3. <strong>详情页广告</strong>：位于版权文章，相关阅读上方，促进落地页推广及应用下载。</p><p>4. <strong>信息流广告</strong>：采用关键词标签技术，精准定位目标用户，可避免预判下个月内CPM量，有效避免广告主投放资源浪费。</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-23.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>四大优势：</h3><div><p>1. <strong>用户年轻</strong>：引领年轻潮流，打造一二线年轻用户生态。抖音85%的用户是90后，有70%的高活跃度用户来自一二线城市，具备购买力。</p><p>2. <strong>形式新潮</strong>：引领潮流的人和事都在抖音。抖音引领音乐风尚，抖音拥有海量魔性版权音乐，并有专业原创音乐团队结合热点不断产出创意音乐素材。</p><p>3. <strong>内容爆点</strong>：创作灵感升级，用户自助形成内容爆点。抖音日均播放量高达20亿，从主动运营到用户自发产生，抖音已成为爆发内容制作器。</p><p>4. <strong>AI技术</strong>：领先AI技术加持，进发多维创意玩法。抖音利用AI技术加持，可进行人脸识别，丰富拍摄玩法，让用户轻松创造独特有张力的短视频，极具强关联社交广告，让广告推广更加高效！</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-24.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>表现形式：</h3><div><p>1. <strong>信息流广告</strong>品牌原生创意 提升品牌好感度。创意定制更原生更前置，高互动。</p><p>2. <strong>开屏广告</strong>强势入口，动/静态潮视展示，震撼视觉曝光。</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-25.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>三大优势：</h3><div><p>1. <strong>精准标签</strong>：将用户行为、浏览行为等转换为云标签，将其匹配于云端唯一标识的用户本身，精准定位广告人群。</p><p>2. <strong>定制化定向功能</strong>：根据用户浏览行为、搜索行为等提供站点重定向、搜索重定向等多种定制化功能，最大化广告收益。</p><p>3. <strong>多渠道投放广告</strong>：提供客户预算控制、反作弊流量滤除，素材优化及自动生成、广告效果监控及优化等功能，保证客户利益。</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-26.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>四大渠道七种形式：</h3><div><p>汇集搜狐APP、手机搜狐网、搜狐视频、搜狐门户，结合了文字链、信息流广告、banner广告、图混广告、通栏广告、半通栏广告以及巨幅广告。</p></div></div></div></ul><ul class=\"medium-advantage-list list-paddingleft-2\"><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-27.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>四大优势：</h3><div><p>1. <strong>日曝光量高达40亿，日活跃用户突破1亿+</strong>：35岁以下年轻用户达83%，一、二线城市用户超6成，同时移动资讯平台日活跃用户量排名第二，仅次于腾讯新闻。</p><p>2. <strong>多类型的广告形式和计费方式</strong>：拥有资讯、Html5等广告形式以及CPT\\CPM和CPC等多种计费方式，灵活方便。</p><p>3. <strong>个性化推荐，精准分析和内容匹配能力</strong>：基于用户兴趣标签进行集合展示量竞价（CPM），达到快速、精准覆盖目标用户的目的。</p><p>4. <strong>成本低于同行业广告平台</strong>：平均CPC（单次点击价格）低于同行业，并根据点击率、CPA等做相应的调整，更好的保障投放成本以及效果。</p></div></div></div><div class=\"item\"><div class=\"img\"><img src=\"/statics/pc/image/gg-28.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>三大形式：</h3><div><p>UC信息流广告位置主要在UC浏览器首页推荐位信息流位置，广告主可根据情况选择大图、小图、组图广告样式进行投放，同时，广告链接可直接跳转至H5页面。</p></div></div></div></ul></div></section>', '20190108', '1564645157');
INSERT INTO `lt_page` VALUES ('58', '营销产品', ';', '', '<section class=\"market-tips\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">专业的团队 做专业的营销</h3><p class=\"tips wow slideInUp\">昱晟通过专现有广告网络和广告系统，帮助广告主透过大数据库数千个标签运算匹配、海量流量的筛选，实现精准的高质用户获取，目前已成功为数百企业提供+互联网解决方案和服务。</p></div><div class=\"market-tips-list\"><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/yxzx-1.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">付费广告托管</h3><div><p>涵盖广告策略、投放管理、媒介采购、数据分析</p><p>1.全方位分析、诊断、制定企业关键词优化策略</p><p>2.搜索引擎覆盖，快速提升网站流量，促进转化</p><p>3.对账户运营情况和效果进行实时监控，监测转化</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/yxzx-2.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">SEO 推广</h3><div><p>为网站提供生态式的自我营销解决方案，进而获得品牌收益。</p><p>1.品牌关键词覆盖百度前 5 页；基础口碑营销建设；</p><p>2.品牌关键词百度排名至首页</p><p>3.维护关键词排名首页</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/yxzx-3.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">客服代运营服务</h3><div><p>专业的客服知识和技巧，有效沟通高效留客</p><p>1.	客服专业知识培训和沟通技巧的传授</p><p>2.	客服日常管理等服务</p></div></div></div></div></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\"><img src=\"/statics/pc/image/logo.png\" alt=\"\" srcset=\"\"/><span>服务优势</span></h3><p class=\"tips wow slideInUp\">专业的“效果、品牌、流量”移动营销解决方案</p></div><div class=\"server-adv-list\"><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/yxzx-4.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>100%主流媒体资源</h3><p>整合TOP媒体平台实现100%营销资源的覆盖率及规模化运营</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/yxzx-5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>创意策划服务</h3><p>以客户为中心，从文案、广告素材、视频等创意策划团队，助力您的广告实现品效双赢</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/yxzx-6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>一站式整合服务</h3><p>专业的“品牌策划、媒体投放、效果评估”智能整合营销服务， 资深广告优化师团队，为广告主利益保驾护航</p></div></div></div></section><section class=\"case\"><div class=\"container\"><h3 class=\"sec-title\">客户案例</h3><div class=\"al-list\"><a href><img src=\"/statics/pc/image/als_1.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_2.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_3.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_4.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_5.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_6.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_7.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_8.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_9.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_10.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_11.png\" alt=\"\" srcset=\"\"/></a></div></div></section>', '20190108', '1564644624');
INSERT INTO `lt_page` VALUES ('59', '信息流推广', ';', '', '<section class=\"market-tips\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">什么是信息流推广</h3><p class=\"tips wow slideInUp\">昱晟合作了百度、腾讯、新浪、今日头条、360等顶级广告资源，广告形式涵盖主流的图文、信息流、沉浸式视频等多种。我们通过对大型程序化产品的代理，以及专业化、精细化的运营服务，为餐饮、电商、金融、游戏等行业APP以及品牌广告主提供最具性价比的投放策略和资源配比方案，兼顾展示效果和曝光双重价值，品效共振，直达用户。</p></div></div></section><section class=\"server-resou set-bg1\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">昱晟代理服务资源</h3><p class=\"tips wow slideInUp\">覆盖国内一线主流媒体</p></div><div class=\"server-resou-list\"><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-1.png\" alt=\"\" srcset=\"\"/></div><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-2.png\" alt=\"\" srcset=\"\"/></div><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-3.png\" alt=\"\" srcset=\"\"/></div><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-4.png\" alt=\"\" srcset=\"\"/></div><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-5.png\" alt=\"\" srcset=\"\"/></div><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-6.png\" alt=\"\" srcset=\"\"/></div><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-7.png\" alt=\"\" srcset=\"\"/></div><div class=\"item wow flip\"><img src=\"/statics/pc/image/xxltg-8.png\" alt=\"\" srcset=\"\"/></div></div></div></section><section class=\"delivery-adv\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">昱晟代理资源投放优势</h3><p class=\"tips wow slideInUp\">全链条为客户提供专业化服务</p></div><div class=\"delivery-adv-list\"><div class=\"item wow slideInLeft\" data-wow-delay=\"0s\"><div class=\"img\"><img src=\"/statics/pc/image/xxltg-9.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">高效的开户流程</div></div><div class=\"item wow slideInLeft\" data-wow-delay=\"0.3s\"><div class=\"img\"><img src=\"/statics/pc/image/xxltg-10.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">专业的推广方案</div></div><div class=\"item wow slideInLeft\" data-wow-delay=\"0.6s\"><div class=\"img\"><img src=\"/statics/pc/image/xxltg-11.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">一流的数据优化</div></div><div class=\"item wow slideInLeft\" data-wow-delay=\"0.9s\"><div class=\"img\"><img src=\"/statics/pc/image/xxltg-12.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">实时的精品监控</div></div><div class=\"item wow slideInLeft\" data-wow-delay=\"1.2s\"><div class=\"img\"><img src=\"/statics/pc/image/xxltg-13.png\" alt=\"\" srcset=\"\"/></div><div class=\"txt\">统一的报表呈现</div></div></div></div></section><section class=\"case\"><div class=\"container\"><h3 class=\"sec-title\">客户案例</h3><div class=\"al-list\"><a href><img src=\"/statics/pc/image/als_1.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_2.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_3.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_4.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_5.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_6.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_7.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_8.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_9.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_10.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_11.png\" alt=\"\" srcset=\"\"/></a></div></div></section>', '20190108', '1564645168');
INSERT INTO `lt_page` VALUES ('60', '营销策划', ';', '', '<section class=\"market-tips market-tips-plan\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">昱晟营销策划</h3><p class=\"tips wow slideInUp\">有机组合策划各要素，最大化提升品牌资产，专注为成长型企业提供各种品牌推广策划、网络营销策划指导，建设营销型网站，以及提供网络营销策划及广告传播等专业营销策划服务</p></div><div class=\"market-tips-list\"><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/yxch-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">品牌策划</h3><div><p>涵盖品牌战略拟定</p><p>视觉识别系统设计</p><p>品牌视觉设计</p><p>品牌线上、线下活动</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/yxch-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">品牌冷启动</h3><div><p>上线前的市场调研分析</p><p>宣传渠道和媒介的搭建</p><p>宣传物料的设计输出</p><p>整体营销策略的分析运行</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/yxch-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">广告投放策划</h3><div><p>选择投渠道</p><p>创建投放策略</p><p>资深优化师投放</p><p>投放效果跟踪</p></div></div></div></div></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">一站式策划流程服务</h3></div><div class=\"server-adv-list\"><div class=\"item wow slideInUp\" data-wow-delay=\"0s\"><div class=\"img\"><img src=\"/statics/pc/image/yxch-4.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>确定业务目标</h3><p>通过市场调研、数据分析以及客户意愿确定最终营销目标，实现精准营销。</p></div></div><div class=\"item wow slideInUp\" data-wow-delay=\"0.3s\"><div class=\"img\"><img src=\"/statics/pc/image/yxch-5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>创新方案</h3><p>根据多年营销策划经验以及推广目标特性，在设计、宣传等多方面内容进行创新，最大化占领市场。</p></div></div><div class=\"item wow slideInUp\" data-wow-delay=\"0.6s\"><div class=\"img\"><img src=\"/statics/pc/image/yxch-6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>内容多样</h3><p>根据不同媒介制作符合该媒介用户性质的内容，迅速占领用户心智以及精准获客。</p></div></div><div class=\"item wow slideInUp\" data-wow-delay=\"0.9s\"><div class=\"img\"><img src=\"/statics/pc/image/yxch-7.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>投放监测</h3><p>推广上线对效果进行实时监测，根据数据和效果进行及时、合适的调整，将资源进行最大的利用和转化。</p></div></div></div></section><!-- 案例 --><section class=\"case\"><div class=\"container\"><h3 class=\"sec-title\">客户案例</h3><div class=\"al-list\"><a href><img src=\"/statics/pc/image/als_1.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_2.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_3.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_4.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_5.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_6.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_7.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_8.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_9.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_10.png\" alt=\"\" srcset=\"\"/></a><a href><img src=\"/statics/pc/image/als_11.png\" alt=\"\" srcset=\"\"/></a></div></div></section>', '20193007', '1564476058');
INSERT INTO `lt_page` VALUES ('61', '商数云智能建站', ';', '', '<section class=\"d-tit\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">商数云智能建站</h3><p class=\"tips wow slideInUp\">商数云智能建站系统，不需要通过技术人员，营销人员可以直接挂网页，大大减少企业消耗，提高工作效率。</p></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">产品优势</h3></div><div class=\"server-adv-list\"><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/zn-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>无技术建站</h3><p>无需代码 ，自己动手做网站。适合有动手能力的个人工作室 、小微企业。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/zn-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>智能建站+模板</h3><p>设计师助力 ，自己动手做网站。精装网站半成品 、快速开通上线。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/zn-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>智能建站+商数定制</h3><p>无需动手 ，建站专家一站式服务。适合企业高要求形象展示、电商和政府机构等。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/zn-4.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>70种控件，操作更简单</h3><p>70+种丰富插件，如图片、文字、表单、地图、在线咨询、视频等。让您按需构想，随心所动，产品卖点突出，更能打动客户。</p></div></div></div></section><section class=\"market-tips market-tips-pro\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">产品功能</h3></div><div class=\"market-tips-list\"><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/zn-5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">丰富的模板及素材库</h3><div><p class=\"bf\">7大色系、60+行业覆盖、2000+套模板、100000+图片库；</p><p class=\"bf\">设计师授权发布模板，有效保护设计版权；</p><p class=\"bf\">模板按周更新，持续跟踪审美趋势。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/zn-6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">企业营销</h3><div><p class=\"bf\">支持全局、单页面、单独文章及产品的SEO设置，有效提升搜索引擎对网站的收录及排名；</p><p class=\"bf\">10+热门客服工具，方便与您客户实时互动咨询，快速提升询盘率和成交转化率，变流量为销量；</p><p class=\"bf\">多种数据分析统计工具，流量、业绩分析尽在掌握。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/zn-7.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">电商功能</h3><div><p class=\"bf\">支持多种主流支付方式，配有会员管理系统，会员权限由你配；</p><p class=\"bf\">产品管理、订单管理、物流配送管理等尽在掌握，让您的产品和服务高效抵达客户。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/zn-8.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">网站安全，商数云保驾护航</h3><div><p class=\"bf\">网站安全稳定，网页打开速度快；</p><p class=\"bf\">支持HTTPS，使网站防劫持、防篡改、防监听。客户更加信任您；</p><p class=\"bf\">升级系统，持续优化功能和插件。</p></div></div></div></div></div></section>', '20190808', '1565251790');
INSERT INTO `lt_page` VALUES ('62', '商数云呼叫中心', ';', '', '<section class=\"d-tit\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">商数云呼叫中心</h3><p class=\"tips wow slideInUp\">可以自助开通呼叫中心，轻松设置IVR流程，管理并追踪客服绩效，无需具备专业技能，无需管理任何设备。基于云端呼叫中心平台的全部优势，实现更大的灵活性，更高的可靠性和更低的成本。</p></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title\">产品优势</h3></div><div class=\"server-adv-list\"><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hj-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>一键开通</h3><p>无需部署，无需技术支持，一键创建呼叫中心，一键发布上线。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hj-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>简单易用</h3><p>采用自助式图形界面，非技术用户也可以轻松设计IVR流程。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hj-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>灵活集成</h3><p>多种方式集成，灵活集成第三方系统，实现来电弹屏，交互式IVR。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hj-4.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>稳定可靠</h3><p>支持行业90%的呼叫业务，稳定性经过重重考验。</p></div></div></div></section><section class=\"market-tips market-tips-pro\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">产品功能</h3></div><div class=\"market-tips-list\"><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hj-5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">分钟级开通</h3><div><p>开箱即用，只需几次点击，即可创建呼叫中心。零门槛，零设备，零部署。</p><p class=\"bf\">通信号码申请，可直接在控制台申请呼叫中心号码，随时呼出呼出不限并发。</p><p class=\"bf\">开箱即用，预置呼叫中心所需所有基本信息，秒级开通立即使用。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hj-6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">图形化IVR设计</h3><div><p>流程图形化，功能模块化，非技术用户也可以轻松设置语音播报流程，更无需预录制背景音频。</p><p class=\"bf\">自由拖拽轻松编辑IV，可自由拖拽预定义的功能模块，实现交互式语音应答流程。</p><p class=\"bf\">文字转语音，背景音部分可直接输入文字，系统自动将文字转换成语音进行播报，节省大量录音的人力成本。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hj-7.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">全方位数据展示</h3><div><p>提供监控大屏，坐席和技能组的详细报表，让呼叫中心运营数据清晰可查。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hj-8.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">实时智能质检</h3><div><p>实时对每一通电话进行智能质检，根据您的预定义规则，自动检测和匹配对话内容，获取客服绩效和服务质量，全程无需人工干预。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hj-9.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">多种方式灵活集成</h3><div><p>提供多种集成方式，您可以轻松的与企业内部的业务系统集成，实现来电弹屏，交互式IVR流程等功能。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hj-10.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">按需付费</h3><div><p>无需预付费或签订长期合约，按量付费可以免费开通，使用时以分钟为单位进行计费。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hj-11.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">弹性扩容</h3><div><p>根据需求量，您可以自助增加和缩减所需要的坐席数量；在业务量高峰期，也无需关心呼叫并发，理论上可支持无限并发。</p></div></div></div></div></div></section><!-- 焦点图 --><section class=\"focus-map\" style=\"background: url(\" center=\"\"><div class=\"focus-bx\"><p>开启智能营销</p></div></section>', '20193007', '1564476980');
INSERT INTO `lt_page` VALUES ('63', '进率客服工具', ';', '', '<section class=\"d-tit\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">进率客服工具</h3><p class=\"tips wow slideInUp\">可帮每一个企业建立企业大数据管理，高效的智能客服，人工客服+智能机器人客服，智能机器人，语义识别，可帮您无限接近人工客服，实现高效率的智能客服</p></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">产品优势</h3></div><div class=\"server-adv-list\"><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/kf-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>全渠道</h3><p>全媒体，全渠道统一接入，随时随地享受方便快捷全方位服务。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/kf-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>智能</h3><p>全国领先智能算法，机器人准确回答问题，降低人力成本90%以上。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/kf-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>多方位监控</h3><p>数据实时汇总分析，以全局视角了解热门问题、服务瓶颈。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/kf-4.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>实时质检</h3><p>通过语音识别和分析，对全量服务记录自动质检，全面覆盖无死角</p></div></div></div></section><section class=\"market-tips market-tips-pro\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title\">产品功能</h3></div><div class=\"market-tips-list\"><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/kf-5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">丰富灵活的服务接入</h3><div><p>多种渠道可以灵活集成到用户的官网、APP、公众号等任意位置，方便快捷。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/kf-6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">自学习智能机器人</h3><div><p>依托全国领先的智能算法，机器人能准确的理解用户的意图，并准确的回答用户的问题；同时通过深度学习和数据挖掘使机器人不断自学习，提升解答能力。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/kf-7.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">统一工作台</h3><div><p>提供完整的热线、在线服务功能，操作简便；可轻松连接企业的其他系统，如CRM等。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/kf-8.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">统一知识库</h3><div><p>提供给客户、坐席使用的统一知识库、知识文章动态管理，一处调整处处生效；支持多场景展示和内容隔离，方便用户在不同场景下知识文章的管理和应用。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/kf-9.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">实时监控大盘</h3><div><p>将数据实时汇总、实时分析，提供给业务决策者全局视角，了解用户的热门问题、服务瓶颈；提供队列、坐席的实时监控和基于室内位置的坐席地图监控的功能。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/kf-10.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">可视化数据分析</h3><div><p>针对自助服务、人工服务进行多维、详尽的数据统计分析，并通过多种图表展示给用户。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/kf-11.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">实时质检</h3><div><p>通过语音识别技术和语义分析技术，对全量的服务记录进行自动质检，全面覆盖无死角。</p></div></div></div></div></div></section><!-- 焦点图 --><section class=\"focus-map\" style=\"background: url(\" center=\"\"><div class=\"focus-bx\"><p>开启智能营销</p></div></section>', '20193007', '1564477051');
INSERT INTO `lt_page` VALUES ('64', '进率网页回呼', ';', '', '<section class=\"d-tit\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">进率网页回呼</h3><p class=\"tips wow slideInUp\">快速建立起访客与网站主之间的电话连接,让访客更加轻松的与网站主进行对话、咨询、洽谈等。</p></div></section><section class=\"server-adv set-bg1\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">产品优势</h3></div><div class=\"server-adv-list\"><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hh-1.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>灵活对接</h3><p>提供多平台技术支持，提供 SDK、API 及 Demo灵活、轻松接入</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hh-2.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>功能可扩展</h3><p>支持、通话录音；呼叫记录等功能、能无限扩展，满足不同业务所需。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hh-3.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>漏电追踪</h3><p>记录推送漏电，每一通漏接的电话都可能是你的潜在客户，为把握商机。</p></div></div><div class=\"item wow flip\"><div class=\"img\"><img src=\"/statics/pc/image/hh-4.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3>99.9%稳定</h3><p>超过十年通讯积累、运营商支撑经验、经过一线企业验证，保证平台高并发无故障运行</p></div></div></div></section><section class=\"market-tips market-tips-pro\"><div class=\"container\"><div class=\"sea-tibox\"><h3 class=\"sec-title wow slideInUp\">产品功能</h3></div><div class=\"market-tips-list\"><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hh-5.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">嵌入广告落地页</h3><div><p>网页回呼能嵌入广告页，进而从广告页中提升咨询数量，提高客户转化率。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hh-6.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">嵌入官网</h3><div><p>网页回呼能嵌入各行业官网首页，只需简单地三步操作电脑即可建立通话。</p></div></div></div><div class=\"item wow slideInUp\"><div class=\"img\"><img src=\"/statics/pc/image/hh-7.jpg\" alt=\"\" srcset=\"\"/></div><div class=\"txt\"><h3 class=\"sec-title\">嵌入B2B网站</h3><div><p>直接为B2B交易企业提供高效的网络在线呼转营销工具。</p></div></div></div></div></div></section><!-- 焦点图 --><section class=\"focus-map\" style=\"background: url(\" center=\"\"><div class=\"focus-bx\"><p>开启智能营销</p></div></section>', '20193007', '1564477136');

-- ----------------------------
-- Table structure for lt_page_history
-- ----------------------------
DROP TABLE IF EXISTS `lt_page_history`;
CREATE TABLE `lt_page_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `title` varchar(160) NOT NULL,
  `style` varchar(24) DEFAULT NULL,
  `keywords` varchar(40) DEFAULT NULL,
  `content` text NOT NULL,
  `template` varchar(30) DEFAULT NULL,
  `updatetime` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for lt_picture
-- ----------------------------
DROP TABLE IF EXISTS `lt_picture`;
CREATE TABLE `lt_picture` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` varchar(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `links` varchar(255) NOT NULL DEFAULT '',
  `futitle` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_picture
-- ----------------------------
INSERT INTO `lt_picture` VALUES ('20', '41', '0', '移动营销  尽在昱晟', '', '/statics/pc/image/banner-3.jpg', '', '', '0', 'http://www.lantu02.com/pcbanner/20.html', '0', '99', '1', 'lantu', '1564454921', '1564638806', '', '您身边的移动营销专家');
INSERT INTO `lt_picture` VALUES ('19', '41', '0', '技术驱动  智能营销', '', '/statics/pc/image/banner-2.jpg', '', '', '0', 'http://www.lantu02.com/pcbanner/19.html', '0', '99', '1', 'lantu', '1564454906', '1564639102', '', '领先的驱动让营销更智能');
INSERT INTO `lt_picture` VALUES ('6', '27', '0', 'c01', '', '/uploadfile/2019/0321/20190321094648375.png', '', '', '0', 'http://www.lantu02.com/productshow/6.html', '0', '99', '1', 'lantu', '1537165900', '1553132811', '', '');
INSERT INTO `lt_picture` VALUES ('7', '27', '0', 'c02', '', '/uploadfile/2018/0917/20180917023346832.jpg', '', '', '0', 'http://www.lantu02.com/productshow/7.html', '0', '99', '1', 'lantu', '1537166014', '1537166033', '', '');
INSERT INTO `lt_picture` VALUES ('18', '41', '0', '精准投放  品效双赢', '', '/statics/pc/image/banner-1.jpg', '', '', '0', 'http://www.lantu02.com/pcbanner/18.html', '0', '99', '1', 'lantu', '1563090590', '1564638822', '', '效果突出的精准营销体系');
INSERT INTO `lt_picture` VALUES ('15', '27', '0', '04', '', '/statics/pc/img/03-01.jpg', '', '', '0', 'http://www.lantu02.com/productshow/15.html', '0', '99', '1', 'lantu', '1551235108', '1551235145', '', '');
INSERT INTO `lt_picture` VALUES ('14', '27', '0', 'test', '', '/uploadfile/2018/0922/20180922021020622.jpg', '', '', '0', 'http://www.lantu02.com/productshow/14.html', '0', '99', '1', 'lantu', '1537596613', '1537596628', '', '');

-- ----------------------------
-- Table structure for lt_picture_data
-- ----------------------------
DROP TABLE IF EXISTS `lt_picture_data`;
CREATE TABLE `lt_picture_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_picture_data
-- ----------------------------
INSERT INTO `lt_picture_data` VALUES ('20', '', '0', '0', '', '0');
INSERT INTO `lt_picture_data` VALUES ('19', '', '0', '0', '', '0');
INSERT INTO `lt_picture_data` VALUES ('6', '', '0', '0', '', '0');
INSERT INTO `lt_picture_data` VALUES ('7', '', '0', '0', '', '0');
INSERT INTO `lt_picture_data` VALUES ('18', '', '0', '0', '', '0');
INSERT INTO `lt_picture_data` VALUES ('15', '', '0', '0', '', '0');
INSERT INTO `lt_picture_data` VALUES ('14', '', '0', '0', '', '0');

-- ----------------------------
-- Table structure for lt_position
-- ----------------------------
DROP TABLE IF EXISTS `lt_position`;
CREATE TABLE `lt_position` (
  `posid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `modelid` smallint(5) unsigned DEFAULT '0',
  `catid` smallint(5) unsigned DEFAULT '0',
  `name` char(30) NOT NULL DEFAULT '',
  `maxnum` smallint(5) NOT NULL DEFAULT '20',
  `extention` char(100) DEFAULT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `thumb` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`posid`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_position
-- ----------------------------

-- ----------------------------
-- Table structure for lt_position_data
-- ----------------------------
DROP TABLE IF EXISTS `lt_position_data`;
CREATE TABLE `lt_position_data` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `module` char(20) DEFAULT NULL,
  `modelid` smallint(6) unsigned DEFAULT '0',
  `thumb` tinyint(1) NOT NULL DEFAULT '0',
  `data` mediumtext,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  `listorder` mediumint(8) DEFAULT '0',
  `expiration` int(10) NOT NULL,
  `extention` char(30) DEFAULT NULL,
  `synedit` tinyint(1) DEFAULT '0',
  KEY `posid` (`posid`),
  KEY `listorder` (`listorder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_position_data
-- ----------------------------

-- ----------------------------
-- Table structure for lt_queue
-- ----------------------------
DROP TABLE IF EXISTS `lt_queue`;
CREATE TABLE `lt_queue` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` char(5) DEFAULT NULL,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `path` varchar(100) DEFAULT NULL,
  `status1` tinyint(1) DEFAULT '0',
  `status2` tinyint(1) DEFAULT '0',
  `status3` tinyint(1) DEFAULT '0',
  `status4` tinyint(1) DEFAULT '0',
  `times` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `siteid` (`siteid`),
  KEY `times` (`times`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_queue
-- ----------------------------

-- ----------------------------
-- Table structure for lt_release_point
-- ----------------------------
DROP TABLE IF EXISTS `lt_release_point`;
CREATE TABLE `lt_release_point` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `port` varchar(10) DEFAULT '21',
  `pasv` tinyint(1) DEFAULT '0',
  `ssl` tinyint(1) DEFAULT '0',
  `path` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_release_point
-- ----------------------------

-- ----------------------------
-- Table structure for lt_search
-- ----------------------------
DROP TABLE IF EXISTS `lt_search`;
CREATE TABLE `lt_search` (
  `searchid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `adddate` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`searchid`),
  KEY `typeid` (`typeid`,`id`),
  KEY `siteid` (`siteid`),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for lt_search_keyword
-- ----------------------------
DROP TABLE IF EXISTS `lt_search_keyword`;
CREATE TABLE `lt_search_keyword` (
  `keyword` char(20) NOT NULL,
  `pinyin` char(20) NOT NULL,
  `searchnums` int(10) unsigned NOT NULL,
  `data` char(20) NOT NULL,
  UNIQUE KEY `keyword` (`keyword`),
  UNIQUE KEY `pinyin` (`pinyin`),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_search_keyword
-- ----------------------------

-- ----------------------------
-- Table structure for lt_session
-- ----------------------------
DROP TABLE IF EXISTS `lt_session`;
CREATE TABLE `lt_session` (
  `sessionid` char(32) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL,
  `lastvisit` int(10) unsigned NOT NULL DEFAULT '0',
  `roleid` tinyint(3) unsigned DEFAULT '0',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `c` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(255) NOT NULL,
  PRIMARY KEY (`sessionid`),
  KEY `lastvisit` (`lastvisit`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_session
-- ----------------------------
INSERT INTO `lt_session` VALUES ('c827qse42i59br908cilo46du3', '1', '127.0.0.1', '1565574528', '1', '0', 'admin', 'index', 'public_session_life', 'code|s:0:\"\";userid|s:1:\"1\";roleid|s:1:\"1\";pc_hash|s:6:\"ReR8PS\";lock_screen|i:0;');

-- ----------------------------
-- Table structure for lt_site
-- ----------------------------
DROP TABLE IF EXISTS `lt_site`;
CREATE TABLE `lt_site` (
  `siteid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(30) DEFAULT '',
  `dirname` char(255) DEFAULT '',
  `domain` char(255) DEFAULT '',
  `site_title` char(255) DEFAULT '',
  `keywords` char(255) DEFAULT '',
  `description` char(255) DEFAULT '',
  `release_point` text,
  `default_style` char(50) DEFAULT NULL,
  `template` text,
  `setting` mediumtext,
  `uuid` char(40) DEFAULT '',
  `olddomain_status` tinyint(1) DEFAULT NULL,
  `cache_status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_site
-- ----------------------------
INSERT INTO `lt_site` VALUES ('1', '示例网站', '', 'http://www.lantu03.com/', '', '', '', '', 'default', 'default', '{\"upload_maxsize\":\"8048\",\"upload_allowext\":\"jpg|jpeg|gif|bmp|png|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|rar|zip|swf\",\"watermark_enable\":\"0\",\"watermark_minwidth\":\"300\",\"watermark_minheight\":\"300\",\"watermark_img\":\"statics\\/images\\/water\\/\\/mark.png\",\"watermark_pct\":\"85\",\"watermark_quality\":\"80\",\"watermark_pos\":\"9\"}', '208c5ce0-b26a-11e8-87bb-2c56dc775727', '1', '1');

-- ----------------------------
-- Table structure for lt_successcase
-- ----------------------------
DROP TABLE IF EXISTS `lt_successcase`;
CREATE TABLE `lt_successcase` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` char(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `facenews` varchar(255) NOT NULL DEFAULT '',
  `appmarket` varchar(255) NOT NULL DEFAULT '',
  `getusers` varchar(255) NOT NULL DEFAULT '',
  `newstop` varchar(255) NOT NULL DEFAULT '',
  `newstoptxt` varchar(255) NOT NULL DEFAULT '',
  `mainkeywordstop` varchar(255) NOT NULL DEFAULT '',
  `mainkeywordstxt` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_successcase
-- ----------------------------
INSERT INTO `lt_successcase` VALUES ('1', '27', '0', '版本更新全新蜕变，助力封面新闻勇攀App Store新高峰1', '', '/statics/pc/image/al-1.jpg', '', '0', 'http://www.lantu02.com/success-cases/1.html', '0', '99', '1', 'lantu', '1564545150', '1564545199', '封面新闻', '应用市场推广', '获取用户', '9', '新闻榜', '9', '核心关键词排名', '11');
INSERT INTO `lt_successcase` VALUES ('2', '27', '0', '版本更新全新蜕变，助力封面新闻勇攀App Store新高峰1', '', '/statics/pc/image/al-1.jpg', '', '0', 'http://www.lantu02.com/success-cases/2.html', '0', '99', '1', 'lantu', '1564545150', '1564545199', '封面新闻', '应用市场推广', '获取用户', '9', '新闻榜', '9', '核心关键词排名', '11');
INSERT INTO `lt_successcase` VALUES ('3', '27', '0', '版本更新全新蜕变，助力封面新闻勇攀App Store新高峰1', '', '/statics/pc/image/al-1.jpg', '', '0', 'http://www.lantu02.com/success-cases/3.html', '0', '99', '1', 'lantu', '1564545150', '1564545199', '封面新闻', '应用市场推广', '获取用户', '9', '新闻榜', '9', '核心关键词排名', '11');
INSERT INTO `lt_successcase` VALUES ('4', '27', '0', '版本更新全新蜕变，助力封面新闻勇攀App Store新高峰1', '', '/statics/pc/image/al-1.jpg', '', '0', 'http://www.lantu02.com/success-cases/4.html', '0', '99', '1', 'lantu', '1564545150', '1564545199', '封面新闻', '应用市场推广', '获取用户', '9', '新闻榜', '9', '核心关键词排名', '11');
INSERT INTO `lt_successcase` VALUES ('5', '27', '0', '版本更新全新蜕变，助力封面新闻勇攀App Store新高峰1', '', '/statics/pc/image/al-1.jpg', '', '0', 'http://www.lantu02.com/success-cases/5.html', '0', '99', '1', 'lantu', '1564545150', '1564545199', '封面新闻', '应用市场推广', '获取用户', '9', '新闻榜', '9', '核心关键词排名', '11');
INSERT INTO `lt_successcase` VALUES ('6', '27', '0', '版本更新全新蜕变，助力封面新闻勇攀App Store新高峰1', '', '/statics/pc/image/al-1.jpg', '', '0', 'http://www.lantu02.com/success-cases/6.html', '0', '99', '1', 'lantu', '1564545150', '1564545199', '封面新闻', '应用市场推广', '获取用户', '9', '新闻榜', '9', '核心关键词排名', '11');
INSERT INTO `lt_successcase` VALUES ('7', '27', '0', '版本更新全新蜕变，助力封面新闻勇攀App Store新高峰1', '', '/statics/pc/image/al-1.jpg', '', '0', 'http://www.lantu02.com/success-cases/7.html', '0', '99', '1', 'lantu', '1564545150', '1564545199', '封面新闻', '应用市场推广', '获取用户', '9', '新闻榜', '9', '核心关键词排名', '11');

-- ----------------------------
-- Table structure for lt_successcase_data
-- ----------------------------
DROP TABLE IF EXISTS `lt_successcase_data`;
CREATE TABLE `lt_successcase_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_successcase_data
-- ----------------------------
INSERT INTO `lt_successcase_data` VALUES ('2', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0');
INSERT INTO `lt_successcase_data` VALUES ('3', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0');
INSERT INTO `lt_successcase_data` VALUES ('4', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0');
INSERT INTO `lt_successcase_data` VALUES ('5', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0');
INSERT INTO `lt_successcase_data` VALUES ('6', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0');
INSERT INTO `lt_successcase_data` VALUES ('7', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0');
INSERT INTO `lt_successcase_data` VALUES ('1', '<h3>营销背景</h1>\r\n                        <p>推广时间：2019年4月17日至5月7日</p>\r\n                        <p>广告形式：应用市场推广</p>\r\n                        <p>背景描述：新闻资讯类App作为重要门类跻身于移动设备，如何通过应用市场推广吸引、留存用户成为封面新闻和昱晟科技一致关心的问题。</p>\r\n                        <h3>营销痛点</h1>\r\n                        <p>封面新闻App于2019年5月推出全新5.0版本，亟需通过应用市场推广优化，助力其突破App Store榜单排名，获取更多的曝光机会和优质用户。</p>\r\n                        <img src=\"/statics/pc/image/cgal-3.png\" alt=\"\">\r\n                        <h3>营销策略</h1>\r\n                        <p>准备期：结合新版本的产品特征与用户群体，选取以核心关键词以及竞品品牌词为主的关键词，进行版本更新迭代，以便覆盖核心词汇后开展优化。</p>\r\n                        <p>预热期：每日逐步加量，前期测试出榜单的优化效果，及时调整量级安排，为正式冲榜做好准备。</p>\r\n                        <p>冲榜期：为封面新闻App上线周年，当天加大导量力度，集中火力冲榜。</p>\r\n                        <p>维护期：相应降低量级维护榜单排名，同时让榜单持续保持较高位置。</p>\r\n                        <h3>营销成果</h1>\r\n                        <p>昱晟深耕应用市场推广，助力封面新闻App突破新闻分类榜TOP9；关键词覆盖数量5000+，有效关键词高位率达1.43%。超越竞品，独领风骚。</p>', '0', '0', '', '0');

-- ----------------------------
-- Table structure for lt_template_bak
-- ----------------------------
DROP TABLE IF EXISTS `lt_template_bak`;
CREATE TABLE `lt_template_bak` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `creat_at` int(10) unsigned DEFAULT '0',
  `fileid` char(50) DEFAULT NULL,
  `userid` mediumint(8) DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `template` text,
  PRIMARY KEY (`id`),
  KEY `fileid` (`fileid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for lt_times
-- ----------------------------
DROP TABLE IF EXISTS `lt_times`;
CREATE TABLE `lt_times` (
  `username` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `logintime` int(10) unsigned NOT NULL DEFAULT '0',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `times` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`isadmin`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_times
-- ----------------------------

-- ----------------------------
-- Table structure for lt_type
-- ----------------------------
DROP TABLE IF EXISTS `lt_type`;
CREATE TABLE `lt_type` (
  `typeid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `module` char(15) NOT NULL,
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` char(30) NOT NULL,
  `parentid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typedir` char(20) NOT NULL,
  `url` char(100) NOT NULL,
  `template` char(30) NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`typeid`),
  KEY `module` (`module`,`parentid`,`siteid`,`listorder`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_type
-- ----------------------------
INSERT INTO `lt_type` VALUES ('52', '1', 'search', '0', '专题', '0', 'special', '', '', '4', '专题');
INSERT INTO `lt_type` VALUES ('1', '1', 'search', '1', '新闻', '0', '', '', '', '1', '新闻模型搜索');
INSERT INTO `lt_type` VALUES ('53', '1', 'search', '12', '图片模型', '0', '', '', '', '0', '');
INSERT INTO `lt_type` VALUES ('54', '1', 'search', '13', '成功案例模型', '0', '', '', '', '0', '');
INSERT INTO `lt_type` VALUES ('55', '1', 'search', '14', '留言模型', '0', '', '', '', '0', '');
INSERT INTO `lt_type` VALUES ('56', '1', 'search', '15', '招聘模型', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for lt_urlrule
-- ----------------------------
DROP TABLE IF EXISTS `lt_urlrule`;
CREATE TABLE `lt_urlrule` (
  `urlruleid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(15) NOT NULL,
  `file` varchar(20) NOT NULL,
  `ishtml` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `urlrule` varchar(255) NOT NULL,
  `example` varchar(255) NOT NULL,
  PRIMARY KEY (`urlruleid`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_urlrule
-- ----------------------------
INSERT INTO `lt_urlrule` VALUES ('1', 'content', 'category', '1', '{$catdir}/index.html|{$catdir}/_{$page}.html', 'news/');
INSERT INTO `lt_urlrule` VALUES ('18', 'content', 'show', '1', '{$catdir}/{$id}.html|{$catdir}/{$id}{$page}.html', 'news/1.html');

-- ----------------------------
-- Table structure for lt_version_update
-- ----------------------------
DROP TABLE IF EXISTS `lt_version_update`;
CREATE TABLE `lt_version_update` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` float NOT NULL COMMENT '版本号',
  `url` varchar(255) DEFAULT NULL COMMENT '更新路径',
  `up_date` varchar(50) DEFAULT NULL COMMENT '更新日期',
  `versiontxt` varchar(400) DEFAULT NULL COMMENT '更新内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_version_update
-- ----------------------------
INSERT INTO `lt_version_update` VALUES ('1', '1.66', 'phpcms/templates/default/content/footer.html', '2019-03-20', 'pc脚部模板更新');

-- ----------------------------
-- Table structure for lt_wap
-- ----------------------------
DROP TABLE IF EXISTS `lt_wap`;
CREATE TABLE `lt_wap` (
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  `sitename` char(30) NOT NULL,
  `logo` char(100) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `setting` mediumtext,
  `status` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_wap
-- ----------------------------
INSERT INTO `lt_wap` VALUES ('1', 'wap', '/statics/images/wap/wlogo.gif', 'http://m.lantucms.com/', 'array (\n  \'listnum\' => \'10\',\n  \'thumb_w\' => \'220\',\n  \'thumb_h\' => \'0\',\n  \'c_num\' => \'1000\',\n  \'index_template\' => \'index\',\n  \'category_template\' => \'category\',\n  \'list_template\' => \'list\',\n  \'show_template\' => \'show\',\n)', '0');

-- ----------------------------
-- Table structure for lt_wap_type
-- ----------------------------
DROP TABLE IF EXISTS `lt_wap_type`;
CREATE TABLE `lt_wap_type` (
  `typeid` smallint(5) NOT NULL AUTO_INCREMENT,
  `cat` smallint(5) NOT NULL,
  `parentid` smallint(5) NOT NULL,
  `typename` varchar(30) NOT NULL,
  `siteid` smallint(5) NOT NULL,
  `listorder` smallint(5) DEFAULT '0',
  PRIMARY KEY (`typeid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_wap_type
-- ----------------------------

-- ----------------------------
-- Table structure for lt_workflow
-- ----------------------------
DROP TABLE IF EXISTS `lt_workflow`;
CREATE TABLE `lt_workflow` (
  `workflowid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `steps` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `workname` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `setting` text NOT NULL,
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`workflowid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lt_workflow
-- ----------------------------
INSERT INTO `lt_workflow` VALUES ('1', '1', '1', '审核', '审核一次', '', '0');
