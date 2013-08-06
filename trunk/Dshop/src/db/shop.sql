/*
Navicat MySQL Data Transfer

Source Server         : 54.250.177.126
Source Server Version : 50532
Source Host           : 54.250.177.126:3306
Source Database       : shop

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2013-08-06 19:45:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bankcard`
-- ----------------------------
DROP TABLE IF EXISTS `bankcard`;
CREATE TABLE `bankcard` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `note` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bankcard
-- ----------------------------

-- ----------------------------
-- Table structure for `barcode`
-- ----------------------------
DROP TABLE IF EXISTS `barcode`;
CREATE TABLE `barcode` (
  `GoodsName` varchar(30) NOT NULL COMMENT '产品名称',
  `BarCode` varchar(13) NOT NULL COMMENT '条形码',
  `Unit` varchar(4) NOT NULL COMMENT '计量单位',
  PRIMARY KEY (`BarCode`),
  KEY `BarCode` (`BarCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barcode
-- ----------------------------

-- ----------------------------
-- Table structure for `feeder`
-- ----------------------------
DROP TABLE IF EXISTS `feeder`;
CREATE TABLE `feeder` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `FeederID` varchar(4) DEFAULT NULL COMMENT '供应商编号',
  `FeederName` varchar(40) DEFAULT NULL COMMENT '供应商姓名',
  `LinkMan` varchar(12) DEFAULT NULL COMMENT '联系人',
  `Address` varchar(40) DEFAULT NULL COMMENT '地址',
  `Zipcode` varchar(6) DEFAULT NULL COMMENT '邮编',
  `Tel` varchar(15) DEFAULT NULL COMMENT '电话',
  `Fax` varchar(15) DEFAULT NULL COMMENT '传真',
  PRIMARY KEY (`ID`),
  KEY `FeederID` (`FeederID`),
  KEY `ID` (`ID`),
  KEY `Zipcode` (`Zipcode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of feeder
-- ----------------------------
INSERT INTO `feeder` VALUES ('1', '1', '11', '1', '1', '1', '1', '1');
INSERT INTO `feeder` VALUES ('2', '1', '222', '1', '1', '1', '1', '1');
INSERT INTO `feeder` VALUES ('3', '1', '333', '1', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for `kjfl`
-- ----------------------------
DROP TABLE IF EXISTS `kjfl`;
CREATE TABLE `kjfl` (
  `编号` varchar(32) CHARACTER SET utf8 NOT NULL,
  `科目代码` varchar(8) CHARACTER SET utf8 NOT NULL,
  `科目名称` varchar(100) CHARACTER SET utf8 NOT NULL,
  `借贷方向` varchar(1) CHARACTER SET utf8 NOT NULL,
  `日期` datetime NOT NULL,
  `凭证编号` varchar(32) CHARACTER SET utf8 NOT NULL,
  `金额` double NOT NULL,
  `经办人` varchar(8) CHARACTER SET utf8 NOT NULL,
  `备注` varchar(1000) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`编号`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of kjfl
-- ----------------------------

-- ----------------------------
-- Table structure for `km`
-- ----------------------------
DROP TABLE IF EXISTS `km`;
CREATE TABLE `km` (
  `顺序号` int(11) NOT NULL,
  `科目分类` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '科目分类',
  `科目代码` varchar(8) CHARACTER SET utf8 NOT NULL COMMENT '科目代码',
  `科目名称` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '科目名称',
  `父科目代码` varchar(8) CHARACTER SET utf8 NOT NULL COMMENT '父科目代码',
  `备注` varchar(1000) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`科目代码`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of km
-- ----------------------------
INSERT INTO `km` VALUES ('1', '资产类', '1001', '库存现金', '', '在用');
INSERT INTO `km` VALUES ('2', '资产类', '1002', '银行存款', '', '在用');
INSERT INTO `km` VALUES ('5', '资产类', '1015', '其他货币资金', '', null);
INSERT INTO `km` VALUES ('8', '资产类', '1101', '交易性金融资产', '', null);
INSERT INTO `km` VALUES ('10', '资产类', '1121', '应收票据', '', '在用');
INSERT INTO `km` VALUES ('11', '资产类', '1122', '应收账款', '', '在用');
INSERT INTO `km` VALUES ('12', '资产类', '1123', '预付账款', '', '在用');
INSERT INTO `km` VALUES ('13', '资产类', '1131', '应收股利', '', null);
INSERT INTO `km` VALUES ('14', '资产类', '1132', '应收利息', '', null);
INSERT INTO `km` VALUES ('18', '资产类', '1221', '其他应收款', '', null);
INSERT INTO `km` VALUES ('19', '资产类', '1231', '坏账准备', '', null);
INSERT INTO `km` VALUES ('26', '资产类', '1401', '材料采购', '', null);
INSERT INTO `km` VALUES ('27', '负债类', '1402', '在途物资', '', '在用');
INSERT INTO `km` VALUES ('28', '资产类', '1403', '原材料', '', null);
INSERT INTO `km` VALUES ('29', '资产类', '1404', '材料成本差异', '', null);
INSERT INTO `km` VALUES ('30', '资产类', '1405', '库存商品', '', '在用');
INSERT INTO `km` VALUES ('31', '资产类', '1406', '发出商品', '', '在用');
INSERT INTO `km` VALUES ('32', '资产类', '1407', '商品进销差价', '', null);
INSERT INTO `km` VALUES ('33', '资产类', '1408', '委托加工物资', '', null);
INSERT INTO `km` VALUES ('34', '资产类', '1411', '周转材料', '', null);
INSERT INTO `km` VALUES ('40', '资产类', '1471', '存货跌价准备', '', '在用');
INSERT INTO `km` VALUES ('41', '资产类', '1501', '持有至到期投资', '', null);
INSERT INTO `km` VALUES ('42', '资产类', '1502', '持有至到期投资减值准备', '', null);
INSERT INTO `km` VALUES ('43', '资产类', '1503', '可供出售金融资产', '', null);
INSERT INTO `km` VALUES ('44', '资产类', '1511', '长期股权投资', '', null);
INSERT INTO `km` VALUES ('45', '资产类', '1512', '长期股权投资减值准备', '', null);
INSERT INTO `km` VALUES ('46', '资产类', '1521', '投资性房地产', '', null);
INSERT INTO `km` VALUES ('47', '资产类', '1531', '长期应收款', '', null);
INSERT INTO `km` VALUES ('48', '资产类', '1532', '未实现融资收益', '', null);
INSERT INTO `km` VALUES ('50', '资产类', '1601', '固定资产', '', '在用');
INSERT INTO `km` VALUES ('51', '资产类', '1602', '累计折旧', '', null);
INSERT INTO `km` VALUES ('52', '资产类', '1603', '固定资产减值准备', '', '在用');
INSERT INTO `km` VALUES ('53', '资产类', '1604', '在建工程', '', null);
INSERT INTO `km` VALUES ('54', '资产类', '1605', '工程物资', '', null);
INSERT INTO `km` VALUES ('55', '资产类', '1606', '固定资产清理', '', '在用');
INSERT INTO `km` VALUES ('62', '资产类', '1701', '无形资产', '', null);
INSERT INTO `km` VALUES ('63', '资产类', '1702', '累计摊销', '', null);
INSERT INTO `km` VALUES ('64', '资产类', '1703', '无形资产减值准备', '', null);
INSERT INTO `km` VALUES ('65', '资产类', '1711', '商誉', '', null);
INSERT INTO `km` VALUES ('66', '资产类', '1801', '长期待摊费用', '', null);
INSERT INTO `km` VALUES ('67', '资产类', '1811', '递延所得税资产', '', null);
INSERT INTO `km` VALUES ('69', '资产类', '1901', '待处理财产损溢', '', null);
INSERT INTO `km` VALUES ('70', '负债类', '2001', '短期借款', '', null);
INSERT INTO `km` VALUES ('77', '负债类', '2101', '交易性金融负债', '', null);
INSERT INTO `km` VALUES ('79', '负债类', '2201', '应付票据', '', '在用');
INSERT INTO `km` VALUES ('80', '负债类', '2202', '应付账款', '', '在用');
INSERT INTO `km` VALUES ('81', '负债类', '2203', '预收账款', '', '在用');
INSERT INTO `km` VALUES ('82', '负债类', '2211', '应付职工薪酬', '', '在用');
INSERT INTO `km` VALUES ('83', '负债类', '2221', '应交税费', '', null);
INSERT INTO `km` VALUES ('84', '负债类', '2231', '应付利息', '', null);
INSERT INTO `km` VALUES ('85', '负债类', '2232', '应付股利', '', null);
INSERT INTO `km` VALUES ('86', '负债类', '2241', '其他应付款', '', null);
INSERT INTO `km` VALUES ('93', '负债类', '2401', '递延收益', '', null);
INSERT INTO `km` VALUES ('94', '负债类', '2501', '长期借款', '', null);
INSERT INTO `km` VALUES ('95', '负债类', '2502', '应付债券', '', null);
INSERT INTO `km` VALUES ('100', '负债类', '2701', '长期应付款', '', null);
INSERT INTO `km` VALUES ('101', '负债类', '2702', '未确认融资费用', '', null);
INSERT INTO `km` VALUES ('102', '负债类', '2711', '专项应付款', '', null);
INSERT INTO `km` VALUES ('103', '负债类', '2801', '预计负债', '', null);
INSERT INTO `km` VALUES ('104', '负债类', '2901', '递延所得税负债', '', null);
INSERT INTO `km` VALUES ('110', '所有者权益类', '4001', '实收资本', '', null);
INSERT INTO `km` VALUES ('111', '所有者权益类', '4002', '资本公积', '', null);
INSERT INTO `km` VALUES ('112', '所有者权益类', '4101', '盈余公积', '', null);
INSERT INTO `km` VALUES ('114', '所有者权益类', '4103', '本年利润', '', null);
INSERT INTO `km` VALUES ('115', '所有者权益类', '4104', '利润分配', '', null);
INSERT INTO `km` VALUES ('117', '成本类', '5001', '生产成本', '', null);
INSERT INTO `km` VALUES ('118', '成本类', '5101', '制造费用', '', null);
INSERT INTO `km` VALUES ('119', '成本类', '5201', '劳务成本', '', null);
INSERT INTO `km` VALUES ('120', '成本类', '5301', '研发成本', '', null);
INSERT INTO `km` VALUES ('124', '损益类', '6001', '主营业务收入', '', null);
INSERT INTO `km` VALUES ('129', '损益类', '6051', '其他业务收入', '', null);
INSERT INTO `km` VALUES ('131', '损益类', '6101', '公允价值变动损益', '', null);
INSERT INTO `km` VALUES ('132', '损益类', '6111', '投资损益', '', null);
INSERT INTO `km` VALUES ('136', '损益类', '6301', '营业外收入', '', null);
INSERT INTO `km` VALUES ('137', '损益类', '6401', '主营业务成本', '', null);
INSERT INTO `km` VALUES ('138', '损益类', '6402', '其他业务成本', '', null);
INSERT INTO `km` VALUES ('139', '损益类', '6403', '营业税金及附加', '', null);
INSERT INTO `km` VALUES ('149', '损益类', '6601', '销售费用', '', null);
INSERT INTO `km` VALUES ('150', '损益类', '6602', '管理费用', '', null);
INSERT INTO `km` VALUES ('151', '损益类', '6603', '财务费用', '', null);
INSERT INTO `km` VALUES ('153', '损益类', '6701', '资产减值损失', '', null);
INSERT INTO `km` VALUES ('154', '损益类', '6711', '营业外支出', '', null);
INSERT INTO `km` VALUES ('155', '损益类', '6801', '所得税费用', '', null);
INSERT INTO `km` VALUES ('156', '损益类', '6901', '以前年度损益调整', '', null);

-- ----------------------------
-- Table structure for `manager`
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserID` varchar(4) DEFAULT NULL COMMENT '员工编号',
  `UserName` varchar(12) DEFAULT NULL COMMENT '员工姓名',
  `UserPass` varchar(32) DEFAULT NULL COMMENT '密码',
  `Address` varchar(40) DEFAULT NULL COMMENT '员工住址',
  `Tel` varchar(15) DEFAULT NULL COMMENT '电话',
  `Purview` int(11) DEFAULT '0',
  `Remark` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `UserID` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('28', '4', '002', 'a87ff679a2f3e71d9181a67b7542122c', '123', '13088417022', '268435455', '三天试用');
INSERT INTO `manager` VALUES ('32', '1', '001', 'c4ca4238a0b923820dcc509a6f75849b', '123', '1', '268435455', '');
INSERT INTO `manager` VALUES ('33', '3', '003', 'c4ca4238a0b923820dcc509a6f75849b', '123', '13088417022', '268435455', '三天试用');

-- ----------------------------
-- Table structure for `mxsp`
-- ----------------------------
DROP TABLE IF EXISTS `mxsp`;
CREATE TABLE `mxsp` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `BarCode` varchar(13) DEFAULT NULL COMMENT '商品编码',
  `GoodsName` varchar(40) DEFAULT NULL COMMENT '商品名称',
  `Unit` varchar(10) DEFAULT NULL COMMENT '计量单位',
  `SellScalar` double DEFAULT '0' COMMENT '数量',
  `PurchasePrice` double DEFAULT '0' COMMENT '进价',
  `SellPrice` double DEFAULT '0' COMMENT '售价',
  `Gift` varchar(4) DEFAULT NULL COMMENT '赠品',
  `UntreadFlag` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `BarCode` (`BarCode`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6934 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mxsp
-- ----------------------------
INSERT INTO `mxsp` VALUES ('6931', '001', '鸳鸯锅', '个', '3', '44.85', '30.15', '-', '-');
INSERT INTO `mxsp` VALUES ('6932', '002', '香辣中锅', '个', '2', '28', '28', '-', '-');
INSERT INTO `mxsp` VALUES ('6933', '003', '白汤中锅', '个', '1', '12', '12', '-', '-');

-- ----------------------------
-- Table structure for `purchase`
-- ----------------------------
DROP TABLE IF EXISTS `purchase`;
CREATE TABLE `purchase` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `InvoiceID` varchar(11) NOT NULL COMMENT '订单编号',
  `BarCode` varchar(15) NOT NULL COMMENT '条形码',
  `GoodsName` varchar(40) NOT NULL COMMENT '产品名称',
  `FeederName` varchar(40) DEFAULT NULL COMMENT '供应商名称',
  `PurchaseScalar` double NOT NULL DEFAULT '0' COMMENT '采购数量',
  `PurchasePrice` double NOT NULL DEFAULT '0' COMMENT '采购价格',
  `Unit` varchar(10) DEFAULT NULL COMMENT '计量单位',
  `EnterFiag` tinyint(1) NOT NULL COMMENT '入库标志',
  `PurchaseDate` datetime NOT NULL COMMENT '采购日期',
  `UserName` varchar(12) NOT NULL COMMENT '采购员',
  `Remark` varchar(11) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `BarCode` (`BarCode`),
  KEY `ID` (`ID`),
  KEY `InvoiceID` (`InvoiceID`)
) ENGINE=InnoDB AUTO_INCREMENT=478 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchase
-- ----------------------------
INSERT INTO `purchase` VALUES ('205', 'P0510100001', '6901028052863', '国宾香烟(绿)', '天客隆超市', '100', '4', '包', '1', '2005-10-10 01:14:52', 'system', null);
INSERT INTO `purchase` VALUES ('208', 'P0510100002', '6901028191012', '软白沙', '天客隆超市', '100', '3', '包', '1', '2005-10-10 01:16:10', 'system', null);
INSERT INTO `purchase` VALUES ('210', 'P0511070001', '001', '锅包肉', '', '10', '10', '盘', '1', '2005-11-07 17:02:53', 'system', null);
INSERT INTO `purchase` VALUES ('211', 'P0511070002', '001', '锅包肉', '', '10', '10', '盘', '1', '2005-11-07 17:15:33', 'system', null);
INSERT INTO `purchase` VALUES ('212', 'P0511070003', '001', '鸳鸯锅', '', '1000', '15', '个', '1', '2005-11-07 22:25:19', 'system', null);
INSERT INTO `purchase` VALUES ('213', 'P0511070004', '002', '香辣中锅', '', '1000', '14', '个', '1', '2005-11-07 22:26:58', 'system', null);
INSERT INTO `purchase` VALUES ('214', 'P0511070005', '003', '白汤中锅', '', '1000', '12', '个', '1', '2005-11-07 22:29:44', 'system', null);
INSERT INTO `purchase` VALUES ('215', 'P0511070006', '004', '滋补锅', '', '1000', '36', '个', '1', '2005-11-07 22:30:38', 'system', null);
INSERT INTO `purchase` VALUES ('216', 'P0511070007', '005', '小锅', '', '10000', '5', '个', '1', '2005-11-07 22:31:17', 'system', null);
INSERT INTO `purchase` VALUES ('217', 'P0511070008', '006', '国蜀调料', '', '10000', '2', '份', '1', '2005-11-07 22:32:29', 'system', null);
INSERT INTO `purchase` VALUES ('218', 'P0511070009', '007', '香辣调料', '', '10000', '2', '份', '1', '2005-11-07 22:33:13', 'system', null);
INSERT INTO `purchase` VALUES ('219', 'P0511070010', '008', '麻酱调料', '', '10000', '2', '份', '1', '2005-11-07 22:34:22', 'system', null);
INSERT INTO `purchase` VALUES ('220', 'P0511070011', '009', '香油蒜泥', '', '10000', '2', '份', '1', '2005-11-07 22:35:37', 'system', null);
INSERT INTO `purchase` VALUES ('221', 'P0511070012', '010', '小料', '', '10000', '1', '份', '1', '2005-11-07 22:36:52', 'system', null);
INSERT INTO `purchase` VALUES ('222', 'P0511070013', '011', '锡盟羔羊', '', '9977', '10', '盘', '1', '2005-11-07 22:43:56', 'system', 'U1307230001');
INSERT INTO `purchase` VALUES ('223', 'P0511070014', '013', '羔羊腿肉', ' ', '10000', '12', '盘', '1', '2005-11-07 22:45:42', 'system', null);
INSERT INTO `purchase` VALUES ('224', 'P0511070015', '012', '新西兰肥羊', '', '10000', '10', '盘', '1', '2005-11-07 22:57:40', 'system', null);
INSERT INTO `purchase` VALUES ('225', 'P0511080001', '014', '国蜀鲜嫩羊肉', '', '10000', '12', '盘', '1', '2005-11-08 09:46:51', 'system', null);
INSERT INTO `purchase` VALUES ('226', 'P0511080002', '015', '羊腰', '', '10000', '12', '盘', '1', '2005-11-08 09:47:32', 'system', null);
INSERT INTO `purchase` VALUES ('227', 'P0511080003', '016', '羊肉滑', '', '10000', '18', '盘', '1', '2005-11-08 09:48:48', 'system', null);
INSERT INTO `purchase` VALUES ('228', 'P0511080004', '017', '国蜀鲜嫩羊肉', '', '10000', '12', '盘', '1', '2005-11-08 10:02:05', 'system', null);
INSERT INTO `purchase` VALUES ('229', 'P0511080005', '018', '国蜀鲜嫩牛肉', '', '10000', '16', '盘', '1', '2005-11-08 11:58:44', 'system', null);
INSERT INTO `purchase` VALUES ('230', 'P0511080006', '019', '精品肥牛', '', '10000', '18', '盘', '1', '2005-11-08 12:05:48', 'system', null);
INSERT INTO `purchase` VALUES ('232', 'P0511080007', '020', '肥牛上脑', '', '10000', '22', '盘', '1', '2005-11-08 12:33:26', 'system', null);
INSERT INTO `purchase` VALUES ('233', 'P0511080008', '021', '肥牛眼肉', '', '10000', '25', '盘 ', '1', '2005-11-08 12:35:41', 'system', null);
INSERT INTO `purchase` VALUES ('234', 'P0511080009', '022', 'A外脊肥牛', '', '10000', '26', '盘', '1', '2005-11-08 12:38:30', 'system', null);
INSERT INTO `purchase` VALUES ('235', 'P0511080010', '023', '牛肉滑', '', '10000', '22', '盘', '1', '2005-11-08 12:40:11', 'system', null);
INSERT INTO `purchase` VALUES ('236', 'P0511080011', '024', '猪五花', '', '10000', '10', '盘', '1', '2005-11-08 12:43:00', 'system', null);
INSERT INTO `purchase` VALUES ('237', 'P0511080012', '025', '腰花', '', '10000', '10', '盘', '1', '2005-11-08 12:43:35', 'system', null);
INSERT INTO `purchase` VALUES ('238', 'P0511080013', '026', '青虾', '', '10000', '18', '盘', '1', '2005-11-08 13:00:20', 'system', null);
INSERT INTO `purchase` VALUES ('239', 'P0511080014', '027', '扇贝', '', '10000', '16', '盘', '1', '2005-11-08 13:02:05', 'system', null);
INSERT INTO `purchase` VALUES ('240', 'P0511080015', '028', '蛎蝗', '', '10000', '12', '盘', '1', '2005-11-08 16:30:12', 'system', null);
INSERT INTO `purchase` VALUES ('241', 'P0511080016', '029', '海兔', '', '10000', '12', '盘', '1', '2005-11-08 16:31:07', 'system', null);
INSERT INTO `purchase` VALUES ('242', 'P0511080017', '030', '墨鱼仔', '', '10000', '15', '盘', '1', '2005-11-08 16:34:25', 'system', null);
INSERT INTO `purchase` VALUES ('243', 'P0511080018', '031', '花鲢鱼片', '', '10000', '10', '盘', '1', '2005-11-08 16:36:00', 'system', null);
INSERT INTO `purchase` VALUES ('244', 'P0511080019', '032', '三文鱼生吃(小)', '', '10000', '22', '盘', '1', '2005-11-08 16:37:51', 'system', null);
INSERT INTO `purchase` VALUES ('245', 'P0511080020', '033', '三文鱼生吃(大)', '', '10000', '38', '盘', '1', '2005-11-08 16:38:51', 'system', null);
INSERT INTO `purchase` VALUES ('246', 'P0511080021', '034', '鲜鱿鱼卷', '', '10000', '16', '盘', '1', '2005-11-08 16:43:34', 'system', null);
INSERT INTO `purchase` VALUES ('247', 'P0511080022', '035', '基围虾', '', '10000', '108', '斤', '1', '2005-11-08 16:48:17', 'system', null);
INSERT INTO `purchase` VALUES ('248', 'P0511080023', '036', '河蟹', '', '10000', '38', '斤', '1', '2005-11-08 16:49:52', 'system', null);
INSERT INTO `purchase` VALUES ('249', 'P0511080024', '037', '海蟹', '', '10000', '200', '斤', '1', '2005-11-08 16:52:27', 'system', null);
INSERT INTO `purchase` VALUES ('250', 'P0511080025', '038', '黑鱼两吃', '', '10000', '22', '斤', '1', '2005-11-08 16:53:41', 'system', null);
INSERT INTO `purchase` VALUES ('251', 'P0511080026', '039', '鲜鱼滑', '', '10000', '22', '盘', '1', '2005-11-08 16:54:40', 'system', null);
INSERT INTO `purchase` VALUES ('252', 'P0511080027', '040', '鲜虾滑', '', '10000', '28', '秀；盘', '1', '2005-11-08 16:56:39', 'system', null);
INSERT INTO `purchase` VALUES ('253', 'P0511080028', '041', '百叶', '', '10000', '12', '盘', '1', '2005-11-08 16:57:34', 'system', null);
INSERT INTO `purchase` VALUES ('254', 'P0511080029', '042', '毛肚', '', '10000', '12', '盘', '1', '2005-11-08 16:58:42', 'system', null);
INSERT INTO `purchase` VALUES ('255', 'P0511080030', '043', '鸭肠', '', '10000', '12', '盘', '1', '2005-11-08 16:59:46', 'system', null);
INSERT INTO `purchase` VALUES ('256', 'P0511080031', '044', '午餐肉', '', '10000', '12', '盘', '1', '2005-11-08 17:03:13', 'system', null);
INSERT INTO `purchase` VALUES ('257', 'P0511080032', '045', '黄喉', '', '10000', '15', '盘', '1', '2005-11-08 17:05:13', 'system', null);
INSERT INTO `purchase` VALUES ('258', 'P0511080033', '046', '牛骨髓', '', '10000', '15', '盘', '1', '2005-11-08 17:06:03', 'system', null);
INSERT INTO `purchase` VALUES ('259', 'P0511080034', '047', '鸭血', '', '10000', '4', '盘', '1', '2005-11-08 17:06:53', 'system', null);
INSERT INTO `purchase` VALUES ('260', 'P0511080035', '048', '羊血', '', '10000', '4', '盘', '1', '2005-11-08 17:07:34', 'system', null);
INSERT INTO `purchase` VALUES ('261', 'P0511080036', '049', '鲜蘑', '', '10000', '4', '盘', '1', '2005-11-08 17:08:22', 'system', null);
INSERT INTO `purchase` VALUES ('262', 'P0511080037', '050', '香菇蘑', '', '10000', '5', '盘', '1', '2005-11-08 17:09:11', 'system', null);
INSERT INTO `purchase` VALUES ('263', 'P0511080038', '051', '金针蘑', '', '10000', '10', '盘', '1', '2005-11-08 17:09:43', 'system', null);
INSERT INTO `purchase` VALUES ('264', 'P0511080039', '052', '鸡腿蘑', '', '10000', '8', '盘', '1', '2005-11-08 17:10:47', 'system', null);
INSERT INTO `purchase` VALUES ('265', 'P0511080040', '053', '乳牛肝蘑', '', '10000', '12', '盘', '1', '2005-11-08 17:12:17', 'system', null);
INSERT INTO `purchase` VALUES ('266', 'P0511080041', '054', '彩云蘑', '', '10000', '12', '盘', '1', '2005-11-08 17:13:29', 'system', null);
INSERT INTO `purchase` VALUES ('267', 'P0511080042', '055', '鲍鱼菇', '', '10000', '12', '盘', '1', '2005-11-08 17:14:18', 'system', null);
INSERT INTO `purchase` VALUES ('268', 'P0511080043', '056', '猴头菇', '', '10000', '12', '盘', '1', '2005-11-08 17:15:15', 'system', null);
INSERT INTO `purchase` VALUES ('269', 'P0511080044', '057', '罗汉竹笋', '', '10000', '5', '盘', '1', '2005-11-08 17:17:12', 'system', null);
INSERT INTO `purchase` VALUES ('270', 'P0511080045', '058', '黑木耳', '', '10000', '6', '盘', '1', '2005-11-08 17:18:34', 'system', null);
INSERT INTO `purchase` VALUES ('271', 'P0511080046', '059', '海带片', '', '10000', '4', '盘', '1', '2005-11-08 17:21:18', 'system', null);
INSERT INTO `purchase` VALUES ('272', 'P0511080047', '060', '海带根', '', '10000', '5', '盘', '1', '2005-11-08 17:21:59', 'system', null);
INSERT INTO `purchase` VALUES ('273', 'P0511080048', '061', '宽粉', '', '10000', '4', '盘', '1', '2005-11-08 17:22:32', 'system', null);
INSERT INTO `purchase` VALUES ('274', 'P0511080049', '062', '粉丝', '', '10000', '4', '盘', '1', '2005-11-08 17:23:12', 'system', null);
INSERT INTO `purchase` VALUES ('275', 'P0511080050', '063', '水晶粉', '', '10000', '5', '盘', '1', '2005-11-08 17:23:53', 'system', null);
INSERT INTO `purchase` VALUES ('276', 'P0511080051', '064', '鲜豆腐', '', '10000', '3', '盘', '1', '2005-11-08 17:24:32', 'system', null);
INSERT INTO `purchase` VALUES ('277', 'P0511080052', '065', '冻豆腐 ', '', '10000', '3', '盘', '1', '2005-11-08 17:25:09', 'system', null);
INSERT INTO `purchase` VALUES ('278', 'P0511080053', '066', '油豆腐皮', '', '10000', '4', '盘', '1', '2005-11-08 17:27:39', 'system', null);
INSERT INTO `purchase` VALUES ('279', 'P0511080054', '067', '腐竹', '', '10000', '4', '盘', '1', '2005-11-08 17:28:13', 'system', null);
INSERT INTO `purchase` VALUES ('280', 'P0511080055', '068', '土豆片', '', '10000', '4', '盘', '1', '2005-11-08 17:29:02', 'system', null);
INSERT INTO `purchase` VALUES ('281', 'P0511080056', '069', '红薯 ', '', '10000', '4', '盘', '1', '2005-11-08 17:29:38', 'system', null);
INSERT INTO `purchase` VALUES ('282', 'P0511080057', '070', '冬瓜', '', '10000', '4', '盘', '1', '2005-11-08 17:30:52', 'system', null);
INSERT INTO `purchase` VALUES ('283', 'P0511080058', '071', '茼蒿', '', '10000', '4', '盘', '1', '2005-11-08 17:31:46', 'system', null);
INSERT INTO `purchase` VALUES ('284', 'P0511080059', '072', '菠菜', '', '10000', '4', '盘', '1', '2005-11-08 17:32:16', 'system', null);
INSERT INTO `purchase` VALUES ('285', 'P0511080060', '073', '生菜', '', '10000', '4', '盘就', '1', '2005-11-08 17:32:50', 'system', null);
INSERT INTO `purchase` VALUES ('286', 'P0511080061', '074', '香菜', '', '10000', '4', '盘', '1', '2005-11-08 17:33:18', 'system', null);
INSERT INTO `purchase` VALUES ('287', 'P0511080062', '075', '大白菜', '', '10000', '4', '盘', '1', '2005-11-08 17:34:00', 'system', null);
INSERT INTO `purchase` VALUES ('288', 'P0511080063', '076', '小白菜', '', '10000', '4', '盘', '1', '2005-11-08 17:34:33', 'system', null);
INSERT INTO `purchase` VALUES ('289', 'P0511080064', '077', '西饼', '', '10000', '1', '个', '1', '2005-11-08 17:35:19', 'system', null);
INSERT INTO `purchase` VALUES ('290', 'P0511080065', '078', '金馒头', '', '10000', '6', '份', '1', '2005-11-08 17:36:10', 'system', null);
INSERT INTO `purchase` VALUES ('291', 'P0511080066', '079', '油炸麻团', '', '10000', '8', '份', '1', '2005-11-08 17:36:52', 'system', null);
INSERT INTO `purchase` VALUES ('292', 'P0511080067', '080', '红薯饼', '', '10000', '8', '份', '1', '2005-11-08 17:39:09', 'system', null);
INSERT INTO `purchase` VALUES ('293', 'P0511080068', '081', '南瓜饼', '', '10000', '8', '份', '1', '2005-11-08 17:40:21', 'system', null);
INSERT INTO `purchase` VALUES ('294', 'P0511080069', '082', '虾饺', '', '10000', '8', '份', '1', '2005-11-08 17:41:13', 'system', null);
INSERT INTO `purchase` VALUES ('295', 'P0511080070', '083', '菜汁面条', '', '10000', '6', '份', '1', '2005-11-08 17:42:37', 'system', null);
INSERT INTO `purchase` VALUES ('296', 'P0511080071', '084', '龙须面', '', '10000', '3', '份', '1', '2005-11-08 17:43:13', 'system', null);
INSERT INTO `purchase` VALUES ('297', 'P0511080072', '085', '娃娃菜', '', '10000', '6', '盘', '1', '2005-11-08 17:44:18', 'system', null);
INSERT INTO `purchase` VALUES ('298', 'P0511080073', '086', '酸菜丝', '', '10000', '3', '盘', '1', '2005-11-08 17:45:29', 'system', null);
INSERT INTO `purchase` VALUES ('299', 'P0511080074', '087', '藕片', '', '10000', '5', '盘', '1', '2005-11-08 17:46:54', 'system', null);
INSERT INTO `purchase` VALUES ('300', 'P0511080075', '088', '西红柿', '', '10000', '4', '盘', '1', '2005-11-08 17:47:34', 'system', null);
INSERT INTO `purchase` VALUES ('301', 'P0511080076', '089', '蟹足棒', '', '10000', '8', '盘', '1', '2005-11-08 17:48:57', 'system', null);
INSERT INTO `purchase` VALUES ('302', 'P0511080077', '090', '鱼丸', '', '10000', '10', '盘', '1', '2005-11-08 17:49:44', 'system', null);
INSERT INTO `purchase` VALUES ('303', 'P0511080078', '091', '虾丸', '', '10000', '10', '盘', '1', '2005-11-08 17:50:23', 'system', null);
INSERT INTO `purchase` VALUES ('304', 'P0511080079', '092', '蟹肉', '', '10000', '10', '份', '1', '2005-11-08 17:51:06', 'system', null);
INSERT INTO `purchase` VALUES ('305', 'P0511080080', '093', '羊尾', '', '10000', '12', '盘  ', '1', '2005-11-08 17:51:59', 'system', null);
INSERT INTO `purchase` VALUES ('306', 'P0511080081', '094', '羊宝', '', '10000', '18', '盘', '1', '2005-11-08 17:52:51', 'system', null);
INSERT INTO `purchase` VALUES ('307', 'P0511080082', '095', '牛鞭', '', '10000', '15', '盘', '1', '2005-11-08 17:53:37', 'system', null);
INSERT INTO `purchase` VALUES ('308', 'P0511080083', '096', '牛宝', '', '10000', '12', '盘', '1', '2005-11-08 17:54:18', 'system', null);
INSERT INTO `purchase` VALUES ('309', 'P0511080084', '097', '意粉', '', '10000', '3', '盘', '1', '2005-11-08 17:54:57', 'system', null);
INSERT INTO `purchase` VALUES ('310', 'P0511080085', '098', '疙瘩汤', '', '10000', '10', '份', '1', '2005-11-08 17:55:51', 'system', null);
INSERT INTO `purchase` VALUES ('311', 'P0511080086', '099', '三鲜烙合', '', '10000', '2', '个', '1', '2005-11-08 17:56:32', 'system', null);
INSERT INTO `purchase` VALUES ('312', 'P0511080087', '100', '豆沙饼', '', '10000', '1', '个', '1', '2005-11-08 17:57:21', 'system', null);
INSERT INTO `purchase` VALUES ('313', 'P0511080088', '101', '葱油饼', '', '10000', '1', '个', '1', '2005-11-08 17:58:27', 'system', null);
INSERT INTO `purchase` VALUES ('314', 'P0511080089', '102', '扬州炒饭', '', '10000', '10', '盘', '1', '2005-11-08 18:00:13', 'system', null);
INSERT INTO `purchase` VALUES ('315', 'P0511080090', '076', '小白菜', '', '10000', '4', '盘', '1', '2005-11-08 18:36:54', 'system', null);
INSERT INTO `purchase` VALUES ('316', 'P0511080091', '051', '金针蘑', '', '10000', '10', '盘', '1', '2005-11-08 18:41:59', 'system', null);
INSERT INTO `purchase` VALUES ('317', 'P0511080092', '200', '金三鞭55', '', '10000', '48', '斤', '1', '2005-11-08 19:03:59', 'system', null);
INSERT INTO `purchase` VALUES ('318', 'P0511080093', '201', '银三鞭55', '', '10000', '28', '斤', '1', '2005-11-08 19:05:06', 'system', null);
INSERT INTO `purchase` VALUES ('319', 'P0511080094', '202', '珍酒三年陈酿', '', '100000', '45', '瓶', '1', '2005-11-08 19:07:19', 'system', null);
INSERT INTO `purchase` VALUES ('320', 'P0511080095', '203', '珍酒五年陈酿', '', '10000', '58', '瓶', '1', '2005-11-08 19:08:26', 'system', null);
INSERT INTO `purchase` VALUES ('321', 'P0511080096', '204', '珍酒十年陈酿(半斤)', '', '10000', '68', '瓶', '1', '2005-11-08 19:10:12', 'system', null);
INSERT INTO `purchase` VALUES ('322', 'P0511080097', '205', '珍酒十年陈酿 ', '', '10000', '108', '瓶', '1', '2005-11-08 19:14:13', 'system', null);
INSERT INTO `purchase` VALUES ('323', 'P0511080098', '206', '宁城老窖八年陈酿', '', '10000', '78', '瓶', '1', '2005-11-08 19:17:00', 'system', null);
INSERT INTO `purchase` VALUES ('324', 'P0511080099', '207', '宁城老窖五年陈酿', '', '10000', '48', '瓶', '1', '2005-11-08 19:18:00', 'system', null);
INSERT INTO `purchase` VALUES ('325', 'P0511080100', '208', '宁城老窖极品38', '', '10000', '68', '瓶', '1', '2005-11-08 19:19:07', 'system', null);
INSERT INTO `purchase` VALUES ('326', 'P0511080101', '209', '宁城老窖极品36', '', '10000', '32', '瓶', '1', '2005-11-08 19:20:10', 'system', null);
INSERT INTO `purchase` VALUES ('327', 'P0511080102', '210', '宁城老窖二星', '', '10000', '52', '瓶', '1', '2005-11-08 19:21:11', 'system', null);
INSERT INTO `purchase` VALUES ('328', 'P0511080103', '211', '宁城老窖福星', '', '10000', '15', '瓶', '1', '2005-11-08 19:21:52', 'system', null);
INSERT INTO `purchase` VALUES ('329', 'P0511080104', '212', '裕井烧坊经典', '', '10000', '128', '瓶', '1', '2005-11-08 19:24:30', 'system', null);
INSERT INTO `purchase` VALUES ('330', 'P0511080105', '213', '裕井三百年陈酿', '', '10000', '48', '瓶', '1', '2005-11-08 19:25:15', 'system', null);
INSERT INTO `purchase` VALUES ('331', 'P0511080106', '214', '裕井十年陈酿 ', '', '10000', '24', '瓶', '1', '2005-11-08 19:26:15', 'system', null);
INSERT INTO `purchase` VALUES ('332', 'P0511080107', '215', '裕井烧坊简装', '', '10000', '18', '瓶', '1', '2005-11-08 19:29:58', 'system', null);
INSERT INTO `purchase` VALUES ('333', 'P0511080108', '216', '裕井小酒蒌', '', '10000', '10', '瓶', '1', '2005-11-08 20:09:01', 'system', null);
INSERT INTO `purchase` VALUES ('334', 'P0511080109', '217', '裕井小酒壶', '', '10000', '6', '瓶', '1', '2005-11-08 20:10:19', 'system', null);
INSERT INTO `purchase` VALUES ('335', 'P0511080110', '218', '精品河套王', '', '10000', '128', '瓶', '1', '2005-11-08 20:11:53', 'system', null);
INSERT INTO `purchase` VALUES ('336', 'P0511080111', '219', '河套金尊', '', '10000', '68', '瓶', '1', '2005-11-08 20:13:08', 'system', null);
INSERT INTO `purchase` VALUES ('337', 'P0511080112', '220', '河套银尊', '', '10000', '48', '瓶', '1', '2005-11-08 20:13:44', 'system', null);
INSERT INTO `purchase` VALUES ('338', 'P0511080113', '221', '河套合口福', '', '10000', '58', '瓶', '1', '2005-11-08 20:15:13', 'system', null);
INSERT INTO `purchase` VALUES ('339', 'P0511080114', '222', '河套福星52', '', '10000', '30', '瓶', '1', '2005-11-08 20:15:57', 'system', null);
INSERT INTO `purchase` VALUES ('340', 'P0511080115', '223', '河套福星38', '', '10000', '28', '瓶', '1', '2005-11-08 20:16:34', 'system', null);
INSERT INTO `purchase` VALUES ('341', 'P0511080116', '224', '河套纯粮', '', '10000', '15', '瓶', '1', '2005-11-08 20:18:22', 'system', null);
INSERT INTO `purchase` VALUES ('342', 'P0511080117', '225', '太白毫杰酒', '', '10000', '48', '瓶', '1', '2005-11-08 20:20:14', 'system', null);
INSERT INTO `purchase` VALUES ('343', 'P0511080118', '226', '太白巴乡村', '', '10000', '28', '瓶', '1', '2005-11-08 20:21:29', 'system', null);
INSERT INTO `purchase` VALUES ('344', 'P0511080119', '227', '诗仙太白简装', '', '10000', '18', '瓶', '1', '2005-11-08 20:22:43', 'system', null);
INSERT INTO `purchase` VALUES ('345', 'P0511080120', '228', '凤城老窖一星', '', '10000', '58', '瓶', '1', '2005-11-08 20:24:03', 'system', null);
INSERT INTO `purchase` VALUES ('346', 'P0511080121', '229', '凤城老窖金蒙', '', '10000', '48', '瓶', '1', '2005-11-08 20:25:04', 'system', null);
INSERT INTO `purchase` VALUES ('347', 'P0511080122', '230', '凤城老窖银蒙', '', '10000', '38', '瓶', '1', '2005-11-08 20:26:00', 'system', null);
INSERT INTO `purchase` VALUES ('348', 'P0511080123', '231', '凤城原浆', '', '10000', '15', '瓶', '1', '2005-11-08 20:27:12', 'system', null);
INSERT INTO `purchase` VALUES ('349', 'P0511080124', '232', '五粮醇', '', '10000', '58', '瓶', '1', '2005-11-08 20:27:54', 'system', null);
INSERT INTO `purchase` VALUES ('350', 'P0511080125', '233', '五粮醇(三)', '', '10000', '108', '瓶', '1', '2005-11-08 20:30:54', 'system', null);
INSERT INTO `purchase` VALUES ('351', 'P0511080126', '234', '小火爆', '', '10000', '8', '瓶', '1', '2005-11-08 20:33:57', 'system', null);
INSERT INTO `purchase` VALUES ('352', 'P0511080127', '235', '三星杞浓', '', '10000', '98', '瓶', '1', '2005-11-08 20:34:51', 'system', null);
INSERT INTO `purchase` VALUES ('353', 'P0511080128', '236', '老池酒 ', '', '10000', '288', '瓶', '1', '2005-11-08 20:35:44', 'system', null);
INSERT INTO `purchase` VALUES ('354', 'P0511080129', '237', '乾豫兴老窖精品', '', '10000', '108', '瓶', '1', '2005-11-08 20:40:46', 'system', null);
INSERT INTO `purchase` VALUES ('355', 'P0511080130', '238', '乾豫兴', '', '10000', '58', '瓶', '1', '2005-11-08 20:41:53', 'system', null);
INSERT INTO `purchase` VALUES ('356', 'P0511080131', '239', '烧锅酒', '', '10000', '20', '瓶', '1', '2005-11-08 20:42:36', 'system', null);
INSERT INTO `purchase` VALUES ('357', 'P0511080132', '240', '四特陈酿', '', '10000', '68', '瓶', '1', '2005-11-08 20:44:37', 'system', null);
INSERT INTO `purchase` VALUES ('358', 'P0511080133', '241', '国宾四特', '', '10000', '48', '瓶', '1', '2005-11-08 20:46:05', 'system', null);
INSERT INTO `purchase` VALUES ('359', 'P0511080134', '242', '店小二38', '', '10000', '36', '瓶', '1', '2005-11-08 20:47:20', 'system', null);
INSERT INTO `purchase` VALUES ('360', 'P0511080135', '243', '店小二46', '', '10000', '46', '瓶', '1', '2005-11-08 20:47:58', 'system', null);
INSERT INTO `purchase` VALUES ('361', 'P0511080136', '244', '庄家汉简装', '', '10000', '18', '瓶', '1', '2005-11-08 20:50:08', 'system', null);
INSERT INTO `purchase` VALUES ('362', 'P0511080137', '245', '庄家汉盒装', '', '10000', '58', '瓶', '1', '2005-11-08 20:50:53', 'system', null);
INSERT INTO `purchase` VALUES ('363', 'P0511080138', '246', '长城红色庄园', '', '10000', '128', '瓶', '1', '2005-11-08 20:52:36', 'system', null);
INSERT INTO `purchase` VALUES ('364', 'P0511080139', '247', '长城干红赤霞珠', '', '10000', '98', '瓶', '1', '2005-11-08 20:54:48', 'system', null);
INSERT INTO `purchase` VALUES ('365', 'P0511080140', '248', '长城干红葡萄酒制醇', '', '10000', '38', '瓶', '1', '2005-11-08 20:56:12', 'system', null);
INSERT INTO `purchase` VALUES ('366', 'P0511080141', '249', '解佰纳干红葡萄酒', '', '10000', '78', '瓶', '1', '2005-11-08 20:57:20', 'system', null);
INSERT INTO `purchase` VALUES ('368', 'P0511080143', '250', '简农达红酒', '', '10000', '38', '瓶', '1', '2005-11-08 20:59:51', 'system', null);
INSERT INTO `purchase` VALUES ('369', 'P0511080142', '251', '燕京无醇', '', '10000', '15', '瓶', '1', '2005-11-08 21:01:05', 'system', null);
INSERT INTO `purchase` VALUES ('370', 'P0511080144', '252', '荞麦干啤', '', '10000', '10', '瓶', '1', '2005-11-08 21:02:43', 'system', null);
INSERT INTO `purchase` VALUES ('371', 'P0511080145', '253', '燕京纯生', '', '10000', '10', '瓶', '1', '2005-11-08 21:04:01', 'system', null);
INSERT INTO `purchase` VALUES ('372', 'P0511080146', '254', '哈干', '', '10000', '10', '瓶', '1', '2005-11-08 21:05:22', 'system', null);
INSERT INTO `purchase` VALUES ('373', 'P0511080147', '255', '哈鲜', '', '10000', '8', '瓶', '1', '2005-11-08 21:05:44', 'system', null);
INSERT INTO `purchase` VALUES ('374', 'P0511080148', '256', '燕京普啤', '', '10000', '2', '瓶', '1', '2005-11-08 21:06:49', 'system', null);
INSERT INTO `purchase` VALUES ('375', 'P0511080149', '257', '汇源高纤维', '', '10000', '25', '盒', '1', '2005-11-08 21:08:00', 'system', null);
INSERT INTO `purchase` VALUES ('376', 'P0511080150', '258', '汇源果汁100%', '', '10000', '20', '盒', '1', '2005-11-08 21:09:15', 'system', null);
INSERT INTO `purchase` VALUES ('377', 'P0511080151', '259', '汇源果汁50%', '', '10000', '10', '瓶', '1', '2005-11-08 21:10:05', 'system', null);
INSERT INTO `purchase` VALUES ('378', 'P0511080152', '260', '雪碧(大)', '', '10000', '10', '瓶', '1', '2005-11-08 21:11:16', 'system', null);
INSERT INTO `purchase` VALUES ('381', 'P0511080155', '263', '可口可乐(厅)', '', '10000', '3', '厅', '1', '2005-11-08 21:15:21', 'system', null);
INSERT INTO `purchase` VALUES ('382', 'P0511080156', '264', '百事可乐(厅)', '', '10000', '3', '厅', '1', '2005-11-08 21:16:18', 'system', null);
INSERT INTO `purchase` VALUES ('383', 'P0511080157', '265', '雪碧(厅)', '', '10000', '3', '厅', '1', '2005-11-08 21:17:10', 'system', null);
INSERT INTO `purchase` VALUES ('384', 'P0511080158', '266', '百事可乐(中)', '', '10000', '4', '瓶', '1', '2005-11-08 21:18:27', 'system', null);
INSERT INTO `purchase` VALUES ('385', 'P0511080154', '262', '百事可乐(大)', '', '10000', '10', '桶', '1', '2005-11-08 21:18:48', 'system', null);
INSERT INTO `purchase` VALUES ('386', 'P0511080153', '261', '可口可乐(大)', '', '10000', '10', '瓶', '1', '2005-11-08 21:19:06', 'system', null);
INSERT INTO `purchase` VALUES ('387', 'P0511080159', '267', '矿泉水', '', '10000', '2', '瓶', '1', '2005-11-08 21:20:12', 'system', null);
INSERT INTO `purchase` VALUES ('388', 'P0511080160', '268', '杏仁乳', '', '10000', '2', '瓶', '1', '2005-11-08 21:21:32', 'system', null);
INSERT INTO `purchase` VALUES ('389', 'P0511080161', '269', '花生奶', '', '10000', '12', '壶', '1', '2005-11-08 21:31:51', 'system', null);
INSERT INTO `purchase` VALUES ('390', 'P0511080162', '270', '硬中华', '', '10000', '60', '盒', '1', '2005-11-08 21:33:34', 'system', null);
INSERT INTO `purchase` VALUES ('391', 'P0511080163', '271', '苁 蓉', '', '10000', '15', '盒', '1', '2005-11-08 21:34:11', 'system', null);
INSERT INTO `purchase` VALUES ('392', 'P0511080164', '272', '红国宾', '', '10000', '13', '盒', '1', '2005-11-08 21:34:49', 'system', null);
INSERT INTO `purchase` VALUES ('393', 'P0511080165', '273', '环保白沙', '', '10000', '12', '盒', '1', '2005-11-08 21:35:35', 'system', null);
INSERT INTO `purchase` VALUES ('394', 'P0511080166', '274', '红云', '', '10000', '10', ' 盒', '1', '2005-11-08 21:36:21', 'system', null);
INSERT INTO `purchase` VALUES ('395', 'P0511080167', '275', '蓝国宾', '', '10000', '8', '盒 ', '1', '2005-11-08 21:36:49', 'system', null);
INSERT INTO `purchase` VALUES ('396', 'P0511080168', '019', '精品肥牛', '', '10000', '18', '盘', '1', '2005-11-08 22:23:20', 'system', null);
INSERT INTO `purchase` VALUES ('397', 'P0511090001', '048', '羊血', '', '10000', '4', '盘', '1', '2005-11-09 10:08:55', 'system', null);
INSERT INTO `purchase` VALUES ('398', 'P0511090002', '095', '牛鞭', '', '10000', '15', '盘', '1', '2005-11-09 10:11:24', 'system', null);
INSERT INTO `purchase` VALUES ('399', 'P0511090003', '300', '八宝茶', '', '10000', '1', '杯', '1', '2005-11-09 10:47:18', 'system', null);
INSERT INTO `purchase` VALUES ('400', 'P0511090004', '067', '腐竹', '', '10000', '5', '盘', '1', '2005-11-09 10:54:58', 'system', null);
INSERT INTO `purchase` VALUES ('401', 'P0511090005', '301', '筷子', '', '100000', '1', '双', '1', '2005-11-09 10:57:18', 'system', null);
INSERT INTO `purchase` VALUES ('402', 'P0511090006', '301', '筷子', '', '100000', '1', '双', '1', '2005-11-09 10:58:37', 'system', null);
INSERT INTO `purchase` VALUES ('404', 'P0511090007', '276', '山水啤酒', '', '100000', '3', '瓶', '1', '2005-11-09 11:03:16', 'system', null);
INSERT INTO `purchase` VALUES ('405', 'P0511090008', '400', '糖醋蒜', '', '100000', '3', '盘', '1', '2005-11-09 11:14:35', 'system', null);
INSERT INTO `purchase` VALUES ('406', 'P0511090009', '401', '小葱拌虾仁', '', '10000', '4', '盘', '1', '2005-11-09 11:15:39', 'system', null);
INSERT INTO `purchase` VALUES ('407', 'P0511090010', '402', '青瓜牛肉', '', '10000', '6', '盘', '1', '2005-11-09 11:16:37', 'system', null);
INSERT INTO `purchase` VALUES ('408', 'P0511090011', '403', '杏仁蕨菜', '', '10000', '5', '盘', '1', '2005-11-09 11:17:28', 'system', null);
INSERT INTO `purchase` VALUES ('409', 'P0511090012', '404', '陈醋花生米', '', '10000', '4', '盘', '1', '2005-11-09 11:18:12', 'system', null);
INSERT INTO `purchase` VALUES ('410', 'P0511090013', '405', '炝拌干丝', '', '100000', '4', '盘', '1', '2005-11-09 11:19:18', 'system', null);
INSERT INTO `purchase` VALUES ('411', 'P0511090014', '406', '椒麻凤爪', '', '10000', '8', '盘', '1', '2005-11-09 11:20:39', 'system', null);
INSERT INTO `purchase` VALUES ('412', 'P0511090015', '407', '鲅鱼焖豆', '', '10000', '6', '盘', '1', '2005-11-09 11:22:11', 'system', null);
INSERT INTO `purchase` VALUES ('413', 'P0511090016', '408', '脆耳瓜丝', '', '10000', '6', '盘', '1', '2005-11-09 11:23:05', 'system', null);
INSERT INTO `purchase` VALUES ('414', 'P0511090017', '409', '美极拌菜', '', '100000', '4', '盘', '1', '2005-11-09 11:24:22', 'system', null);
INSERT INTO `purchase` VALUES ('415', 'P0511090018', '410', '干烧银鱼 ', '', '10000', '4', '盘', '1', '2005-11-09 11:25:24', 'system', null);
INSERT INTO `purchase` VALUES ('416', 'P0511090019', '411', '三鲜炝菠菜', '', '10000', '5', '盘', '1', '2005-11-09 11:27:11', 'system', null);
INSERT INTO `purchase` VALUES ('417', 'P0511090020', '412', '盐爆花生米', '', '10000', '4', '盘', '1', '2005-11-09 11:28:07', 'system', null);
INSERT INTO `purchase` VALUES ('418', 'P0511090021', '413', '四喜豆付', '', '10000', '5', '盘', '1', '2005-11-09 11:28:43', 'system', null);
INSERT INTO `purchase` VALUES ('419', 'P0511090022', '414', '拌皮冻', '', '10000', '4', '盘', '1', '2005-11-09 11:29:28', 'system', null);
INSERT INTO `purchase` VALUES ('420', 'P0511090023', '415', '孜然鸡脖', '', '10000', '8', '盘', '1', '2005-11-09 11:31:13', 'system', null);
INSERT INTO `purchase` VALUES ('421', 'P0511090024', '416', '香辣毛肚', '', '10000', '6', '盘', '1', '2005-11-09 11:31:53', 'system', null);
INSERT INTO `purchase` VALUES ('422', 'P0511090025', '417', '红梅卧雪', '', '10000', '4', '盘', '1', '2005-11-09 11:33:46', 'system', null);
INSERT INTO `purchase` VALUES ('423', 'P0511090026', '418', '凉拌三鲜', '', '10000', '5', '盘', '1', '2005-11-09 11:35:02', 'system', null);
INSERT INTO `purchase` VALUES ('424', 'P0511090027', '419', '小白菜拌木耳', '', '100000', '4', '盘', '1', '2005-11-09 11:36:01', 'system', null);
INSERT INTO `purchase` VALUES ('425', 'P0511090028', '420', '牛肉耳段', '', '100000', '6', '盘', '1', '2005-11-09 11:37:56', 'system', null);
INSERT INTO `purchase` VALUES ('426', 'P0511090029', '277', '海味火锅', '', '10000', '58', '个', '1', '2005-11-09 12:44:35', 'system', null);
INSERT INTO `purchase` VALUES ('427', 'P0511090030', '278', '香辣蟹火锅', '', '10000', '48', '个', '1', '2005-11-09 12:45:18', 'system', null);
INSERT INTO `purchase` VALUES ('428', 'P0511090031', '279', '花鲢鱼火锅', '', '10000', '36', '个', '1', '2005-11-09 12:46:14', 'system', null);
INSERT INTO `purchase` VALUES ('429', 'P0511090032', '280', '水煮鱼', '', '10000', '22', '斤', '1', '2005-11-09 12:47:33', 'system', null);
INSERT INTO `purchase` VALUES ('430', 'P0511090033', '281', '黑鱼', '', '10000', '36', '斤', '1', '2005-11-09 12:48:45', 'system', null);
INSERT INTO `purchase` VALUES ('431', 'P0511090034', '288', '手擀面', '', '100000', '6', '份', '1', '2005-11-09 12:56:24', 'system', null);
INSERT INTO `purchase` VALUES ('432', 'P0511090035', '280', '水煮鱼草鱼', '', '10000', '22', '斤', '1', '2005-11-09 21:46:49', 'system', null);
INSERT INTO `purchase` VALUES ('433', 'P0511090036', '281', '水煮黑鱼', '', '10000', '36', '斤', '1', '2005-11-09 21:49:49', 'system', null);
INSERT INTO `purchase` VALUES ('434', 'P0511090037', '282', '乌鸡甲鱼锅', '', '10000', '88', '个', '1', '2005-11-09 21:52:49', 'system', null);
INSERT INTO `purchase` VALUES ('435', 'P0511090038', '283', '鲜对虾丸', '', '10000', '36', '盘', '1', '2005-11-09 21:54:43', 'system', null);
INSERT INTO `purchase` VALUES ('436', 'P0511090039', '284', '辣根', '', '10000', '2', '份', '1', '2005-11-09 21:56:51', 'system', null);
INSERT INTO `purchase` VALUES ('437', 'P0511090040', '285', '泥螺', '', '10000', '10', '盘', '1', '2005-11-09 22:00:30', 'system', null);
INSERT INTO `purchase` VALUES ('438', 'P0511090041', '286', '果盘', '', '10000', '10', '盘', '1', '2005-11-09 22:03:44', 'system', null);
INSERT INTO `purchase` VALUES ('439', 'P0511090042', '287', '扑克', '', '10000', '2', '副', '1', '2005-11-09 22:06:19', 'system', null);
INSERT INTO `purchase` VALUES ('440', 'P0511090043', '289', '歌曲', '', '10000', '20', '首', '1', '2005-11-09 22:12:36', 'system', null);
INSERT INTO `purchase` VALUES ('441', 'P0511090044', '290', '泡椒 ', '', '10000', '2', '份', '1', '2005-11-09 22:14:13', 'system', null);
INSERT INTO `purchase` VALUES ('442', 'P0511090045', '014', '羊脑', '', '10000', '12', '盘', '1', '2005-11-09 22:47:18', 'system', null);
INSERT INTO `purchase` VALUES ('443', 'P0511090046', '095', '牛鞭', '', '10000', '15', '盘', '1', '2005-11-09 23:12:50', 'system', null);
INSERT INTO `purchase` VALUES ('444', 'P0511100001', '083', '菜汁面条', '', '10000', '6', '份', '1', '2005-11-10 10:52:00', 'system', null);
INSERT INTO `purchase` VALUES ('445', 'P0511170001', '201', '银三鞭55', '', '10000', '28', '斤', '1', '2005-11-17 15:48:00', 'system', null);
INSERT INTO `purchase` VALUES ('446', 'P0511170002', '500', '酒精', '', '10000', '1', '个', '1', '2005-11-17 17:39:01', 'system', null);
INSERT INTO `purchase` VALUES ('447', 'P0511170003', '416', '香辣毛肚', '', '10000', '8', '盘', '1', '2005-11-17 18:00:52', 'system', null);
INSERT INTO `purchase` VALUES ('448', 'P0511170004', '501', '玉米饼', '', '10000', '4', '份', '1', '2005-11-17 18:53:20', 'system', null);
INSERT INTO `purchase` VALUES ('449', 'P0511170005', '502', '四野泡菜', '', '10000', '4', '盘', '1', '2005-11-17 18:54:22', 'system', null);
INSERT INTO `purchase` VALUES ('452', 'P0511190001', '504', '生鸡蛋', '', '10000', '0.5', '个', '1', '2005-11-19 16:57:16', 'system', null);
INSERT INTO `purchase` VALUES ('453', 'P0511190002', '011', '锡盟羔羊', '', '10000', '10', '盘', '1', '2005-11-19 16:58:53', 'system', null);
INSERT INTO `purchase` VALUES ('454', 'P0511190003', '503', '米饭', '', '10000', '1', '碗', '1', '2005-11-19 18:50:05', 'system', null);
INSERT INTO `purchase` VALUES ('455', 'P0511190004', '505', '长寿面', '', '10000', '12', '碗', '1', '2005-11-19 19:41:50', 'system', null);
INSERT INTO `purchase` VALUES ('456', 'P0511190005', '506', '油菜', '', '1000', '4', '份', '1', '2005-11-19 19:42:51', 'system', null);
INSERT INTO `purchase` VALUES ('457', 'P0511190006', '507', '韭菜', '', '10000', '4', '份', '1', '2005-11-19 19:43:25', 'system', null);
INSERT INTO `purchase` VALUES ('458', 'P0511190007', '083', '菜汁面条', '', '10000', '6', '份', '1', '2005-11-19 22:33:00', 'system', null);
INSERT INTO `purchase` VALUES ('459', 'P0511190008', '012', '新西兰肥羊', '', '10000', '10', '盘', '1', '2005-11-19 22:37:56', 'system', null);
INSERT INTO `purchase` VALUES ('460', 'P0511190009', '017', '国蜀鲜嫩羊肉', '', '10100', '12', '盘', '1', '2005-11-19 22:46:24', 'system', null);
INSERT INTO `purchase` VALUES ('461', 'P0511190010', '018', '国蜀鲜嫩牛肉', '', '1000', '16', '盘', '1', '2005-11-19 22:46:48', 'system', null);
INSERT INTO `purchase` VALUES ('462', 'P0511190011', '018', '国蜀鲜嫩牛肉', '', '1000', '16', '盘', '1', '2005-11-19 22:48:54', 'system', null);
INSERT INTO `purchase` VALUES ('463', 'P0511200001', '508', '面包排', '', '10000', '2', '份', '1', '2005-11-20 12:31:41', 'system', null);
INSERT INTO `purchase` VALUES ('464', 'P0511200002', '073', '生菜', '', '10000', '4', '盘', '1', '2005-11-20 12:40:26', 'system', null);
INSERT INTO `purchase` VALUES ('465', 'P0511200003', '093', '羊尾', '', '10000', '12', '盘', '1', '2005-11-20 12:41:48', 'system', null);
INSERT INTO `purchase` VALUES ('466', 'P0511200004', '021', '肥牛眼肉', '', '10000', '25', '盘', '1', '2005-11-20 12:42:39', 'system', null);
INSERT INTO `purchase` VALUES ('467', 'P0511200005', '040', '鲜虾滑', '', '100000', '28', '盘', '1', '2005-11-20 12:43:28', 'system', null);
INSERT INTO `purchase` VALUES ('468', 'P0511200006', '509', '黄瓜', '', '10000', '1', '根', '1', '2005-11-20 12:46:59', 'system', null);
INSERT INTO `purchase` VALUES ('469', 'P0511210001', '421', '小葱', '', '10000', '2', '份', '1', '2005-11-21 19:41:49', 'system', null);
INSERT INTO `purchase` VALUES ('470', 'P0511210002', '422', '拍黄瓜', '', '10000', '4', '盘', '1', '2005-11-21 20:13:25', 'system', null);
INSERT INTO `purchase` VALUES ('471', 'P0511220001', '423', '萝卜', '', '10000', '3', '份', '1', '2005-11-22 13:00:27', '002', null);
INSERT INTO `purchase` VALUES ('472', 'P0511220002', '510', '纯牛奶', '', '2', '1.5', '袋', '1', '2005-11-22 18:34:49', '002', null);
INSERT INTO `purchase` VALUES ('473', 'P0511230001', '511', '川椒', '', '10000', '2', '份', '1', '2005-11-23 19:32:07', '002', null);
INSERT INTO `purchase` VALUES ('474', 'P0511230002', '511', '川椒', '', '10000', '6', '份', '1', '2005-11-23 20:17:16', '002', null);
INSERT INTO `purchase` VALUES ('475', 'P0511250001', '512', '单饼', '', '1', '1', '张', '1', '2005-11-25 20:39:03', '002', null);
INSERT INTO `purchase` VALUES ('476', 'P1307220001', '001', '鸳鸯锅', '11', '0', '15', '个', '0', '2013-07-22 12:30:09', '001', 'U1307220002');
INSERT INTO `purchase` VALUES ('477', 'P1307220002', '005', '小锅', '11', '3', '5', '个', '1', '2013-07-22 12:32:08', '001', 'U1307220001');

-- ----------------------------
-- Table structure for `sell_main`
-- ----------------------------
DROP TABLE IF EXISTS `sell_main`;
CREATE TABLE `sell_main` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `InvoiceID` varchar(10) DEFAULT NULL,
  `AR` double DEFAULT '0',
  `PU` double DEFAULT '0',
  `Hang` tinyint(1) DEFAULT NULL COMMENT '售卖标志',
  `SellDate` datetime DEFAULT NULL,
  `UserName` varchar(12) DEFAULT NULL,
  `Remark` double DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `InvoiceID` (`InvoiceID`)
) ENGINE=InnoDB AUTO_INCREMENT=672 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sell_main
-- ----------------------------
INSERT INTO `sell_main` VALUES ('669', '1307200001', '40', '41', '1', '2013-07-20 17:23:33', '001', '0');
INSERT INTO `sell_main` VALUES ('670', '1307200002', '0', '0', '0', '2013-07-20 17:24:50', '001', '0');
INSERT INTO `sell_main` VALUES ('671', '1307220001', '25', '29', '1', '2013-07-22 10:47:04', '001', '0');

-- ----------------------------
-- Table structure for `sell_minor`
-- ----------------------------
DROP TABLE IF EXISTS `sell_minor`;
CREATE TABLE `sell_minor` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `InvoiceID` varchar(10) DEFAULT NULL COMMENT '出库编号',
  `BarCode` varchar(13) DEFAULT NULL COMMENT '条形码',
  `GoodsName` varchar(40) DEFAULT NULL COMMENT '产品名称',
  `Unit` varchar(10) DEFAULT NULL COMMENT '计量单位',
  `SellScalar` double DEFAULT '0' COMMENT '数量',
  `Agio` smallint(6) DEFAULT '0',
  `PurchasePrice` double DEFAULT '0' COMMENT '进价',
  `SellPrice` double DEFAULT '0' COMMENT '售价',
  `Subtotal` double DEFAULT '0' COMMENT '折扣',
  `Gift` varchar(4) DEFAULT NULL COMMENT '赠品',
  `UntreadFlag` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `BarCode` (`BarCode`),
  KEY `ID` (`ID`),
  KEY `InvoiceID` (`InvoiceID`)
) ENGINE=InnoDB AUTO_INCREMENT=7887 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sell_minor
-- ----------------------------
INSERT INTO `sell_minor` VALUES ('7881', '1307200001', '001', '鸳鸯锅', '个', '1', '100', '14.95', '15', '15', '-', '-');
INSERT INTO `sell_minor` VALUES ('7882', '1307200001', '002', '香辣中锅', '个', '1', '100', '14', '14', '14', '-', '-');
INSERT INTO `sell_minor` VALUES ('7883', '1307200001', '003', '白汤中锅', '个', '1', '100', '12', '12', '12', '-', '-');
INSERT INTO `sell_minor` VALUES ('7884', '1307200002', '001', '鸳鸯锅', '个', '1', '1', '14.95', '15', '0.15', '-', '-');
INSERT INTO `sell_minor` VALUES ('7885', '1307220001', '001', '鸳鸯锅', '个', '1', '100', '14.95', '15', '15', '-', '-');
INSERT INTO `sell_minor` VALUES ('7886', '1307220001', '002', '香辣中锅', '个', '1', '100', '14', '14', '14', '-', '-');

-- ----------------------------
-- Table structure for `stock`
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `BarCode` varchar(15) DEFAULT NULL COMMENT '条形码',
  `GoodsName` varchar(40) DEFAULT NULL COMMENT '产品名称',
  `PYBrevity` varchar(20) DEFAULT NULL COMMENT '拼音简称',
  `Unit` varchar(10) DEFAULT NULL COMMENT '计量单位',
  `PurchasePrice` double DEFAULT '0' COMMENT '进价',
  `SellPrice` double DEFAULT '0' COMMENT '售价',
  `StockScalar` double DEFAULT '0' COMMENT '库存数量',
  `Agio` smallint(6) DEFAULT '0' COMMENT '最高折扣',
  `StockBaseline` double DEFAULT '0' COMMENT '最低库存',
  `UntreadDate` smallint(6) DEFAULT '0' COMMENT '退货期限',
  PRIMARY KEY (`ID`),
  KEY `BarCode` (`BarCode`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stock
-- ----------------------------
INSERT INTO `stock` VALUES ('25', '001', '鸳鸯锅', 'yyg', '个', '14.95', '15', '609', '100', '10', '3');
INSERT INTO `stock` VALUES ('26', '005', '小锅', 'xg', '个', '5', '5', '9784', '66', '10', '3');
INSERT INTO `stock` VALUES ('27', '002', '香辣中锅', 'xlzg', '个', '14', '14', '977', '100', '10', '3');
INSERT INTO `stock` VALUES ('28', '003', '白汤中锅', 'btzg', '个', '12', '12', '923', '100', '10', '3');
INSERT INTO `stock` VALUES ('29', '004', '滋补锅', 'zbg', '个', '36', '36', '984', '100', '10', '3');
INSERT INTO `stock` VALUES ('30', '006', '国蜀调料', 'gstl', '份', '2', '2', '9276', '100', '10', '3');
INSERT INTO `stock` VALUES ('31', '007', '香辣调料', 'xltl', '份', '2', '2', '9759', '100', '10', '3');
INSERT INTO `stock` VALUES ('32', '008', '麻酱调料', 'mjtl', '份', '2', '2', '9283', '100', '10', '3');
INSERT INTO `stock` VALUES ('33', '009', '香油蒜泥', 'xysn', '份', '2', '2', '9963', '100', '10', '3');
INSERT INTO `stock` VALUES ('34', '010', '小料', 'xl', '份', '1', '1', '9901', '100', '10', '3');
INSERT INTO `stock` VALUES ('36', '013', '羔羊腿肉', 'gytr', '盘', '12', '12', '9907', '100', '10', '3');
INSERT INTO `stock` VALUES ('37', '012', '新西兰肥羊', 'fy', '盘', '10', '10', '19880', '100', '10', '3');
INSERT INTO `stock` VALUES ('38', '016', '羊肉滑', 'yrh', '盘', '18', '18', '9956', '100', '10', '3');
INSERT INTO `stock` VALUES ('40', '015', '羊腰', 'yy', '盘', '12', '12', '9986', '100', '10', '3');
INSERT INTO `stock` VALUES ('41', '017', '国蜀鲜嫩羊肉', 'xyr', '盘', '12', '12', '19994', '100', '10', '3');
INSERT INTO `stock` VALUES ('42', '018', '国蜀鲜嫩牛肉', 'xnr', '盘', '16', '16', '11983', '100', '10', '3');
INSERT INTO `stock` VALUES ('44', '023', '牛肉滑', 'nrh', '盘', '22', '22', '9986', '100', '10', '3');
INSERT INTO `stock` VALUES ('45', '020', '肥牛上脑', 'fnsn', '盘', '22', '22', '9992', '100', '10', '3');
INSERT INTO `stock` VALUES ('47', '022', 'A外脊肥牛', 'awjfn', '盘', '26', '26', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('48', '024', '猪五花', 'zwh', '盘', '10', '10', '9988', '100', '10', '3');
INSERT INTO `stock` VALUES ('49', '025', '腰花', 'yh', '盘', '10', '10', '9988', '100', '10', '3');
INSERT INTO `stock` VALUES ('50', '026', '青虾', 'qx', '盘', '18', '18', '9857.44', '100', '10', '3');
INSERT INTO `stock` VALUES ('51', '027', '扇贝', 'sb', '盘', '16', '16', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('52', '031', '花鲢鱼片', 'hlyp', '盘', '10', '10', '9981', '100', '10', '3');
INSERT INTO `stock` VALUES ('53', '028', '蛎蝗', 'lh', '盘', '12', '12', '9992', '100', '10', '3');
INSERT INTO `stock` VALUES ('54', '029', '海兔', 'ht', '盘', '12', '12', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('55', '030', '墨鱼仔', 'myz', '盘', '15', '15', '9981', '100', '10', '3');
INSERT INTO `stock` VALUES ('56', '032', '三文鱼生吃(小)', 'swyscx', '盘', '22', '22', '9993', '100', '10', '3');
INSERT INTO `stock` VALUES ('57', '033', '三文鱼生吃(大)', 'swyscd', '盘', '38', '38', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('58', '034', '鲜鱿鱼卷', 'xyyj', '盘', '16', '16', '9983', '100', '10', '3');
INSERT INTO `stock` VALUES ('59', '035', '基围虾', 'jwx', '斤', '108', '108', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('60', '036', '河蟹', 'hx', '斤', '38', '38', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('61', '037', '海蟹', 'hx', '斤', '200', '200', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('62', '038', '黑鱼两吃', 'hylc', '斤', '22', '22', '9994.2', '100', '10', '3');
INSERT INTO `stock` VALUES ('63', '039', '鲜鱼滑', 'xyh', '盘', '22', '22', '9945', '100', '10', '3');
INSERT INTO `stock` VALUES ('65', '041', '百叶', 'by', '盘', '12', '12', '9961', '100', '10', '3');
INSERT INTO `stock` VALUES ('66', '042', '毛肚', 'md', '盘', '12', '12', '9915', '100', '10', '3');
INSERT INTO `stock` VALUES ('67', '043', '鸭肠', 'yc', '盘', '12', '12', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('68', '044', '午餐肉', 'wcr', '盘', '12', '12', '9993', '100', '10', '3');
INSERT INTO `stock` VALUES ('69', '045', '黄喉', 'hh', '盘', '15', '15', '9981', '100', '10', '3');
INSERT INTO `stock` VALUES ('70', '046', '牛骨髓', 'ngs', '盘', '15', '15', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('71', '047', '鸭血', 'yx', '盘', '4', '4', '9920', '100', '10', '3');
INSERT INTO `stock` VALUES ('73', '049', '鲜蘑', 'xm', '盘', '4', '4', '9948', '100', '10', '3');
INSERT INTO `stock` VALUES ('74', '050', '香菇蘑', 'xgm', '盘', '5', '5', '9964', '100', '10', '3');
INSERT INTO `stock` VALUES ('76', '052', '鸡腿蘑', 'jtm', '盘', '8', '8', '9992', '100', '10', '3');
INSERT INTO `stock` VALUES ('77', '053', '乳牛肝蘑', 'rngm', '盘', '12', '12', '9992', '100', '10', '3');
INSERT INTO `stock` VALUES ('78', '054', '彩云蘑', 'cym', '盘', '12', '12', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('79', '055', '鲍鱼菇', 'byg', '盘', '12', '12', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('80', '056', '猴头菇', 'htg', '盘', '12', '12', '9994', '100', '10', '3');
INSERT INTO `stock` VALUES ('81', '057', '罗汉竹笋', 'lhzs', '盘', '5', '5', '9989', '100', '10', '3');
INSERT INTO `stock` VALUES ('82', '058', '黑木耳', 'hme', '盘', '6', '6', '9956', '100', '10', '3');
INSERT INTO `stock` VALUES ('83', '059', '海带片', 'hdp', '盘', '4', '4', '9967', '100', '10', '3');
INSERT INTO `stock` VALUES ('84', '060', '海带根', 'hdg', '盘', '5', '5', '9846', '100', '10', '3');
INSERT INTO `stock` VALUES ('85', '061', '宽粉', 'kf', '盘', '4', '4', '9837', '100', '10', '3');
INSERT INTO `stock` VALUES ('86', '062', '粉丝', 'fs', '盘', '4', '4', '9965', '100', '10', '3');
INSERT INTO `stock` VALUES ('87', '063', '水晶粉', 'sjf', '盘', '5', '5', '9954', '100', '10', '3');
INSERT INTO `stock` VALUES ('88', '064', '鲜豆腐', 'xdf', '盘', '3', '3', '9945', '100', '10', '3');
INSERT INTO `stock` VALUES ('89', '065', '冻豆腐 ', 'ddf', '盘', '3', '3', '9767', '100', '10', '3');
INSERT INTO `stock` VALUES ('90', '066', '油豆腐皮', 'ydfp', '盘', '4', '4', '9956', '100', '10', '3');
INSERT INTO `stock` VALUES ('92', '068', '土豆片', 'tdp', '盘', '4', '4', '9937', '100', '10', '3');
INSERT INTO `stock` VALUES ('93', '069', '红薯 ', 'hs', '盘', '4', '4', '9890', '100', '10', '3');
INSERT INTO `stock` VALUES ('94', '070', '冬瓜', 'dg', '盘', '4', '4', '9942', '100', '10', '3');
INSERT INTO `stock` VALUES ('95', '071', '茼蒿', 'th', '盘', '4', '4', '9762', '100', '10', '3');
INSERT INTO `stock` VALUES ('96', '072', '菠菜', 'bc', '盘', '4', '4', '9883', '100', '10', '3');
INSERT INTO `stock` VALUES ('98', '074', '香菜', 'xc', '盘', '4', '4', '9812', '100', '10', '3');
INSERT INTO `stock` VALUES ('99', '075', '大白菜', 'dbc', '盘', '4', '4', '9838', '100', '10', '3');
INSERT INTO `stock` VALUES ('101', '077', '西饼', 'xb', '个', '1', '1', '9981', '100', '10', '3');
INSERT INTO `stock` VALUES ('102', '078', '金馒头', 'jmt', '份', '6', '6', '9944', '100', '10', '3');
INSERT INTO `stock` VALUES ('103', '079', '油炸麻团', 'yzmt', '份', '8', '8', '9988', '100', '10', '3');
INSERT INTO `stock` VALUES ('104', '080', '红薯饼', 'hsb', '份', '8', '8', '9989.75', '100', '10', '3');
INSERT INTO `stock` VALUES ('105', '081', '南瓜饼', 'ngb', '份', '8', '8', '9964', '100', '10', '3');
INSERT INTO `stock` VALUES ('106', '082', '虾饺', 'xj', '份', '8', '8', '9985', '100', '10', '3');
INSERT INTO `stock` VALUES ('108', '084', '龙须面', 'lxm', '份', '3', '3', '9973.98', '100', '10', '3');
INSERT INTO `stock` VALUES ('109', '085', '娃娃菜', 'wwc', '盘', '6', '6', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('110', '086', '酸菜丝', 'scs', '盘', '3', '3', '9981', '100', '10', '3');
INSERT INTO `stock` VALUES ('111', '087', '藕片', 'op', '盘', '5', '5', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('112', '088', '西红柿', 'xhs', '盘', '4', '4', '9980', '100', '10', '3');
INSERT INTO `stock` VALUES ('113', '089', '蟹足棒', 'xzb', '盘', '8', '8', '9977', '100', '10', '3');
INSERT INTO `stock` VALUES ('114', '090', '鱼丸', 'yw', '盘', '10', '10', '9991', '100', '10', '3');
INSERT INTO `stock` VALUES ('115', '091', '虾丸', 'xw', '盘', '10', '10', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('116', '092', '蟹肉', 'xr', '份', '10', '10', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('118', '094', '羊宝', 'yb', '盘', '18', '18', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('120', '096', '牛宝', 'nb', '盘', '12', '12', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('121', '097', '意粉', 'yf', '盘', '3', '3', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('122', '098', '疙瘩汤', 'gdt', '份', '10', '10', '9990.5', '100', '10', '3');
INSERT INTO `stock` VALUES ('123', '099', '三鲜烙合', 'sxlh', '个', '2', '2', '9838', '100', '10', '3');
INSERT INTO `stock` VALUES ('124', '100', '豆沙饼', 'dsb', '个', '1', '1', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('125', '101', '葱油饼', 'cyb', '个', '1', '1', '9947', '100', '10', '3');
INSERT INTO `stock` VALUES ('126', '102', '扬州炒饭', 'yzcf', '盘', '10', '10', '9987.8', '100', '10', '3');
INSERT INTO `stock` VALUES ('127', '076', '小白菜', 'xbc', '盘', '4', '4', '9935', '100', '10', '3');
INSERT INTO `stock` VALUES ('128', '051', '金针蘑', 'jzm', '盘', '10', '10', '9947', '100', '10', '3');
INSERT INTO `stock` VALUES ('129', '202', '珍酒三年陈酿', 'zjsncl', '瓶', '45', '45', '99998', '100', '10', '3');
INSERT INTO `stock` VALUES ('130', '200', '金三鞭55', 'jsb55', '斤', '48', '48', '9973.7', '100', '10', '3');
INSERT INTO `stock` VALUES ('132', '203', '珍酒五年陈酿', 'zjwncl', '瓶', '58', '58', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('133', '204', '珍酒十年陈酿(半斤)', 'zjsncnbj', '瓶', '68', '68', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('134', '205', '珍酒十年陈酿 ', 'zjsncn', '瓶', '108', '108', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('135', '206', '宁城老窖八年陈酿', 'ncljbncn', '瓶', '78', '78', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('136', '207', '宁城老窖五年陈酿', 'ncljwncn', '瓶', '48', '48', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('137', '208', '宁城老窖极品38', 'ncljjp38', '瓶', '68', '68', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('138', '209', '宁城老窖极品36', 'ncljjp36', '瓶', '32', '32', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('139', '210', '宁城老窖二星', 'ncljex', '瓶', '52', '52', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('140', '211', '宁城老窖福星', 'ncljfx', '瓶', '15', '15', '9987', '100', '10', '3');
INSERT INTO `stock` VALUES ('141', '212', '裕井烧坊经典', 'yjsfjd', '瓶', '128', '128', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('142', '213', '裕井三百年陈酿', 'yjsbncn', '瓶', '48', '48', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('143', '214', '裕井十年陈酿 ', 'yjsncn', '瓶', '24', '24', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('144', '215', '裕井烧坊简装', 'yjsfjz', '瓶', '18', '18', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('145', '216', '裕井小酒蒌', 'yjxjl', '瓶', '10', '10', '9982', '100', '10', '3');
INSERT INTO `stock` VALUES ('146', '217', '裕井小酒壶', 'yjxjh', '瓶', '6', '6', '9993', '100', '10', '3');
INSERT INTO `stock` VALUES ('147', '218', '精品河套王', 'JPHTW', '瓶', '128', '128', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('148', '219', '河套金尊', 'htjz', '瓶', '68', '68', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('149', '220', '河套银尊', 'htyz', '瓶', '48', '48', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('150', '221', '河套合口福', 'hthkf', '瓶', '58', '58', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('151', '222', '河套福星52', 'htfx52', '瓶', '30', '30', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('152', '223', '河套福星38', 'htfx38', '瓶', '28', '28', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('153', '224', '河套纯粮', 'htcl', '瓶', '15', '15', '9935', '100', '10', '3');
INSERT INTO `stock` VALUES ('154', '225', '太白毫杰酒', 'tbhjj', '瓶', '48', '48', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('155', '226', '太白巴乡村', 'tbbxc', '瓶', '28', '28', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('156', '227', '诗仙太白简装', 'sxtbjz', '瓶', '18', '18', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('157', '228', '凤城老窖一星', 'fcljyx', '瓶', '58', '58', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('158', '229', '凤城老窖金蒙', 'fcljjm', '瓶', '48', '48', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('159', '230', '凤城老窖银蒙', 'fcljym', '瓶', '38', '38', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('160', '231', '凤城原浆', 'fcyj', '瓶', '15', '15', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('161', '232', '五粮醇', 'wlc', '瓶', '58', '58', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('162', '233', '五粮醇(三)', 'wlcs', '瓶', '108', '108', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('163', '234', '小火爆', 'xhb', '瓶', '8', '8', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('164', '235', '三星杞浓', 'sxqn', '瓶', '98', '98', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('165', '236', '老池酒 ', 'lcj', '瓶', '288', '288', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('166', '237', '乾豫兴老窖精品', 'qyxljjp', '瓶', '108', '108', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('167', '238', '乾豫兴', 'qyx', '瓶', '58', '58', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('168', '239', '烧锅酒', 'sgj', '瓶', '20', '20', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('169', '240', '四特陈酿', 'stcn', '瓶', '68', '68', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('170', '241', '国宾四特', 'gbst', '瓶', '48', '48', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('171', '242', '店小二38', 'dxe38', '瓶', '36', '36', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('172', '243', '店小二46', 'dxe46', '瓶', '46', '46', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('173', '244', '庄家汉简装', 'zjhjz', '瓶', '18', '18', '9985', '100', '10', '3');
INSERT INTO `stock` VALUES ('174', '245', '庄家汉盒装', 'zjhhz', '瓶', '58', '58', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('175', '246', '长城红色庄园', 'cchszy', '瓶', '128', '128', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('176', '247', '长城干红赤霞珠', 'ccghcxz', '瓶', '98', '98', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('177', '248', '长城干红葡萄酒制醇', 'ccghptjzc', '瓶', '38', '38', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('178', '249', '解佰纳干红葡萄酒', 'jbnghptj', '瓶', '78', '78', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('179', '250', '简农达红酒', 'jndhj', '瓶', '38', '38', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('180', '251', '燕京无醇', 'yjwc', '瓶', '15', '15', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('181', '252', '荞麦干啤', 'qmgp', '瓶', '10', '10', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('182', '253', '燕京纯生', 'yjcs', '瓶', '10', '10', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('183', '254', '哈干', 'hg', '瓶', '10', '10', '9991', '100', '10', '3');
INSERT INTO `stock` VALUES ('184', '255', '哈鲜', 'hx', '瓶', '8', '8', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('185', '256', '燕京普啤', 'yjpp', '瓶', '2', '2', '9791', '100', '10', '3');
INSERT INTO `stock` VALUES ('186', '257', '汇源高纤维', 'hygxw', '盒', '25', '25', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('187', '258', '汇源果汁100%', 'hygz100%', '盒', '20', '20', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('188', '259', '汇源果汁50%', 'hygz50%', '瓶', '10', '10', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('189', '260', '雪碧(大)', 'xbd', '瓶', '10', '10', '9994', '100', '10', '3');
INSERT INTO `stock` VALUES ('190', '263', '可口可乐(厅)', 'kkklt', '厅', '3', '3', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('191', '264', '百事可乐(厅)', 'bsklt', '厅', '3', '3', '9991', '100', '10', '3');
INSERT INTO `stock` VALUES ('192', '265', '雪碧(厅)', 'xbt', '厅', '3', '3', '9981', '100', '10', '3');
INSERT INTO `stock` VALUES ('193', '266', '百事可乐(中)', 'bsklz', '瓶', '4', '4', '9987', '100', '10', '3');
INSERT INTO `stock` VALUES ('194', '262', '百事可乐(大)', 'bskld', '桶', '10', '10', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('195', '261', '可口可乐(大)', 'kkkld', '瓶', '10', '10', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('196', '267', '矿泉水', 'kqs', '瓶', '2', '2', '9988', '100', '10', '3');
INSERT INTO `stock` VALUES ('197', '268', '杏仁乳', 'xrr', '瓶', '2', '2', '9993', '100', '10', '3');
INSERT INTO `stock` VALUES ('198', '269', '花生奶', 'hsn', '壶', '12', '12', '9948', '100', '10', '3');
INSERT INTO `stock` VALUES ('199', '270', '硬中华', 'yzh', '盒', '60', '60', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('200', '271', '苁 蓉', 'cr', '盒', '15', '15', '9988', '100', '10', '3');
INSERT INTO `stock` VALUES ('201', '272', '红国宾', 'hgb', '盒', '13', '13', '9970', '100', '10', '3');
INSERT INTO `stock` VALUES ('202', '273', '环保白沙', 'hbbs', '盒', '12', '12', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('203', '274', '红云', 'hy', ' 盒', '10', '10', '9985', '100', '10', '3');
INSERT INTO `stock` VALUES ('204', '275', '蓝国宾', 'lgb', '盒 ', '8', '8', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('205', '019', '精品肥牛', 'jpfn', '盘', '18', '18', '9957', '100', '10', '3');
INSERT INTO `stock` VALUES ('206', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('207', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('208', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('209', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('210', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('211', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('212', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('213', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('214', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('215', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('216', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('217', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('218', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('219', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('220', '048', '羊血', 'yangx', '盘', '4', '4', '9960', '100', '10', '3');
INSERT INTO `stock` VALUES ('221', '095', '牛鞭', 'nb', '盘', '15', '15', '19995', '100', '10', '3');
INSERT INTO `stock` VALUES ('222', '300', '八宝茶', 'bbc', '杯', '1', '1', '9838', '100', '10', '3');
INSERT INTO `stock` VALUES ('223', '067', '腐竹', 'fz', '盘', '5', '5', '9984', '100', '10', '3');
INSERT INTO `stock` VALUES ('225', '301', '筷子', 'kz', '双', '1', '1', '98086', '100', '10', '3');
INSERT INTO `stock` VALUES ('226', '276', '山水啤酒', 'sspj', '瓶', '3', '3', '97922', '100', '10', '3');
INSERT INTO `stock` VALUES ('227', '401', '小葱拌虾仁', 'xcbxr', '盘', '4', '4', '9971', '100', '10', '3');
INSERT INTO `stock` VALUES ('228', '400', '糖醋蒜', 'tcs', '盘', '3', '3', '99920.6', '100', '10', '3');
INSERT INTO `stock` VALUES ('229', '402', '青瓜牛肉', 'qgnr', '盘', '6', '6', '9994', '100', '10', '3');
INSERT INTO `stock` VALUES ('230', '403', '杏仁蕨菜', 'xrjc', '盘', '5', '5', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('231', '404', '陈醋花生米', 'cchsm', '盘', '4', '4', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('232', '405', '炝拌干丝', 'qbgs', '盘', '4', '4', '99990', '100', '10', '3');
INSERT INTO `stock` VALUES ('233', '406', '椒麻凤爪', 'jmfz', '盘', '8', '8', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('234', '407', '鲅鱼焖豆', 'bymd', '盘', '6', '6', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('235', '408', '脆耳瓜丝', 'crgs', '盘', '6', '6', '9998.5', '100', '10', '3');
INSERT INTO `stock` VALUES ('236', '409', '美极拌菜', 'mjbc', '盘', '4', '4', '100000', '100', '10', '3');
INSERT INTO `stock` VALUES ('237', '410', '干烧银鱼 ', 'gsyy', '盘', '4', '4', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('238', '411', '三鲜炝菠菜', 'sxqbc', '盘', '5', '5', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('239', '412', '盐爆花生米', 'ybhsm', '盘', '4', '4', '9979', '100', '10', '3');
INSERT INTO `stock` VALUES ('240', '413', '四喜豆付', 'sxdf', '盘', '5', '5', '9993', '100', '10', '3');
INSERT INTO `stock` VALUES ('241', '414', '拌皮冻', 'bpd', '盘', '4', '4', '9989', '100', '10', '3');
INSERT INTO `stock` VALUES ('242', '415', '孜然鸡脖', 'zrjb', '盘', '8', '8', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('243', '416', '香辣毛肚', 'xlmd', '盘', '7', '8', '19996', '100', '10', '3');
INSERT INTO `stock` VALUES ('244', '417', '红梅卧雪', 'hmwx', '盘', '4', '4', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('245', '418', '凉拌三鲜', 'lbsx', '盘', '5', '5', '9987', '100', '10', '3');
INSERT INTO `stock` VALUES ('246', '419', '小白菜拌木耳', 'xbcbme', '盘', '4', '4', '100000', '100', '10', '3');
INSERT INTO `stock` VALUES ('247', '420', '牛肉耳段', 'nred', '盘', '6', '6', '99994', '100', '10', '3');
INSERT INTO `stock` VALUES ('248', '281', '水煮黑鱼', 'szhy', '斤', '36', '36', '19999', '100', '10', '3');
INSERT INTO `stock` VALUES ('249', '277', '海味火锅', 'hwhg', '个', '58', '58', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('250', '278', '香辣蟹火锅', 'xlxhg', '个', '48', '48', '9991', '100', '10', '3');
INSERT INTO `stock` VALUES ('251', '279', '花鲢鱼火锅', 'hlyhg', '个', '36', '36', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('253', '288', '手擀面', 'sgm', '份', '6', '6', '99991', '100', '10', '3');
INSERT INTO `stock` VALUES ('256', '280', '水煮鱼草鱼', 'szcy', '斤', '22', '22', '9990.7', '100', '10', '3');
INSERT INTO `stock` VALUES ('257', '282', '乌鸡甲鱼锅', 'wjjyg', '个', '88', '88', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('258', '283', '鲜对虾丸', 'xdxw', '盘', '36', '36', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('259', '284', '辣根', 'lg', '份', '2', '2', '9995', '100', '10', '3');
INSERT INTO `stock` VALUES ('260', '285', '泥螺', 'nl', '盘', '10', '10', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('261', '286', '果盘', 'gp', '盘', '10', '10', '9988', '100', '10', '3');
INSERT INTO `stock` VALUES ('262', '287', '扑克', 'pk', '副', '2', '2', '9992', '100', '10', '3');
INSERT INTO `stock` VALUES ('263', '289', '歌曲', 'gq', '首', '20', '20', '9993', '100', '10', '3');
INSERT INTO `stock` VALUES ('264', '290', '泡椒 ', 'pj', '份', '2', '2', '9993', '100', '10', '3');
INSERT INTO `stock` VALUES ('265', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('266', '014', '羊脑', 'yn', '盘', '12', '12', '9988', '100', '10', '3');
INSERT INTO `stock` VALUES ('267', '083', '菜汁面条', 'czm', '份', '6', '6', '19907', '100', '10', '3');
INSERT INTO `stock` VALUES ('268', '201', '银三鞭55', 'ysb55', '斤', '28', '28', '9977.1', '100', '10', '3');
INSERT INTO `stock` VALUES ('269', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('270', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('271', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('272', '500', '酒精', 'jj', '个', '1', '1', '9942', '100', '10', '3');
INSERT INTO `stock` VALUES ('273', '501', '玉米饼', 'ymb', '份', '4', '4', '9997', '100', '10', '3');
INSERT INTO `stock` VALUES ('274', '502', '四野泡菜', 'sypc', '盘', '4', '4', '9994.5', '100', '10', '3');
INSERT INTO `stock` VALUES ('275', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('276', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('277', '504', '生鸡蛋', 'sjd', '个', '0.5', '0.5', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('278', '011', '锡盟羔羊', 'gy', '盘', '10', '10', '9078', '100', '10', '3');
INSERT INTO `stock` VALUES ('279', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('280', '503', '米饭', 'mf', '碗', '1', '1', '9986', '100', '10', '3');
INSERT INTO `stock` VALUES ('281', '505', '长寿面', 'csm', '碗', '12', '12', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('282', '506', '油菜', 'y', '份', '4', '4', '983', '100', '10', '3');
INSERT INTO `stock` VALUES ('283', '507', '韭菜', 'jc', '份', '4', '4', '10000', '100', '10', '3');
INSERT INTO `stock` VALUES ('284', '508', '面包排', 'mbp', '份', '2', '2', '9999', '100', '10', '3');
INSERT INTO `stock` VALUES ('285', '073', '生菜', 'sc', '盘', '4', '4', '9936', '100', '10', '3');
INSERT INTO `stock` VALUES ('286', '093', '羊尾', 'yw', '盘', '12', '12', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('287', '021', '肥牛眼肉', 'yr', '盘', '25', '25', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('288', '040', '鲜虾滑', 'xh', '盘', '28', '28', '99988', '100', '10', '3');
INSERT INTO `stock` VALUES ('289', '509', '黄瓜', 'hg', '根', '1', '1', '9984', '100', '10', '3');
INSERT INTO `stock` VALUES ('290', '421', '小葱', 'xc', '份', '2', '2', '9998', '100', '10', '3');
INSERT INTO `stock` VALUES ('291', '422', '拍黄瓜', 'phg', '盘', '4', '4', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('292', null, null, null, null, '0', '0', '0', '0', '0', '0');
INSERT INTO `stock` VALUES ('293', '423', '萝卜', 'lb', '份', '3', '3', '9996', '100', '10', '3');
INSERT INTO `stock` VALUES ('294', '510', '纯牛奶', 'cnn', '袋', '1.5', '1.5', '0', '100', '10', '3');
INSERT INTO `stock` VALUES ('295', '511', '川椒', 'cj', '份', '4', '6', '19999', '100', '10', '3');
INSERT INTO `stock` VALUES ('296', '512', '单饼', 'db', '张', '1', '1', '0', '100', '10', '3');
INSERT INTO `stock` VALUES ('297', null, null, null, null, '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `unit`
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UnitName` varchar(10) DEFAULT NULL COMMENT '计量名称',
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit` VALUES ('7', '盒');
INSERT INTO `unit` VALUES ('10', '瓶');
INSERT INTO `unit` VALUES ('12', '盘');
INSERT INTO `unit` VALUES ('13', '份');
INSERT INTO `unit` VALUES ('14', '个');
INSERT INTO `unit` VALUES ('15', '斤');
INSERT INTO `unit` VALUES ('16', 'sha');

-- ----------------------------
-- Table structure for `unstock`
-- ----------------------------
DROP TABLE IF EXISTS `unstock`;
CREATE TABLE `unstock` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `InvoiceID` varchar(11) DEFAULT NULL COMMENT '退货单号',
  `PID` varchar(11) DEFAULT NULL COMMENT '采购单号',
  `BarCode` varchar(15) DEFAULT NULL COMMENT '条形码',
  `GoodsName` varchar(40) DEFAULT NULL COMMENT '产品名称',
  `Unit` varchar(10) DEFAULT NULL COMMENT '计量单位',
  `UnitPrice` double DEFAULT '0' COMMENT '采购价格',
  `UNScalar` double DEFAULT '0' COMMENT '退货数量',
  `UNDate` datetime DEFAULT NULL COMMENT '退货日期',
  `UserName` varchar(12) DEFAULT NULL COMMENT '操作员',
  PRIMARY KEY (`ID`),
  KEY `BarCode` (`BarCode`),
  KEY `ID` (`ID`),
  KEY `InvoiceID` (`InvoiceID`),
  KEY `PID` (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unstock
-- ----------------------------
INSERT INTO `unstock` VALUES ('1', 'U1307220001', 'P1307220002', '005', '小锅', '个', '5', '1', '2013-07-22 12:36:40', '001');
INSERT INTO `unstock` VALUES ('2', 'U1307220002', 'P1307220001', '001', '鸳鸯锅', '个', '15', '1', '2013-07-22 12:37:25', '001');
INSERT INTO `unstock` VALUES ('3', 'U1307230001', 'P0511070013', '011', '锡盟羔羊', '盘', '10', '23', '2013-07-23 11:45:47', '002');

-- ----------------------------
-- Table structure for `vip_1`
-- ----------------------------
DROP TABLE IF EXISTS `vip_1`;
CREATE TABLE `vip_1` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(12) DEFAULT NULL COMMENT '会员姓名',
  `Address` varchar(40) DEFAULT NULL COMMENT '地址',
  `Tel` varchar(15) DEFAULT NULL COMMENT '电话',
  `Money` double DEFAULT '0' COMMENT '卡片余额',
  `VipID` varchar(15) DEFAULT NULL COMMENT '卡号',
  `Remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `State` varchar(4) DEFAULT NULL COMMENT '状态',
  `UserName` varchar(12) DEFAULT NULL COMMENT '发卡员',
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `VipID` (`VipID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vip_1
-- ----------------------------
INSERT INTO `vip_1` VALUES ('1', '1', '1', '1', '124456', '111111111111111', '1', '挂失', '001');

-- ----------------------------
-- Table structure for `vip_2`
-- ----------------------------
DROP TABLE IF EXISTS `vip_2`;
CREATE TABLE `vip_2` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VipID` varchar(15) DEFAULT NULL,
  `InvoiceID` varchar(10) DEFAULT NULL,
  `Money` double DEFAULT '0',
  `UserName` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `InvoiceID` (`InvoiceID`),
  KEY `VipID` (`VipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vip_2
-- ----------------------------

-- ----------------------------
-- Table structure for `vip_3`
-- ----------------------------
DROP TABLE IF EXISTS `vip_3`;
CREATE TABLE `vip_3` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `VipID` varchar(15) DEFAULT NULL COMMENT '卡号',
  `Money` double DEFAULT '0' COMMENT '充值金额',
  `Date` datetime DEFAULT NULL COMMENT '充值日期',
  `UserName` varchar(12) DEFAULT NULL COMMENT '充值员',
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `VipID` (`VipID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vip_3
-- ----------------------------
INSERT INTO `vip_3` VALUES ('1', '111111111111111', '1000', '2013-07-22 16:21:02', '001');
INSERT INTO `vip_3` VALUES ('2', '111111111111111', '123456', '2013-07-23 10:26:42', '002');

-- ----------------------------
-- Table structure for `vip_4`
-- ----------------------------
DROP TABLE IF EXISTS `vip_4`;
CREATE TABLE `vip_4` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VipID` varchar(15) DEFAULT NULL,
  `NewID` varchar(15) DEFAULT NULL,
  `Date` varchar(50) DEFAULT NULL,
  `UserName` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `NewID` (`NewID`),
  KEY `VipID` (`VipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vip_4
-- ----------------------------
