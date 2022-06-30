/*
 Navicat Premium Data Transfer

 Source Server         : zhongWFY测试
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 180.76.190.170
 Source Database       : translate_pay

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : utf-8

 Date: 06/29/2022 23:29:00 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_app_channel_goods`
-- ----------------------------
DROP TABLE IF EXISTS `t_app_channel_goods`;
CREATE TABLE `t_app_channel_goods` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `goods_id` varchar(50) DEFAULT NULL COMMENT '商品表id（冗余)',
  `iflypay_goods_id` varchar(36) DEFAULT NULL COMMENT '统一商品编号',
  `app_channel_id` varchar(36) DEFAULT NULL COMMENT '商户渠道id',
  `app_id` varchar(36) DEFAULT NULL COMMENT '商户id(冗余）',
  `creater` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updater` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `goodsName` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `appName` varchar(50) DEFAULT NULL COMMENT '商户名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_base_app`
-- ----------------------------
DROP TABLE IF EXISTS `t_base_app`;
CREATE TABLE `t_base_app` (
  `ID` varchar(36) NOT NULL COMMENT '主键',
  `app_code` varchar(20) DEFAULT NULL COMMENT '应用编码',
  `app_name` varchar(50) DEFAULT NULL COMMENT '应用名',
  `app_desc` varchar(200) DEFAULT NULL COMMENT '应用描述',
  `status` varchar(1) DEFAULT NULL COMMENT '状态 0：无效 1：有效',
  `del_flag` varchar(1) DEFAULT NULL COMMENT '删除状态 0：删除 1：未删除',
  `creater` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updater` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `merchant_pub_key` varchar(2000) DEFAULT NULL COMMENT '商户应用公钥',
  `iflypay_pub_key` varchar(2000) DEFAULT NULL COMMENT '平台应用公钥',
  `iflypay_pri_key` varchar(2000) DEFAULT NULL COMMENT '平台应用私钥',
  `ip_white_list` varchar(200) DEFAULT NULL COMMENT 'ip白名单',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_base_app_alipay_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_base_app_alipay_info`;
CREATE TABLE `t_base_app_alipay_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `partner` varchar(30) DEFAULT NULL COMMENT '合作身份者ID',
  `seller_id` varchar(30) DEFAULT NULL COMMENT '收款支付宝账号',
  `private_key` varchar(2000) DEFAULT NULL COMMENT '商户的私钥',
  `alipay_public_key` varchar(2000) DEFAULT NULL COMMENT '支付宝的公钥',
  `return_url` varchar(200) DEFAULT NULL COMMENT '页面跳转同步通知页面路径 ',
  `notify_url` varchar(200) DEFAULT NULL COMMENT '服务器异步通知页面路径',
  `del_flag` varchar(2) DEFAULT NULL COMMENT '是否删除(0.删除,1.未删除)',
  `creater` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updater` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `sign_type` varchar(10) DEFAULT NULL COMMENT '签名方式',
  `payment_type` varchar(2) DEFAULT NULL COMMENT '支付类型',
  `alipay_app_id` varchar(30) DEFAULT NULL COMMENT '支付宝应用id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_base_app_channel`
-- ----------------------------
DROP TABLE IF EXISTS `t_base_app_channel`;
CREATE TABLE `t_base_app_channel` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `app_id` varchar(36) DEFAULT NULL COMMENT '应用系统id',
  `iflypay_goods_id` varchar(36) DEFAULT NULL COMMENT '废弃字段',
  `types` varchar(10) DEFAULT NULL,
  `del_flag` varchar(2) DEFAULT NULL COMMENT '是否删除(0.删除,1.未删除)',
  `creater` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updater` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `channel_info_id` varchar(36) DEFAULT NULL COMMENT '渠道配置id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_base_app_unionpay_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_base_app_unionpay_info`;
CREATE TABLE `t_base_app_unionpay_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `merId` varchar(20) DEFAULT NULL COMMENT '商户号码',
  `sign_method` varchar(100) DEFAULT NULL COMMENT '签名方法',
  `cert_path` varchar(100) DEFAULT NULL COMMENT '证书地址',
  `cert_pwd` varchar(100) DEFAULT NULL COMMENT '密码',
  `private_key` varchar(100) DEFAULT NULL COMMENT '私钥',
  `front_url` varchar(200) DEFAULT NULL COMMENT '前台通知地址',
  `back_url` varchar(200) DEFAULT NULL COMMENT '后台通知地址',
  `version` varchar(20) DEFAULT NULL COMMENT '版本号',
  `del_flag` varchar(2) DEFAULT NULL COMMENT '是否删除(0.删除,1.未删除)',
  `creater` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updater` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_base_app_wxpay_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_base_app_wxpay_info`;
CREATE TABLE `t_base_app_wxpay_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `wx_app_id` varchar(32) DEFAULT NULL COMMENT '微信公众账号ID',
  `api_key` varchar(200) DEFAULT NULL COMMENT 'key',
  `mch_id` varchar(32) DEFAULT NULL COMMENT '商户号',
  `seciet` varchar(32) DEFAULT NULL COMMENT '秘钥',
  `spbill_create_ip` varchar(20) DEFAULT '' COMMENT '终端IP',
  `notify_url` varchar(200) DEFAULT NULL COMMENT '通知地址',
  `trade_type` varchar(36) DEFAULT NULL COMMENT '交易类型（JSAPI，NATIVE，APP等）',
  `del_flag` varchar(2) DEFAULT NULL COMMENT '是否删除(0.删除,1.未删除)',
  `creater` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updater` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `t_product_code` varchar(36) DEFAULT NULL COMMENT '支付产品代码',
  `merchant_name` varchar(100) DEFAULT NULL COMMENT '商户名称',
  `merchant_no` varchar(50) DEFAULT NULL COMMENT '商户编号',
  `app_name` varchar(50) DEFAULT NULL COMMENT '应用名称',
  `cert_path` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_base_goods`
-- ----------------------------
DROP TABLE IF EXISTS `t_base_goods`;
CREATE TABLE `t_base_goods` (
  `ID` varchar(36) NOT NULL COMMENT '主键',
  `iflypay_goods_id` varchar(36) DEFAULT NULL COMMENT '统一商品编号',
  `name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `status` char(1) DEFAULT NULL COMMENT '状态 1：有效 0：无效',
  `del_flag` char(1) DEFAULT NULL COMMENT '是否删除 0：删除 1：未删除',
  `creater` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updater` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_channel_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_channel_order`;
CREATE TABLE `t_channel_order` (
  `ID` varchar(36) NOT NULL DEFAULT '' COMMENT '主键',
  `contract_id` varchar(36) NOT NULL COMMENT '合同记录id',
  `iflypay_order_no` varchar(20) NOT NULL COMMENT '合同订单号',
  `amount` float(10,2) DEFAULT NULL COMMENT '订单总金额',
  `pay_channel_id` varchar(36) NOT NULL COMMENT '交易渠道-ID',
  `pay_channel_name` varchar(20) DEFAULT NULL COMMENT '交易渠道-名称',
  `tx` varchar(50) DEFAULT NULL COMMENT '交易渠道生成的流水号',
  `iflypay_start_time` datetime DEFAULT NULL COMMENT '支付起始时间',
  `iflypay_end_time` datetime DEFAULT NULL COMMENT '支付结束时间',
  `iflypay_expired_time` datetime DEFAULT NULL COMMENT '支付超时时间',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `index_contract_id` (`contract_id`) USING BTREE,
  KEY `index_pay_channel_id` (`pay_channel_id`) USING BTREE,
  KEY `idx_iflypay_order_no` (`iflypay_order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_contract_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_contract_order`;
CREATE TABLE `t_contract_order` (
  `ID` varchar(36) NOT NULL COMMENT '主键',
  `iflypay_order_no` varchar(20) NOT NULL COMMENT '合同订单号',
  `app_id` varchar(36) NOT NULL COMMENT '应用ID',
  `app_order_id` varchar(50) DEFAULT NULL COMMENT '应用方订单ID',
  `user_id` varchar(50) DEFAULT NULL COMMENT '交易主体-用户ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '交易主体-用户名',
  `user_account` varchar(50) DEFAULT NULL COMMENT '交易主体-账号（可能有多个账号）',
  `pay_channel_id` varchar(36) DEFAULT NULL COMMENT '交易渠道-ID',
  `pay_channel_name` varchar(20) DEFAULT NULL COMMENT '交易渠道-名称',
  `iflypay_goods_id` varchar(36) NOT NULL COMMENT '统一商品编号',
  `goods_id` varchar(100) DEFAULT NULL COMMENT '商品编号(水电气户号)',
  `goods_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `amount` decimal(16,4) DEFAULT NULL COMMENT '支付金额',
  `currency_code` varchar(20) DEFAULT NULL COMMENT '币种(暂时默认RMB)',
  `app_order_time` datetime DEFAULT NULL COMMENT '应用方下单时间',
  `app_notify_time` datetime DEFAULT NULL COMMENT '应用方通知时间(返回true更新)',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态',
  `del_flag` varchar(1) DEFAULT NULL COMMENT '是否删除0：删除 1：未删除',
  `return_url` varchar(200) DEFAULT NULL COMMENT '页面跳转地址',
  `notify_url` varchar(200) DEFAULT NULL COMMENT '通知地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `order_amount` decimal(16,4) DEFAULT NULL COMMENT '订单金额',
  `coupon_amount` decimal(16,4) DEFAULT NULL COMMENT '优惠券金额',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `iflypay_order_no` (`iflypay_order_no`) USING BTREE,
  KEY `index_status` (`STATUS`) USING BTREE,
  KEY `index_iflypay_goods_id` (`iflypay_goods_id`) USING BTREE,
  KEY `index_app_id` (`app_id`) USING BTREE,
  KEY `index_app_order_id` (`app_order_id`) USING BTREE,
  KEY `index_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_contract_record`
-- ----------------------------
DROP TABLE IF EXISTS `t_contract_record`;
CREATE TABLE `t_contract_record` (
  `ID` varchar(36) NOT NULL COMMENT '主键',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同记录表id',
  `description` varchar(2000) DEFAULT NULL COMMENT '轨迹描述',
  `last_status` varchar(2) DEFAULT NULL COMMENT '合同变更前状态',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '合同当前状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_user_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_order`;
CREATE TABLE `t_user_order` (
  `ID` varchar(36) NOT NULL COMMENT '主键',
  `app_id` varchar(36) NOT NULL COMMENT '应用ID',
  `app_order_no` varchar(50) NOT NULL COMMENT '应用方订单号',
  `user_id` varchar(50) DEFAULT NULL COMMENT '交易主体-用户ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '交易主体-用户名',
  `user_account` varchar(50) DEFAULT NULL COMMENT '交易主体-账号（可能有多个账号）',
  `goods_description` varchar(200) DEFAULT NULL COMMENT '商品描述',
  `iflypay_goods_id` varchar(36) DEFAULT NULL COMMENT '统一商品编号',
  `goods_id` varchar(100) DEFAULT NULL COMMENT '商品编号(水电气户号)',
  `goods_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `amount` float(10,2) DEFAULT NULL COMMENT '订单总金额',
  `currency_code` varchar(20) DEFAULT NULL COMMENT '币种(暂时默认RMB)',
  `app_order_time` datetime DEFAULT NULL COMMENT '应用方下单时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `return_url` varchar(200) DEFAULT NULL COMMENT '页面跳转地址',
  `notify_url` varchar(200) DEFAULT NULL COMMENT '通知地址',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态',
  `telephone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `order_amount` decimal(16,4) DEFAULT NULL,
  `coupon_amount` decimal(16,4) DEFAULT NULL,
  `coupon_detail` varchar(2000) DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `index_app_order_no` (`app_order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `t_user_order_attr`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_order_attr`;
CREATE TABLE `t_user_order_attr` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) NOT NULL,
  `attr_name` varchar(50) DEFAULT NULL,
  `attr_value` text COMMENT '值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

SET FOREIGN_KEY_CHECKS = 1;
