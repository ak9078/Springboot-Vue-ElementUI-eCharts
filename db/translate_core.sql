/*
 Navicat Premium Data Transfer

 Source Server         : zhongWFY测试
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 180.76.190.170
 Source Database       : translate_core

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : utf-8

 Date: 06/29/2022 23:28:36 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_common_atta`
-- ----------------------------
DROP TABLE IF EXISTS `t_common_atta`;
CREATE TABLE `t_common_atta` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `record_id` varchar(36) DEFAULT NULL COMMENT '记录id',
  `record_type` varchar(255) DEFAULT NULL COMMENT '记录类型：1、订单；2、招募；3.订单环节4：简历',
  `atta_type` char(2) NOT NULL COMMENT '1.原稿、任务文件、试译文件;2.初稿;3.中间稿;4.终稿;5.参考文件',
  `atta_name` varchar(200) NOT NULL COMMENT '附件名称',
  `atta_suffix` varchar(10) DEFAULT NULL COMMENT '附件后缀',
  `atta_path` varchar(300) NOT NULL COMMENT '附件路径',
  `atta_size` varchar(10) DEFAULT NULL COMMENT '附件大小(单位K)',
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `user_name` varchar(36) DEFAULT NULL COMMENT '上传人姓名',
  `role_name` varchar(36) DEFAULT NULL COMMENT '角色名称',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_record` (`record_id`,`record_type`,`atta_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通用附件表';

-- ----------------------------
--  Table structure for `t_common_atta_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_common_atta_info`;
CREATE TABLE `t_common_atta_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileId` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `orderNo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9842 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_file_sentence`
-- ----------------------------
DROP TABLE IF EXISTS `t_file_sentence`;
CREATE TABLE `t_file_sentence` (
  `id` int(16) NOT NULL AUTO_INCREMENT COMMENT ' ',
  `file_id` varchar(36) NOT NULL COMMENT '文件id，即 t_common_atta 的id',
  `sentence` text COMMENT '文件的句段',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_file_id` (`file_id`) USING BTREE COMMENT '文件Id索引'
) ENGINE=InnoDB AUTO_INCREMENT=3087582 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文件句子信息';

-- ----------------------------
--  Table structure for `t_file_sentence_statistics`
-- ----------------------------
DROP TABLE IF EXISTS `t_file_sentence_statistics`;
CREATE TABLE `t_file_sentence_statistics` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '文件句段记录Id',
  `order_file_id` varchar(36) NOT NULL COMMENT '订单文件Id：表 t_order_file_info 主键Id',
  `statistic_type` tinyint(1) NOT NULL COMMENT '文件句段统计类型：1-重复；2-交叉重复；3-匹配100%；4-匹配95%~99%；5-匹配75%~95%；6-新内容',
  `sentence_count` int(8) DEFAULT NULL COMMENT '句数',
  `character_count` int(16) DEFAULT NULL COMMENT '字数',
  `character_count_no_space` int(16) DEFAULT NULL COMMENT '字符数不包含空格',
  `chn_north` int(16) DEFAULT NULL COMMENT '中朝',
  `no_chn_words` int(16) DEFAULT NULL COMMENT '非中文单词',
  `percentage` varchar(8) DEFAULT NULL COMMENT '字数百分比：字数/总字数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_file_id` (`order_file_id`) USING BTREE COMMENT '文件Id索引'
) ENGINE=InnoDB AUTO_INCREMENT=24401 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文件句子统计信息表';

-- ----------------------------
--  Table structure for `t_flow_node`
-- ----------------------------
DROP TABLE IF EXISTS `t_flow_node`;
CREATE TABLE `t_flow_node` (
  `id` varchar(36) NOT NULL,
  `code` varchar(20) DEFAULT NULL COMMENT '节点代码',
  `name` varchar(20) DEFAULT NULL COMMENT '节点名称',
  `class_name` varchar(20) DEFAULT NULL COMMENT '节点类名称',
  `type` char(1) DEFAULT NULL COMMENT '节点类型:1、快速翻译；2、文档翻译；3、口译；4、试译；5.文档环节',
  `kh_state` char(3) DEFAULT NULL COMMENT '客户状态',
  `kf_state` char(3) DEFAULT NULL COMMENT '客服状态',
  `pmzg_state` char(3) DEFAULT NULL COMMENT 'PM主管状态',
  `pm_state` char(3) DEFAULT NULL COMMENT 'PM状态',
  `yy_state` char(3) DEFAULT NULL COMMENT '译员状态',
  `shkf_state` char(3) DEFAULT NULL COMMENT '销售客服状态',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_inter_auxiliary_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_auxiliary_task`;
CREATE TABLE `t_inter_auxiliary_task` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `task_id` varchar(36) DEFAULT NULL COMMENT '任务ID',
  `auxiliary_id` varchar(50) DEFAULT NULL COMMENT '辅助资料ID：记忆库则对应记忆库ID；术语库则对应术语库ID',
  `auxiliary_type` char(1) DEFAULT NULL COMMENT '辅助资料类型：1、记忆库；2、术语库',
  `del_state` char(1) CHARACTER SET utf8 DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='任务所用辅助资料';

-- ----------------------------
--  Table structure for `t_inter_fee_trim`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_fee_trim`;
CREATE TABLE `t_inter_fee_trim` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `word_num` int(11) DEFAULT NULL,
  `fee_type` char(2) DEFAULT NULL COMMENT '费用类型：1、增加；2、扣除',
  `fee` decimal(6,2) DEFAULT NULL COMMENT '费用金额',
  `user_id` varchar(36) DEFAULT NULL COMMENT '译员userid',
  `note` text COMMENT '备注',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='译员收入调整表';

-- ----------------------------
--  Table structure for `t_inter_hall_fast`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_hall_fast`;
CREATE TABLE `t_inter_hall_fast` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `receive_state` char(1) NOT NULL DEFAULT '0' COMMENT '领取状态：0、未领取；1、已领取',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user` (`create_user`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='译员任务大厅（快速翻译）表';

-- ----------------------------
--  Table structure for `t_inter_memory`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_memory`;
CREATE TABLE `t_inter_memory` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `memory_name` varchar(100) DEFAULT NULL COMMENT '记忆库名称',
  `original_language` varchar(50) DEFAULT NULL COMMENT '源语言',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `professional_field` varchar(4) DEFAULT NULL COMMENT '专业领域',
  `memory_desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `memory_source` char(1) DEFAULT NULL COMMENT '来源：1、个人添加；2、任务添加；3、系统添加',
  `application_range` char(1) DEFAULT NULL COMMENT '使用范围：1、个人；2、公用',
  `del_state` char(1) CHARACTER SET utf8 DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='记忆库';

-- ----------------------------
--  Table structure for `t_inter_memory_sentence`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_memory_sentence`;
CREATE TABLE `t_inter_memory_sentence` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `original_text` text COMMENT '源文',
  `target_text` text COMMENT '译文',
  `memory_id` varchar(36) DEFAULT NULL COMMENT '记忆库ID',
  `del_state` char(1) CHARACTER SET utf8 DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `sentence_source` varchar(36) DEFAULT NULL COMMENT '句对来源：1、手动导入；2、任务添加。',
  `source_detail` varchar(36) DEFAULT NULL COMMENT '来源详细：若是任务来源则为订单号，若是手动导入则为随机号',
  `sort_value` int(11) DEFAULT NULL COMMENT '序号，和来源详细一起用来确定上下文',
  `create_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_memory_id` (`memory_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='记忆库句对表';

-- ----------------------------
--  Table structure for `t_inter_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_task`;
CREATE TABLE `t_inter_task` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `record_id` varchar(36) DEFAULT NULL COMMENT '对应的任务id',
  `order_type` varchar(1) DEFAULT NULL COMMENT '订单类型：1、快速翻译；2、文档翻译；3、口译；4、试译',
  `task_type` char(2) DEFAULT NULL COMMENT '任务类型：1、快翻翻译、2、快翻返稿；3、快翻指定评估；6.文档指定评估',
  `task_state` char(3) DEFAULT '1' COMMENT '任务状态:参考t_sys_dictionary中type in(c_order_state,i_order_state,s_order_state,p_order_state)',
  `task_money` decimal(8,2) DEFAULT NULL COMMENT '任务金额',
  `end_tag` char(1) DEFAULT '1' COMMENT '结束标志：1、未结束，0、已结束',
  `finish_time` datetime DEFAULT NULL COMMENT '截止时间',
  `note` text COMMENT '备注',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='译员任务表';

-- ----------------------------
--  Table structure for `t_inter_task_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_task_log`;
CREATE TABLE `t_inter_task_log` (
  `id` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `action` varchar(200) DEFAULT NULL,
  `new_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务记录表';

-- ----------------------------
--  Table structure for `t_inter_term`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_term`;
CREATE TABLE `t_inter_term` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `term_name` varchar(100) DEFAULT NULL COMMENT '术语名称',
  `original_language` varchar(50) DEFAULT NULL COMMENT '源语言',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `professional_field` varchar(4) DEFAULT NULL COMMENT '专业领域',
  `term_desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `del_state` char(1) CHARACTER SET utf8 DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='术语库';

-- ----------------------------
--  Table structure for `t_inter_term_sentence`
-- ----------------------------
DROP TABLE IF EXISTS `t_inter_term_sentence`;
CREATE TABLE `t_inter_term_sentence` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `original_text` varchar(200) DEFAULT NULL COMMENT '源文',
  `target_text` varchar(200) DEFAULT NULL COMMENT '译文',
  `term_id` varchar(36) DEFAULT NULL COMMENT '术语库ID',
  `del_state` char(1) CHARACTER SET utf8 DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_term_id` (`term_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='术语库句对表';

-- ----------------------------
--  Table structure for `t_interpret_project_cc`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_cc`;
CREATE TABLE `t_interpret_project_cc` (
  `id` varchar(36) NOT NULL,
  `activity_date_id` varchar(36) DEFAULT NULL COMMENT '活动日期id',
  `activity_cc` varchar(50) DEFAULT NULL COMMENT '活动场次',
  `activity_scale` varchar(10) DEFAULT NULL COMMENT '规模',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案场次表';

-- ----------------------------
--  Table structure for `t_interpret_project_cc_equipment`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_cc_equipment`;
CREATE TABLE `t_interpret_project_cc_equipment` (
  `id` varchar(36) NOT NULL,
  `project_cc_id` varchar(36) DEFAULT NULL COMMENT '场次id',
  `equipment_business` varchar(50) DEFAULT NULL COMMENT '设备商',
  `note` varchar(50) DEFAULT NULL COMMENT '备注',
  `cost_subtotal` decimal(10,2) DEFAULT NULL COMMENT '小计',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案场次设备表';

-- ----------------------------
--  Table structure for `t_interpret_project_cc_produce`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_cc_produce`;
CREATE TABLE `t_interpret_project_cc_produce` (
  `id` varchar(36) NOT NULL,
  `produce_type` char(1) DEFAULT NULL COMMENT '产品类型1:交传2:同传3:陪同',
  `source_language` char(5) DEFAULT NULL COMMENT '源语言',
  `target_language` char(5) DEFAULT NULL COMMENT '目标语言',
  `project_cc_id` varchar(36) DEFAULT NULL COMMENT '场次id',
  `produce_name` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `type` varchar(255) DEFAULT NULL COMMENT '1译员 2供应商',
  `orderId` varchar(255) DEFAULT NULL,
  `sort` varchar(255) DEFAULT NULL COMMENT '供应商和译员排序 （序号）',
  `faSort` varchar(255) DEFAULT NULL COMMENT '方案',
  `interpreter` varchar(255) DEFAULT NULL COMMENT '译员（供应商）',
  `costType` varchar(255) DEFAULT NULL COMMENT '费用类型',
  `costDetail` varchar(255) DEFAULT NULL COMMENT '费用明细',
  `method` varchar(255) DEFAULT NULL COMMENT '统计方式',
  `unitPrice` varchar(255) DEFAULT NULL COMMENT '单价',
  `time` varchar(255) DEFAULT NULL COMMENT '时长',
  `subtotal` varchar(255) DEFAULT NULL COMMENT '小计',
  `takeEffect` varchar(255) DEFAULT NULL COMMENT '生效状态(0无效1有效)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案场次产品表';

-- ----------------------------
--  Table structure for `t_interpret_project_date`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_date`;
CREATE TABLE `t_interpret_project_date` (
  `id` varchar(36) NOT NULL,
  `activity_time` datetime DEFAULT NULL COMMENT '活动时间',
  `plan_id` varchar(36) DEFAULT NULL COMMENT '方案id',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `plan_id` (`plan_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='方案时间表';

-- ----------------------------
--  Table structure for `t_interpret_project_equipment_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_equipment_info`;
CREATE TABLE `t_interpret_project_equipment_info` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) DEFAULT NULL COMMENT '设备id',
  `equipment` char(2) DEFAULT NULL COMMENT '设备',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `people_num` char(30) DEFAULT NULL COMMENT '人数',
  `count_num` char(30) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总计',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案场次设备信息表';

-- ----------------------------
--  Table structure for `t_interpret_project_plan`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_plan`;
CREATE TABLE `t_interpret_project_plan` (
  `id` varchar(36) NOT NULL,
  `state` char(1) DEFAULT NULL COMMENT '审核状态(0:驳回 1:通过 2:审批中 3:待提交)',
  `back_reason` varchar(100) DEFAULT NULL COMMENT '打回原因',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `risk_estimate` varchar(500) DEFAULT NULL COMMENT '风险评估',
  `profit_margin` varchar(10) DEFAULT NULL COMMENT '利润率',
  `cost_subtotal` decimal(10,2) DEFAULT NULL COMMENT '成本小计',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `productTotalMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `shorthandMoney` varchar(255) DEFAULT NULL,
  `devTotalMoney` varchar(255) DEFAULT NULL,
  `travelTotalMoney` varchar(255) DEFAULT NULL,
  `otherMoney` varchar(255) DEFAULT NULL,
  `newProductTotalMoney` varchar(255) DEFAULT NULL,
  `newShorthandMoney` varchar(255) DEFAULT NULL,
  `newDevTotalMoney` varchar(255) DEFAULT NULL,
  `newTravelTotalMoney` varchar(255) DEFAULT NULL,
  `newOtherMoney` varchar(255) DEFAULT NULL,
  `newProfitMargin` varchar(255) DEFAULT NULL,
  `newTotal` varchar(255) DEFAULT NULL,
  `takeEffect` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案';

-- ----------------------------
--  Table structure for `t_interpret_project_plan_summarize`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_plan_summarize`;
CREATE TABLE `t_interpret_project_plan_summarize` (
  `id` varchar(36) NOT NULL,
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `back_reason` varchar(500) DEFAULT NULL COMMENT '打回原因',
  `approval_state` char(1) DEFAULT NULL COMMENT '审批状态(0:驳回1:通过2:已提交)',
  `pm_summ` varchar(500) DEFAULT NULL COMMENT 'pm总结',
  `zg_approval` varchar(500) DEFAULT NULL COMMENT '主管评价',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案结项表';

-- ----------------------------
--  Table structure for `t_interpret_project_produce_interpreter`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_produce_interpreter`;
CREATE TABLE `t_interpret_project_produce_interpreter` (
  `id` varchar(36) NOT NULL,
  `interpreter_type` varchar(20) DEFAULT NULL COMMENT '译员类型',
  `produce_id` varchar(36) DEFAULT NULL COMMENT '产品id',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `interpreter_name` varchar(100) DEFAULT NULL COMMENT '译员姓名',
  `interpreter_id` varchar(500) DEFAULT NULL COMMENT '译员id',
  `quote_price` char(30) DEFAULT NULL COMMENT '报价',
  `count_type` varchar(10) DEFAULT NULL COMMENT '统计类型',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `count_num` char(30) DEFAULT NULL COMMENT '数量',
  `old_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '合计',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案产品译员表';

-- ----------------------------
--  Table structure for `t_interpret_project_travel`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_travel`;
CREATE TABLE `t_interpret_project_travel` (
  `id` varchar(36) NOT NULL,
  `plan_id` varchar(36) DEFAULT NULL COMMENT '方案id',
  `blance_type` char(1) DEFAULT NULL COMMENT '结算形式',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `cost_subtotal` decimal(10,2) DEFAULT NULL COMMENT '小计',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `plan_id` (`plan_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案差旅表';

-- ----------------------------
--  Table structure for `t_interpret_project_travel_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_interpret_project_travel_info`;
CREATE TABLE `t_interpret_project_travel_info` (
  `id` varchar(36) NOT NULL,
  `travel_id` varchar(36) DEFAULT NULL COMMENT '差旅id',
  `travel_name` varchar(50) DEFAULT NULL COMMENT '差旅名称',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `person_num` char(30) DEFAULT NULL COMMENT '人数',
  `count_num` char(30) DEFAULT NULL COMMENT '天数',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总计',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译项目方案差旅信息表';

-- ----------------------------
--  Table structure for `t_invoices_address_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_invoices_address_info`;
CREATE TABLE `t_invoices_address_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `user_id` varchar(36) NOT NULL COMMENT '用户Id',
  `recipients` varchar(50) NOT NULL COMMENT '收件人',
  `telphone` varchar(11) NOT NULL COMMENT '联系电话',
  `area` varchar(100) NOT NULL COMMENT '所在地区',
  `address` varchar(100) NOT NULL COMMENT '详细地址',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creater` varchar(50) NOT NULL COMMENT '创建人',
  `updater_time` datetime NOT NULL COMMENT '修改时间',
  `updater` varchar(50) NOT NULL COMMENT '修改人',
  `del_state` varchar(2) NOT NULL COMMENT '是否删除(0:已删除 1:未删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='地址信息表';

-- ----------------------------
--  Table structure for `t_invoices_base_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_invoices_base_info`;
CREATE TABLE `t_invoices_base_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `user_id` varchar(36) NOT NULL COMMENT '用户id',
  `invoices_title_type` varchar(2) NOT NULL COMMENT '抬头类型（1:企业单位，2:个人/非企业单位)',
  `invoices_type` varchar(2) NOT NULL COMMENT '发票类型(1:增值税普通发票 2:增值税专有发票)',
  `invoices_title` varchar(50) NOT NULL COMMENT '发票抬头',
  `tax_number` varchar(50) NOT NULL COMMENT '税号',
  `invoices_content` varchar(50) NOT NULL COMMENT '发票内容',
  `company_address` varchar(50) NOT NULL COMMENT '单位地址',
  `company_tel` varchar(50) NOT NULL COMMENT '单位电话',
  `open_bank` varchar(50) NOT NULL COMMENT '开户银行',
  `bank_account` varchar(50) NOT NULL COMMENT '银行账户',
  `del_state` varchar(2) NOT NULL COMMENT '是否删除(0:已删除 1:未删除)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creater` varchar(50) NOT NULL COMMENT '创建人',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `updater` varchar(50) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='发票信息表';

-- ----------------------------
--  Table structure for `t_invoices_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_invoices_info`;
CREATE TABLE `t_invoices_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `invoices_num` varchar(20) DEFAULT NULL COMMENT '发票编号',
  `user_id` varchar(36) NOT NULL COMMENT '用户表id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `invoices_title_type` varchar(2) NOT NULL COMMENT '抬头类型（1:企业单位，2:个人/非企业单位)',
  `invoices_title` varchar(50) NOT NULL COMMENT '发票抬头',
  `invoices_type` varchar(2) NOT NULL COMMENT '发票类型(1:增值税普通发票 2:增值税专有发票)',
  `tax_number` varchar(50) DEFAULT NULL COMMENT '税号',
  `invoices_content` varchar(100) NOT NULL COMMENT '发票内容',
  `invoices_amount` decimal(16,2) NOT NULL COMMENT '发票金额',
  `recipients` varchar(50) NOT NULL COMMENT '收件人',
  `telphone` varchar(20) NOT NULL COMMENT '联系电话',
  `area` varchar(100) NOT NULL COMMENT '所在地区',
  `address` varchar(100) NOT NULL COMMENT '详细地址',
  `remark` varchar(50) NOT NULL COMMENT '备注说明',
  `company_addr` varchar(100) DEFAULT NULL COMMENT '公司地址',
  `company_tel` varchar(50) DEFAULT NULL COMMENT '公司电话',
  `open_bank` varchar(50) DEFAULT NULL COMMENT '开户行',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '账号',
  `status` varchar(2) DEFAULT NULL COMMENT '状态(1.未开票;2.已开票;3.打回;4.寄发票,5.作废)',
  `del_state` varchar(2) DEFAULT NULL COMMENT '0,无效,1有效(打回视为无效)',
  `source` varchar(2) DEFAULT NULL COMMENT '来源(1,线上,2线下)',
  `order_type` varchar(2) DEFAULT NULL COMMENT '订单类型(1.订单发票,2.预付款发票)',
  `leading_official` varchar(50) DEFAULT NULL COMMENT '负责人',
  `ticket_holder` varchar(50) DEFAULT NULL COMMENT '开票人',
  `ticket_time` datetime DEFAULT NULL COMMENT '开票时间',
  `invoices_no` varchar(200) DEFAULT NULL COMMENT '发票号码',
  `courier_number` varchar(50) DEFAULT NULL COMMENT '快递单号',
  `courier_company` varchar(50) DEFAULT NULL COMMENT '快递公司',
  `link_person` varchar(50) DEFAULT NULL COMMENT '联系人',
  `ticket_remark` varchar(255) DEFAULT NULL COMMENT '开票备注',
  `contract_no` varchar(50) DEFAULT NULL COMMENT '合同编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creater` varchar(50) NOT NULL COMMENT '创建人',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `updater` varchar(50) NOT NULL COMMENT '修改人',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '负责人所在销售部门Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='发票表';

-- ----------------------------
--  Table structure for `t_invoices_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_invoices_order`;
CREATE TABLE `t_invoices_order` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `invoices_id` varchar(36) NOT NULL COMMENT '发票id',
  `order_id` varchar(36) NOT NULL COMMENT '订单id',
  `del_state` varchar(36) DEFAULT NULL COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='发票订单中间表';

-- ----------------------------
--  Table structure for `t_invoices_record`
-- ----------------------------
DROP TABLE IF EXISTS `t_invoices_record`;
CREATE TABLE `t_invoices_record` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `invoices_id` varchar(36) DEFAULT NULL COMMENT '发票id',
  `creater` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='开票操纵记录表';

-- ----------------------------
--  Table structure for `t_kfmethod`
-- ----------------------------
DROP TABLE IF EXISTS `t_kfmethod`;
CREATE TABLE `t_kfmethod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(255) DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL,
  `userId` varchar(64) DEFAULT NULL,
  `orderNo` varchar(255) DEFAULT NULL,
  `payTime` varchar(255) DEFAULT NULL,
  `settlementMethod` varchar(255) DEFAULT NULL COMMENT '结算方式：1正常结算 2不结算 3线下已付',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14067 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_newkfmethod`
-- ----------------------------
DROP TABLE IF EXISTS `t_newkfmethod`;
CREATE TABLE `t_newkfmethod` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `dates` varchar(8000) CHARACTER SET utf8 DEFAULT NULL COMMENT '数据list',
  `orderNo` varchar(255) DEFAULT NULL,
  `isSend` varchar(2) DEFAULT NULL COMMENT '2已发送1未发送',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_base`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_base`;
CREATE TABLE `t_order_base` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) NOT NULL COMMENT '订单编号',
  `nickname` varchar(60) DEFAULT NULL COMMENT '下单账号(昵称)',
  `link_tel` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '联系邮箱',
  `source` char(1) DEFAULT NULL COMMENT '数据来源：1.译鱼  2.代客下单 3.crm 4.手机下单 5.百度 6.360 7.腾讯 8.公众号',
  `order_type` char(1) DEFAULT NULL COMMENT '订单类型：1、快翻；2、文档翻译；3、口译；4、补差价',
  `doc_name` varchar(600) DEFAULT NULL COMMENT '稿件名称（摘要）',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `real_price` decimal(10,2) DEFAULT NULL COMMENT '实际价格',
  `discount_money` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
  `modify_money` decimal(10,2) DEFAULT NULL COMMENT '客服编辑优惠的价格',
  `pay_type` char(1) DEFAULT NULL COMMENT '支付方式：1、支付宝；2、微信；3、银联；4、余额；5、线下支付',
  `found_time` datetime DEFAULT NULL COMMENT '下单时间',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `finish_time_new` datetime DEFAULT NULL COMMENT '新交稿时间',
  `finish_time_old` datetime DEFAULT NULL COMMENT '原交稿时间',
  `order_state` char(3) DEFAULT NULL COMMENT '订单状态：参考t_sys_dictionary中type in(c_order_state)104待评价 107退款中 106售后中 101待估价 102待付款 108已关闭 103翻译中 105已完成',
  `node_code` varchar(20) DEFAULT NULL COMMENT '当前环节',
  `node_state` char(1) DEFAULT '1' COMMENT '流程环节状态0.待审核,1.已审核',
  `try_trans` char(1) DEFAULT '0' COMMENT '是否试译：1-试译订单 0-非试译',
  `sms_alert` char(1) DEFAULT '0' COMMENT '短信提醒：0、不提醒；1、短信提醒',
  `score_result` char(1) DEFAULT NULL COMMENT '翻译结果：1~5星',
  `score_service` char(1) DEFAULT NULL COMMENT '服务态度：1~5星',
  `score_speed` char(1) DEFAULT '' COMMENT '交稿速度：1~5星',
  `score_describe` text COMMENT '评价描述',
  `del_state` char(3) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `submit_result_time` datetime DEFAULT NULL COMMENT '提交翻译结果时间',
  `evaluate_time` datetime DEFAULT NULL COMMENT '客户评价时间',
  `total_profit_margin` varchar(20) DEFAULT NULL COMMENT '订单总利润率',
  `total_cost` decimal(10,2) DEFAULT NULL COMMENT '总成本',
  `note` text COMMENT '客户备注',
  `customer_user_id` varchar(36) DEFAULT NULL COMMENT '客户用户Id',
  `customer_name` varchar(48) DEFAULT NULL COMMENT '客户名称',
  `responsible_user_id` varchar(36) DEFAULT NULL COMMENT '负责人用户Id',
  `responsible_name` varchar(48) DEFAULT NULL COMMENT '负责人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user` (`create_user`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单基本信息表';

-- ----------------------------
--  Table structure for `t_order_base_ext`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_base_ext`;
CREATE TABLE `t_order_base_ext` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `final_cost` decimal(8,2) DEFAULT NULL COMMENT '最终成本',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单信息扩展（展示给后台人员）表';

-- ----------------------------
--  Table structure for `t_order_batch`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_batch`;
CREATE TABLE `t_order_batch` (
  `id` varchar(255) NOT NULL COMMENT '批次编号',
  `generate_time` datetime DEFAULT NULL COMMENT '批次生成时间',
  `task_number` varchar(255) DEFAULT NULL COMMENT '任务数',
  `before_money_total` varchar(255) DEFAULT NULL COMMENT '原提交金额总计',
  `actual_money_total` varchar(255) DEFAULT NULL COMMENT '实际税前金额总计',
  `modify_money` varchar(255) DEFAULT NULL COMMENT '修改差额',
  `modify_task` varchar(255) DEFAULT NULL COMMENT '修改任务数',
  `state` varchar(255) DEFAULT NULL COMMENT '数据人员支付批次状态（默认为 1确认中 2线下审核 3申请财务支付 4已支付 5已关闭）已废弃',
  `togid` varchar(255) DEFAULT NULL,
  `taxAmount` varchar(255) DEFAULT NULL COMMENT '税额',
  `payableAfterTax` varchar(255) DEFAULT NULL COMMENT '税后应付',
  `paidInAfterTax` varchar(255) DEFAULT NULL COMMENT '税后实付',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_id` varchar(255) DEFAULT NULL COMMENT '任务id',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `group_id` varchar(255) DEFAULT NULL COMMENT '任务组编号（任务组id）',
  `identification` varchar(255) DEFAULT NULL COMMENT '修改标识（调整任务数及金额等的标识）默认0 不能修改为 1',
  `task_state` varchar(255) DEFAULT NULL COMMENT '任务状态（任何状态）',
  `takeEffect_state` varchar(255) DEFAULT NULL COMMENT '译费确认状态 （默认0待确认 1已确认 2审核中3已关闭）',
  `pay_state` varchar(255) DEFAULT NULL COMMENT '译费支付状态（默认0未发起结算 1结算中 2待支付 3已支付）',
  `pm_id` varchar(255) DEFAULT NULL COMMENT 'PMid',
  `operate` varchar(11) DEFAULT NULL COMMENT '操作标识 0为添加 1为移除',
  `link` varchar(20) DEFAULT NULL COMMENT '环节id1.2.3.4.5.6代表6个环节',
  `beginTime` datetime DEFAULT NULL COMMENT '开始时间',
  `endTime` datetime DEFAULT NULL COMMENT '结束时间（三天时间）',
  `confirmIden` varchar(255) DEFAULT NULL COMMENT '确认标识（0自动确认，1手动确认）',
  `reconfirm` varchar(255) DEFAULT NULL COMMENT '再次确认状态（同环节状态）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12384 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_document`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_document`;
CREATE TABLE `t_order_document` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `p_id` varchar(36) DEFAULT NULL COMMENT '父级id',
  `p_order_no` varchar(36) DEFAULT NULL COMMENT '总订单编号',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号:如果是单个订单，则使用父订单号，如果是多个订单则创建子订单号',
  `order_language` varchar(50) DEFAULT NULL COMMENT '订单语言',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `proj_name` varchar(600) DEFAULT NULL COMMENT '项目名称',
  `unit_num` char(32) DEFAULT NULL COMMENT '数量：字、词、页、条',
  `unit_price` double(12,5) DEFAULT NULL COMMENT '单价',
  `unit` char(1) DEFAULT NULL COMMENT '单位：1、字；2、词；3、页；4、条；',
  `translate_level` char(1) DEFAULT NULL COMMENT '翻译等级',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT '预估总价',
  `real_price` decimal(10,2) DEFAULT NULL COMMENT '实际成本',
  `note` varchar(600) DEFAULT NULL COMMENT '备注（项目主管）',
  `note1` varchar(600) DEFAULT NULL COMMENT '备注（PM）',
  `note2` varchar(255) DEFAULT NULL COMMENT '备注（项目负责人）',
  `proj_abstract` varchar(600) DEFAULT NULL COMMENT '项目摘要',
  `node_code` char(20) DEFAULT NULL COMMENT '当前环节',
  `node_state` char(1) DEFAULT '1' COMMENT '流程状态默认0.待审核,1.已审核',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `treatment_group` varchar(36) DEFAULT NULL COMMENT '处理组别(多语言发布项目大厅用)',
  `profit_margin` varchar(20) DEFAULT NULL COMMENT '利润率',
  `actual_done_time` datetime DEFAULT NULL COMMENT '译员第一次提交时间',
  `amountReceivabless` decimal(20,2) DEFAULT NULL COMMENT '应收金额',
  `ripe_corpus` varchar(256) DEFAULT NULL COMMENT '熟语料库附件Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_pid` (`p_id`) USING BTREE,
  KEY `idx_p_order_no` (`p_order_no`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档翻译信息表';

-- ----------------------------
--  Table structure for `t_order_document_ext`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_document_ext`;
CREATE TABLE `t_order_document_ext` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `professional_field` char(5) DEFAULT NULL COMMENT '专业领域',
  `purpose` char(5) DEFAULT NULL COMMENT '翻译用途',
  `pic_tag` char(1) DEFAULT NULL COMMENT '是否翻译图片：0、否；1、是',
  `note` varchar(600) DEFAULT NULL COMMENT '备注',
  `treatment_group` varchar(36) DEFAULT NULL COMMENT '处理组',
  `unit_num` char(30) DEFAULT NULL COMMENT '总字数',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `seller_id` varchar(36) DEFAULT NULL COMMENT '销售人id',
  `seller_name` varchar(20) DEFAULT NULL COMMENT '销售人姓名',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档翻译信息扩展表';

-- ----------------------------
--  Table structure for `t_order_document_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_document_feedback`;
CREATE TABLE `t_order_document_feedback` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `record_id` varchar(36) DEFAULT NULL COMMENT '关联的任务信息主键',
  `type` char(3) DEFAULT NULL COMMENT '类型(1.译员反馈)5客户主管',
  `business_type` char(10) DEFAULT NULL COMMENT '业务类型(0.客服继续翻译,1.译文反馈(客服无法翻译),3.pm无法翻译反馈,4.申请延迟,5补差价)',
  `feedback_option` varchar(200) DEFAULT NULL COMMENT '反馈意见',
  `handle_option` varchar(36) DEFAULT NULL COMMENT '处理意见',
  `handle_result` char(1) DEFAULT NULL COMMENT '处理结果（0、未处理；1、同意；2、不同意）',
  `handle_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '处理时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `creater` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `content` text COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档反馈表';

-- ----------------------------
--  Table structure for `t_order_document_format`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_document_format`;
CREATE TABLE `t_order_document_format` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `record_id` varchar(36) DEFAULT NULL COMMENT '所属记录id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `atta_name` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `set_type` char(3) DEFAULT NULL COMMENT '排版要求',
  `format` char(3) DEFAULT NULL COMMENT '交付格式',
  `num` char(30) DEFAULT NULL COMMENT '计数',
  `unit` char(1) DEFAULT NULL COMMENT '单位',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档翻译交付格式表';

-- ----------------------------
--  Table structure for `t_order_document_link`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_document_link`;
CREATE TABLE `t_order_document_link` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `cir_tag` char(1) DEFAULT '0' COMMENT '流转标识：是否自动流转：0、否；1、是',
  `curr_link_id` varchar(36) DEFAULT NULL COMMENT '当前执行环节id',
  `sum_count` int(3) DEFAULT NULL COMMENT '环节总数',
  `assessment` varchar(500) DEFAULT NULL COMMENT '风险评估',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT '成本小计',
  `profit_margin` varchar(200) DEFAULT NULL COMMENT '利润率',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后时间',
  `current_flag` char(1) DEFAULT '1' COMMENT '是否为最新的方案',
  `create_pm_name` varchar(30) DEFAULT NULL COMMENT '创建pm的Name(冗余)',
  `task_id` varchar(36) DEFAULT NULL COMMENT '任务id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_curr_link_id` (`curr_link_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_document_sign`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_document_sign`;
CREATE TABLE `t_order_document_sign` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `record_id` varchar(36) DEFAULT NULL COMMENT '外键',
  `type` varchar(36) DEFAULT NULL COMMENT '1.无法翻译',
  `is_used` char(1) DEFAULT NULL COMMENT '是否被使用：0、否；1、是',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后时间',
  `content` text COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档标记信息';

-- ----------------------------
--  Table structure for `t_order_doucment_return`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_doucment_return`;
CREATE TABLE `t_order_doucment_return` (
  `id` varchar(36) NOT NULL,
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `record_id` varchar(36) DEFAULT NULL COMMENT '关联的任务信息主键',
  `cus_option` varchar(200) DEFAULT NULL COMMENT '客户意见',
  `sale_option` varchar(200) DEFAULT NULL COMMENT '销售意见',
  `update_flag` char(1) DEFAULT NULL COMMENT '是否修改(0.不修改,1修改)',
  `update_option` varchar(200) DEFAULT NULL COMMENT '修改意见',
  `finish_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '完成时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '取消返稿备注',
  `type` char(1) DEFAULT NULL COMMENT '返稿类型：1、中间稿反馈；2、终稿返稿',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='返稿';

-- ----------------------------
--  Table structure for `t_order_doucment_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_doucment_task`;
CREATE TABLE `t_order_doucment_task` (
  `id` varchar(36) NOT NULL,
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `base_id` varchar(36) DEFAULT NULL COMMENT '主订单id(冗余)',
  `record_id` varchar(36) DEFAULT NULL COMMENT '关联的任务信息主键',
  `task_type` varchar(1) DEFAULT NULL COMMENT '任务类型：1、快速翻译；2、文档翻译；3、口译；4、试译；5。文档环节,6,售后客服',
  `task_state` char(1) DEFAULT '0' COMMENT '任务状态：0、待办；1、已办；2、已退回；3、进行中（翻译中）',
  `record_state` char(20) DEFAULT NULL COMMENT '关联订单或者环节的节点状态',
  `user_id` varchar(36) DEFAULT NULL COMMENT '任务处理用户的id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '任务处理用户的account_code',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `freeze_state` varchar(20) DEFAULT NULL COMMENT '冻结状态(ptkf待考虑为300)',
  `suspend_state` char(1) DEFAULT '1' COMMENT '暂停状态:0.暂停,1.未暂停',
  `actual_done_time` timestamp NULL DEFAULT NULL COMMENT '译员第一次完成时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_base_id` (`base_id`) USING BTREE,
  KEY `idx_record_id` (`record_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档翻译任务表';

-- ----------------------------
--  Table structure for `t_order_fast`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fast`;
CREATE TABLE `t_order_fast` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `order_language` varchar(50) DEFAULT NULL COMMENT '订单语言',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `word_num` int(11) DEFAULT NULL COMMENT '订单字数',
  `unit_price` decimal(8,2) DEFAULT NULL COMMENT '单价',
  `order_text` text COMMENT '订单原文',
  `note` varchar(600) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `maximum_time` decimal(8,2) DEFAULT NULL COMMENT '给客户显示翻译时间',
  `shortest_time` decimal(8,2) DEFAULT NULL COMMENT '给客户显示翻译时间',
  `interpreter_time` decimal(8,2) DEFAULT NULL COMMENT '给译员显示的翻译时间',
  `actual_done_time` datetime DEFAULT NULL COMMENT '任务第一次交稿时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='快速翻译信息表';

-- ----------------------------
--  Table structure for `t_order_fast_result`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fast_result`;
CREATE TABLE `t_order_fast_result` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `translator` varchar(50) DEFAULT NULL COMMENT '翻译人员',
  `translate_text` text COMMENT '翻译文本',
  `translate_time` datetime DEFAULT NULL COMMENT '翻译时间',
  `translate_type` char(1) DEFAULT '1' COMMENT '翻译类型：1、初稿；2、返稿；3、终稿',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='快速翻译成果表';

-- ----------------------------
--  Table structure for `t_order_fast_reversion`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fast_reversion`;
CREATE TABLE `t_order_fast_reversion` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `cus_opinion` text COMMENT '客户意见',
  `ser_opinion` text COMMENT '客服意见',
  `pm_opinion` text COMMENT '项目经理意见',
  `pm_tel` varchar(11) DEFAULT NULL COMMENT '项目经理电话',
  `assess_tag` char(1) DEFAULT '0' COMMENT '评估标志：0、未指定译员评估；1、已指定译员评估；',
  `reversion_state` char(1) DEFAULT NULL COMMENT '返稿标志：1、同意返稿；2、取消返稿',
  `finish_time` datetime DEFAULT NULL COMMENT '新交稿时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='快翻订单返稿申请表';

-- ----------------------------
--  Table structure for `t_order_fast_reversion_assess`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fast_reversion_assess`;
CREATE TABLE `t_order_fast_reversion_assess` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `reversion_id` varchar(36) DEFAULT NULL COMMENT '返稿id',
  `inter_opinion` text COMMENT '译员意见',
  `reversion_state` char(1) DEFAULT NULL COMMENT '返稿标志：1、同意返稿；2、取消返稿',
  `inter_name` varchar(36) DEFAULT NULL COMMENT '译员姓名',
  `inter_tel` varchar(36) DEFAULT NULL COMMENT '译员手机号',
  `user_id` varchar(36) DEFAULT NULL COMMENT '译员的userId',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_reversion_id` (`reversion_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='快翻订单返稿申请译员评估表';

-- ----------------------------
--  Table structure for `t_order_fee_add`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fee_add`;
CREATE TABLE `t_order_fee_add` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `fee_type` char(2) DEFAULT NULL COMMENT '费用类型：1、无；2、加急；3、其它',
  `fee` decimal(20,2) DEFAULT NULL COMMENT '费用金额',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单附加费用表';

-- ----------------------------
--  Table structure for `t_order_fee_reduce`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fee_reduce`;
CREATE TABLE `t_order_fee_reduce` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `record_id` varchar(36) DEFAULT NULL COMMENT '记录id',
  `fee_type` char(2) DEFAULT NULL COMMENT '费用类型：1、优惠码；2、优惠券',
  `fee` decimal(6,2) DEFAULT NULL COMMENT '费用金额',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单优惠费用表';

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单悬赏表';

-- ----------------------------
--  Table structure for `t_order_file_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_file_info`;
CREATE TABLE `t_order_file_info` (
  `file_id` varchar(36) NOT NULL COMMENT '文件Id，即 t_common_atta 的id',
  `order_id` varchar(36) NOT NULL COMMENT '订单Id',
  `file_name` varchar(256) NOT NULL COMMENT '文件名',
  `file_path` varchar(256) NOT NULL COMMENT '文件存储路径',
  `file_size` varchar(16) DEFAULT NULL COMMENT '文件大小',
  `sentence_count` int(8) DEFAULT NULL COMMENT '文件句数：默认为 0',
  `file_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '文件状态（默认为 1-未解析）： 1-未解析 2-不可读取 3-已解析',
  `del_state` tinyint(1) DEFAULT '1' COMMENT '删除状态：0-已删除，1-未删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`file_id`) USING BTREE,
  KEY `index_file_id` (`file_id`) USING BTREE,
  KEY `index_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单文件关联表';

-- ----------------------------
--  Table structure for `t_order_fill_price`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_fill_price`;
CREATE TABLE `t_order_fill_price` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `record_id` varchar(36) NOT NULL COMMENT '记录id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `fill_type` char(2) NOT NULL COMMENT '记录类型：1、前台下单；2、代客下单',
  `fee` decimal(10,2) DEFAULT NULL COMMENT '补差金额',
  `note` varchar(2000) DEFAULT NULL COMMENT '备注',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_no` (`order_no`) USING BTREE,
  KEY `idx_record_id` (`record_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='补差价表';

-- ----------------------------
--  Table structure for `t_order_group`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_group`;
CREATE TABLE `t_order_group` (
  `id` varchar(255) NOT NULL COMMENT '主键 id',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `task_number` varchar(255) DEFAULT NULL COMMENT '任务数',
  `before_money_total` varchar(255) DEFAULT NULL COMMENT '原提交金额总计',
  `actual_money_total` varchar(255) DEFAULT NULL COMMENT '实际税前金额总计',
  `modify_money` varchar(255) DEFAULT NULL COMMENT '修改差额',
  `modify_task` varchar(255) DEFAULT NULL COMMENT '修改任务数',
  `state` varchar(255) DEFAULT NULL COMMENT 'pm支付组状态（默认 1pm申请支付 2pm确认中 3pm已确认 4申请财务支付 5已支付 6已关闭） 已 废弃',
  `batech_id` varchar(255) DEFAULT NULL COMMENT '批次编号',
  `pm_id` varchar(255) DEFAULT NULL COMMENT 'pmid',
  `orgId` varchar(255) DEFAULT NULL COMMENT '机构id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_inter_assess`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_inter_assess`;
CREATE TABLE `t_order_inter_assess` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `inter_opinion` text COMMENT '译员意见',
  `inter_name` varchar(36) DEFAULT NULL COMMENT '译员姓名',
  `inter_tel` varchar(36) DEFAULT NULL COMMENT '译员手机号',
  `user_id` varchar(36) DEFAULT NULL COMMENT '译员的accountId',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单译员评估表';

-- ----------------------------
--  Table structure for `t_order_inter_report`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_inter_report`;
CREATE TABLE `t_order_inter_report` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `report_type` char(1) DEFAULT NULL COMMENT '反馈类型：1、申请延时；2、无法翻译',
  `time_node` datetime DEFAULT NULL COMMENT '时间节点（延时时间节点）',
  `note` text COMMENT '反馈信息',
  `report_state` char(1) DEFAULT NULL COMMENT '反馈标志：1、同意；2、拒绝',
  `refuse_reason` text COMMENT '拒绝原因',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单译员反馈表表';

-- ----------------------------
--  Table structure for `t_order_interpret`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_interpret`;
CREATE TABLE `t_order_interpret` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_id` varchar(36) DEFAULT NULL COMMENT '订单id',
  `customer_name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `state` varchar(5) DEFAULT NULL COMMENT '状态(1:待指派 2:已指派 3:已发布;4:已领取)',
  `node_code` varchar(5) DEFAULT NULL COMMENT '当前环节(501:指派；502:发项目大厅；503:领取)',
  `activity_name` varchar(100) DEFAULT NULL COMMENT '活动名称',
  `activity_address` varchar(100) DEFAULT NULL COMMENT '活动地址',
  `activity_time_quantum` varchar(100) DEFAULT NULL COMMENT '活动时间',
  `contract_note` varchar(500) DEFAULT NULL COMMENT '合同备注',
  `sales_note` varchar(200) DEFAULT NULL COMMENT '销售备注',
  `work_group_id` varchar(36) DEFAULT NULL COMMENT '承接组',
  `treatment_group` varchar(36) DEFAULT NULL COMMENT '处理组别（发项目大厅）',
  `conference_linkman` varchar(50) DEFAULT NULL COMMENT '会议联络人',
  `contact_way` varchar(50) DEFAULT NULL COMMENT '联系方式',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `document_name` varchar(50) DEFAULT NULL COMMENT '参考文件',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译订单信息表';

-- ----------------------------
--  Table structure for `t_order_interpret_activity_cc`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_interpret_activity_cc`;
CREATE TABLE `t_order_interpret_activity_cc` (
  `id` varchar(36) NOT NULL,
  `activity_date_id` varchar(36) DEFAULT NULL COMMENT '活动日期id',
  `activity_cc` varchar(50) DEFAULT NULL COMMENT '活动场次',
  `activity_scale` varchar(50) DEFAULT NULL COMMENT '规模',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动场次表';

-- ----------------------------
--  Table structure for `t_order_interpret_activity_cc_extends`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_interpret_activity_cc_extends`;
CREATE TABLE `t_order_interpret_activity_cc_extends` (
  `id` varchar(36) NOT NULL,
  `activity_cc_id` varchar(36) DEFAULT NULL COMMENT '活动场次id',
  `extend_type` char(1) DEFAULT NULL COMMENT ' 扩展类型1：产品 3：设备',
  `produce_type` char(1) DEFAULT NULL COMMENT '产品类型1:交传2:同传3:陪同',
  `extned_content` varchar(50) DEFAULT NULL COMMENT ' 扩展内容',
  `unit_price` char(30) DEFAULT NULL COMMENT ' 单价',
  `people_number` char(30) DEFAULT NULL COMMENT ' 人数',
  `day_number` char(30) DEFAULT NULL COMMENT ' 天数',
  `source_language` varchar(5) DEFAULT NULL COMMENT '源语言',
  `target_language` varchar(5) DEFAULT NULL COMMENT '目标语言',
  `statistical_pattern` varchar(50) DEFAULT NULL COMMENT ' 统计方式',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动场次扩展表';

-- ----------------------------
--  Table structure for `t_order_interpret_activity_date`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_interpret_activity_date`;
CREATE TABLE `t_order_interpret_activity_date` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '主键',
  `order_id` varchar(36) DEFAULT NULL COMMENT '订单id',
  `activity_time` datetime DEFAULT NULL COMMENT '活动时间',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除'',',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动日期表';

-- ----------------------------
--  Table structure for `t_order_interpret_translate_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_interpret_translate_info`;
CREATE TABLE `t_order_interpret_translate_info` (
  `id` varchar(36) NOT NULL,
  `product_group_id` varchar(36) DEFAULT NULL COMMENT '产品id',
  `source_language` varchar(20) DEFAULT NULL COMMENT '源语言',
  `target_language` varchar(20) DEFAULT NULL COMMENT '目标语言',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品语项表';

-- ----------------------------
--  Table structure for `t_order_interpret_travel`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_interpret_travel`;
CREATE TABLE `t_order_interpret_travel` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_id` varchar(36) DEFAULT NULL COMMENT '订单id',
  `travel_name` varchar(50) DEFAULT NULL COMMENT '差旅名称',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `person_num` char(30) DEFAULT NULL COMMENT '人数',
  `days_num` char(30) DEFAULT NULL COMMENT '天数',
  `del_state` char(1) DEFAULT '1' COMMENT '0:已删除 1:未删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动差旅表';

-- ----------------------------
--  Table structure for `t_order_link_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_link_info`;
CREATE TABLE `t_order_link_info` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `document_link_id` varchar(36) DEFAULT NULL COMMENT '文档环节表id',
  `order_no` varchar(36) DEFAULT NULL COMMENT 'doucment的orderNo(冗余)',
  `link_type` varchar(2) DEFAULT NULL COMMENT '环节类型(1、翻译；2、审校；3、评估；4、质检；5、排版)',
  `sort` int(3) DEFAULT NULL COMMENT '环节所处的位置',
  `put_num` int(2) DEFAULT NULL COMMENT '任务发放人数',
  `link_state` varchar(10) DEFAULT NULL COMMENT '环节状态(备用)',
  `is_used` char(1) DEFAULT NULL COMMENT '是否被启用(0.未启用,1启用)',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_link_id` (`document_link_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_link_plan`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_link_plan`;
CREATE TABLE `t_order_link_plan` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `document_link_id` varchar(36) DEFAULT NULL COMMENT '文档环节表id',
  `content` longtext COMMENT '内容',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `name` varchar(10) DEFAULT NULL COMMENT '方案名',
  `sort` int(11) DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档翻译方案';

-- ----------------------------
--  Table structure for `t_order_link_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_link_task`;
CREATE TABLE `t_order_link_task` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `link_id` varchar(36) DEFAULT NULL COMMENT '环节信息表id',
  `user_id` varchar(36) DEFAULT NULL COMMENT '任务人员id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '任务人员姓名(冗余)',
  `user_tel` varchar(11) DEFAULT NULL COMMENT '用户手机号码',
  `word_num` char(30) DEFAULT NULL COMMENT '字数或者条数..',
  `unit` char(1) DEFAULT NULL COMMENT '单位：1、字；2、词；3、页；4、条；',
  `offer_price` varchar(20) DEFAULT NULL COMMENT '报价',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `cost_price` decimal(8,2) DEFAULT NULL COMMENT '任务总金额',
  `note` varchar(2000) DEFAULT NULL COMMENT '备注',
  `task_state` varchar(20) DEFAULT NULL COMMENT '任务状态',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_link_id` (`link_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_link_task_format`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_link_task_format`;
CREATE TABLE `t_order_link_task_format` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `link_task_id` varchar(36) DEFAULT NULL COMMENT '环节任务id',
  `level` char(1) DEFAULT NULL COMMENT '1.初稿；2.中间稿；3终稿',
  `format` char(3) DEFAULT NULL COMMENT '排版要求',
  `num` char(30) DEFAULT NULL COMMENT '计数',
  `unit` char(1) DEFAULT NULL COMMENT '单位',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `delay_time` datetime DEFAULT NULL COMMENT '延迟时间',
  `del_state` char(1) DEFAULT NULL COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`link_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_modify_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_modify_detail`;
CREATE TABLE `t_order_modify_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_number` varchar(255) DEFAULT NULL COMMENT '订单号',
  `manuscript_name` varchar(255) DEFAULT NULL COMMENT '稿件名称',
  `project_manager` varchar(255) DEFAULT NULL COMMENT '项目经理（操作人）',
  `interpreter_name` varchar(255) DEFAULT NULL COMMENT '译员姓名',
  `estimate_money` varchar(255) DEFAULT NULL COMMENT '预计支付金额',
  `actual_money` varchar(255) DEFAULT NULL COMMENT '实际支付金额',
  `money_gap` varchar(255) DEFAULT NULL COMMENT '差额',
  `remarks` varchar(255) DEFAULT NULL COMMENT '说明备注',
  `project_id` varchar(255) DEFAULT NULL COMMENT 'pmid',
  `task_id` varchar(255) DEFAULT NULL COMMENT '任务id',
  `order_id` varchar(255) DEFAULT NULL COMMENT '订单id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `group_id` varchar(255) DEFAULT NULL COMMENT '组id',
  `batch_id` varchar(255) DEFAULT NULL COMMENT '批次id',
  `opm` varchar(255) DEFAULT NULL COMMENT '项目部',
  `delState` varchar(255) DEFAULT NULL COMMENT '删除标志',
  `oldNum` varchar(255) DEFAULT NULL COMMENT '旧字数',
  `newNum` varchar(255) DEFAULT NULL COMMENT '新字数',
  `oldMethod` varchar(255) DEFAULT NULL COMMENT '旧统计方式',
  `newMethod` varchar(255) DEFAULT NULL COMMENT '新统计方式',
  `oldChargingTime` varchar(255) DEFAULT NULL COMMENT '旧计费时间',
  `newChargingTime` varchar(255) DEFAULT NULL COMMENT '新计费时间',
  `oldRemarks` varchar(255) DEFAULT NULL COMMENT '旧备注',
  `newRemarks` varchar(255) DEFAULT NULL COMMENT '新备注',
  `oldPrice` varchar(255) DEFAULT NULL COMMENT '旧单价',
  `newPrice` varchar(255) DEFAULT NULL COMMENT '新单价',
  `oldSettlementMethod` varchar(255) DEFAULT NULL COMMENT '旧结算方式',
  `newSettlementMethod` varchar(255) DEFAULT NULL COMMENT '新结算方式',
  `typeOperation` varchar(255) DEFAULT NULL COMMENT '操作种类（1增加 2删除 3修改）',
  `dhState` varchar(255) DEFAULT NULL COMMENT '4打回',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4354 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_new_time`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_new_time`;
CREATE TABLE `t_order_new_time` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `finish_time` datetime DEFAULT NULL COMMENT '新交稿时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单交稿时间记录表';

-- ----------------------------
--  Table structure for `t_order_note`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_note`;
CREATE TABLE `t_order_note` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `note` text COMMENT '备注',
  `record_time` datetime DEFAULT NULL COMMENT '记录时间',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单信息备注表';

-- ----------------------------
--  Table structure for `t_order_op`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_op`;
CREATE TABLE `t_order_op` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `op_type` char(1) DEFAULT NULL COMMENT '操作类型：1、流程操作；2、添加备注',
  `proc_state` varchar(20) NOT NULL COMMENT '任务状态:参考t_sys_dictionary中type in(c_order_state,i_order_state,s_order_state,p_order_state)',
  `person_type` char(1) DEFAULT NULL COMMENT '人员类型：1、客户；2、译员；3、后台人员',
  `op_time` datetime NOT NULL COMMENT '操作时间',
  `op_user` varchar(100) NOT NULL COMMENT '操作人姓名',
  `note` text COMMENT '备注',
  `role_code` varchar(20) DEFAULT NULL COMMENT '角色编码',
  `role_name` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `action` varchar(10) DEFAULT NULL COMMENT '操作动作',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单操作记录表';

-- ----------------------------
--  Table structure for `t_order_operation_record`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_operation_record`;
CREATE TABLE `t_order_operation_record` (
  `id` varchar(255) CHARACTER SET utf8 NOT NULL,
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `operator` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作人',
  `remark` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `groupOrbatchId` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '组或批次id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_payment`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_payment`;
CREATE TABLE `t_order_payment` (
  `id` varchar(50) CHARACTER SET utf8 NOT NULL,
  `pmId` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '译员id',
  `bankAccount` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '银行开户行和账号',
  `idCard` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '身份证/国籍/护照号',
  `phone` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '手机号',
  `preTaxAmount` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '税前金额',
  `taxes` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '税金',
  `payableAfterTax` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '税后应付',
  `taxRate` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '税率',
  `actualPayment` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '实际支付',
  `payState` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '支付状态 1待支付2已支付',
  `pmName` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '译员名字',
  `batechId` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '批次id',
  `payTime` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '支付周期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_pool`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_pool`;
CREATE TABLE `t_order_pool` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `base_id` varchar(36) DEFAULT NULL COMMENT '主订单id',
  `record_id` varchar(36) DEFAULT NULL COMMENT '关联的任务信息主键',
  `pool_type` char(1) DEFAULT NULL COMMENT '池类型：1、客服估价；2、客服售后；3、pm售后；4、pm项目',
  `task_state` varchar(20) DEFAULT NULL COMMENT '任务状态:参考t_sys_dictionary中type in(c_order_state,i_order_state,s_order_state,p_order_state)',
  `receive_state` char(1) DEFAULT '0' COMMENT '领取状态：0、未领取；1、已领取',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_receive_state` (`receive_state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单池表';

-- ----------------------------
--  Table structure for `t_order_proc_aud`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_proc_aud`;
CREATE TABLE `t_order_proc_aud` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'id',
  `record_id` varchar(36) DEFAULT NULL COMMENT '记录id(关联具体的流程申请表)',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `event_name` varchar(20) DEFAULT NULL COMMENT '事项简称',
  `proc_code` varchar(20) DEFAULT NULL COMMENT '流程编号',
  `proc_type` char(2) DEFAULT NULL COMMENT '流程类型：1.文档方案审核；2.口译方案审核；3.结项审核；4.项目暂停；5.环节暂停；6.订单加价；7.估价审核；8.补差价审核；9.退款审核',
  `pend_person` varchar(36) DEFAULT NULL COMMENT '当前待办人',
  `sponsor` varchar(36) DEFAULT NULL COMMENT '发起人',
  `audit_status` char(1) DEFAULT '0' COMMENT '审批状态：0.待办；1.已办；2.办结',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `audit_result` char(1) DEFAULT NULL COMMENT '审批结果：1.同意；2.拒绝',
  `audit_time` datetime DEFAULT NULL COMMENT '审批时间',
  `back_reason` varchar(255) DEFAULT NULL COMMENT '打回意见',
  `duty_person` varchar(36) DEFAULT NULL COMMENT '负责人',
  `del_state` char(1) DEFAULT '1' COMMENT '删除状态1：未删除 0：已删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IDX_PROC_USER_ID` (`user_id`) USING BTREE,
  KEY `IDX_PROC_ORDER_ID` (`record_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单流程审批表';

-- ----------------------------
--  Table structure for `t_order_proc_change`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_proc_change`;
CREATE TABLE `t_order_proc_change` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `note` text COMMENT '反馈信息',
  `audit_state` char(1) DEFAULT NULL COMMENT '审核状态：1、同意；2、拒绝',
  `audit_note` varchar(255) DEFAULT NULL COMMENT '打回原因',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单流程（需求变更）表';

-- ----------------------------
--  Table structure for `t_order_proc_common`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_proc_common`;
CREATE TABLE `t_order_proc_common` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `node_code` char(20) DEFAULT NULL COMMENT '当前环节',
  `note` text COMMENT '备注',
  `audit_state` char(1) DEFAULT NULL COMMENT '审核状态：1、同意；2、拒绝',
  `audit_note` varchar(255) DEFAULT NULL COMMENT '打回原因',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='问题订单流程申请表';

-- ----------------------------
--  Table structure for `t_order_proc_refund`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_proc_refund`;
CREATE TABLE `t_order_proc_refund` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `fee` decimal(8,2) DEFAULT NULL COMMENT '退款金额',
  `full_name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `refund_type` char(1) DEFAULT NULL COMMENT '退款方式：1、支付宝；2、微信；3、银行卡；4、余额；',
  `account_num` varchar(100) DEFAULT NULL COMMENT '退款账号',
  `refund_note` text COMMENT '备注',
  `audit_state` char(1) DEFAULT NULL COMMENT '审核状态：1、同意；2、拒绝',
  `audit_note` varchar(255) DEFAULT NULL COMMENT '打回原因',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单费用退款流程申请表';

-- ----------------------------
--  Table structure for `t_order_refund`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_refund`;
CREATE TABLE `t_order_refund` (
  `id` varchar(36) NOT NULL COMMENT '主键',
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
  `creater` varchar(50) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_remark`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_remark`;
CREATE TABLE `t_order_remark` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `base_order_no` varchar(36) DEFAULT NULL COMMENT '主订单编号',
  `operator_role` varchar(20) DEFAULT NULL COMMENT '操作人角色',
  `operator_name` varchar(20) DEFAULT NULL COMMENT '操作人名',
  `del_statue` char(1) DEFAULT NULL COMMENT '删除标志(1.未删除,0.已删除)',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_order_sentence_statistics`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_sentence_statistics`;
CREATE TABLE `t_order_sentence_statistics` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '订单文件句段关联Id',
  `order_id` varchar(36) NOT NULL COMMENT '订单Id',
  `file_count` varchar(16) NOT NULL COMMENT '文件数：文件可读数/文件总数',
  `statistic_type` tinyint(1) NOT NULL COMMENT '文件统计类型：1-重复；2-交叉重复；3-匹配100%；4-匹配95%~99%；5-匹配75%~95%；6-新内容',
  `sentence_count` int(8) DEFAULT NULL COMMENT '句数',
  `character_count` int(16) DEFAULT NULL COMMENT '字数',
  `character_count_no_space` int(16) DEFAULT NULL COMMENT '字符数不包含空格',
  `chn_north` int(16) DEFAULT NULL COMMENT '中朝',
  `no_chn_words` int(16) DEFAULT NULL COMMENT '非中文单词',
  `percentage` varchar(8) DEFAULT NULL COMMENT '字数百分比：字数/总字数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_order_id` (`order_id`) USING BTREE COMMENT '订单Id索引',
  KEY `index_order_file_id` (`order_id`) USING BTREE COMMENT '订单Id，文件Id联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=34555 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单句子统计信息表';

-- ----------------------------
--  Table structure for `t_order_service_report`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_service_report`;
CREATE TABLE `t_order_service_report` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `report_type` char(1) DEFAULT NULL COMMENT '反馈类型：1、需求变更',
  `note` text COMMENT '反馈信息',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单客服反馈表表';

-- ----------------------------
--  Table structure for `t_order_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_task`;
CREATE TABLE `t_order_task` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `proc_state` char(4) NOT NULL COMMENT '任务状态:参考t_sys_dictionary中type in(c_order_state,i_order_state,s_order_state,p_order_state)',
  `user_name` varchar(36) DEFAULT NULL COMMENT '用户姓名',
  `task_type` char(1) DEFAULT NULL COMMENT '池类型：1、客服估价；2、客服售后；3、pm售后；4、pm项目',
  `end_tag` char(1) DEFAULT '0' COMMENT '结束标志：0、待办；1、已办；2、已退回；3、进行中（翻译中）',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_user` (`create_user`,`end_tag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单任务（客服、项目经理）表';

-- ----------------------------
--  Table structure for `t_order_test`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_test`;
CREATE TABLE `t_order_test` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '试译订单编号',
  `task_id` varchar(36) DEFAULT NULL COMMENT 't_recruit_task表id',
  `order_language` varchar(50) DEFAULT NULL COMMENT '订单语言',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `word_num` int(11) DEFAULT NULL COMMENT '订单字数',
  `unit_price` decimal(8,2) DEFAULT NULL COMMENT '单价',
  `order_text` text COMMENT '订单原文',
  `note` varchar(600) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='试译订单表';

-- ----------------------------
--  Table structure for `t_order_test_result`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_test_result`;
CREATE TABLE `t_order_test_result` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '试译订单编号',
  `translator` varchar(50) DEFAULT NULL COMMENT '翻译人员',
  `translate_text` text COMMENT '翻译文本',
  `translate_time` datetime DEFAULT NULL COMMENT '翻译时间',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='试译翻译成果表';

-- ----------------------------
--  Table structure for `t_order_time`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_time`;
CREATE TABLE `t_order_time` (
  `id` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '批次id',
  `times` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '所选几天时间确认',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_proj_hall`
-- ----------------------------
DROP TABLE IF EXISTS `t_proj_hall`;
CREATE TABLE `t_proj_hall` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '机构id',
  `receive_state` char(1) NOT NULL DEFAULT '0' COMMENT '领取状态：0、未领取；1、已领取',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_organ_id` (`organ_id`) USING BTREE,
  KEY `idx_receive_state` (`receive_state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='项目大厅表';

-- ----------------------------
--  Table structure for `t_recruit_application_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_recruit_application_info`;
CREATE TABLE `t_recruit_application_info` (
  `id` varchar(36) DEFAULT NULL,
  `link_id` varchar(36) DEFAULT NULL COMMENT '环节id',
  `user_id` varchar(36) DEFAULT NULL COMMENT 'userId',
  `account_code` varchar(36) DEFAULT NULL COMMENT '账号',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `user_name` varchar(36) DEFAULT NULL COMMENT '申请人姓名',
  `status` char(1) DEFAULT NULL COMMENT '状态：0：未审核 1：审核通过 2：审核不通过',
  `sy_status` char(1) DEFAULT NULL COMMENT '试译状态(0：试译中 1：试译关闭2：试译完成  3：待翻译)',
  `apply_attr` varchar(1000) DEFAULT NULL COMMENT '上传附件id',
  `not_pass_reason` varchar(1000) DEFAULT NULL COMMENT '不通过原因',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志（0：未生效1：已生效）',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL COMMENT '类型：1：表示后台添加人员'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_recruit_base`
-- ----------------------------
DROP TABLE IF EXISTS `t_recruit_base`;
CREATE TABLE `t_recruit_base` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `recruit_no` varchar(36) DEFAULT NULL COMMENT '招募号',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号(可为空)',
  `link_id` varchar(36) DEFAULT NULL COMMENT '项目环节id(可为空)',
  `tran_type` char(1) DEFAULT NULL COMMENT '翻译类型：1、快翻；2、文档；3、口译',
  `finish_time` datetime DEFAULT NULL COMMENT '交稿时间',
  `cut_off_time` datetime DEFAULT NULL COMMENT '截止时间',
  `order_language` varchar(50) DEFAULT NULL COMMENT '订单语言',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `word_num` int(11) DEFAULT NULL COMMENT '预估字数',
  `proj_name` varchar(100) DEFAULT NULL COMMENT '项目名称',
  `proj_abstract` varchar(600) DEFAULT NULL COMMENT '项目简介',
  `proj_note` varchar(600) DEFAULT NULL COMMENT '项目备注',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_user` (`create_user`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='招募信息表';

-- ----------------------------
--  Table structure for `t_recruit_base_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_recruit_base_info`;
CREATE TABLE `t_recruit_base_info` (
  `id` varchar(36) NOT NULL,
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单号（可有可无，只是展示用的）',
  `name` varchar(300) DEFAULT NULL COMMENT '项目名称',
  `origin_language` varchar(36) DEFAULT NULL COMMENT '起始语向',
  `target_language` varchar(36) DEFAULT NULL COMMENT '目标语向',
  `unit_num` char(30) DEFAULT NULL COMMENT '总量',
  `m_field` varchar(50) DEFAULT NULL COMMENT '稿件领域',
  `m_purpose` varchar(50) DEFAULT NULL COMMENT '稿件用途',
  `star_time` datetime DEFAULT NULL COMMENT '开始时间',
  `hand_time` varchar(20) DEFAULT NULL COMMENT '交稿时间',
  `out_time` varchar(20) DEFAULT NULL COMMENT '截止时间',
  `introduction` varchar(700) DEFAULT NULL COMMENT '项目简介',
  `notes` varchar(700) DEFAULT NULL COMMENT '项目备注',
  `status` char(1) DEFAULT '3' COMMENT '招募信息状态（0：关闭 1：招募中 2：招募完成3：未发布）',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志（1：有效 0：无效）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_edit_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `create_user_id` varchar(100) DEFAULT NULL COMMENT '创建人用户Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='PM发布译员招募信息基本表';

-- ----------------------------
--  Table structure for `t_recruit_link_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_recruit_link_info`;
CREATE TABLE `t_recruit_link_info` (
  `id` varchar(36) NOT NULL,
  `recruit_id` varchar(36) DEFAULT NULL COMMENT '招募译员基本信息id',
  `type` varchar(50) DEFAULT NULL COMMENT '环节类型（1、翻译；2、质检；3、审校；4、评估；5、排版）',
  `is_show` char(1) DEFAULT NULL COMMENT '0：显示1：不显示',
  `p_number` int(11) DEFAULT NULL COMMENT '招募人数',
  `total_number` varchar(36) DEFAULT NULL COMMENT '预估字数',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `task_amount` decimal(10,2) DEFAULT NULL COMMENT '任务金额',
  `hand_time` varchar(20) DEFAULT NULL COMMENT '交稿时间',
  `is_try` char(1) DEFAULT NULL COMMENT '是否试译：0：无需试译  1：需要试译',
  `attr` varchar(1000) DEFAULT NULL COMMENT '试译文件附件id多个用逗号分割',
  `requirment` varchar(1000) DEFAULT NULL COMMENT '要求',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志（0：未生效 1：已生效）',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `close_link` varchar(2) DEFAULT NULL COMMENT '是否手动关闭：0：表示手动关闭',
  `create_user_id` varchar(100) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='译员招募环节信息表';

-- ----------------------------
--  Table structure for `t_recruit_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_recruit_task`;
CREATE TABLE `t_recruit_task` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `recruit_no` varchar(36) DEFAULT NULL COMMENT '招募号',
  `task_type` char(1) DEFAULT NULL COMMENT '任务类型：1、翻译；2、质检；3、审校；4、评估；5、排版',
  `put_num` int(11) DEFAULT NULL COMMENT '任务发放人数',
  `word_num` int(11) DEFAULT NULL COMMENT '预估字数',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `cost_price` decimal(6,2) DEFAULT NULL COMMENT '任务金额',
  `end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `date_tag` char(1) DEFAULT NULL COMMENT '有无语料参考：0、无；1、有',
  `test_tag` char(1) DEFAULT NULL COMMENT '有无试译：0、无；1、有',
  `hall_tag` char(1) DEFAULT NULL COMMENT '是否大厅显示：0、否；1、是',
  `apply_require` text COMMENT '申请要求',
  `note` text COMMENT '备注',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_recruit_no` (`recruit_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='招募任务表';

-- ----------------------------
--  Table structure for `t_recruit_task_finish`
-- ----------------------------
DROP TABLE IF EXISTS `t_recruit_task_finish`;
CREATE TABLE `t_recruit_task_finish` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `task_id` varchar(36) DEFAULT NULL COMMENT 't_recruit_task表的id',
  `doc_type` char(1) DEFAULT NULL COMMENT '稿件类型：1、初稿；2、中间稿；3、终稿',
  `finish_time` datetime DEFAULT NULL COMMENT '交稿时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='招募环节交稿时间表';

-- ----------------------------
--  Table structure for `t_recruit_task_person`
-- ----------------------------
DROP TABLE IF EXISTS `t_recruit_task_person`;
CREATE TABLE `t_recruit_task_person` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `task_id` varchar(36) DEFAULT NULL COMMENT 't_recruit_task表的id',
  `person_type` varchar(36) DEFAULT NULL COMMENT '1、指定译员；2、自己申请',
  `choose_tag` char(1) DEFAULT '0' COMMENT '选择标志：0、未选择；1、已选择；2、已拒绝',
  `note` text COMMENT '备注：填写拒绝原因',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `language` varchar(100) DEFAULT NULL COMMENT '语种',
  `price` decimal(6,2) DEFAULT NULL COMMENT '报价',
  `user_id` varchar(36) DEFAULT NULL COMMENT '报名人员的用户id',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='招募环节人员表';

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
--  Table structure for `t_sys_price`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_price`;
CREATE TABLE `t_sys_price` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `source_language` varchar(50) DEFAULT NULL COMMENT '源语言',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `order_type` char(1) DEFAULT NULL COMMENT '订单类型：1、快翻；2、文档翻译；3、口译；',
  `translate_level` char(1) DEFAULT NULL COMMENT '翻译等级：0、无；1、标准；2、专业；3、母语；4、专家；11、标准化证件；12、非标准证件；21；创意翻译',
  `doc_type` char(1) DEFAULT NULL COMMENT '文本类型：1、中文翻译（字）；2、外文翻译（词）；3、证件翻译（页）；4、词条翻译（条）',
  `price` decimal(8,2) DEFAULT NULL COMMENT '单价',
  `price_type` char(1) DEFAULT NULL COMMENT '价格类型：1、标准价；2、起步价；3:、咨询客服',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='翻译价格表';

-- ----------------------------
--  Table structure for `t_task_resolve`
-- ----------------------------
DROP TABLE IF EXISTS `t_task_resolve`;
CREATE TABLE `t_task_resolve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskId` varchar(255) DEFAULT NULL,
  `isResolve` int(11) DEFAULT NULL,
  `types` int(11) DEFAULT NULL,
  `fileType` int(11) DEFAULT NULL,
  `times` varchar(255) DEFAULT NULL,
  `sizes` varchar(255) DEFAULT NULL,
  `recordId` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `taskIds` varchar(255) DEFAULT NULL COMMENT '任务id',
  `isStop` varchar(255) DEFAULT NULL COMMENT '0中止 1继续',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9163 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
	
	
	SELECT IFNULL(t1.`p_order_no`,IFNULL(t1.`order_no`,IFNULL(t.`p_order_no`,t.order_no))) INTO @baseOrderNo FROM `t_order_document` t LEFT JOIN t_order_document t1 ON t1.`id` = t.p_id
		WHERE t.`order_no` = p_doc_order_no;
	
	SELECT real_price,cost_price INTO @baserealPrice,@baseCostPirce FROM t_order_base WHERE order_no = @baseOrderNo;
	
	SELECT IFNULL(SUM(fee),0) INTO @fee FROM `t_order_fee_add` WHERE order_no = @baseOrderNo;
	
	
	
	SELECT GROUP_CONCAT(CONCAT('\'',order_no,'\'')) INTO @docOrderNos FROM t_order_document WHERE order_no  = p_doc_order_no;
	
	SET @sql = CONCAT('SELECT SUM(cost_price) INTO @interpreterTotalPrice FROM t_order_document_link WHERE order_no IN (',@docOrderNos,') and del_state = \'1\'');	
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	SET interpreterTotalPrice = @interpreterTotalPrice;
	
	DEALLOCATE PREPARE stmt;
	SET r_profit_margin = ROUND((1-ROUND(interpreterTotalPrice/@baserealPrice,4))*100,2);
	
	UPDATE t_order_base SET total_profit_margin = r_profit_margin , total_cost = interpreterTotalPrice WHERE order_no = @baseOrderNo;	
	
	
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
    
	DECLARE done INT DEFAULT 0; 
	DECLARE interpreterTotalPrice DECIMAL(10,2) DEFAULT 0.00; 
	DECLARE refundFee DECIMAL(10,2) DEFAULT 0.00; 
	
	DECLARE r_profit_margin VARCHAR(20);  
	DECLARE linkId VARCHAR(50) DEFAULT '';  
	DECLARE createTime TIMESTAMP;  
	 
	DECLARE docId VARCHAR(36);  
	DECLARE docOrderNo VARCHAR(36);  
	DECLARE docRealPrice DECIMAL(10,2) DEFAULT 0.00;  
	DECLARE docOrderNos VARCHAR(200) DEFAULT '';  
	
	DECLARE multilingual_record CURSOR FOR SELECT id,order_no,real_price FROM `t_order_document` WHERE del_state = '1' AND p_order_no = p_base_order_no;  
	DECLARE cur CURSOR FOR(SELECT id,create_time FROM doclink_view); 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
	
	
	SELECT real_price INTO @realPrice FROM t_order_base WHERE order_no = p_base_order_no;
	
	SELECT IFNULL(SUM(fee),0) INTO @fee FROM `t_order_fee_add` WHERE order_no = p_base_order_no;
	
	SELECT IFNULL(SUM(cost_price),0) INTO @priceDifferences FROM `t_order_base` WHERE order_no LIKE CONCAT('%',p_base_order_no,'-BXJ%') AND del_state = '1'  AND pay_type IS NOT NULL;
		
	SELECT COUNT(1) INTO @countFlag FROM t_order_document WHERE order_no = p_base_order_no AND del_state = '1';
	
	IF @countFlag <> 0 THEN 
		
		
		SELECT IFNULL(SUM(fee),0) INTO refundFee FROM `t_order_proc_refund` WHERE audit_state = '1' AND del_state  = '1'  AND order_no = p_base_order_no;
		SET @sumPrice = @realPrice +  @fee + @priceDifferences - refundFee;
		
		SELECT SUM(cost_price) INTO interpreterTotalPrice FROM t_order_document_link WHERE order_no = p_base_order_no  AND del_state = '1';
		
		SET r_profit_margin = ROUND((1-ROUND(interpreterTotalPrice/@sumPrice,4))*100,2);
		
		
		
		UPDATE t_order_base SET total_profit_margin = r_profit_margin , total_cost = interpreterTotalPrice WHERE order_no = p_base_order_no;	
		
		
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
				
				SET r_profit_margin = ROUND((1-ROUND( @docCostPrice/@sumPrice,4))*100,2);
				UPDATE t_order_document_link SET profit_margin =  r_profit_margin WHERE id = linkId;
				
			END LOOP f_loop;
	        CLOSE cur;
	ELSE 
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
						
						
						SET r_profit_margin = ROUND((1-ROUND(@docCostPrice/docRealPrice,4))*100,2);
						UPDATE t_order_document_link SET profit_margin = r_profit_margin WHERE id = linkId;
					END LOOP myLoop;
				CLOSE cur;
				SET done = 0;
			END LOOP f_loop;
	        CLOSE multilingual_record;
		SET @sumPrice = @realPrice +  @fee + @priceDifferences - refundFee;
		
		SET @sqlstr = CONCAT('SELECT SUM(cost_price) INTO interpreterTotalPrice FROM t_order_document_link WHERE order_no IN (',docOrderNos,')  AND del_state = \'1\'');
		SET r_profit_margin = ROUND((1-ROUND(interpreterTotalPrice/@sumPrice,4))*100,2);
		
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

SET FOREIGN_KEY_CHECKS = 1;
