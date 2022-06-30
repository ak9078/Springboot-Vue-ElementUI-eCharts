/*
 Navicat Premium Data Transfer

 Source Server         : zhongWFY测试
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 180.76.190.170
 Source Database       : translate_account

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : utf-8

 Date: 06/29/2022 23:28:20 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_inter_role_state`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_role_state`;
CREATE TABLE `t_inter_role_state` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `resume_id` varchar(36) DEFAULT NULL COMMENT '简历id',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `author` varchar(36) DEFAULT NULL COMMENT '权限(1:正式译员2:临时译员3:内部译员)',
  `state` char(1) DEFAULT NULL COMMENT '状态(1:禁用2:正常)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建人',
  `del_state` char(1) DEFAULT NULL COMMENT '删除状态(0:已删除1:未删除)',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_updater` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  PRIMARY KEY (`id`)
) ENGINE=FEDERATED DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC CONNECTION='mysql://atp:atp123456@127.0.0.1:3306/translate_base/t_inter_role_state';

-- ----------------------------
--  Table structure for `t_order_fee_reward`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fee_reward`;
CREATE TABLE `t_order_fee_reward` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `fee_type` char(2) DEFAULT NULL COMMENT '费用类型：1、悬赏',
  `fee` decimal(6,2) DEFAULT NULL COMMENT '费用金额',
  `audit_state` char(1) DEFAULT NULL COMMENT '审核状态：1、同意；2、拒绝',
  `fee_note` varchar(255) DEFAULT NULL COMMENT '加价原因',
  `audit_note` varchar(255) DEFAULT NULL COMMENT '打回原因',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_no` (`order_no`)
) ENGINE=FEDERATED DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC CONNECTION='mysql://atp:atp123456@127.0.0.1:3306/translate_core/t_order_fee_reward';

-- ----------------------------
--  Table structure for `t_pay_account`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_account`;
CREATE TABLE `t_pay_account` (
  `id` varchar(36) NOT NULL COMMENT '主键id',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `account_balance` decimal(16,2) DEFAULT NULL COMMENT '账户余额',
  `task_incom_amount` decimal(16,2) DEFAULT NULL COMMENT '任务收入',
  `spread_income_amount` decimal(16,2) DEFAULT NULL COMMENT '推广收入',
  `account_freeze_amount` decimal(16,2) DEFAULT NULL COMMENT '账户冻结金额',
  `spread_freeze_amount` decimal(16,2) DEFAULT NULL COMMENT '推广收入冻结占用',
  `cash_amount` decimal(16,2) DEFAULT NULL COMMENT '可提现余额',
  `cash_freeze_amount` decimal(16,2) DEFAULT NULL COMMENT '提现占用',
  `status` char(1) DEFAULT NULL COMMENT '状态(0:正常 1:异常)',
  `del_state` char(1) DEFAULT NULL COMMENT '是否删除(1:未删除 0:已删除)',
  `share_code` varchar(8) DEFAULT NULL COMMENT '分享码',
  `forbid_code_flag` char(1) DEFAULT NULL COMMENT '是否禁用：0正常；1.禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_updater` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_pay_account_stream`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_account_stream`;
CREATE TABLE `t_pay_account_stream` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `user_account` varchar(50) DEFAULT NULL COMMENT '用户账号',
  `pay_type` char(1) DEFAULT NULL COMMENT '支付渠道(1:支付宝 2:微信 3:银联 4:余额 5:线下支付)',
  `iflypay_order_no` varchar(40) DEFAULT NULL COMMENT '渠道流水号',
  `pay_amount` decimal(16,2) DEFAULT NULL COMMENT '实际交易金额',
  `real_goods` varchar(50) DEFAULT NULL COMMENT '实物礼品',
  `prepaid_card_amount` decimal(16,2) DEFAULT NULL COMMENT '预付卡折扣金额',
  `order_no` varchar(40) DEFAULT NULL COMMENT '订单号',
  `pay_time` datetime DEFAULT NULL COMMENT '付款时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater` varchar(40) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_updater` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `del_state` char(1) DEFAULT NULL COMMENT '是否删除(1:未删除 0:已删除)',
  `remark_info` varchar(150) DEFAULT NULL COMMENT '摘要信息',
  `state` char(1) DEFAULT NULL COMMENT '状态(0:支付中 1:支付成功 2:支付失败 3:关闭 4:已退款)',
  `type` char(2) DEFAULT NULL COMMENT '类型(0:预付卡充值1:快速翻译 2:文档翻译 3:补差价30:自定义充值 31:退款)',
  `face_amount` decimal(16,2) DEFAULT NULL COMMENT '面值',
  `prepaid_card_id` varchar(50) DEFAULT NULL COMMENT '预付卡id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='账户流水表';

-- ----------------------------
--  Table structure for `t_pay_cash_manage`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_cash_manage`;
CREATE TABLE `t_pay_cash_manage` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `cash_type` char(1) DEFAULT NULL COMMENT '提现方式(1:支付宝 2:微信 3:银联 )',
  `account` varchar(50) DEFAULT NULL COMMENT '账号',
  `cash_amount` decimal(16,2) DEFAULT NULL COMMENT '提现金额',
  `export_state` char(1) DEFAULT '' COMMENT '导出状态：0.已导出；1.已打回',
  `deal_state` char(1) DEFAULT '1' COMMENT '处理状态：1.未处理；0.已处理',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_updater` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `del_state` char(1) DEFAULT NULL COMMENT '是否删除(1:未删除 0:已删除)',
  `cash_id` varchar(36) DEFAULT NULL COMMENT '流水id',
  `user_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='提现管理表';

-- ----------------------------
--  Table structure for `t_pay_cash_record`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_cash_record`;
CREATE TABLE `t_pay_cash_record` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `cash_id` varchar(36) DEFAULT NULL COMMENT '收入流水id',
  `state` char(1) DEFAULT NULL COMMENT '状态(4:未生效 5:已生效 6:已失效 14:冻结 15:解冻)',
  `operater` varchar(50) DEFAULT NULL COMMENT '操作人',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='提现记录';

-- ----------------------------
--  Table structure for `t_pay_dict`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_dict`;
CREATE TABLE `t_pay_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(5) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_pay_income_stream`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_income_stream`;
CREATE TABLE `t_pay_income_stream` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `task_id` varchar(36) DEFAULT NULL COMMENT '文档译员任务id（t_order_link_task）的id',
  `record_id` varchar(36) DEFAULT NULL COMMENT '口译任务id',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `order_no` varchar(40) DEFAULT NULL COMMENT '订单号',
  `cash_type` char(1) DEFAULT NULL COMMENT '收入类型(7:任务收入 8:推广收入 9:提现)',
  `income_amount` decimal(16,2) DEFAULT NULL COMMENT '收入金额',
  `state` char(2) DEFAULT NULL COMMENT '状态(4:未生效 5:已生效 6:已失效 16:提现申请 17:提现成功 18:提现失败)',
  `order_final_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `order_sys_account` varchar(40) DEFAULT NULL COMMENT '下单账号',
  `order_amount` decimal(16,2) DEFAULT NULL COMMENT '订单金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建人',
  `del_state` char(1) DEFAULT NULL COMMENT '是否删除(1:未删除 0:已删除)',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_updater` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `money_reward` decimal(16,2) DEFAULT NULL COMMENT '奖励金额',
  `task_type` char(2) DEFAULT NULL COMMENT '任务类型(20:快速翻译21:文档翻译22:口译翻译23:提现)',
  `pay_type` char(1) DEFAULT NULL COMMENT '支付渠道(1:支付宝2:微信3:银行卡4:线下支付)',
  `freeze_state` char(1) DEFAULT NULL COMMENT '是否冻结（推广收入）：0.正常；1.已冻结',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='收入流水表';

-- ----------------------------
--  Table structure for `t_pay_internal_cost`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_internal_cost`;
CREATE TABLE `t_pay_internal_cost` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `internal_cost` decimal(16,2) DEFAULT NULL COMMENT '内部成本',
  `internal_time` datetime DEFAULT NULL COMMENT '成本日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(40) DEFAULT NULL COMMENT '创建人',
  `last_edit_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_edit_user` varchar(40) DEFAULT NULL COMMENT '最后修改人',
  `del_state` char(1) DEFAULT '1' COMMENT '是否删除(1:未删除 0:已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='内部成本表';

-- ----------------------------
--  Table structure for `t_pay_normal_payback`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_normal_payback`;
CREATE TABLE `t_pay_normal_payback` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单号',
  `translate_type` char(1) DEFAULT NULL COMMENT '翻译类型(1:快速翻译 2:文档翻译 3:补差价)',
  `user_account` varchar(50) DEFAULT NULL COMMENT '下单账号',
  `order_amount` decimal(16,2) DEFAULT NULL COMMENT '订单金额',
  `remittance_no` varchar(50) DEFAULT NULL COMMENT '汇款码',
  `remittance_amount` decimal(16,2) DEFAULT NULL COMMENT '已回金额',
  `remittance_time` datetime DEFAULT NULL COMMENT '回款时间',
  `state` char(1) DEFAULT '3' COMMENT '状态：1：已销账 2：部分销账 3：未销账 0：关闭',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `source` char(1) DEFAULT '1' COMMENT '来源：1.线上',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标识:1.未删除；0.已删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单回款表';

-- ----------------------------
--  Table structure for `t_pay_recharge_card`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_recharge_card`;
CREATE TABLE `t_pay_recharge_card` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_no` varchar(20) DEFAULT NULL COMMENT '订单号',
  `precard_id` varchar(36) DEFAULT NULL COMMENT '充值卡id',
  `precard_no` varchar(50) DEFAULT NULL COMMENT '充值卡编号',
  `precard_name` varchar(255) DEFAULT NULL COMMENT '充值卡名称',
  `user_id` varchar(50) DEFAULT NULL COMMENT '用户id',
  `face_amount` decimal(16,2) DEFAULT NULL COMMENT '面值',
  `user_account` varchar(50) DEFAULT NULL COMMENT '下单账号',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `remittance_no` varchar(50) DEFAULT NULL COMMENT '汇款码',
  `real_amount` decimal(16,2) DEFAULT NULL COMMENT '实付金额',
  `remittance_amount` decimal(16,2) DEFAULT NULL COMMENT '已回金额',
  `remittance_time` datetime DEFAULT NULL COMMENT '回款时间',
  `state` char(1) DEFAULT '3' COMMENT '状态：1：已销账 2：部分销账 3：未销账 0：关闭',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标识:1.未删除；0.已删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='预付卡回款表';

-- ----------------------------
--  Table structure for `t_pay_refund_manage`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_refund_manage`;
CREATE TABLE `t_pay_refund_manage` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '主键',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `translate_type` char(1) DEFAULT NULL COMMENT '翻译类型',
  `refund_amount` decimal(16,2) DEFAULT NULL COMMENT '退款金额',
  `refund_way` varchar(30) DEFAULT NULL COMMENT '退款方式',
  `refund_account` varchar(50) DEFAULT NULL COMMENT '退款账号',
  `user_name` varchar(30) DEFAULT NULL COMMENT '姓名',
  `user_id` varchar(50) DEFAULT NULL COMMENT '用户id',
  `treat_state` char(1) DEFAULT NULL COMMENT '处理状态：1.未处理；0.已处理',
  `state` char(1) DEFAULT NULL COMMENT '退款状态：5.退款中；6.已退款',
  `note` varchar(300) DEFAULT NULL COMMENT '备注',
  `del_state` varchar(255) DEFAULT '1' COMMENT '删除状态：1.未删除；0已删除',
  `order_source` char(1) DEFAULT NULL COMMENT '订单来源：1.译鱼  2.代客下单 3.crm 4.移动端下单',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单退款表';

-- ----------------------------
--  Table structure for `t_sys_account`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_account`;
CREATE TABLE `t_sys_account` (
  `id` varchar(36) NOT NULL,
  `account_code` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `mobile_phone` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `account_pwd` varchar(36) DEFAULT NULL COMMENT '账号密码',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `user_head_img` varchar(100) DEFAULT NULL COMMENT '用户头像url',
  `account_type` char(1) DEFAULT NULL COMMENT '用户类型 1：前台用户 2：后台用户',
  `work_number` varchar(20) DEFAULT '' COMMENT '工号，只针对后台用户',
  `register_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `register_ip` varchar(50) DEFAULT NULL COMMENT '注册IP',
  `register_source` char(1) DEFAULT NULL COMMENT '注册来源',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登陆IP',
  `login_count` varchar(10) DEFAULT NULL COMMENT '登陆次数',
  `role_id` varchar(200) DEFAULT NULL COMMENT '角色ID 多角色以 逗号隔开',
  `onlie_state` char(1) DEFAULT NULL COMMENT '在线状态 1：在线 0：离线',
  `account_state` char(1) DEFAULT '1' COMMENT '账号状态 1：启用 2：禁用 3：注销',
  `del_state` char(1) DEFAULT '1' COMMENT '删除状态 1:未删除 0：已删除',
  `personal_auth_flag` char(1) DEFAULT NULL COMMENT '是否已个人实名认证 1：是  0:否',
  `company_auth_flag` char(1) DEFAULT NULL COMMENT '是否已企业认证 1：是 0：否',
  `bind_card_flag` char(1) DEFAULT NULL COMMENT '是否绑定银行卡 1：是 0：否',
  `bind_alipayno_flag` char(1) DEFAULT NULL COMMENT '是否绑定支付宝 1：是 0：否',
  `bind_wxno_flag` char(1) DEFAULT NULL COMMENT '是否绑定微信 1：是 0：否',
  `share_code` varchar(8) DEFAULT NULL COMMENT '分享码',
  `forbid_code_flag` char(1) DEFAULT NULL COMMENT '是否禁止：0.正常；1.禁止',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `account_code_bind_time` datetime DEFAULT NULL COMMENT '账号绑定时间',
  PRIMARY KEY (`id`)
) ENGINE=FEDERATED DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC CONNECTION='mysql://atp:atp123456@127.0.0.1:3306/translate_base/t_sys_account';

-- ----------------------------
--  Table structure for `t_sys_auth_personal`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_auth_personal`;
CREATE TABLE `t_sys_auth_personal` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `sys_account_id` varchar(36) DEFAULT NULL COMMENT '账号表主键',
  `auth_type` char(1) DEFAULT NULL COMMENT '认证类型 1：身份证 2：护照',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `card_no` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `address_in_china` varchar(300) DEFAULT NULL COMMENT '在中国居住地址',
  `come_date` varchar(30) DEFAULT NULL COMMENT '到达中国的日期',
  `legal_name` varchar(200) DEFAULT NULL COMMENT '法定名称',
  `auth_state` char(1) DEFAULT NULL COMMENT '认证状态 0：待审核 1：通过 2：不通过',
  `del_state` char(1) DEFAULT NULL COMMENT '删除状态 1：未删除 0：已删除',
  `auth_time` datetime DEFAULT NULL COMMENT '实名认证时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='个人实名认证记录表';

-- ----------------------------
--  Table structure for `t_sys_auth_result`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_auth_result`;
CREATE TABLE `t_sys_auth_result` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `auth_record_id` varchar(36) DEFAULT NULL COMMENT '实名认证记录表主键包含个人和企业实名',
  `auditor` varchar(36) DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_result` char(1) DEFAULT NULL COMMENT '审核结果 1：通过  0：不通过',
  `audit_description` varchar(200) DEFAULT NULL COMMENT '审核意见',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='实名认证审核结果表';

-- ----------------------------
--  Table structure for `t_sys_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_dictionary`;
CREATE TABLE `t_sys_dictionary` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `pid` varchar(36) DEFAULT NULL COMMENT '父级id',
  `name` varchar(30) DEFAULT NULL COMMENT '字典名称',
  `value` varchar(30) DEFAULT NULL COMMENT '字典值',
  `type` varchar(30) DEFAULT NULL COMMENT '字典类型',
  `type_name` varchar(30) DEFAULT NULL COMMENT '类型名称',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `del_state` char(1) DEFAULT '1' COMMENT '删除状态 1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_type` (`type`,`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典表';

-- ----------------------------
--  Table structure for `t_sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user` (
  `id` varchar(36) NOT NULL,
  `sys_account_id` varchar(36) DEFAULT '' COMMENT 't_sys_account主键',
  `user_name` varchar(30) DEFAULT NULL COMMENT '姓名',
  `card_type` char(1) DEFAULT NULL COMMENT '证件类型 1：身份证',
  `card_no` varchar(30) DEFAULT NULL COMMENT '身份证号码',
  `user_sex` char(1) DEFAULT NULL COMMENT '性别 1：男 2：女 3：保密',
  `user_age` tinyint(3) DEFAULT NULL COMMENT '年龄',
  `user_city` varchar(50) DEFAULT NULL COMMENT '所在城市',
  `del_state` char(1) DEFAULT NULL COMMENT '删除状态 1：未删除 0：已删除',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `union_card` varchar(30) DEFAULT NULL COMMENT '银行卡号',
  `aipay_acoount` varchar(50) DEFAULT NULL COMMENT '支付宝账号',
  `aipay_user` varchar(50) DEFAULT NULL COMMENT '支付宝用户名',
  `open_bank` varchar(50) DEFAULT NULL COMMENT '开户行',
  `wechat_no` varchar(50) DEFAULT NULL COMMENT '微信号',
  PRIMARY KEY (`id`)
) ENGINE=FEDERATED DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC CONNECTION='mysql://atp:atp123456@127.0.0.1:3306/translate_base/t_sys_user';

-- ----------------------------
--  Table structure for `t_translator_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_translator_info`;
CREATE TABLE `t_translator_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `resume_id` varchar(36) NOT NULL COMMENT '简历id',
  `real_name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(18) DEFAULT NULL COMMENT '身份证',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `translator_type` char(1) DEFAULT NULL COMMENT '译员类型：1：正式译员 2：临时译员 3：内部译员',
  `status` char(1) DEFAULT NULL COMMENT '状态：1启用 2禁用',
  `del_state` char(1) DEFAULT '1' COMMENT '删除状态 1：未删除 0：已删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_edit_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  PRIMARY KEY (`id`)
) ENGINE=FEDERATED DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC CONNECTION='mysql://atp:atp123456@127.0.0.1:3306/translate_base/t_translator_info';

-- ----------------------------
--  View structure for `doclink_view`
-- ----------------------------
DROP VIEW IF EXISTS `doclink_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`atp`@`%` SQL SECURITY DEFINER VIEW `doclink_view` AS select `t_order_document_link`.`id` AS `id`,`t_order_document_link`.`create_time` AS `create_time` from `t_order_document_link` where ((`t_order_document_link`.`order_no` = 'DD00004679EN') and (`t_order_document_link`.`del_state` = '1') and (`t_order_document_link`.`cost_price` is not null));

-- ----------------------------
--  Procedure structure for `proc_profitMargin`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_profitMargin`;
delimiter ;;
CREATE DEFINER=`atp`@`%` PROCEDURE `proc_profitMargin`(IN p_doc_order_no VARCHAR(36), IN p_pm_id VARCHAR(36))
BEGIN
	
	DECLARE interpreterTotalPrice DECIMAL(10,2) DEFAULT 0.00;
	DECLARE r_profit_margin VARCHAR(20);
	
	-- 查找baseOrderNo
	SELECT IFNULL(t1.`p_order_no`,IFNULL(t1.`order_no`,IFNULL(t.`p_order_no`,t.order_no))) INTO @baseOrderNo FROM `t_order_document` t LEFT JOIN t_order_document t1 ON t1.`id` = t.p_id
		WHERE t.`order_no` = p_doc_order_no;
	-- 订单价格
	SELECT real_price,cost_price INTO @baserealPrice,@baseCostPirce FROM t_order_base WHERE order_no = @baseOrderNo;
	-- 加价
	SELECT IFNULL(SUM(fee),0) INTO @fee FROM `t_order_fee_add` WHERE order_no = @baseOrderNo;
	
	-- 译员总价格
	-- 查找所有子订单的orderNO
	SELECT GROUP_CONCAT(CONCAT('\'',order_no,'\'')) INTO @docOrderNos FROM t_order_document WHERE order_no  = p_doc_order_no;
	-- 拼接sql 
	SET @sql = CONCAT('SELECT SUM(cost_price) INTO @interpreterTotalPrice FROM t_order_document_link WHERE order_no IN (',@docOrderNos,') and del_state = \'1\'');	
	-- 执行
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	SET interpreterTotalPrice = @interpreterTotalPrice;
	
	DEALLOCATE PREPARE stmt;
	SET r_profit_margin = ROUND((1-ROUND(interpreterTotalPrice/@baserealPrice,4))*100,2);
	-- 修改base表利润率
	UPDATE t_order_base SET total_profit_margin = r_profit_margin , total_cost = interpreterTotalPrice WHERE order_no = @baseOrderNo;	
	
	-- 修改当前子订单的利润率
	SELECT SUM(cost_price) INTO interpreterTotalPrice FROM t_order_document_link WHERE order_no = p_doc_order_no  AND del_state = '1';
	 
	SELECT real_price INTO @docRealPrice FROM  t_order_document WHERE order_no = p_doc_order_no;
	
	SET @docRealPrice = @docRealPrice + (@docRealPrice/@baseCostPirce) * @fee;

	SET r_profit_margin = ROUND((1-ROUND(interpreterTotalPrice/@docRealPrice,4))*100,2);
	
	UPDATE 
	  t_order_document_link 
	SET
	  profit_margin = r_profit_margin
	WHERE order_no = p_doc_order_no
	  AND create_user = p_pm_id 
	  AND cir_tag IS NOT NULL 
	ORDER BY create_time DESC 
	LIMIT 1 ;
    END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proc_profitMargin_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_profitMargin_all`;
delimiter ;;
CREATE DEFINER=`atp`@`%` PROCEDURE `proc_profitMargin_all`(IN p_base_order_no VARCHAR(36))
BEGIN
    
	DECLARE done INT DEFAULT 0; -- 循环标识
	DECLARE interpreterTotalPrice DECIMAL(10,2) DEFAULT 0.00; -- 译员总价格
	DECLARE refundFee DECIMAL(10,2) DEFAULT 0.00; -- 退款数额
	
	DECLARE r_profit_margin VARCHAR(20);  -- 利润率
	DECLARE linkId VARCHAR(50) DEFAULT '';  -- 环节总表Id
	DECLARE createTime TIMESTAMP;  -- 环节总表创建时间
	 
	DECLARE docId VARCHAR(36);  -- 文档表id
	DECLARE docOrderNo VARCHAR(36);  -- 文档表no
	DECLARE docRealPrice DECIMAL(10,2) DEFAULT 0.00;  -- 文档价格
	DECLARE docOrderNos VARCHAR(200) DEFAULT '';  -- 文档编号集合，使用逗号隔开
	
	DECLARE multilingual_record CURSOR FOR SELECT id,order_no,real_price FROM `t_order_document` WHERE del_state = '1' AND p_order_no = p_base_order_no;  -- 多语言文档游标
	DECLARE cur CURSOR FOR(SELECT id,create_time FROM doclink_view); -- 视图表
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
	-- 获取主订单总价格
	-- 订单价格
	SELECT real_price INTO @realPrice FROM t_order_base WHERE order_no = p_base_order_no;
	-- 加价
	SELECT IFNULL(SUM(fee),0) INTO @fee FROM `t_order_fee_add` WHERE order_no = p_base_order_no;
	-- 补差价
	SELECT IFNULL(SUM(cost_price),0) INTO @priceDifferences FROM `t_order_base` WHERE order_no LIKE CONCAT('%',p_base_order_no,'-BXJ%') AND del_state = '1'  AND pay_type IS NOT NULL;
		
	SELECT COUNT(1) INTO @countFlag FROM t_order_document WHERE order_no = p_base_order_no AND del_state = '1';
	
	IF @countFlag <> 0 THEN -- 单语言
		-- 计算base表的利润率
		-- 查询退款信息
		SELECT IFNULL(SUM(fee),0) INTO refundFee FROM `t_order_proc_refund` WHERE audit_state = '1' AND del_state  = '1'  AND order_no = p_base_order_no;
		SET @sumPrice = @realPrice +  @fee + @priceDifferences - refundFee;
		-- 计算总订单的利润率
		SELECT SUM(cost_price) INTO interpreterTotalPrice FROM t_order_document_link WHERE order_no = p_base_order_no  AND del_state = '1';
		
		SET r_profit_margin = ROUND((1-ROUND(interpreterTotalPrice/@sumPrice,4))*100,2);
		
		
		-- 修改base表利润率
		UPDATE t_order_base SET total_profit_margin = r_profit_margin , total_cost = interpreterTotalPrice WHERE order_no = p_base_order_no;	
		
		-- MySQL本身是不支持动态游标的，但可以通过（准备语句+视图+静态游标）的方法来近似实现。
		DROP VIEW IF EXISTS doclink_view;
		SET @sqlstr = CONCAT('CREATE VIEW doclink_view AS SELECT id, create_time  FROM t_order_document_link WHERE order_no = \'',p_base_order_no,'\' AND del_state = \'1\' AND cost_price IS NOT NULL');
		PREPARE stmt FROM @sqlstr;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
		OPEN cur;
			f_loop:LOOP FETCH cur INTO linkId,createTime;
				IF done THEN 
					LEAVE f_loop;  
				END IF;
				SELECT IFNULL(SUM(cost_price),0) INTO @docCostPrice FROM t_order_document_link WHERE order_no = p_base_order_no AND create_time <= createTime;
				-- 修改doc利润率
				SET r_profit_margin = ROUND((1-ROUND( @docCostPrice/@sumPrice,4))*100,2);
				UPDATE t_order_document_link SET profit_margin =  r_profit_margin WHERE id = linkId;
				
			END LOOP f_loop;
	        CLOSE cur;
	ELSE -- 多语言
		OPEN multilingual_record;
			f_loop:LOOP FETCH multilingual_record INTO docId,docOrderNo,docRealPrice;
				SELECT docId;
				IF done THEN 
					LEAVE f_loop;  
				END IF;
				IF docOrderNos = '' THEN
					SET docOrderNos = CONCAT('\'',docOrderNo,'\'');
				ELSE 
					SET docOrderNos = CONCAT(docOrderNos,',\'',docOrderNo,'\'');
				END IF;
				-- 查询退款信息
				SELECT IFNULL(SUM(fee),0) INTO @refundFee FROM `t_order_proc_refund` WHERE audit_state = '1' AND del_state  = '1'  AND order_no = docOrderNo;
				SET refundFee = refundFee + @refundFee;
				SET docRealPrice = docRealPrice - @refundFee + (docRealPrice/@realPrice) * (@fee + @priceDifferences);
				DROP VIEW IF EXISTS doclink_view;
				SET @sqlstr = CONCAT('CREATE VIEW doclink_view AS SELECT id,create_time FROM t_order_document_link WHERE order_no = \'',docOrderNo,'\' AND del_state = \'1\' AND cost_price IS NOT NULL');
				PREPARE stmt FROM @sqlstr;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				OPEN cur;
					myLoop:LOOP FETCH cur INTO linkId,createTime;
						
						IF done THEN 
							LEAVE myLoop;  
						END IF;
						SELECT SUM(cost_price) INTO @docCostPrice FROM t_order_document_link WHERE order_no = docOrderNo AND create_time <= createTime;
						
						-- 修改doc利润率
						SET r_profit_margin = ROUND((1-ROUND(@docCostPrice/docRealPrice,4))*100,2);
						UPDATE t_order_document_link SET profit_margin = r_profit_margin WHERE id = linkId;
					END LOOP myLoop;
				CLOSE cur;
				SET done = 0;
			END LOOP f_loop;
	        CLOSE multilingual_record;
		SET @sumPrice = @realPrice +  @fee + @priceDifferences - refundFee;
		-- 计算总订单的利润率
		SET @sqlstr = CONCAT('SELECT SUM(cost_price) INTO interpreterTotalPrice FROM t_order_document_link WHERE order_no IN (',docOrderNos,')  AND del_state = \'1\'');
		SET r_profit_margin = ROUND((1-ROUND(interpreterTotalPrice/@sumPrice,4))*100,2);
		-- 修改base表利润率
		UPDATE t_order_base SET total_profit_margin = r_profit_margin , total_cost = interpreterTotalPrice WHERE order_no = p_base_order_no;	
	END IF;
    END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `TimeOrderBase`
-- ----------------------------
DROP PROCEDURE IF EXISTS `TimeOrderBase`;
delimiter ;;
CREATE DEFINER=`atp`@`%` PROCEDURE `TimeOrderBase`()
BEGIN
	UPDATE t_order_base m
  SET m.state = '2'
  WHERE 
      TO_DAYS(SYSDATE()) - TO_DAYS(m.create_time)>10
  AND
     instr(
		  '0',
		  m.order_state)>0;

END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `update_pay_share_code`
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_pay_share_code`;
delimiter ;;
CREATE DEFINER=`atp`@`%` PROCEDURE `update_pay_share_code`()
BEGIN
  DECLARE i int DEFAULT 1;
  DECLARE id VARCHAR(36);
  DECLARE share_code VARCHAR(8);
	DECLARE userId cursor for select a.id,a.share_code from t_sys_account a; 
  open userId;
  while i<=315 DO
  fetch userId into id,share_code;
  update t_pay_account p set p.share_code = share_code where p.user_id = id;
  set i = i + 1;
  end while; 
END
 ;;
delimiter ;

-- ----------------------------
--  Event structure for `TimeOrderBase`
-- ----------------------------
DROP EVENT IF EXISTS `TimeOrderBase`;
delimiter ;;
CREATE DEFINER=`atp`@`%` EVENT `TimeOrderBase` ON SCHEDULE EVERY 5 MINUTE STARTS '2018-09-12 00:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT '超过十天不付款，订单关闭' DO CALL TimeOrderBase()
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
