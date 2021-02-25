/*
 Navicat Premium Data Transfer

 Source Server         : 本地lison
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : shengtest2

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 17/07/2020 13:50:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lt_log
-- ----------------------------
DROP TABLE IF EXISTS `lt_log`;
CREATE TABLE `lt_log`  (
  `logid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `field` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `module` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `querystring` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userid` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` datetime(0) NOT NULL DEFAULT '2020-07-07 00:00:00',
  PRIMARY KEY (`logid`) USING BTREE,
  INDEX `module`(`module`, `file`, `action`) USING BTREE,
  INDEX `username`(`username`, `action`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5961 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
