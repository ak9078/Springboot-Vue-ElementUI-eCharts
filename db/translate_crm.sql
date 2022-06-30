/*
 Navicat Premium Data Transfer

 Source Server         : zhongWFY测试
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 180.76.190.170
 Source Database       : translate_crm

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : utf-8

 Date: 06/29/2022 23:28:44 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `act_evt_log`
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `act_ge_bytearray`
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '资源文件编号，自增长',
  `REV_` int(11) DEFAULT NULL COMMENT '版本号',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '资源文件名称',
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '来自于父表act_re_deployment的主键',
  `BYTES_` longblob COMMENT '大文本类型，存储文本字节流',
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='二进制数据表，用来保存部署文件的大文本数据';

-- ----------------------------
--  Table structure for `act_ge_property`
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '属性名称',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL COMMENT '属性值',
  `REV_` int(11) DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='属性数据表，存储这整个流程引擎级别的数据。在初始化表结构时，会默认插入三条记录';

-- ----------------------------
--  Table structure for `act_hi_actinst`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '标识',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '流程定义id',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '流程实例id',
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '执行实例',
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '节点id',
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '节点名称',
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL COMMENT ' 节点类型',
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '节点任务分配人',
  `START_TIME_` datetime(3) NOT NULL COMMENT '开始时间',
  `END_TIME_` datetime(3) DEFAULT NULL COMMENT '结束时间',
  `DURATION_` bigint(20) DEFAULT NULL COMMENT '经过时长',
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史节点表';

-- ----------------------------
--  Table structure for `act_hi_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史附件表';

-- ----------------------------
--  Table structure for `act_hi_comment`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '标识',
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '意见记录类型 为comment 时 为处理意见',
  `TIME_` datetime(3) NOT NULL COMMENT '记录时间',
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '对应任务的id',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '对应的流程实例的id',
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '为AddComment 时为处理意见',
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '处理意见',
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史意见表';

-- ----------------------------
--  Table structure for `act_hi_detail`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '标识',
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'variableUpdate 和 formProperty 两种值',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '对应流程实例id',
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '对应执行实例id',
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '对应任务id',
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '对应节点id',
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '历史流程变量名称，或者表单属性的名称',
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '定义类型',
  `REV_` int(11) DEFAULT NULL COMMENT '版本',
  `TIME_` datetime(3) NOT NULL COMMENT '导入时间',
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL COMMENT ' 如果定义的变量或者表单属性的类型为double，他的值存在这里',
  `LONG_` bigint(20) DEFAULT NULL COMMENT '如果定义的变量或者表单属性的类型为LONG ,他的值存在这里',
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '如果定义的变量或者表单属性的类型为string，值存在这里',
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史详情表，启动流程或者在任务complete之后,记录历史流程变量';

-- ----------------------------
--  Table structure for `act_hi_identitylink`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史流程人员表';

-- ----------------------------
--  Table structure for `act_hi_procinst`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '唯一标识',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '流程ID',
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '业务编号',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '流程定义id',
  `START_TIME_` datetime(3) NOT NULL COMMENT '流程开始时间',
  `END_TIME_` datetime(3) DEFAULT NULL COMMENT '结束时间',
  `DURATION_` bigint(20) DEFAULT NULL COMMENT '流程经过时间',
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '开启流程用户id',
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '开始节点',
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '结束节点',
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '父流程流程id',
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '从运行中任务表中删除原因',
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史流程实例表';

-- ----------------------------
--  Table structure for `act_hi_taskinst`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '标识',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程定义id',
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '任务定义id',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例id',
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '执行实例id',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '任务名称',
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '父任务id',
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '说明',
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '拥有人（发起人）',
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '分配到任务的人',
  `START_TIME_` datetime(3) NOT NULL COMMENT '开始任务时间',
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL COMMENT '结束任务时间',
  `DURATION_` bigint(20) DEFAULT NULL COMMENT '时长',
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '从运行时任务表中删除的原因',
  `PRIORITY_` int(11) DEFAULT NULL COMMENT '紧急程度',
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史任务实例表';

-- ----------------------------
--  Table structure for `act_hi_varinst`
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`) USING BTREE,
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='历史变量表';

-- ----------------------------
--  Table structure for `act_id_group`
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户组名',
  `REV_` int(11) DEFAULT NULL COMMENT '版本号',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户组描述信息',
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户组类型',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='用户组信息表，用来存储用户组信息';

-- ----------------------------
--  Table structure for `act_id_info`
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='用户扩展信息表';

-- ----------------------------
--  Table structure for `act_id_membership`
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户名',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户组名',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`) USING BTREE,
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='用户与用户组对应信息表，用来保存用户的分组信息';

-- ----------------------------
--  Table structure for `act_id_user`
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户名',
  `REV_` int(11) DEFAULT NULL COMMENT '版本号',
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名称',
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户姓氏',
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
--  Table structure for `act_re_deployment`
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `act_re_model`
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`) USING BTREE,
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) USING BTREE,
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `act_re_procdef`
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `act_ru_event_subscr`
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`) USING BTREE,
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `act_ru_execution`
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '主键，这个主键有可能和PROC_INST_ID_相同，相同的情况表示这条记录为主实例记录',
  `REV_` int(11) DEFAULT NULL COMMENT '版本，表示数据库表更新次数',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例编号，一个流程实例不管有多少条分支实例，这个ID都是一致的',
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '业务编号，业务主键，主流程才会使用业务主键，另外这个业务主键字段在表中有唯一约束',
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '找到该执行实例的父级，最终会找到整个流程的执行实例',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程定义ID',
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '引用的执行模板，这个如果存在表示这个实例记录为一个外部子流程记录，对应主流程的主键ID',
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '节点id，表示流程运行到哪个节点',
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL COMMENT '是否活动流程实例',
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL COMMENT '是否并发。上图同步节点后为并发，如果是并发多实例也是为1',
  `IS_SCOPE_` tinyint(4) DEFAULT NULL COMMENT '主实例为1，子实例为0',
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL COMMENT '没有使用到事件的情况下，一般都为0',
  `SUSPENSION_STATE_` int(11) DEFAULT NULL COMMENT '是否暂停',
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '这个字段表示租户ID。可以应对多租户的设计',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`) USING BTREE,
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`) USING BTREE,
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`) USING BTREE,
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='运行时流程执行实例表';

-- ----------------------------
--  Table structure for `act_ru_identitylink`
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '标识',
  `REV_` int(11) DEFAULT NULL COMMENT '版本',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '组织id',
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户id',
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '任务id',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`) USING BTREE,
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`) USING BTREE,
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`) USING BTREE,
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='运行时流程人员表，主要存储任务节点与参与者的相关信息';

-- ----------------------------
--  Table structure for `act_ru_job`
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `act_ru_task`
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '执行实例的id',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例的id',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程定义的id,对应act_re_procdef 的id_',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '任务名称，对应task 的name',
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '对应父任务',
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'task 的id',
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '发起人',
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '分配到任务的人',
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '委托人',
  `PRIORITY_` int(11) DEFAULT NULL COMMENT '紧急程度',
  `CREATE_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `DUE_DATE_` datetime(3) DEFAULT NULL COMMENT '审批时长',
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`) USING BTREE,
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`) USING BTREE,
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='运行时任务节点表';

-- ----------------------------
--  Table structure for `act_ru_variable`
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '标识',
  `REV_` int(11) DEFAULT NULL COMMENT '版本号',
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '数据类型',
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '变量名',
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '执行实例id',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例id',
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '任务id',
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL COMMENT '若数据类型为double ,保存数据在此列',
  `LONG_` bigint(20) DEFAULT NULL COMMENT '若数据类型为Long保存数据到此列',
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT 'string 保存到此列',
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`) USING BTREE,
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`) USING BTREE,
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='运行时流程变量数据表';

-- ----------------------------
--  Table structure for `common_corpus`
-- ----------------------------
DROP TABLE IF EXISTS `common_corpus`;
CREATE TABLE `common_corpus` (
  `id` varchar(36) NOT NULL,
  `raw_corpus_name` varchar(300) NOT NULL COMMENT '语料库名称',
  `source_language` varchar(100) NOT NULL COMMENT '源语言',
  `source_language_name` varchar(100) NOT NULL COMMENT '源语言',
  `target_language` char(100) NOT NULL COMMENT '目标语言',
  `target_language_name` char(100) NOT NULL COMMENT '目标语言',
  `domain` varchar(200) DEFAULT NULL COMMENT '领域',
  `type` int(1) NOT NULL COMMENT '所属类目 1-记忆库 2-术语库',
  `del_state` int(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除0：已删除',
  `usable_state` int(1) NOT NULL DEFAULT '1' COMMENT '启用状态1：启用 0：禁用',
  `remark` varchar(1000) DEFAULT NULL COMMENT '描述',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` varchar(36) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_common_corpus` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户通用语料基本信息表';

-- ----------------------------
--  Table structure for `common_corpus_sentence`
-- ----------------------------
DROP TABLE IF EXISTS `common_corpus_sentence`;
CREATE TABLE `common_corpus_sentence` (
  `id` varchar(36) NOT NULL,
  `raw_corpus_id` varchar(36) NOT NULL COMMENT '通用语料库id',
  `seq_num` int(5) NOT NULL COMMENT '序号',
  `source_text` varchar(1000) NOT NULL COMMENT '原文',
  `target_text` varchar(1000) NOT NULL COMMENT '译文',
  `del_state` int(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` varchar(36) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_common_corpus_sentence` (`raw_corpus_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户通用语料句对信息表';

-- ----------------------------
--  Table structure for `raw_corpus`
-- ----------------------------
DROP TABLE IF EXISTS `raw_corpus`;
CREATE TABLE `raw_corpus` (
  `id` varchar(36) NOT NULL,
  `raw_corpus_name` varchar(300) NOT NULL COMMENT '语料库名称',
  `source_language` varchar(100) NOT NULL COMMENT '源语言',
  `source_language_name` varchar(100) NOT NULL COMMENT '源语言',
  `target_language` char(100) NOT NULL COMMENT '目标语言',
  `target_language_name` char(100) NOT NULL COMMENT '目标语言',
  `customer_id` varchar(50) DEFAULT NULL COMMENT '客户ID',
  `customer_name` varchar(200) DEFAULT NULL COMMENT '客户名称',
  `order_no` varchar(20) DEFAULT NULL COMMENT '订单编号',
  `domain` varchar(200) DEFAULT NULL COMMENT '领域',
  `type` int(1) NOT NULL COMMENT '所属类目 1-记忆库 2-术语库',
  `audit_state` int(1) DEFAULT NULL COMMENT '审核状态 0-待审核 1-已审核 2-审核中',
  `audit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核完成时间',
  `del_state` int(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除0：已删除',
  `remark` varchar(1000) DEFAULT NULL COMMENT '描述',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` varchar(36) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_raw_corpus` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户生语料基本信息表';

-- ----------------------------
--  Table structure for `raw_corpus_sentence`
-- ----------------------------
DROP TABLE IF EXISTS `raw_corpus_sentence`;
CREATE TABLE `raw_corpus_sentence` (
  `id` varchar(36) NOT NULL,
  `raw_corpus_id` varchar(36) NOT NULL COMMENT '生语料库id',
  `seq_num` int(5) NOT NULL COMMENT '序号',
  `source_text` varchar(10000) NOT NULL COMMENT '原文',
  `target_text` varchar(10000) NOT NULL COMMENT '译文',
  `del_state` int(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` varchar(36) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_raw_corpus_sentence` (`raw_corpus_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户生语料句对信息表';

-- ----------------------------
--  Table structure for `t_crm_atta`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_atta`;
CREATE TABLE `t_crm_atta` (
  `id` varchar(36) NOT NULL,
  `correlation_id` varchar(36) NOT NULL COMMENT '关联ID,可以是线索，可以是客户、可以是合同等等',
  `atta_name` varchar(200) NOT NULL COMMENT '附件名称',
  `atta_type` char(1) NOT NULL COMMENT '附件类型 (0:合同；1：线索 2：客户 3：销售机会 )',
  `atta_url` varchar(200) NOT NULL COMMENT '附件地址',
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_name` varchar(36) DEFAULT NULL COMMENT '创建人名称',
  `atta_size` varchar(12) DEFAULT NULL COMMENT '文件大写,byte为单位',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_correlation` (`correlation_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='附件表';

-- ----------------------------
--  Table structure for `t_crm_attention`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_attention`;
CREATE TABLE `t_crm_attention` (
  `id` varchar(36) NOT NULL,
  `correlation_id` varchar(36) NOT NULL COMMENT '关联的id',
  `correlation_type` char(1) NOT NULL COMMENT '关联类型 1：线索 2：客户。。。。可扩展',
  `user_id` varchar(36) NOT NULL COMMENT '关注人ID  t_base_account表主键',
  `attent_time` datetime NOT NULL,
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_type` (`user_id`,`correlation_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='关注表（线索、客户、联系人商机、合同等都可以关注）';

-- ----------------------------
--  Table structure for `t_crm_chargeoffs_records`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_chargeoffs_records`;
CREATE TABLE `t_crm_chargeoffs_records` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `charge_offs_time` datetime DEFAULT NULL COMMENT '销账时间',
  `charge_offs_money` double(10,2) DEFAULT NULL COMMENT '销账金额',
  `operator` varchar(20) DEFAULT NULL COMMENT '操作人',
  `del_state` char(1) DEFAULT NULL COMMENT '删除状态：1.未删除；0.已删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creater_user` varchar(36) DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销账记录表';

-- ----------------------------
--  Table structure for `t_crm_chargeoffs_records_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_chargeoffs_records_detail`;
CREATE TABLE `t_crm_chargeoffs_records_detail` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `chargeoffId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '订单发票销账详情id',
  `fpId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '发票号',
  `invoiceMoneys` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '当次开发票的金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_clue`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_clue`;
CREATE TABLE `t_crm_clue` (
  `id` varchar(36) NOT NULL,
  `clue_name` varchar(100) NOT NULL COMMENT '线索名称',
  `customer_name` varchar(100) NOT NULL COMMENT '客户名称',
  `linkman_id` varchar(36) DEFAULT NULL COMMENT '线索信息对应联系人id',
  `linkman` varchar(50) DEFAULT NULL COMMENT '线索联系人',
  `linkman_sex` char(1) DEFAULT NULL COMMENT '线索联系人性别 1:男 2：女',
  `linkman_dept` varchar(100) DEFAULT NULL COMMENT '线索联系人部门',
  `linkman_position` varchar(50) DEFAULT NULL COMMENT '线索联系人职务',
  `contact_mobile` varchar(20) DEFAULT NULL COMMENT '联系人手机号码',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系人固话',
  `contact_wecat` varchar(50) DEFAULT NULL COMMENT '联系人微信',
  `contact_qq` varchar(12) DEFAULT NULL COMMENT '联系人QQ',
  `contact_email` varchar(50) DEFAULT NULL COMMENT '联系人邮箱',
  `customer_addr` varchar(200) DEFAULT NULL COMMENT '客户公司地址',
  `clue_remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `clue_source` char(2) DEFAULT NULL COMMENT '线索来源  0：网站、1：投标、2：合作关系、3：自主挖掘、4：内部转移、5：市场活动、6：老客户二次机会、7:培训、8:网络、9:微信、10:其他 （当来源为市场活动时，必须填写市场活动）',
  `clue_source_other` varchar(100) DEFAULT NULL COMMENT '线索来源为其他时自定义',
  `market_activity` varchar(100) DEFAULT NULL COMMENT '市场活动',
  `clue_state` char(1) NOT NULL COMMENT '线索状态，0：草稿，每个用户唯一 1：已提交',
  `clue_leader` varchar(36) DEFAULT NULL COMMENT '线索负责人',
  `clue_leader_name` varchar(50) DEFAULT NULL COMMENT '线索负责人名',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '团队ID，这里不是临时团队是指线索负责人的所在的组织',
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态 1:未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '线索创建人',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '线索创建人名',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_edit_user_name` varchar(50) DEFAULT NULL COMMENT '最后修改人名',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_leader` (`clue_leader`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='线索表';

-- ----------------------------
--  Table structure for `t_crm_contract`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_contract`;
CREATE TABLE `t_crm_contract` (
  `id` varchar(36) NOT NULL,
  `contract_name` varchar(50) DEFAULT NULL COMMENT '合同名称',
  `customer_id` varchar(36) DEFAULT NULL COMMENT '所属客户',
  `linkman_ids` varchar(400) DEFAULT NULL COMMENT '客户联系人，可多个 ，多个以,隔开',
  `opportunity_id` varchar(36) DEFAULT NULL COMMENT '所属销售机会',
  `contract_type` char(1) DEFAULT NULL COMMENT '合同类型（0：长期服务合同；1：单项目合同）',
  `product_group_id` varchar(36) DEFAULT NULL COMMENT '产品组ID',
  `partyA_signer` varchar(50) DEFAULT NULL COMMENT '甲方签约人',
  `partyB_signer` varchar(50) DEFAULT NULL COMMENT '乙方签约人',
  `contract_remarks` varchar(500) DEFAULT NULL COMMENT '合同简述',
  `contract_special_remarks` varchar(500) DEFAULT NULL COMMENT '合同特殊承诺',
  `contract_sum` double(15,2) DEFAULT NULL COMMENT '合同金额',
  `contract_state` char(1) DEFAULT NULL COMMENT '合同状态（0：签约；1：执行中；2：完毕；3：意外终止）',
  `contract_audit_state` char(1) DEFAULT NULL COMMENT '合同审批状态（ 0：草稿；1：审核中；2：（审核通过）有效;3：（审核不通过）无效）',
  `contract_leader` varchar(36) DEFAULT NULL COMMENT '合同负责人',
  `contract_create_user` varchar(36) DEFAULT NULL COMMENT '合同创建人',
  `contract_sign_date` datetime DEFAULT NULL COMMENT '签约日期',
  `contract_expire_date` datetime DEFAULT NULL COMMENT '合同到期日期',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '所属部门',
  `contract_pay_type` char(1) DEFAULT NULL COMMENT '支付方式(1网银转账、2现金、3支票、4微信、5支付宝、6电汇、7承兑汇票)',
  `contract_returned_date` datetime DEFAULT NULL COMMENT '回款日期',
  `contract_returned_type` char(1) DEFAULT NULL COMMENT '回款方式(1:一次性支付、2:分批支付、3:定期支付)',
  `del_state` char(1) DEFAULT NULL,
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `last_edit_user_name` varchar(36) DEFAULT NULL,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_name` varchar(36) DEFAULT NULL COMMENT '创建人姓名',
  `leader_name` varchar(36) DEFAULT NULL COMMENT '负责人姓名',
  `contract_num` varchar(20) DEFAULT NULL COMMENT '合同编号',
  `confirm_voucher` char(1) DEFAULT NULL COMMENT '信息确认凭证（0：否；1：是）',
  `presales_consultant` varchar(50) DEFAULT '' COMMENT '售前顾问',
  `productIds` text COMMENT '产品组详情产品ID集合， 英文逗号分隔',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_leader` (`contract_leader`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='合同信息表';

-- ----------------------------
--  Table structure for `t_crm_contract_msg`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_contract_msg`;
CREATE TABLE `t_crm_contract_msg` (
  `id` varchar(36) NOT NULL COMMENT '数据id',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同id',
  `msg_type` char(1) DEFAULT NULL COMMENT '消息类型：1、临近过期，2、未更新',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='合同信息表';

-- ----------------------------
--  Table structure for `t_crm_contract_product_relation`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_contract_product_relation`;
CREATE TABLE `t_crm_contract_product_relation` (
  `id` varchar(36) NOT NULL,
  `contract_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='合同-产品关系表';

-- ----------------------------
--  Table structure for `t_crm_customer`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_customer`;
CREATE TABLE `t_crm_customer` (
  `id` varchar(36) NOT NULL,
  `clue_id` varchar(36) DEFAULT NULL COMMENT '线索ID，可为null',
  `customer_trade_ext` varchar(100) DEFAULT NULL COMMENT '客户行业扩展自定义内容',
  `parent_customer_id` varchar(36) DEFAULT NULL COMMENT '上级客户',
  `customer_name` varchar(50) NOT NULL COMMENT '客户名称',
  `customer_source` char(1) DEFAULT NULL COMMENT '客户来源（1：转介绍:2：自开拓:3：电话咨询:4：展会资源:5：邮件咨询:6：投标、7、线索、8：其他）',
  `customer_source_other` varchar(100) DEFAULT NULL COMMENT '客户来源为其他时自定义',
  `customer_state` char(1) NOT NULL COMMENT '客户状态（1：意向客户:2：成交客户:3：忠诚客户:4：流失客户:5：潜在客户）',
  `customer_type` char(1) NOT NULL DEFAULT '2' COMMENT '客户类型：1：重点客户2：非重点客户',
  `customer_nature` char(1) DEFAULT NULL COMMENT '客户性质（1：政府事业单位:2：央/国企客户:3：外企客户、4：民企客户、5：股份制企业客户、6：其他）',
  `customer_nature_other` varchar(100) DEFAULT NULL COMMENT '客户性质为其他时自定义',
  `customer_trade` char(1) DEFAULT NULL COMMENT '客户行业-(1:一级行业 2：二级行业)',
  `customer_area` char(2) DEFAULT NULL COMMENT '客户区域',
  `customer_addr` varchar(200) DEFAULT NULL COMMENT '客户地址-详细地址',
  `customer_addr_prov` varchar(100) DEFAULT NULL COMMENT '客户地址-省',
  `customer_addr_city` varchar(100) DEFAULT NULL COMMENT '客户地址-市',
  `customer_addr_area` varchar(100) DEFAULT NULL COMMENT '客户地址-县区',
  `conglomerate` varchar(100) DEFAULT NULL COMMENT '隶属企业集团',
  `lev` int(3) DEFAULT NULL COMMENT '客户级别',
  `market_size` char(1) DEFAULT NULL COMMENT '市场规模（1：5万以下 2：5-20万 3：20-50万 4：50-100万 100-200万 200万以上）',
  `registered_capital` varchar(100) DEFAULT NULL COMMENT '注册资本',
  `customer_audit_state` char(1) DEFAULT NULL COMMENT '客户审核状态 0：草稿、 1;审核中 2：（审核通过）有效 3：（审核不通过）无效',
  `customer_create_user` varchar(36) DEFAULT NULL COMMENT '客户创建人',
  `customer_leader` varchar(36) DEFAULT NULL COMMENT '客户负责人',
  `customer_leader_name` varchar(50) DEFAULT NULL COMMENT '客户负责人名',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '团队ID，这里不是临时团队是指线索负责人的所在的组织',
  `remarks` varchar(200) DEFAULT NULL COMMENT '客户备注',
  `privately` char(1) DEFAULT '0' COMMENT '是否私有（0：非私有 1：私有）',
  `last_follow_time` timestamp NULL DEFAULT NULL COMMENT '最新跟进时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除状态 1：未删除 0:已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '记录创建人名',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '记录创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '记录最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后修改时间',
  `last_edit_user_name` varchar(50) DEFAULT NULL COMMENT '记录最后修改人名',
  `customer_audit_flag` varchar(1) DEFAULT '0' COMMENT '是否生效',
  `presales_consultant` varchar(50) DEFAULT '' COMMENT '售前顾问字段',
  `source_customer_name` varchar(64) DEFAULT NULL COMMENT '未修改前的客户名',
  `source_customer_leader_id` varchar(36) DEFAULT NULL COMMENT '原负责人Id',
  `source_customer_leader_name` varchar(64) DEFAULT NULL COMMENT '原负责人姓名',
  `note` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_leader` (`customer_leader`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='客户表';

-- ----------------------------
--  Table structure for `t_crm_delivery_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_delivery_info`;
CREATE TABLE `t_crm_delivery_info` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) DEFAULT NULL COMMENT '文档翻译下单id',
  `target_language` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `lev` varchar(50) DEFAULT NULL COMMENT '产品级别',
  `unit_price` double(10,2) DEFAULT NULL COMMENT '单价',
  `statistical_type` varchar(50) DEFAULT NULL COMMENT '统计方式',
  `forecast` int(11) DEFAULT NULL COMMENT '预估量',
  `reversion_state` varchar(50) DEFAULT NULL COMMENT '返稿 1:申请反稿 0：未反稿',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_edit_user` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档翻译交付信息';

-- ----------------------------
--  Table structure for `t_crm_invoice`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_invoice`;
CREATE TABLE `t_crm_invoice` (
  `id` varchar(36) NOT NULL,
  `invoice_no` varchar(36) NOT NULL COMMENT '发票编号',
  `type` char(1) DEFAULT NULL COMMENT '发票类型,1:增值税普票、2:增值税专票、3:收据',
  `customer_id` varchar(36) DEFAULT NULL COMMENT '所属客户id',
  `link_man_id` varchar(36) DEFAULT NULL COMMENT '所属联系人id',
  `title` varchar(50) DEFAULT NULL COMMENT '抬头',
  `title_type` char(1) DEFAULT NULL COMMENT '抬头类型（1:企业单位，2:个人/非企业单位)',
  `ticket_time` varchar(20) DEFAULT NULL COMMENT '财务开票时间',
  `tax_num` varchar(50) DEFAULT NULL COMMENT '税号',
  `content` varchar(50) DEFAULT NULL COMMENT '发票内容',
  `openning_bank` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL COMMENT '银行账号',
  `address` varchar(50) DEFAULT NULL COMMENT '地址',
  `mobile` varchar(50) DEFAULT NULL COMMENT '电话',
  `note` varchar(200) DEFAULT NULL COMMENT '备注说明',
  `par` double(10,2) DEFAULT '0.00' COMMENT '票面金额',
  `real_income` double(10,2) DEFAULT '0.00' COMMENT '实际收入',
  `org_amount` double(10,2) DEFAULT '0.00' COMMENT '修改前金额',
  `update_type` char(3) DEFAULT NULL COMMENT '修改金额方式 (1、折让，2、加价，3、劈单)',
  `reciever` varchar(50) DEFAULT NULL COMMENT '收件人',
  `reciever_mobile` varchar(50) DEFAULT NULL COMMENT '收件人联系电话',
  `reciever_area` varchar(50) DEFAULT NULL COMMENT '所在地区',
  `reciever_address` varchar(50) DEFAULT NULL COMMENT '收件人详细地址',
  `state` char(2) DEFAULT NULL COMMENT '发票状态：1、已开票，2、未开票，3、已寄出，4、作废，5、打回',
  `returned_money` double(10,2) DEFAULT '0.00' COMMENT '回款金额',
  `returned_state` char(1) DEFAULT '3' COMMENT '回款状态 1：已回款 2：部分回款 3：未回款',
  `returned_time` timestamp NULL DEFAULT NULL COMMENT '回款时间',
  `charge_offs_total` double(10,2) DEFAULT '0.00' COMMENT '已销账总金额',
  `order_type` char(1) DEFAULT NULL COMMENT '订单类型(1.订单发票,2.预付款发票)',
  `invoice_num` varchar(200) DEFAULT NULL COMMENT '发票号码',
  `audit_state` char(1) DEFAULT NULL COMMENT '发票审核状态 1待审核 2审核通过 3驳回',
  `audit_note` varchar(255) DEFAULT NULL COMMENT '打回原因',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `salesman` varchar(36) DEFAULT NULL COMMENT '销售',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '团队ID，这里不是临时团队是指线索负责人的所在的组织',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_user_name` varchar(36) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_edit_user_name` varchar(36) DEFAULT NULL COMMENT '最后修改人姓名',
  `deposit_card_id` varchar(36) DEFAULT NULL COMMENT '预存款id',
  `billing_type` char(1) DEFAULT NULL COMMENT '开票方式 1 固定金额开票 2 订单金额开票',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='发票信息表';

-- ----------------------------
--  Table structure for `t_crm_linkman`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_linkman`;
CREATE TABLE `t_crm_linkman` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '联系人姓名',
  `clue_id` varchar(36) DEFAULT NULL COMMENT '线索id（不为空时，为线索关联联系人，联系人管理里不显示）',
  `customer_id` varchar(36) DEFAULT NULL COMMENT '所属客户',
  `phone` varchar(20) DEFAULT NULL COMMENT '住宅',
  `office_tel` varchar(20) DEFAULT NULL COMMENT '工作',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机',
  `main_tel` varchar(20) DEFAULT NULL COMMENT '主要',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `other_tel` varchar(20) DEFAULT NULL COMMENT '其他',
  `dept_name` varchar(50) DEFAULT NULL COMMENT '联系人所属部门',
  `position` varchar(50) DEFAULT NULL COMMENT '职务',
  `position_level` varchar(10) DEFAULT NULL COMMENT '职务级别 1:高层、2:中层、3:基层',
  `standpoint` char(1) DEFAULT NULL COMMENT '联系人立场 1:支持我方、2:支持竞品、3:中立、4:不明',
  `decision_power` char(1) DEFAULT NULL COMMENT '决策力 1:关键决策人、2:分项决策人、3:上午决策人、4:技术决策人、5:财务决策人、6:使用人、7:意见影响人、8:普通人',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(20) DEFAULT NULL COMMENT 'QQ号码',
  `address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `addr_prov` varchar(100) DEFAULT NULL COMMENT '联系人地址-省',
  `addr_city` varchar(100) DEFAULT NULL COMMENT '联系人地址-市',
  `addr_area` varchar(100) DEFAULT NULL COMMENT '联系人地址-县区',
  `post_code` varchar(50) DEFAULT NULL COMMENT '邮编',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `calendar` char(1) DEFAULT NULL COMMENT '历法 1：公历 2：阳历',
  `birthday` varchar(20) DEFAULT NULL COMMENT '生日',
  `account_id` varchar(36) DEFAULT NULL COMMENT '翻译平台账号id',
  `accont_code` varchar(50) DEFAULT NULL COMMENT '翻译平台账户',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `linkman_create_user` varchar(36) DEFAULT NULL COMMENT '联系人创建人',
  `linkman_leader` varchar(36) DEFAULT NULL COMMENT '联系人负责人',
  `linkman_leader_name` varchar(50) DEFAULT NULL COMMENT '联系人负责人名',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '团队ID，这里不是临时团队是指线索负责人的所在的组织',
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态 1：未删除 ）：已删除',
  `linkman_state` char(1) NOT NULL DEFAULT '0' COMMENT '联系人状态 0：草稿 ,1:已生效,2:客户审核中，3：客户审批被打回',
  `create_user` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '记录创建人名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_user_name` varchar(50) DEFAULT NULL COMMENT '最后修改人名',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信',
  `customer_source` varchar(255) DEFAULT NULL COMMENT '客户来源（1：转介绍:2：自开拓:3：电话咨询:4：展会资源:5：邮件咨询:6：投标、7、线索、8：其他）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='联系人';

-- ----------------------------
--  Table structure for `t_crm_new_invoice`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_new_invoice`;
CREATE TABLE `t_crm_new_invoice` (
  `id` varchar(50) NOT NULL COMMENT 'id',
  `order_id` varchar(255) DEFAULT NULL,
  `invoice_money` double(10,2) DEFAULT NULL COMMENT '订单开票金额',
  `invoice_old_money` double(10,2) DEFAULT NULL COMMENT '修改前开票金额',
  `order_money` double(10,2) DEFAULT NULL COMMENT '订单应收',
  `order_old_money` double(10,2) DEFAULT NULL COMMENT '修改前订单应收',
  `invoice_state` varchar(10) DEFAULT NULL COMMENT '订单开票方式  1折让 2劈单 3加价 4折让并劈单 5加价并劈单',
  `remark` varchar(3000) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `p_order_no` varchar(50) DEFAULT NULL COMMENT '主订单编号',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `mode` varchar(2) DEFAULT NULL COMMENT '方式 1修改订单应收 2修改开票金额',
  `dis_id` varchar(255) DEFAULT NULL COMMENT '发票id',
  `state` varchar(255) DEFAULT NULL COMMENT '生效状态 默认1未生效 2已生效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_offer`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_offer`;
CREATE TABLE `t_crm_offer` (
  `id` char(36) NOT NULL,
  `ord_id` char(36) DEFAULT NULL COMMENT '口译订单id',
  `project_name` char(50) DEFAULT NULL COMMENT '项目',
  `day` int(11) DEFAULT NULL COMMENT '天数',
  `meet_field` char(50) DEFAULT NULL COMMENT '会议场次',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价（元）',
  `num` char(30) DEFAULT NULL COMMENT '数量',
  `total` double(10,2) DEFAULT NULL COMMENT '小计',
  `type` char(2) DEFAULT NULL COMMENT '费用类型：1：口译费用2：差旅费用3：设备费用',
  `start_date` datetime DEFAULT NULL COMMENT '起止时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` char(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` char(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译费用报价';

-- ----------------------------
--  Table structure for `t_crm_operation`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_operation`;
CREATE TABLE `t_crm_operation` (
  `id` varchar(36) NOT NULL,
  `correlation_id` varchar(36) NOT NULL COMMENT '关联ID 可以是线索，可以是合同、客户等等',
  `operator` varchar(36) DEFAULT NULL COMMENT '操作人',
  `operate_time` datetime DEFAULT NULL,
  `operate_desc` varchar(200) NOT NULL COMMENT '操作备注',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `create_user` varchar(36) DEFAULT NULL,
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除 0：已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_correlation` (`correlation_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作表';

-- ----------------------------
--  Table structure for `t_crm_opportunity`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_opportunity`;
CREATE TABLE `t_crm_opportunity` (
  `id` varchar(36) NOT NULL,
  `opportunity_name` varchar(100) DEFAULT NULL COMMENT '销售机会名称',
  `opportunity_no` varchar(20) NOT NULL COMMENT '销售机会编号',
  `customer_id` varchar(36) DEFAULT NULL COMMENT '客户ID',
  `customer_name` varchar(100) DEFAULT NULL COMMENT '客户名称（冗余）',
  `customer_dept_name` varchar(50) DEFAULT NULL COMMENT '客户所属部门',
  `linkman_id` varchar(500) DEFAULT NULL COMMENT '联系人（普通）(可多选)',
  `linkman_name` varchar(500) DEFAULT NULL COMMENT '联系人姓名（冗余）(可多选)',
  `opportunity_type` char(1) DEFAULT NULL COMMENT '机会类型 1：新客户机会、2：老客户新机会:3：老客户老机会',
  `opportunity_phase` char(1) DEFAULT NULL COMMENT '机会阶段\r\n1：0%-已丢失\r\n2：5%-线索-已获知\r\n3：25%-立项-已明确（建立产品报价）\r\n4：50%-认可-已合格（通过产品报价）\r\n5：75%-协议-已协议（合同）\r\n6：90%-实现-已下单\r\n7：100%-完成-已回款',
  `opportunity_phase_percent` varchar(4) DEFAULT NULL COMMENT '阶段百分比',
  `product_type` varchar(27) DEFAULT NULL COMMENT '产品类型(1:笔译、2:口译、3:母审、4:审读、5:审校、6：派驻、7：听译、8：译制、9：试译、10：编辑、11：采集、12：其他。可多选，用,隔开)',
  `opportunity_amount` varchar(20) DEFAULT NULL COMMENT '销售机会额度',
  `opportunity_desc` varchar(200) DEFAULT NULL COMMENT '销售机会描述',
  `opportunity_source` char(1) DEFAULT NULL COMMENT '销售机会来源',
  `opportunity_state` char(1) DEFAULT NULL COMMENT '销售机会状态 0:草稿 1：已生效',
  `opportunity_audit_state` char(1) DEFAULT '2' COMMENT '审核状态: 0-草稿;1-审核中;2-审核通过;3-审核不通过',
  `pro_cycle` char(1) DEFAULT NULL COMMENT '项目周期：1：一个月2：三个月3：半年4：一年5：一年以上',
  `contract_date_expected` date DEFAULT NULL COMMENT '预计签约日期',
  `bid_date` date DEFAULT NULL COMMENT '中标日期',
  `presales_counselor` varchar(50) DEFAULT NULL COMMENT '售前顾问',
  `win_rate` varchar(4) DEFAULT NULL COMMENT '赢率',
  `lost_reason` varchar(200) DEFAULT NULL COMMENT '输单原因',
  `opportunity_leader` varchar(36) DEFAULT NULL COMMENT '销售机会负责人',
  `opportunity_create_user` varchar(36) DEFAULT NULL COMMENT '销售机会创建人',
  `organ_id` varchar(36) DEFAULT NULL,
  `customer_type` char(1) DEFAULT NULL COMMENT '新老客户 1：新客户 2：老客户',
  `decision_user` varchar(36) DEFAULT NULL COMMENT '决策人',
  `del_state` varchar(1) NOT NULL DEFAULT '1',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_name` varchar(50) NOT NULL COMMENT '创建人名',
  `last_edit_user_name` varchar(50) NOT NULL COMMENT '最后修改人名',
  `opportunity_leader_name` varchar(50) DEFAULT NULL COMMENT '负责人名',
  `update_phase_time` timestamp NULL DEFAULT NULL COMMENT '进度更新时间',
  `opportunity_find_time` date DEFAULT NULL COMMENT '发现时间',
  `presales_consultant` varchar(50) DEFAULT '' COMMENT '售前顾问字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_opportunity_track`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_opportunity_track`;
CREATE TABLE `t_crm_opportunity_track` (
  `id` varchar(32) NOT NULL COMMENT '机会轨迹Id',
  `opportunity_id` varchar(36) NOT NULL COMMENT '机会Id',
  `track_desc` varchar(255) NOT NULL COMMENT '轨迹描述',
  `track_stage` char(1) NOT NULL COMMENT '轨迹阶段:1：0%-已丢失；2：5%-线索-已获知；3：25%-立项-已明确（建立产品报价）；4：50%-认可-已合格（通过产品报价）；5：75%-协议-已协议（合同）；6：90%-实现-已下单；7：100%-完成-已回款''',
  `track_create_time` date NOT NULL COMMENT '发现时间：精确到天',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销售机会轨迹记录表';

-- ----------------------------
--  Table structure for `t_crm_order_base`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_base`;
CREATE TABLE `t_crm_order_base` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `customer_id` varchar(36) DEFAULT NULL,
  `linkman_id` varchar(200) DEFAULT NULL,
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同',
  `product_group_id` varchar(36) DEFAULT NULL COMMENT '产品组',
  `work_group_id` varchar(36) DEFAULT NULL COMMENT '承接工作组ID',
  `work_group_name` varchar(50) DEFAULT NULL COMMENT '承接工作组名称',
  `order_type` char(1) DEFAULT NULL COMMENT '订单类型 2:文档3:口译',
  `appoint_returned_date` date DEFAULT NULL COMMENT '约定回款日期',
  `actual_returned_date` date DEFAULT NULL COMMENT '实际回款日期',
  `order_money` double(10,2) DEFAULT '0.00' COMMENT '订单总金额',
  `receivable_money` double(10,2) DEFAULT '0.00' COMMENT '订单应收金额',
  `open_money` double(10,2) DEFAULT NULL COMMENT '可开金额（未开票时和订单应收金额相同）',
  `charge_offs_type` char(1) DEFAULT NULL COMMENT '销账类型 1:财务销账 2：预存卡销账',
  `charge_offs_state` char(1) DEFAULT '3' COMMENT '销账状态1：已销账 2：部分销账 3：未销账',
  `charge_offs_money` double(10,2) DEFAULT '0.00' COMMENT '已销账金额',
  `charge_offs_time` datetime DEFAULT NULL COMMENT '销账时间',
  `deposit_card_id` varchar(36) DEFAULT NULL COMMENT '预存卡',
  `deposit_state` char(1) DEFAULT NULL COMMENT '预存款状态1:已开票 2：部分开票 3：未开票 ',
  `financial_state` char(1) DEFAULT NULL COMMENT '财务开发票状态1:已开票 2：部分开票 3：未开票 ',
  `invoice_state` char(1) DEFAULT NULL COMMENT '开票状态 1:已开票 2：部分开票 3：未开票 ',
  `deposit_money` double(10,2) DEFAULT '0.00' COMMENT '预存款金额',
  `financial_money` double(10,2) DEFAULT '0.00' COMMENT '财务开发票金额',
  `invoice_money` double(10,2) DEFAULT '0.00' COMMENT '开票金额',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `order_affirm_time` datetime DEFAULT NULL COMMENT '订单确认时间',
  `order_audit_state` char(1) DEFAULT NULL COMMENT '订单审核状态1;审核中 2：（审核通过）有效 3：（审核不通过）无效',
  `order_state` char(2) DEFAULT NULL COMMENT '订单状态 1:创建订单 2：审核中 3：待翻译 4：翻译中 5：问题订单 6：无法翻译 7：待确认 8：返稿 9：取消返稿 10：已完成 11：已关闭',
  `try_trans` char(1) DEFAULT '0' COMMENT '是否试译：1-试译订单 0-非试译',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '部门id',
  `organ_name` varchar(20) DEFAULT NULL COMMENT '销售部门名称',
  `del_state` char(1) DEFAULT '1' COMMENT '删除状态1：未删除 0：已删除',
  `order_create_user_id` varchar(36) DEFAULT NULL COMMENT '订单创建人ID',
  `order_create_user` varchar(20) DEFAULT NULL COMMENT '订单创建人名称',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '记录创建人ID',
  `create_user` varchar(36) DEFAULT NULL COMMENT '记录创建人名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user_id` varchar(36) DEFAULT NULL COMMENT '最后修改人ID',
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `freeze_money` double(10,2) DEFAULT '0.00' COMMENT '冻结金额（预存款销账）',
  `open_amount` double(10,2) DEFAULT NULL COMMENT '预存款可开金额',
  `residue_money` double(10,2) DEFAULT NULL COMMENT '预存款剩余金额',
  `order_complete_time` timestamp NULL DEFAULT NULL COMMENT '确认完成时间',
  `back_remark` varchar(256) DEFAULT NULL COMMENT '订单退回备注',
  `split_order` char(1) DEFAULT '0' COMMENT '劈单（用于财务销账）：0-正常；1-劈单未销账或销账中；2-劈单已销账',
  `channel` varchar(64) DEFAULT '0' COMMENT '下单渠道',
  `order_states` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销售订单基础表';

-- ----------------------------
--  Table structure for `t_crm_order_document`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_document`;
CREATE TABLE `t_crm_order_document` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) DEFAULT NULL COMMENT 't_crm_order_base主键',
  `manuscript_name` varchar(600) DEFAULT NULL COMMENT '稿件名称',
  `manuscript_field` varchar(10) DEFAULT NULL COMMENT '稿件领域',
  `manuscript_use` varchar(10) DEFAULT NULL COMMENT '稿件用途,字典',
  `deliver_format` char(1) DEFAULT NULL COMMENT '交付格式，1:段段对照 2：页页对照 3：纯译文',
  `submit_format` varchar(200) DEFAULT NULL COMMENT '提交格式,字典',
  `delivery_time` datetime DEFAULT NULL COMMENT '稿件交付时间',
  `contract_note` varchar(500) DEFAULT NULL COMMENT '合同备注，从合同中拉取，也可以自己填写',
  `sales_note` varchar(200) DEFAULT NULL COMMENT '销售备注',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ttt` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档下单';

-- ----------------------------
--  Table structure for `t_crm_order_document_extend`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_document_extend`;
CREATE TABLE `t_crm_order_document_extend` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `order_id` varchar(36) DEFAULT NULL,
  `childorder_no` varchar(36) DEFAULT NULL COMMENT '子订单编号，仅当扩展类型为产品时存在',
  `childorder_state` char(2) DEFAULT NULL COMMENT '子订单状态 同主订单状态',
  `extend_type` char(1) DEFAULT NULL COMMENT '扩展类型 1：产品明细 2：加价项目 3：差旅',
  `extend_id` varchar(36) DEFAULT NULL COMMENT '如果是产品，必填关联的产品id',
  `extend_content` varchar(50) DEFAULT NULL COMMENT '扩展内容 可以是产品 也可以是加价，也可以是口译订单的产品和差旅，填写从页面传来的值',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价',
  `sales_volume` char(32) DEFAULT NULL COMMENT '销售数量（字数）',
  `sales_volume_actual` char(32) DEFAULT NULL COMMENT '实际数量（PM更改）',
  `sales_volume_receivable` char(32) DEFAULT NULL COMMENT '应收字数（销售更改，不改的话和实际数量相同）',
  `total_momey_receivable` decimal(10,2) DEFAULT NULL COMMENT '应收总金额（针对于产品）',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `statistical_pattern` varchar(50) DEFAULT NULL COMMENT '统计方式',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_id_index` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档订单扩展产品表';

-- ----------------------------
--  Table structure for `t_crm_order_interpret`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_interpret`;
CREATE TABLE `t_crm_order_interpret` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `activity_name` varchar(50) DEFAULT NULL COMMENT '口译活动名称',
  `activity_address` varchar(100) DEFAULT NULL COMMENT '活动地址',
  `activity_time_quantum` varchar(100) DEFAULT NULL COMMENT '活动时间段',
  `conference_linkman` varchar(50) DEFAULT NULL COMMENT '会议联络人',
  `contact_way` varchar(50) DEFAULT NULL COMMENT '联系方式',
  `contract_note` varchar(500) DEFAULT NULL COMMENT '合同备注',
  `travel_payments_type` char(1) DEFAULT NULL COMMENT '差旅结算形式1：打包结算 2：实报实销',
  `sales_note` varchar(200) DEFAULT NULL COMMENT '销售备注',
  `del_state` char(1) DEFAULT '1' COMMENT '是否删除 1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `activityContact` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '活动联系人',
  `provideTime` varchar(255) DEFAULT NULL COMMENT '资料提供时间',
  `productTotalMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '翻译总额',
  `shorthandMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '速记总金额',
  `devTotalMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '设备金额',
  `travelTotalMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '差旅',
  `otherMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '其他总金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译订单表';

-- ----------------------------
--  Table structure for `t_crm_order_interpret_activity_cc`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_interpret_activity_cc`;
CREATE TABLE `t_crm_order_interpret_activity_cc` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `activity_date_id` varchar(36) DEFAULT NULL,
  `activity_cc` varchar(50) DEFAULT NULL COMMENT '活动场次',
  `activity_scale` varchar(10) DEFAULT NULL,
  `del_state` char(1) DEFAULT '1' COMMENT '是否删除1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动场次表';

-- ----------------------------
--  Table structure for `t_crm_order_interpret_activity_cc_extend`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_interpret_activity_cc_extend`;
CREATE TABLE `t_crm_order_interpret_activity_cc_extend` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `order_id` varchar(36) DEFAULT NULL,
  `activity_cc_id` varchar(36) DEFAULT NULL,
  `childorder_no` varchar(30) DEFAULT NULL COMMENT '子订单编号，仅当扩展类型为产品时存在',
  `extend_type` char(1) DEFAULT NULL COMMENT '扩展类型1：产品 3：设备  4：速记 5：其他',
  `extend_id` varchar(36) DEFAULT NULL,
  `extned_content` varchar(50) DEFAULT NULL COMMENT '扩展内容',
  `statistical_pattern` varchar(50) DEFAULT NULL COMMENT '统计方式',
  `unit_price` char(30) DEFAULT NULL,
  `people_number` char(30) DEFAULT NULL COMMENT '人数、设备台数',
  `sales_volume` char(30) DEFAULT NULL COMMENT '销售数量/天数/小时数',
  `del_state` char(1) DEFAULT NULL,
  `create_ueser` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sourceLanguageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `targetLanguageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `priceXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `personNumXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `salesVolumeXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `total` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `subtotal` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `deviceNumXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `settlementForm` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `daysNumXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `productTypes` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `unittwo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `unitone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `newTotal` varchar(255) DEFAULT NULL,
  `newSubtotal` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译订单场次扩展产品表';

-- ----------------------------
--  Table structure for `t_crm_order_interpret_activity_date`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_interpret_activity_date`;
CREATE TABLE `t_crm_order_interpret_activity_date` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `order_id` varchar(36) DEFAULT NULL COMMENT 't_crm_order_base表主键',
  `activity_time` varchar(255) DEFAULT NULL COMMENT '活动日期时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除状态 1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译订单活动日期表';

-- ----------------------------
--  Table structure for `t_crm_order_interpret_travel`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_interpret_travel`;
CREATE TABLE `t_crm_order_interpret_travel` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `order_id` varchar(36) DEFAULT NULL COMMENT '订单ID',
  `product_travel_id` varchar(36) DEFAULT NULL,
  `travel_name` varchar(50) DEFAULT NULL COMMENT '差旅名称',
  `unit_price` char(30) DEFAULT NULL,
  `person_num` int(6) DEFAULT NULL,
  `days_num` char(30) DEFAULT NULL,
  `del_state` char(1) DEFAULT NULL,
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `settlementForm` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `priceXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `personNumXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `daysNumXg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `subtotal` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `total` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `newTotal` varchar(255) DEFAULT NULL,
  `newSubtotal` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译订单差旅信息表';

-- ----------------------------
--  Table structure for `t_crm_order_invoice`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_invoice`;
CREATE TABLE `t_crm_order_invoice` (
  `id` varchar(36) NOT NULL,
  `correlation_id` varchar(36) DEFAULT NULL COMMENT '关联用户Id',
  `order_id` varchar(36) DEFAULT NULL,
  `invoice_id` varchar(36) DEFAULT NULL,
  `order_money` double(10,2) DEFAULT '0.00' COMMENT '对应订单部分或全部金额',
  `invoice_money` double(10,2) DEFAULT '0.00' COMMENT '票面金额',
  `charge_offs_money` double(10,2) DEFAULT '0.00' COMMENT '销账金额',
  `first_open_money` double(10,2) DEFAULT '0.00' COMMENT '开票前可开金额',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单-发票关系表';

-- ----------------------------
--  Table structure for `t_crm_order_performance`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_performance`;
CREATE TABLE `t_crm_order_performance` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `order_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名 对应t-sys_account accountcode',
  `leader_flag` char(1) DEFAULT NULL COMMENT '是否负责人 1：是 0：否',
  `performance_ratio` varchar(4) DEFAULT NULL COMMENT '绩效比率',
  `del_state` char(1) DEFAULT NULL COMMENT '是否删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单业绩分配表';

-- ----------------------------
--  Table structure for `t_crm_order_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_project`;
CREATE TABLE `t_crm_order_project` (
  `id` varchar(36) NOT NULL COMMENT '唯一标识',
  `p_id` varchar(36) DEFAULT NULL COMMENT '拆分子订单用父订单id',
  `p_order_no` varchar(36) DEFAULT NULL COMMENT '语向子订单用主订单id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单号',
  `pm` varchar(36) DEFAULT NULL COMMENT '处理组PM',
  `real_finish_time` datetime DEFAULT NULL COMMENT '实际交稿时间',
  `real_word_num` char(30) DEFAULT NULL COMMENT '实际字数',
  `remark` varchar(600) DEFAULT NULL COMMENT '备注',
  `real_income` decimal(10,2) DEFAULT NULL COMMENT '实际销售收入',
  `profit_margin` varchar(255) DEFAULT NULL COMMENT '利润率',
  `translator_id` varchar(36) DEFAULT NULL COMMENT '译员id',
  `translator_name` varchar(255) DEFAULT NULL COMMENT '译员姓名',
  `task_id` varchar(36) DEFAULT NULL COMMENT '译员任务id',
  `link_id` varchar(36) DEFAULT NULL COMMENT '文档翻译:环节id，口译（产品类型id）',
  `link_type` char(2) DEFAULT NULL COMMENT '文档翻译（link_type），口译（produce_type）',
  `job_type` char(1) DEFAULT NULL COMMENT '专职/兼职',
  `statistical_method` varchar(10) DEFAULT NULL COMMENT '译员统计方式',
  `price` char(30) DEFAULT NULL COMMENT '译员单价',
  `word_num` char(30) DEFAULT NULL COMMENT '译员处理字数',
  `cost` decimal(20,2) DEFAULT NULL COMMENT '翻译成本',
  `finish_on_time` char(1) DEFAULT NULL COMMENT '译员是否按时交稿',
  `translator_mobile` varchar(11) DEFAULT NULL COMMENT '译员手机号',
  `pay_cost` decimal(20,2) DEFAULT NULL COMMENT '已付译费',
  `pay_time` datetime DEFAULT NULL COMMENT '支付译员费用时间',
  `last_edit_time` timestamp NULL DEFAULT NULL COMMENT '订单最后更新时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，同步时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='从core库同步的订单项目信息表';

-- ----------------------------
--  Table structure for `t_crm_order_settlement`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_order_settlement`;
CREATE TABLE `t_crm_order_settlement` (
  `id` varchar(36) NOT NULL,
  `settlement_id` varchar(36) DEFAULT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `del_state` char(1) DEFAULT '1',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='结算单-订单关系表';

-- ----------------------------
--  Table structure for `t_crm_orderpricechange_records`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_orderpricechange_records`;
CREATE TABLE `t_crm_orderpricechange_records` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `order_id` varchar(36) DEFAULT NULL COMMENT 'crm 订单ID',
  `alteration_remarks` varchar(500) DEFAULT NULL COMMENT '变更备注',
  `orderMoney_brefore` double(10,2) DEFAULT NULL COMMENT '订单原金额',
  `orderMoney_change` double(10,2) DEFAULT NULL COMMENT '订单变更金额',
  `del_state` char(1) DEFAULT NULL COMMENT '删除状态 1:未删除 0：已删除',
  `commit_change_time` datetime DEFAULT NULL COMMENT '操作时间 提交修改的时间',
  `create_user` varchar(36) DEFAULT NULL COMMENT '记录创建人ID',
  `create_user_name` varchar(30) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_user_name` varchar(30) DEFAULT NULL COMMENT '记录修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录修改时间',
  `audi_status` char(1) DEFAULT '1' COMMENT '审批状态(1：审核中；2：审核通过；3：审核不通过)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单改价记录表';

-- ----------------------------
--  Table structure for `t_crm_pre_deposit`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_pre_deposit`;
CREATE TABLE `t_crm_pre_deposit` (
  `id` varchar(36) NOT NULL COMMENT '预存款id',
  `deposit_name` varchar(100) DEFAULT NULL COMMENT '预存款名称',
  `deposit_no` varchar(30) DEFAULT NULL COMMENT '预存款编号',
  `customer_id` varchar(36) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `deposit_amount` decimal(12,2) DEFAULT NULL COMMENT '预存金额',
  `consume_amount` decimal(12,2) DEFAULT NULL COMMENT '消费金额',
  `residue_amount` decimal(12,2) DEFAULT NULL COMMENT '剩余金额',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同id',
  `contract_name` varchar(100) DEFAULT NULL COMMENT '合同名称',
  `opportunity_id` varchar(36) DEFAULT NULL COMMENT '商机Id',
  `opportunity_name` varchar(64) DEFAULT NULL COMMENT '商机名称',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '团队',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建用户id',
  `create_user_name` varchar(100) DEFAULT NULL COMMENT '创建用户名称',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `deposit_leader` varchar(36) DEFAULT NULL COMMENT '负责人id',
  `deposit_leader_name` varchar(100) DEFAULT NULL COMMENT '负责人名称',
  `update_user` varchar(36) DEFAULT NULL COMMENT '更新用户id',
  `update_user_name` varchar(100) DEFAULT NULL COMMENT '更新用户名称',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `dept_name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `deposit_state` char(1) DEFAULT NULL COMMENT '状态 0 草稿 1 已生效 2审核中 3 审核不通过',
  `del_state` char(1) DEFAULT NULL COMMENT '删除状态 0 已删除 1未删除',
  `deposit_source` char(1) DEFAULT NULL COMMENT '来源',
  `receive_state` char(1) DEFAULT NULL COMMENT '回款状态 0 未回款 1 部分回款 2 全部回款',
  `receive_money` decimal(12,2) DEFAULT NULL COMMENT '回款金额',
  `receive_time` timestamp NULL DEFAULT NULL COMMENT '回款时间',
  `freeze_money` decimal(12,2) DEFAULT NULL COMMENT '冻结金额',
  `available_amount` decimal(12,2) DEFAULT NULL COMMENT '可用金额',
  `open_amount` decimal(12,2) DEFAULT NULL COMMENT '可开金额',
  `invoice_type` char(1) DEFAULT '1' COMMENT '开票类型 1 固定金额开票 2 订单金额开票',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='预存卡管理表';

-- ----------------------------
--  Table structure for `t_crm_pre_deposit_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_pre_deposit_order`;
CREATE TABLE `t_crm_pre_deposit_order` (
  `id` varchar(36) NOT NULL COMMENT '唯一标识',
  `deposit_id` varchar(36) NOT NULL COMMENT '预存款id',
  `order_id` varchar(36) NOT NULL COMMENT '订单id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单号',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同id',
  `contract_name` varchar(100) DEFAULT NULL COMMENT '合同名称',
  `used_money` double(12,2) DEFAULT NULL COMMENT '订单消费金额',
  `residue_money` double(12,2) DEFAULT NULL COMMENT '预存款剩余金额',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建用户id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单消费预存卡金额记录表';

-- ----------------------------
--  Table structure for `t_crm_procuct_record_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_procuct_record_info`;
CREATE TABLE `t_crm_procuct_record_info` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `contractId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同id',
  `contractName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同名称',
  `customerName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '客户名称',
  `adviser` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '售前顾问',
  `personCharge` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '负责人',
  `contacts` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '联系人',
  `saleOpportunity` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '销售机会',
  `contractType` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同类型',
  `relatedProducts` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '关联产品',
  `signatory` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '签约人',
  `contractSignatory` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同签约人',
  `contractDescribe` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同简述',
  `promise` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '特殊承诺',
  `contractNum` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同金额',
  `contractState` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同状态',
  `signDay` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '签约日期',
  `expirationTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '到期时间',
  `collectionState` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '回款方式',
  `paymentState` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '付款方式',
  `collectionTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '回款日期',
  `delState` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '删除标志',
  `iden` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '标识（保存任务id）',
  `onId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '新数据旧数据标识',
  `types` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '笔口译区分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_procuct_record_info_t`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_procuct_record_info_t`;
CREATE TABLE `t_crm_procuct_record_info_t` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `contractId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '合同id',
  `productId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '产品id',
  `productName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称（笔译）',
  `level` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '级别（笔译）',
  `settlementForm` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '结算形式',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '费用类目',
  `unitone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '单位一',
  `unittwo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '单位二',
  `sourceLanguageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '源语言',
  `targetLanguageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '目标语言',
  `productType` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '口译类型：1：交传 2：同传 3：陪同 4：派驻',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '统计方式',
  `productUnitPrice` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '标准单价',
  `personNum` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '人数',
  `daysNum` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '时长',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `productDeviceName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '设备：中央控制器、红外发射机、红外辐射板、译员机、译员耳机、线材配件、翻译间、接收机及耳机、红外辐射板、翻译间+译员机、同传设备运输费、其他（可自定义输入）',
  `trvaelCost` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '差旅项目',
  `attaName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '附件名称（文件）',
  `attaSize` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '大小（文件）',
  `attaAuth` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '上传人（文件）',
  `attaTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '上传时间（文件）',
  `delState` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '删除标志',
  `iden` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '标识（保存任务id）',
  `onId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_product_device_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_device_info`;
CREATE TABLE `t_crm_product_device_info` (
  `id` varchar(36) NOT NULL,
  `product_group_id` varchar(36) NOT NULL,
  `product_device_name` varchar(20) DEFAULT NULL COMMENT '设备：中央控制器、红外发射机、红外辐射板、译员机、译员耳机、线材配件、翻译间、接收机及耳机、红外辐射板、翻译间+译员机、同传设备运输费、其他（可自定义输入）',
  `device_name_other` varchar(20) DEFAULT NULL COMMENT '设备选择其他时自定义内容',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价：单位 台/天',
  `device_num` char(30) DEFAULT NULL COMMENT '设备数量',
  `person_num` char(30) DEFAULT NULL COMMENT '天数',
  `remarks` varchar(600) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) NOT NULL DEFAULT '1',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品设备表';

-- ----------------------------
--  Table structure for `t_crm_product_group`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_group`;
CREATE TABLE `t_crm_product_group` (
  `id` varchar(36) NOT NULL,
  `opportunity_id` varchar(36) NOT NULL COMMENT '销售机会Id',
  `product_type` char(2) NOT NULL COMMENT '产品组类型 1：笔译 2：口译 3：母审 4：审读 5：审校 6：听译 7：译制 8：试译 9：编辑 10：采集',
  `product_group_name` varchar(50) NOT NULL COMMENT '产品组名称',
  `product_group_state` char(1) DEFAULT NULL,
  `product_group_audit_state` char(1) NOT NULL COMMENT '产品组审核状态 0：草稿 1：审核中 2：（审核通过）有效 3：（审核不通过）无效',
  `product_group_leader` varchar(36) NOT NULL COMMENT '产品组负责人',
  `travel_payments_type` char(1) DEFAULT NULL COMMENT '差旅报销方式',
  `travel_notes` varchar(350) DEFAULT NULL,
  `organ_id` varchar(36) DEFAULT NULL,
  `del_state` varchar(50) NOT NULL COMMENT '删除状态1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `presales_consultant` varchar(50) DEFAULT '' COMMENT '售前顾问',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品组表';

-- ----------------------------
--  Table structure for `t_crm_product_interpretation_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_interpretation_info`;
CREATE TABLE `t_crm_product_interpretation_info` (
  `id` varchar(36) NOT NULL,
  `prodoct_group_id` varchar(36) NOT NULL,
  `source_language_name` varchar(50) DEFAULT NULL COMMENT '源语言',
  `target_language_name` varchar(50) DEFAULT NULL COMMENT '目标语言',
  `source_language_value` varchar(20) DEFAULT NULL,
  `target_language_value` varchar(20) DEFAULT NULL,
  `product_type` char(1) DEFAULT NULL COMMENT '口译类型：1：交传 2：同传 3：陪同',
  `product_unit_price` char(30) DEFAULT NULL COMMENT '标准单价',
  `product_statistics_pattern` varchar(50) DEFAULT NULL COMMENT '统计方式： 1：人/小时 2：人/天',
  `person_num` int(10) DEFAULT NULL COMMENT '人数',
  `sales_volume` char(30) DEFAULT NULL COMMENT '销售数量 单位和统计方式关联，统计方式是人/天 ，单位则是天；统计方式是人/小时，单位则文小时',
  `remarks` varchar(600) DEFAULT NULL,
  `product_state` char(1) DEFAULT NULL,
  `del_state` char(1) DEFAULT NULL,
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='口译产品信息表';

-- ----------------------------
--  Table structure for `t_crm_product_interpretation_info_t`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_interpretation_info_t`;
CREATE TABLE `t_crm_product_interpretation_info_t` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `translationTimeLong` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '时长',
  `sourceLanguageNameQt` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `targetLanguageNameQt` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `interId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sort` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_product_method_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_method_info`;
CREATE TABLE `t_crm_product_method_info` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `productId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '费用id',
  `method` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '统计方式',
  `trvaelCost` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '差旅费用',
  `sort` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_product_other_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_other_info`;
CREATE TABLE `t_crm_product_other_info` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '费用名称',
  `method` varchar(36) DEFAULT NULL COMMENT '统计方式',
  `productGroupId` varchar(255) DEFAULT NULL COMMENT '报价组id',
  `unitPrice` char(30) DEFAULT NULL COMMENT '单价',
  `remarks` varchar(600) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `unitone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '单位一',
  `unittwo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '单位二',
  `delState` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `createUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `lastEditUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `lastEditTime` datetime DEFAULT NULL,
  `sort` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='口译其他费用';

-- ----------------------------
--  Table structure for `t_crm_product_shorthand_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_shorthand_info`;
CREATE TABLE `t_crm_product_shorthand_info` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '主键',
  `language` varchar(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '语言',
  `method` varchar(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '统计方式',
  `productGroupId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '报价组id',
  `unitPrice` char(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '单价',
  `personNum` char(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '人数',
  `daysNum` char(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '天数',
  `delState` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `createUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `lastEditUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `lastEditTime` datetime DEFAULT NULL,
  `remarks` varchar(600) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `sort` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '排序',
  `sourceLanguageNameQt` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `targetLanguageNameQt` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='口译速记表';

-- ----------------------------
--  Table structure for `t_crm_product_translation_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_translation_info`;
CREATE TABLE `t_crm_product_translation_info` (
  `id` varchar(36) NOT NULL,
  `product_group_id` varchar(36) NOT NULL,
  `source_language_name` varchar(50) DEFAULT NULL COMMENT '源语言',
  `target_language_name` varchar(50) DEFAULT NULL,
  `target_language_value` varchar(20) DEFAULT NULL,
  `source_language_value` varchar(20) DEFAULT NULL,
  `product_level` varchar(1) DEFAULT NULL COMMENT '1:标准、2:专业、3:母语、4:专家',
  `product_statistical_pattern` varchar(50) DEFAULT NULL COMMENT '不同产品类型对应不同的统计方式。 笔译、母审、审读、审校、试译、编辑对应统计方式为字符数不计空格、非中文单词、份； 听译对应统计方式为分钟、份； 译制对应统计方式为分钟、小时、份； 采集对应统计方式为条、篇、份',
  `product_unit_price` char(30) DEFAULT NULL COMMENT '标准单价',
  `product_sales_volume` varchar(20) DEFAULT NULL COMMENT '产品销售数量',
  `repetitive_fee` varchar(30) DEFAULT NULL COMMENT '重复率计费',
  `remarks` varchar(600) DEFAULT NULL COMMENT '备注',
  `product_state` char(1) DEFAULT NULL COMMENT '产品状态',
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='笔译产品信息表';

-- ----------------------------
--  Table structure for `t_crm_product_travel_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_product_travel_info`;
CREATE TABLE `t_crm_product_travel_info` (
  `id` varchar(36) NOT NULL,
  `product_group_id` varchar(36) NOT NULL,
  `travel_name` varchar(50) DEFAULT NULL COMMENT '差旅项目名称：0~15字符',
  `unit_price` char(30) DEFAULT NULL COMMENT '单价 单位是 元/人/天',
  `person_num` char(30) DEFAULT NULL COMMENT '人数',
  `days_num` char(30) DEFAULT NULL COMMENT '天数',
  `del_state` char(1) NOT NULL,
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='差旅产品信息';

-- ----------------------------
--  Table structure for `t_crm_refund_period`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_refund_period`;
CREATE TABLE `t_crm_refund_period` (
  `id` varchar(36) NOT NULL COMMENT '回款期次id',
  `refund_id` varchar(36) DEFAULT NULL COMMENT '回款id',
  `plan_refund_money` double(10,2) DEFAULT NULL COMMENT '计划回款金额',
  `plan_refund_date` datetime DEFAULT NULL COMMENT '计划回款日期',
  `refund_period_sort` varchar(3) DEFAULT NULL COMMENT '回款期次排序',
  `del_state` char(1) DEFAULT NULL COMMENT '''删除标志：1、未删除，0、已删除''',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='回款期次表';

-- ----------------------------
--  Table structure for `t_crm_refund_plan`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_refund_plan`;
CREATE TABLE `t_crm_refund_plan` (
  `id` varchar(36) NOT NULL COMMENT '回款计划id',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同id',
  `customer_id` varchar(36) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `contract_name` varchar(50) DEFAULT NULL COMMENT '合同名称',
  `contract_no` varchar(30) DEFAULT NULL COMMENT '合同编号',
  `refund_no` varchar(30) DEFAULT NULL COMMENT '回款编号',
  `prestore_flag` char(1) DEFAULT NULL COMMENT '是否预存：0.否；1.是',
  `refund_period` varchar(5) DEFAULT NULL COMMENT '回款期次',
  `plan_refund_total_money` double(10,2) DEFAULT NULL COMMENT '计划回款总金额',
  `final_statement` varchar(50) DEFAULT NULL COMMENT '关联结算单',
  `refund_leader_name` varchar(50) DEFAULT NULL COMMENT '回款负责人姓名',
  `refund_leader` varchar(36) DEFAULT NULL COMMENT '回款负责人',
  `refund_state` char(1) DEFAULT NULL COMMENT '回款状态：0：草稿、 1：已生效；',
  `organ_id` varchar(36) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_state` varchar(255) DEFAULT '' COMMENT '''删除标志：1、未删除，0、已删除''',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_edit_user_name` varchar(50) DEFAULT NULL COMMENT '修改者姓名',
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '修改人',
  `last_edit_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='回款计划表';

-- ----------------------------
--  Table structure for `t_crm_return_deposit`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_return_deposit`;
CREATE TABLE `t_crm_return_deposit` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `depositNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '预存款编号',
  `returnMoney` double(10,2) DEFAULT NULL COMMENT '本次回款金额',
  `returnTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '本次回款时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_return_invoice`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_return_invoice`;
CREATE TABLE `t_crm_return_invoice` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `invoiceNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '发票编号',
  `returnMoney` double(10,2) DEFAULT NULL COMMENT '本次发票回款金额',
  `returnTime` varchar(255) DEFAULT NULL COMMENT '本次发票回款时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_crm_sales_competitors`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_sales_competitors`;
CREATE TABLE `t_crm_sales_competitors` (
  `id` varchar(36) NOT NULL,
  `correlation_id` varchar(36) NOT NULL COMMENT '关联id可以是多类Id',
  `competitor` varchar(100) NOT NULL COMMENT '竞争对手名称',
  `linkman` varchar(50) DEFAULT NULL COMMENT '联系人',
  `contact` varchar(100) DEFAULT NULL COMMENT '联系方式',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '记录创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_correlation` (`correlation_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销售客户竞争对手表';

-- ----------------------------
--  Table structure for `t_crm_settlement_sheet`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_settlement_sheet`;
CREATE TABLE `t_crm_settlement_sheet` (
  `id` varchar(36) NOT NULL,
  `code` varchar(50) DEFAULT NULL COMMENT '单号',
  `customer_id` varchar(50) DEFAULT NULL COMMENT '客户id',
  `link_man` varchar(50) DEFAULT NULL COMMENT '联系人',
  `amount` double(10,2) DEFAULT NULL COMMENT '结算单金额',
  `pay_type` char(3) DEFAULT NULL COMMENT '付款方式',
  `pay_state` char(3) DEFAULT NULL COMMENT '付款状态:1、未付款，2、已付款，3、结算关闭',
  `pay_date` datetime DEFAULT NULL COMMENT '付款时间',
  `note` text COMMENT '备注',
  `owner` varchar(36) DEFAULT NULL COMMENT '所有人',
  `owner_date` datetime DEFAULT NULL COMMENT '领取时间',
  `del_state` char(1) DEFAULT '1' COMMENT '删除标志：1、未删除，0、已删除',
  `organ_id` varchar(36) DEFAULT NULL COMMENT '团队ID，这里不是临时团队是指线索负责人的所在的组织',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_user_name` varchar(36) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL COMMENT '最后修改人',
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_edit_user_name` varchar(36) DEFAULT NULL COMMENT '最后修改人姓名',
  `customer_company` varchar(200) DEFAULT NULL COMMENT '公司名称（客户）',
  `m_company` varchar(200) DEFAULT NULL COMMENT '公司名称（我方）',
  `customer_contact` varchar(100) DEFAULT NULL COMMENT '联系人（客户）',
  `m_contact` varchar(100) DEFAULT NULL COMMENT '联系人（我方）',
  `customer_tel` varchar(20) DEFAULT NULL COMMENT '电话（客户）',
  `m_tel` varchar(20) DEFAULT NULL COMMENT '电话（我方）',
  `customer_email` varchar(200) DEFAULT NULL COMMENT '邮箱（客户）',
  `m_email` varchar(200) DEFAULT NULL COMMENT '邮箱（我方）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='结算单表';

-- ----------------------------
--  Table structure for `t_crm_team`
-- ----------------------------
DROP TABLE IF EXISTS `t_crm_team`;
CREATE TABLE `t_crm_team` (
  `id` varchar(36) NOT NULL,
  `team_member_id` varchar(36) NOT NULL COMMENT '团队成员ID',
  `team_member_name` varchar(30) DEFAULT NULL COMMENT '团队成员名称',
  `team_member_type` char(1) NOT NULL COMMENT '团队成员类型 1：负责人 2：普通成员 3：助理；4:售前顾问',
  `correlation_id` varchar(36) NOT NULL COMMENT '关联ID 可以是客户、可以是合同、可以是销售机会的主键',
  `team_type` char(1) DEFAULT NULL COMMENT '团队类型 1：客户 2：合同 3：销售机会',
  `del_state` char(1) NOT NULL DEFAULT '1' COMMENT '删除状态 1：未删除 0：已删除',
  `create_user` varchar(36) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_user` varchar(36) DEFAULT NULL,
  `last_edit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role_name` varchar(50) DEFAULT NULL COMMENT '帐号角色名称',
  `general_jurisdiction` char(1) NOT NULL DEFAULT '1' COMMENT '普通成员操作权限：1：查看 2：编辑',
  `team_member_label` varchar(5) DEFAULT NULL COMMENT '团队成员标签：',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_member_type` (`team_member_id`,`team_type`,`del_state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='临时团队表';

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
--  Table structure for `usable_corpus`
-- ----------------------------
DROP TABLE IF EXISTS `usable_corpus`;
CREATE TABLE `usable_corpus` (
  `id` varchar(36) NOT NULL,
  `raw_corpus_name` varchar(300) NOT NULL COMMENT '语料库名称',
  `source_language` varchar(100) NOT NULL COMMENT '源语言',
  `source_language_name` varchar(100) NOT NULL COMMENT '源语言',
  `target_language` char(100) NOT NULL COMMENT '目标语言',
  `target_language_name` char(100) NOT NULL COMMENT '目标语言',
  `customer_id` varchar(50) DEFAULT NULL COMMENT '客户ID',
  `customer_name` varchar(200) DEFAULT NULL COMMENT '客户名称',
  `order_no` varchar(20) DEFAULT NULL COMMENT '订单编号',
  `domain` varchar(200) DEFAULT NULL COMMENT '领域',
  `type` int(1) NOT NULL COMMENT '所属类目 1-记忆库 2-术语库',
  `del_state` int(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除0：已删除',
  `usable_state` int(1) NOT NULL DEFAULT '1' COMMENT '启用状态1：启用 0：禁用',
  `remark` varchar(1000) DEFAULT NULL COMMENT '描述',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` varchar(36) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_raw_corpus` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户熟语料基本信息表';

-- ----------------------------
--  Table structure for `usable_corpus_sentence`
-- ----------------------------
DROP TABLE IF EXISTS `usable_corpus_sentence`;
CREATE TABLE `usable_corpus_sentence` (
  `id` varchar(36) NOT NULL,
  `raw_corpus_id` varchar(36) NOT NULL COMMENT '熟语料库id',
  `seq_num` int(5) NOT NULL COMMENT '序号',
  `source_text` varchar(10000) NOT NULL COMMENT '原文',
  `target_text` varchar(10000) NOT NULL COMMENT '译文',
  `del_state` int(1) NOT NULL DEFAULT '1' COMMENT '删除状态1：未删除0：已删除',
  `create_user` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` varchar(36) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_raw_corpus_sentence` (`raw_corpus_id`) USING BTREE,
  KEY `idx_id_raw_corpus_id` (`id`,`raw_corpus_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户熟语料句对信息表';

-- ----------------------------
--  Procedure structure for `editInterpretOrderState`
-- ----------------------------
DROP PROCEDURE IF EXISTS `editInterpretOrderState`;
delimiter ;;
CREATE DEFINER=`atp`@`%` PROCEDURE `editInterpretOrderState`()
BEGIN
UPDATE t_crm_order_base b LEFT JOIN t_crm_order_interpret i ON b.id=i.order_id SET b.order_state = '4' 
WHERE DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i') BETWEEN LEFT(activity_time_quantum, 16) AND RIGHT(activity_time_quantum,16) AND b.order_audit_state='2';
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `editInterpretOrderState2`
-- ----------------------------
DROP PROCEDURE IF EXISTS `editInterpretOrderState2`;
delimiter ;;
CREATE DEFINER=`atp`@`%` PROCEDURE `editInterpretOrderState2`()
BEGIN
UPDATE t_crm_order_base b LEFT JOIN t_crm_order_interpret i ON b.id=i.order_id SET b.order_state = '7' 
WHERE DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i')> RIGHT(activity_time_quantum,16) AND b.order_state = '4';
END
 ;;
delimiter ;

-- ----------------------------
--  Event structure for `run_test`
-- ----------------------------
DROP EVENT IF EXISTS `run_test`;
delimiter ;;
CREATE DEFINER=`atp`@`%` EVENT `run_test` ON SCHEDULE EVERY 1 MINUTE STARTS '2022-06-07 10:36:06' ON COMPLETION PRESERVE ENABLE DO call test()
 ;;
delimiter ;

-- ----------------------------
--  Event structure for `edit_orderstate_event`
-- ----------------------------
DROP EVENT IF EXISTS `edit_orderstate_event`;
delimiter ;;
CREATE DEFINER=`atp`@`%` EVENT `edit_orderstate_event` ON SCHEDULE EVERY 3 MINUTE STARTS '2019-01-24 21:18:04' ON COMPLETION PRESERVE ENABLE DO CALL editInterpretOrderState()
 ;;
delimiter ;

-- ----------------------------
--  Event structure for `edit_orderstate_event2`
-- ----------------------------
DROP EVENT IF EXISTS `edit_orderstate_event2`;
delimiter ;;
CREATE DEFINER=`atp`@`%` EVENT `edit_orderstate_event2` ON SCHEDULE EVERY 3 MINUTE STARTS '2019-01-24 21:18:04' ON COMPLETION PRESERVE ENABLE DO CALL editInterpretOrderState2()
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
