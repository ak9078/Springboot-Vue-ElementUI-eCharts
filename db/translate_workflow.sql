/*
 Navicat Premium Data Transfer

 Source Server         : zhongWFY测试
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 180.76.190.170
 Source Database       : translate_workflow

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : utf-8

 Date: 06/29/2022 23:29:06 PM
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

SET FOREIGN_KEY_CHECKS = 1;
