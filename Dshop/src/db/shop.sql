/*
navicat mysql data transfer

source server         : 54.250.177.126
source server version : 50532
source host           : 54.250.177.126:3306
source database       : shop

target server type    : mysql
target server version : 50532
file encoding         : 65001

date: 2013-08-06 19:45:04
*/

set foreign_key_checks=0;

-- ----------------------------
-- table structure for `bankcard`
-- ----------------------------
drop table if exists `bankcard`;
create table `bankcard` (
  `id` varchar(32) not null,
  `name` varchar(100) not null,
  `note` varchar(1000) not null,
  primary key (`id`)
) engine=innodb default charset=utf8;

-- ----------------------------
-- records of bankcard
-- ----------------------------

-- ----------------------------
-- table structure for `barcode`
-- ----------------------------
drop table if exists `barcode`;
create table `barcode` (
  `goodsname` varchar(30) not null comment '产品名称',
  `barcode` varchar(13) not null comment '条形码',
  `unit` varchar(4) not null comment '计量单位',
  primary key (`barcode`),
  key `barcode` (`barcode`)
) engine=innodb default charset=utf8;

-- ----------------------------
-- records of barcode
-- ----------------------------

-- ----------------------------
-- table structure for `feeder`
-- ----------------------------
drop table if exists `feeder`;
create table `feeder` (
  `id` int(11) not null auto_increment comment '主键',
  `feederid` varchar(4) default null comment '供应商编号',
  `feedername` varchar(40) default null comment '供应商姓名',
  `linkman` varchar(12) default null comment '联系人',
  `address` varchar(40) default null comment '地址',
  `zipcode` varchar(6) default null comment '邮编',
  `tel` varchar(15) default null comment '电话',
  `fax` varchar(15) default null comment '传真',
  primary key (`id`),
  key `feederid` (`feederid`),
  key `id` (`id`),
  key `zipcode` (`zipcode`)
) engine=innodb auto_increment=4 default charset=utf8;

-- ----------------------------
-- records of feeder
-- ----------------------------
insert into `feeder` values ('1', '1', '11', '1', '1', '1', '1', '1');
insert into `feeder` values ('2', '1', '222', '1', '1', '1', '1', '1');
insert into `feeder` values ('3', '1', '333', '1', '1', '1', '1', '1');

-- ----------------------------
-- table structure for `kjfl`
-- ----------------------------
drop table if exists `kjfl`;
create table `kjfl` (
  `编号` varchar(32) character set utf8 not null,
  `科目代码` varchar(8) character set utf8 not null,
  `科目名称` varchar(100) character set utf8 not null,
  `借贷方向` varchar(1) character set utf8 not null,
  `日期` datetime not null,
  `凭证编号` varchar(32) character set utf8 not null,
  `金额` double not null,
  `经办人` varchar(8) character set utf8 not null,
  `备注` varchar(1000) character set utf8 not null,
  primary key (`编号`)
) engine=innodb default charset=latin1;

-- ----------------------------
-- records of kjfl
-- ----------------------------

-- ----------------------------
-- table structure for `km`
-- ----------------------------
drop table if exists `km`;
create table `km` (
  `顺序号` int(11) not null,
  `科目分类` varchar(100) character set utf8 not null comment '科目分类',
  `科目代码` varchar(8) character set utf8 not null comment '科目代码',
  `科目名称` varchar(100) character set utf8 not null comment '科目名称',
  `父科目代码` varchar(8) character set utf8 not null comment '父科目代码',
  `备注` varchar(1000) character set utf8 default null comment '备注',
  primary key (`科目代码`)
) engine=innodb default charset=latin1;

-- ----------------------------
-- records of km
-- ----------------------------
insert into `km` values ('1', '资产类', '1001', '库存现金', '', '在用');
insert into `km` values ('2', '资产类', '1002', '银行存款', '', '在用');
insert into `km` values ('5', '资产类', '1015', '其他货币资金', '', null);
insert into `km` values ('8', '资产类', '1101', '交易性金融资产', '', null);
insert into `km` values ('10', '资产类', '1121', '应收票据', '', '在用');
insert into `km` values ('11', '资产类', '1122', '应收账款', '', '在用');
insert into `km` values ('12', '资产类', '1123', '预付账款', '', '在用');
insert into `km` values ('13', '资产类', '1131', '应收股利', '', null);
insert into `km` values ('14', '资产类', '1132', '应收利息', '', null);
insert into `km` values ('18', '资产类', '1221', '其他应收款', '', null);
insert into `km` values ('19', '资产类', '1231', '坏账准备', '', null);
insert into `km` values ('26', '资产类', '1401', '材料采购', '', null);
insert into `km` values ('27', '负债类', '1402', '在途物资', '', '在用');
insert into `km` values ('28', '资产类', '1403', '原材料', '', null);
insert into `km` values ('29', '资产类', '1404', '材料成本差异', '', null);
insert into `km` values ('30', '资产类', '1405', '库存商品', '', '在用');
insert into `km` values ('31', '资产类', '1406', '发出商品', '', '在用');
insert into `km` values ('32', '资产类', '1407', '商品进销差价', '', null);
insert into `km` values ('33', '资产类', '1408', '委托加工物资', '', null);
insert into `km` values ('34', '资产类', '1411', '周转材料', '', null);
insert into `km` values ('40', '资产类', '1471', '存货跌价准备', '', '在用');
insert into `km` values ('41', '资产类', '1501', '持有至到期投资', '', null);
insert into `km` values ('42', '资产类', '1502', '持有至到期投资减值准备', '', null);
insert into `km` values ('43', '资产类', '1503', '可供出售金融资产', '', null);
insert into `km` values ('44', '资产类', '1511', '长期股权投资', '', null);
insert into `km` values ('45', '资产类', '1512', '长期股权投资减值准备', '', null);
insert into `km` values ('46', '资产类', '1521', '投资性房地产', '', null);
insert into `km` values ('47', '资产类', '1531', '长期应收款', '', null);
insert into `km` values ('48', '资产类', '1532', '未实现融资收益', '', null);
insert into `km` values ('50', '资产类', '1601', '固定资产', '', '在用');
insert into `km` values ('51', '资产类', '1602', '累计折旧', '', null);
insert into `km` values ('52', '资产类', '1603', '固定资产减值准备', '', '在用');
insert into `km` values ('53', '资产类', '1604', '在建工程', '', null);
insert into `km` values ('54', '资产类', '1605', '工程物资', '', null);
insert into `km` values ('55', '资产类', '1606', '固定资产清理', '', '在用');
insert into `km` values ('62', '资产类', '1701', '无形资产', '', null);
insert into `km` values ('63', '资产类', '1702', '累计摊销', '', null);
insert into `km` values ('64', '资产类', '1703', '无形资产减值准备', '', null);
insert into `km` values ('65', '资产类', '1711', '商誉', '', null);
insert into `km` values ('66', '资产类', '1801', '长期待摊费用', '', null);
insert into `km` values ('67', '资产类', '1811', '递延所得税资产', '', null);
insert into `km` values ('69', '资产类', '1901', '待处理财产损溢', '', null);
insert into `km` values ('70', '负债类', '2001', '短期借款', '', null);
insert into `km` values ('77', '负债类', '2101', '交易性金融负债', '', null);
insert into `km` values ('79', '负债类', '2201', '应付票据', '', '在用');
insert into `km` values ('80', '负债类', '2202', '应付账款', '', '在用');
insert into `km` values ('81', '负债类', '2203', '预收账款', '', '在用');
insert into `km` values ('82', '负债类', '2211', '应付职工薪酬', '', '在用');
insert into `km` values ('83', '负债类', '2221', '应交税费', '', null);
insert into `km` values ('84', '负债类', '2231', '应付利息', '', null);
insert into `km` values ('85', '负债类', '2232', '应付股利', '', null);
insert into `km` values ('86', '负债类', '2241', '其他应付款', '', null);
insert into `km` values ('93', '负债类', '2401', '递延收益', '', null);
insert into `km` values ('94', '负债类', '2501', '长期借款', '', null);
insert into `km` values ('95', '负债类', '2502', '应付债券', '', null);
insert into `km` values ('100', '负债类', '2701', '长期应付款', '', null);
insert into `km` values ('101', '负债类', '2702', '未确认融资费用', '', null);
insert into `km` values ('102', '负债类', '2711', '专项应付款', '', null);
insert into `km` values ('103', '负债类', '2801', '预计负债', '', null);
insert into `km` values ('104', '负债类', '2901', '递延所得税负债', '', null);
insert into `km` values ('110', '所有者权益类', '4001', '实收资本', '', null);
insert into `km` values ('111', '所有者权益类', '4002', '资本公积', '', null);
insert into `km` values ('112', '所有者权益类', '4101', '盈余公积', '', null);
insert into `km` values ('114', '所有者权益类', '4103', '本年利润', '', null);
insert into `km` values ('115', '所有者权益类', '4104', '利润分配', '', null);
insert into `km` values ('117', '成本类', '5001', '生产成本', '', null);
insert into `km` values ('118', '成本类', '5101', '制造费用', '', null);
insert into `km` values ('119', '成本类', '5201', '劳务成本', '', null);
insert into `km` values ('120', '成本类', '5301', '研发成本', '', null);
insert into `km` values ('124', '损益类', '6001', '主营业务收入', '', null);
insert into `km` values ('129', '损益类', '6051', '其他业务收入', '', null);
insert into `km` values ('131', '损益类', '6101', '公允价值变动损益', '', null);
insert into `km` values ('132', '损益类', '6111', '投资损益', '', null);
insert into `km` values ('136', '损益类', '6301', '营业外收入', '', null);
insert into `km` values ('137', '损益类', '6401', '主营业务成本', '', null);
insert into `km` values ('138', '损益类', '6402', '其他业务成本', '', null);
insert into `km` values ('139', '损益类', '6403', '营业税金及附加', '', null);
insert into `km` values ('149', '损益类', '6601', '销售费用', '', null);
insert into `km` values ('150', '损益类', '6602', '管理费用', '', null);
insert into `km` values ('151', '损益类', '6603', '财务费用', '', null);
insert into `km` values ('153', '损益类', '6701', '资产减值损失', '', null);
insert into `km` values ('154', '损益类', '6711', '营业外支出', '', null);
insert into `km` values ('155', '损益类', '6801', '所得税费用', '', null);
insert into `km` values ('156', '损益类', '6901', '以前年度损益调整', '', null);

-- ----------------------------
-- table structure for `manager`
-- ----------------------------
drop table if exists `manager`;
create table `manager` (
  `id` int(11) not null auto_increment comment '主键',
  `userid` varchar(4) default null comment '员工编号',
  `username` varchar(12) default null comment '员工姓名',
  `userpass` varchar(32) default null comment '密码',
  `address` varchar(40) default null comment '员工住址',
  `tel` varchar(15) default null comment '电话',
  `purview` int(11) default '0',
  `remark` varchar(50) default null comment '备注',
  primary key (`id`),
  key `id` (`id`),
  key `userid` (`userid`)
) engine=innodb auto_increment=34 default charset=utf8;

-- ----------------------------
-- records of manager
-- ----------------------------
insert into `manager` values ('28', '4', '002', 'a87ff679a2f3e71d9181a67b7542122c', '123', '13088417022', '268435455', '三天试用');
insert into `manager` values ('32', '1', '001', 'c4ca4238a0b923820dcc509a6f75849b', '123', '1', '268435455', '');
insert into `manager` values ('33', '3', '003', 'c4ca4238a0b923820dcc509a6f75849b', '123', '13088417022', '268435455', '三天试用');

-- ----------------------------
-- table structure for `mxsp`
-- ----------------------------
drop table if exists `mxsp`;
create table `mxsp` (
  `id` int(11) not null auto_increment comment '主键',
  `barcode` varchar(13) default null comment '商品编码',
  `goodsname` varchar(40) default null comment '商品名称',
  `unit` varchar(10) default null comment '计量单位',
  `sellscalar` double default '0' comment '数量',
  `purchaseprice` double default '0' comment '进价',
  `sellprice` double default '0' comment '售价',
  `gift` varchar(4) default null comment '赠品',
  `untreadflag` varchar(4) default null,
  primary key (`id`),
  key `barcode` (`barcode`),
  key `id` (`id`)
) engine=innodb auto_increment=6934 default charset=utf8;

-- ----------------------------
-- records of mxsp
-- ----------------------------
insert into `mxsp` values ('6931', '001', '鸳鸯锅', '个', '3', '44.85', '30.15', '-', '-');
insert into `mxsp` values ('6932', '002', '香辣中锅', '个', '2', '28', '28', '-', '-');
insert into `mxsp` values ('6933', '003', '白汤中锅', '个', '1', '12', '12', '-', '-');

-- ----------------------------
-- table structure for `purchase`
-- ----------------------------
drop table if exists `purchase`;
create table `purchase` (
  `id` int(11) not null auto_increment comment '主键',
  `invoiceid` varchar(11) not null comment '订单编号',
  `barcode` varchar(15) not null comment '条形码',
  `goodsname` varchar(40) not null comment '产品名称',
  `feedername` varchar(40) default null comment '供应商名称',
  `purchasescalar` double not null default '0' comment '采购数量',
  `purchaseprice` double not null default '0' comment '采购价格',
  `unit` varchar(10) default null comment '计量单位',
  `enterfiag` tinyint(1) not null comment '入库标志',
  `purchasedate` datetime not null comment '采购日期',
  `username` varchar(12) not null comment '采购员',
  `remark` varchar(11) default null comment '备注',
  primary key (`id`),
  key `barcode` (`barcode`),
  key `id` (`id`),
  key `invoiceid` (`invoiceid`)
) engine=innodb auto_increment=478 default charset=utf8;

-- ----------------------------
-- records of purchase
-- ----------------------------
insert into `purchase` values ('205', 'p0510100001', '6901028052863', '国宾香烟(绿)', '天客隆超市', '100', '4', '包', '1', '2005-10-10 01:14:52', 'system', null);
insert into `purchase` values ('208', 'p0510100002', '6901028191012', '软白沙', '天客隆超市', '100', '3', '包', '1', '2005-10-10 01:16:10', 'system', null);
insert into `purchase` values ('210', 'p0511070001', '001', '锅包肉', '', '10', '10', '盘', '1', '2005-11-07 17:02:53', 'system', null);
insert into `purchase` values ('211', 'p0511070002', '001', '锅包肉', '', '10', '10', '盘', '1', '2005-11-07 17:15:33', 'system', null);
insert into `purchase` values ('212', 'p0511070003', '001', '鸳鸯锅', '', '1000', '15', '个', '1', '2005-11-07 22:25:19', 'system', null);
insert into `purchase` values ('213', 'p0511070004', '002', '香辣中锅', '', '1000', '14', '个', '1', '2005-11-07 22:26:58', 'system', null);
insert into `purchase` values ('214', 'p0511070005', '003', '白汤中锅', '', '1000', '12', '个', '1', '2005-11-07 22:29:44', 'system', null);
insert into `purchase` values ('215', 'p0511070006', '004', '滋补锅', '', '1000', '36', '个', '1', '2005-11-07 22:30:38', 'system', null);
insert into `purchase` values ('216', 'p0511070007', '005', '小锅', '', '10000', '5', '个', '1', '2005-11-07 22:31:17', 'system', null);
insert into `purchase` values ('217', 'p0511070008', '006', '国蜀调料', '', '10000', '2', '份', '1', '2005-11-07 22:32:29', 'system', null);
insert into `purchase` values ('218', 'p0511070009', '007', '香辣调料', '', '10000', '2', '份', '1', '2005-11-07 22:33:13', 'system', null);
insert into `purchase` values ('219', 'p0511070010', '008', '麻酱调料', '', '10000', '2', '份', '1', '2005-11-07 22:34:22', 'system', null);
insert into `purchase` values ('220', 'p0511070011', '009', '香油蒜泥', '', '10000', '2', '份', '1', '2005-11-07 22:35:37', 'system', null);
insert into `purchase` values ('221', 'p0511070012', '010', '小料', '', '10000', '1', '份', '1', '2005-11-07 22:36:52', 'system', null);
insert into `purchase` values ('222', 'p0511070013', '011', '锡盟羔羊', '', '9977', '10', '盘', '1', '2005-11-07 22:43:56', 'system', 'u1307230001');
insert into `purchase` values ('223', 'p0511070014', '013', '羔羊腿肉', ' ', '10000', '12', '盘', '1', '2005-11-07 22:45:42', 'system', null);
insert into `purchase` values ('224', 'p0511070015', '012', '新西兰肥羊', '', '10000', '10', '盘', '1', '2005-11-07 22:57:40', 'system', null);
insert into `purchase` values ('225', 'p0511080001', '014', '国蜀鲜嫩羊肉', '', '10000', '12', '盘', '1', '2005-11-08 09:46:51', 'system', null);
insert into `purchase` values ('226', 'p0511080002', '015', '羊腰', '', '10000', '12', '盘', '1', '2005-11-08 09:47:32', 'system', null);
insert into `purchase` values ('227', 'p0511080003', '016', '羊肉滑', '', '10000', '18', '盘', '1', '2005-11-08 09:48:48', 'system', null);
insert into `purchase` values ('228', 'p0511080004', '017', '国蜀鲜嫩羊肉', '', '10000', '12', '盘', '1', '2005-11-08 10:02:05', 'system', null);
insert into `purchase` values ('229', 'p0511080005', '018', '国蜀鲜嫩牛肉', '', '10000', '16', '盘', '1', '2005-11-08 11:58:44', 'system', null);
insert into `purchase` values ('230', 'p0511080006', '019', '精品肥牛', '', '10000', '18', '盘', '1', '2005-11-08 12:05:48', 'system', null);
insert into `purchase` values ('232', 'p0511080007', '020', '肥牛上脑', '', '10000', '22', '盘', '1', '2005-11-08 12:33:26', 'system', null);
insert into `purchase` values ('233', 'p0511080008', '021', '肥牛眼肉', '', '10000', '25', '盘 ', '1', '2005-11-08 12:35:41', 'system', null);
insert into `purchase` values ('234', 'p0511080009', '022', 'a外脊肥牛', '', '10000', '26', '盘', '1', '2005-11-08 12:38:30', 'system', null);
insert into `purchase` values ('235', 'p0511080010', '023', '牛肉滑', '', '10000', '22', '盘', '1', '2005-11-08 12:40:11', 'system', null);
insert into `purchase` values ('236', 'p0511080011', '024', '猪五花', '', '10000', '10', '盘', '1', '2005-11-08 12:43:00', 'system', null);
insert into `purchase` values ('237', 'p0511080012', '025', '腰花', '', '10000', '10', '盘', '1', '2005-11-08 12:43:35', 'system', null);
insert into `purchase` values ('238', 'p0511080013', '026', '青虾', '', '10000', '18', '盘', '1', '2005-11-08 13:00:20', 'system', null);
insert into `purchase` values ('239', 'p0511080014', '027', '扇贝', '', '10000', '16', '盘', '1', '2005-11-08 13:02:05', 'system', null);
insert into `purchase` values ('240', 'p0511080015', '028', '蛎蝗', '', '10000', '12', '盘', '1', '2005-11-08 16:30:12', 'system', null);
insert into `purchase` values ('241', 'p0511080016', '029', '海兔', '', '10000', '12', '盘', '1', '2005-11-08 16:31:07', 'system', null);
insert into `purchase` values ('242', 'p0511080017', '030', '墨鱼仔', '', '10000', '15', '盘', '1', '2005-11-08 16:34:25', 'system', null);
insert into `purchase` values ('243', 'p0511080018', '031', '花鲢鱼片', '', '10000', '10', '盘', '1', '2005-11-08 16:36:00', 'system', null);
insert into `purchase` values ('244', 'p0511080019', '032', '三文鱼生吃(小)', '', '10000', '22', '盘', '1', '2005-11-08 16:37:51', 'system', null);
insert into `purchase` values ('245', 'p0511080020', '033', '三文鱼生吃(大)', '', '10000', '38', '盘', '1', '2005-11-08 16:38:51', 'system', null);
insert into `purchase` values ('246', 'p0511080021', '034', '鲜鱿鱼卷', '', '10000', '16', '盘', '1', '2005-11-08 16:43:34', 'system', null);
insert into `purchase` values ('247', 'p0511080022', '035', '基围虾', '', '10000', '108', '斤', '1', '2005-11-08 16:48:17', 'system', null);
insert into `purchase` values ('248', 'p0511080023', '036', '河蟹', '', '10000', '38', '斤', '1', '2005-11-08 16:49:52', 'system', null);
insert into `purchase` values ('249', 'p0511080024', '037', '海蟹', '', '10000', '200', '斤', '1', '2005-11-08 16:52:27', 'system', null);
insert into `purchase` values ('250', 'p0511080025', '038', '黑鱼两吃', '', '10000', '22', '斤', '1', '2005-11-08 16:53:41', 'system', null);
insert into `purchase` values ('251', 'p0511080026', '039', '鲜鱼滑', '', '10000', '22', '盘', '1', '2005-11-08 16:54:40', 'system', null);
insert into `purchase` values ('252', 'p0511080027', '040', '鲜虾滑', '', '10000', '28', '秀；盘', '1', '2005-11-08 16:56:39', 'system', null);
insert into `purchase` values ('253', 'p0511080028', '041', '百叶', '', '10000', '12', '盘', '1', '2005-11-08 16:57:34', 'system', null);
insert into `purchase` values ('254', 'p0511080029', '042', '毛肚', '', '10000', '12', '盘', '1', '2005-11-08 16:58:42', 'system', null);
insert into `purchase` values ('255', 'p0511080030', '043', '鸭肠', '', '10000', '12', '盘', '1', '2005-11-08 16:59:46', 'system', null);
insert into `purchase` values ('256', 'p0511080031', '044', '午餐肉', '', '10000', '12', '盘', '1', '2005-11-08 17:03:13', 'system', null);
insert into `purchase` values ('257', 'p0511080032', '045', '黄喉', '', '10000', '15', '盘', '1', '2005-11-08 17:05:13', 'system', null);
insert into `purchase` values ('258', 'p0511080033', '046', '牛骨髓', '', '10000', '15', '盘', '1', '2005-11-08 17:06:03', 'system', null);
insert into `purchase` values ('259', 'p0511080034', '047', '鸭血', '', '10000', '4', '盘', '1', '2005-11-08 17:06:53', 'system', null);
insert into `purchase` values ('260', 'p0511080035', '048', '羊血', '', '10000', '4', '盘', '1', '2005-11-08 17:07:34', 'system', null);
insert into `purchase` values ('261', 'p0511080036', '049', '鲜蘑', '', '10000', '4', '盘', '1', '2005-11-08 17:08:22', 'system', null);
insert into `purchase` values ('262', 'p0511080037', '050', '香菇蘑', '', '10000', '5', '盘', '1', '2005-11-08 17:09:11', 'system', null);
insert into `purchase` values ('263', 'p0511080038', '051', '金针蘑', '', '10000', '10', '盘', '1', '2005-11-08 17:09:43', 'system', null);
insert into `purchase` values ('264', 'p0511080039', '052', '鸡腿蘑', '', '10000', '8', '盘', '1', '2005-11-08 17:10:47', 'system', null);
insert into `purchase` values ('265', 'p0511080040', '053', '乳牛肝蘑', '', '10000', '12', '盘', '1', '2005-11-08 17:12:17', 'system', null);
insert into `purchase` values ('266', 'p0511080041', '054', '彩云蘑', '', '10000', '12', '盘', '1', '2005-11-08 17:13:29', 'system', null);
insert into `purchase` values ('267', 'p0511080042', '055', '鲍鱼菇', '', '10000', '12', '盘', '1', '2005-11-08 17:14:18', 'system', null);
insert into `purchase` values ('268', 'p0511080043', '056', '猴头菇', '', '10000', '12', '盘', '1', '2005-11-08 17:15:15', 'system', null);
insert into `purchase` values ('269', 'p0511080044', '057', '罗汉竹笋', '', '10000', '5', '盘', '1', '2005-11-08 17:17:12', 'system', null);
insert into `purchase` values ('270', 'p0511080045', '058', '黑木耳', '', '10000', '6', '盘', '1', '2005-11-08 17:18:34', 'system', null);
insert into `purchase` values ('271', 'p0511080046', '059', '海带片', '', '10000', '4', '盘', '1', '2005-11-08 17:21:18', 'system', null);
insert into `purchase` values ('272', 'p0511080047', '060', '海带根', '', '10000', '5', '盘', '1', '2005-11-08 17:21:59', 'system', null);
insert into `purchase` values ('273', 'p0511080048', '061', '宽粉', '', '10000', '4', '盘', '1', '2005-11-08 17:22:32', 'system', null);
insert into `purchase` values ('274', 'p0511080049', '062', '粉丝', '', '10000', '4', '盘', '1', '2005-11-08 17:23:12', 'system', null);
insert into `purchase` values ('275', 'p0511080050', '063', '水晶粉', '', '10000', '5', '盘', '1', '2005-11-08 17:23:53', 'system', null);
insert into `purchase` values ('276', 'p0511080051', '064', '鲜豆腐', '', '10000', '3', '盘', '1', '2005-11-08 17:24:32', 'system', null);
insert into `purchase` values ('277', 'p0511080052', '065', '冻豆腐 ', '', '10000', '3', '盘', '1', '2005-11-08 17:25:09', 'system', null);
insert into `purchase` values ('278', 'p0511080053', '066', '油豆腐皮', '', '10000', '4', '盘', '1', '2005-11-08 17:27:39', 'system', null);
insert into `purchase` values ('279', 'p0511080054', '067', '腐竹', '', '10000', '4', '盘', '1', '2005-11-08 17:28:13', 'system', null);
insert into `purchase` values ('280', 'p0511080055', '068', '土豆片', '', '10000', '4', '盘', '1', '2005-11-08 17:29:02', 'system', null);
insert into `purchase` values ('281', 'p0511080056', '069', '红薯 ', '', '10000', '4', '盘', '1', '2005-11-08 17:29:38', 'system', null);
insert into `purchase` values ('282', 'p0511080057', '070', '冬瓜', '', '10000', '4', '盘', '1', '2005-11-08 17:30:52', 'system', null);
insert into `purchase` values ('283', 'p0511080058', '071', '茼蒿', '', '10000', '4', '盘', '1', '2005-11-08 17:31:46', 'system', null);
insert into `purchase` values ('284', 'p0511080059', '072', '菠菜', '', '10000', '4', '盘', '1', '2005-11-08 17:32:16', 'system', null);
insert into `purchase` values ('285', 'p0511080060', '073', '生菜', '', '10000', '4', '盘就', '1', '2005-11-08 17:32:50', 'system', null);
insert into `purchase` values ('286', 'p0511080061', '074', '香菜', '', '10000', '4', '盘', '1', '2005-11-08 17:33:18', 'system', null);
insert into `purchase` values ('287', 'p0511080062', '075', '大白菜', '', '10000', '4', '盘', '1', '2005-11-08 17:34:00', 'system', null);
insert into `purchase` values ('288', 'p0511080063', '076', '小白菜', '', '10000', '4', '盘', '1', '2005-11-08 17:34:33', 'system', null);
insert into `purchase` values ('289', 'p0511080064', '077', '西饼', '', '10000', '1', '个', '1', '2005-11-08 17:35:19', 'system', null);
insert into `purchase` values ('290', 'p0511080065', '078', '金馒头', '', '10000', '6', '份', '1', '2005-11-08 17:36:10', 'system', null);
insert into `purchase` values ('291', 'p0511080066', '079', '油炸麻团', '', '10000', '8', '份', '1', '2005-11-08 17:36:52', 'system', null);
insert into `purchase` values ('292', 'p0511080067', '080', '红薯饼', '', '10000', '8', '份', '1', '2005-11-08 17:39:09', 'system', null);
insert into `purchase` values ('293', 'p0511080068', '081', '南瓜饼', '', '10000', '8', '份', '1', '2005-11-08 17:40:21', 'system', null);
insert into `purchase` values ('294', 'p0511080069', '082', '虾饺', '', '10000', '8', '份', '1', '2005-11-08 17:41:13', 'system', null);
insert into `purchase` values ('295', 'p0511080070', '083', '菜汁面条', '', '10000', '6', '份', '1', '2005-11-08 17:42:37', 'system', null);
insert into `purchase` values ('296', 'p0511080071', '084', '龙须面', '', '10000', '3', '份', '1', '2005-11-08 17:43:13', 'system', null);
insert into `purchase` values ('297', 'p0511080072', '085', '娃娃菜', '', '10000', '6', '盘', '1', '2005-11-08 17:44:18', 'system', null);
insert into `purchase` values ('298', 'p0511080073', '086', '酸菜丝', '', '10000', '3', '盘', '1', '2005-11-08 17:45:29', 'system', null);
insert into `purchase` values ('299', 'p0511080074', '087', '藕片', '', '10000', '5', '盘', '1', '2005-11-08 17:46:54', 'system', null);
insert into `purchase` values ('300', 'p0511080075', '088', '西红柿', '', '10000', '4', '盘', '1', '2005-11-08 17:47:34', 'system', null);
insert into `purchase` values ('301', 'p0511080076', '089', '蟹足棒', '', '10000', '8', '盘', '1', '2005-11-08 17:48:57', 'system', null);
insert into `purchase` values ('302', 'p0511080077', '090', '鱼丸', '', '10000', '10', '盘', '1', '2005-11-08 17:49:44', 'system', null);
insert into `purchase` values ('303', 'p0511080078', '091', '虾丸', '', '10000', '10', '盘', '1', '2005-11-08 17:50:23', 'system', null);
insert into `purchase` values ('304', 'p0511080079', '092', '蟹肉', '', '10000', '10', '份', '1', '2005-11-08 17:51:06', 'system', null);
insert into `purchase` values ('305', 'p0511080080', '093', '羊尾', '', '10000', '12', '盘  ', '1', '2005-11-08 17:51:59', 'system', null);
insert into `purchase` values ('306', 'p0511080081', '094', '羊宝', '', '10000', '18', '盘', '1', '2005-11-08 17:52:51', 'system', null);
insert into `purchase` values ('307', 'p0511080082', '095', '牛鞭', '', '10000', '15', '盘', '1', '2005-11-08 17:53:37', 'system', null);
insert into `purchase` values ('308', 'p0511080083', '096', '牛宝', '', '10000', '12', '盘', '1', '2005-11-08 17:54:18', 'system', null);
insert into `purchase` values ('309', 'p0511080084', '097', '意粉', '', '10000', '3', '盘', '1', '2005-11-08 17:54:57', 'system', null);
insert into `purchase` values ('310', 'p0511080085', '098', '疙瘩汤', '', '10000', '10', '份', '1', '2005-11-08 17:55:51', 'system', null);
insert into `purchase` values ('311', 'p0511080086', '099', '三鲜烙合', '', '10000', '2', '个', '1', '2005-11-08 17:56:32', 'system', null);
insert into `purchase` values ('312', 'p0511080087', '100', '豆沙饼', '', '10000', '1', '个', '1', '2005-11-08 17:57:21', 'system', null);
insert into `purchase` values ('313', 'p0511080088', '101', '葱油饼', '', '10000', '1', '个', '1', '2005-11-08 17:58:27', 'system', null);
insert into `purchase` values ('314', 'p0511080089', '102', '扬州炒饭', '', '10000', '10', '盘', '1', '2005-11-08 18:00:13', 'system', null);
insert into `purchase` values ('315', 'p0511080090', '076', '小白菜', '', '10000', '4', '盘', '1', '2005-11-08 18:36:54', 'system', null);
insert into `purchase` values ('316', 'p0511080091', '051', '金针蘑', '', '10000', '10', '盘', '1', '2005-11-08 18:41:59', 'system', null);
insert into `purchase` values ('317', 'p0511080092', '200', '金三鞭55', '', '10000', '48', '斤', '1', '2005-11-08 19:03:59', 'system', null);
insert into `purchase` values ('318', 'p0511080093', '201', '银三鞭55', '', '10000', '28', '斤', '1', '2005-11-08 19:05:06', 'system', null);
insert into `purchase` values ('319', 'p0511080094', '202', '珍酒三年陈酿', '', '100000', '45', '瓶', '1', '2005-11-08 19:07:19', 'system', null);
insert into `purchase` values ('320', 'p0511080095', '203', '珍酒五年陈酿', '', '10000', '58', '瓶', '1', '2005-11-08 19:08:26', 'system', null);
insert into `purchase` values ('321', 'p0511080096', '204', '珍酒十年陈酿(半斤)', '', '10000', '68', '瓶', '1', '2005-11-08 19:10:12', 'system', null);
insert into `purchase` values ('322', 'p0511080097', '205', '珍酒十年陈酿 ', '', '10000', '108', '瓶', '1', '2005-11-08 19:14:13', 'system', null);
insert into `purchase` values ('323', 'p0511080098', '206', '宁城老窖八年陈酿', '', '10000', '78', '瓶', '1', '2005-11-08 19:17:00', 'system', null);
insert into `purchase` values ('324', 'p0511080099', '207', '宁城老窖五年陈酿', '', '10000', '48', '瓶', '1', '2005-11-08 19:18:00', 'system', null);
insert into `purchase` values ('325', 'p0511080100', '208', '宁城老窖极品38', '', '10000', '68', '瓶', '1', '2005-11-08 19:19:07', 'system', null);
insert into `purchase` values ('326', 'p0511080101', '209', '宁城老窖极品36', '', '10000', '32', '瓶', '1', '2005-11-08 19:20:10', 'system', null);
insert into `purchase` values ('327', 'p0511080102', '210', '宁城老窖二星', '', '10000', '52', '瓶', '1', '2005-11-08 19:21:11', 'system', null);
insert into `purchase` values ('328', 'p0511080103', '211', '宁城老窖福星', '', '10000', '15', '瓶', '1', '2005-11-08 19:21:52', 'system', null);
insert into `purchase` values ('329', 'p0511080104', '212', '裕井烧坊经典', '', '10000', '128', '瓶', '1', '2005-11-08 19:24:30', 'system', null);
insert into `purchase` values ('330', 'p0511080105', '213', '裕井三百年陈酿', '', '10000', '48', '瓶', '1', '2005-11-08 19:25:15', 'system', null);
insert into `purchase` values ('331', 'p0511080106', '214', '裕井十年陈酿 ', '', '10000', '24', '瓶', '1', '2005-11-08 19:26:15', 'system', null);
insert into `purchase` values ('332', 'p0511080107', '215', '裕井烧坊简装', '', '10000', '18', '瓶', '1', '2005-11-08 19:29:58', 'system', null);
insert into `purchase` values ('333', 'p0511080108', '216', '裕井小酒蒌', '', '10000', '10', '瓶', '1', '2005-11-08 20:09:01', 'system', null);
insert into `purchase` values ('334', 'p0511080109', '217', '裕井小酒壶', '', '10000', '6', '瓶', '1', '2005-11-08 20:10:19', 'system', null);
insert into `purchase` values ('335', 'p0511080110', '218', '精品河套王', '', '10000', '128', '瓶', '1', '2005-11-08 20:11:53', 'system', null);
insert into `purchase` values ('336', 'p0511080111', '219', '河套金尊', '', '10000', '68', '瓶', '1', '2005-11-08 20:13:08', 'system', null);
insert into `purchase` values ('337', 'p0511080112', '220', '河套银尊', '', '10000', '48', '瓶', '1', '2005-11-08 20:13:44', 'system', null);
insert into `purchase` values ('338', 'p0511080113', '221', '河套合口福', '', '10000', '58', '瓶', '1', '2005-11-08 20:15:13', 'system', null);
insert into `purchase` values ('339', 'p0511080114', '222', '河套福星52', '', '10000', '30', '瓶', '1', '2005-11-08 20:15:57', 'system', null);
insert into `purchase` values ('340', 'p0511080115', '223', '河套福星38', '', '10000', '28', '瓶', '1', '2005-11-08 20:16:34', 'system', null);
insert into `purchase` values ('341', 'p0511080116', '224', '河套纯粮', '', '10000', '15', '瓶', '1', '2005-11-08 20:18:22', 'system', null);
insert into `purchase` values ('342', 'p0511080117', '225', '太白毫杰酒', '', '10000', '48', '瓶', '1', '2005-11-08 20:20:14', 'system', null);
insert into `purchase` values ('343', 'p0511080118', '226', '太白巴乡村', '', '10000', '28', '瓶', '1', '2005-11-08 20:21:29', 'system', null);
insert into `purchase` values ('344', 'p0511080119', '227', '诗仙太白简装', '', '10000', '18', '瓶', '1', '2005-11-08 20:22:43', 'system', null);
insert into `purchase` values ('345', 'p0511080120', '228', '凤城老窖一星', '', '10000', '58', '瓶', '1', '2005-11-08 20:24:03', 'system', null);
insert into `purchase` values ('346', 'p0511080121', '229', '凤城老窖金蒙', '', '10000', '48', '瓶', '1', '2005-11-08 20:25:04', 'system', null);
insert into `purchase` values ('347', 'p0511080122', '230', '凤城老窖银蒙', '', '10000', '38', '瓶', '1', '2005-11-08 20:26:00', 'system', null);
insert into `purchase` values ('348', 'p0511080123', '231', '凤城原浆', '', '10000', '15', '瓶', '1', '2005-11-08 20:27:12', 'system', null);
insert into `purchase` values ('349', 'p0511080124', '232', '五粮醇', '', '10000', '58', '瓶', '1', '2005-11-08 20:27:54', 'system', null);
insert into `purchase` values ('350', 'p0511080125', '233', '五粮醇(三)', '', '10000', '108', '瓶', '1', '2005-11-08 20:30:54', 'system', null);
insert into `purchase` values ('351', 'p0511080126', '234', '小火爆', '', '10000', '8', '瓶', '1', '2005-11-08 20:33:57', 'system', null);
insert into `purchase` values ('352', 'p0511080127', '235', '三星杞浓', '', '10000', '98', '瓶', '1', '2005-11-08 20:34:51', 'system', null);
insert into `purchase` values ('353', 'p0511080128', '236', '老池酒 ', '', '10000', '288', '瓶', '1', '2005-11-08 20:35:44', 'system', null);
insert into `purchase` values ('354', 'p0511080129', '237', '乾豫兴老窖精品', '', '10000', '108', '瓶', '1', '2005-11-08 20:40:46', 'system', null);
insert into `purchase` values ('355', 'p0511080130', '238', '乾豫兴', '', '10000', '58', '瓶', '1', '2005-11-08 20:41:53', 'system', null);
insert into `purchase` values ('356', 'p0511080131', '239', '烧锅酒', '', '10000', '20', '瓶', '1', '2005-11-08 20:42:36', 'system', null);
insert into `purchase` values ('357', 'p0511080132', '240', '四特陈酿', '', '10000', '68', '瓶', '1', '2005-11-08 20:44:37', 'system', null);
insert into `purchase` values ('358', 'p0511080133', '241', '国宾四特', '', '10000', '48', '瓶', '1', '2005-11-08 20:46:05', 'system', null);
insert into `purchase` values ('359', 'p0511080134', '242', '店小二38', '', '10000', '36', '瓶', '1', '2005-11-08 20:47:20', 'system', null);
insert into `purchase` values ('360', 'p0511080135', '243', '店小二46', '', '10000', '46', '瓶', '1', '2005-11-08 20:47:58', 'system', null);
insert into `purchase` values ('361', 'p0511080136', '244', '庄家汉简装', '', '10000', '18', '瓶', '1', '2005-11-08 20:50:08', 'system', null);
insert into `purchase` values ('362', 'p0511080137', '245', '庄家汉盒装', '', '10000', '58', '瓶', '1', '2005-11-08 20:50:53', 'system', null);
insert into `purchase` values ('363', 'p0511080138', '246', '长城红色庄园', '', '10000', '128', '瓶', '1', '2005-11-08 20:52:36', 'system', null);
insert into `purchase` values ('364', 'p0511080139', '247', '长城干红赤霞珠', '', '10000', '98', '瓶', '1', '2005-11-08 20:54:48', 'system', null);
insert into `purchase` values ('365', 'p0511080140', '248', '长城干红葡萄酒制醇', '', '10000', '38', '瓶', '1', '2005-11-08 20:56:12', 'system', null);
insert into `purchase` values ('366', 'p0511080141', '249', '解佰纳干红葡萄酒', '', '10000', '78', '瓶', '1', '2005-11-08 20:57:20', 'system', null);
insert into `purchase` values ('368', 'p0511080143', '250', '简农达红酒', '', '10000', '38', '瓶', '1', '2005-11-08 20:59:51', 'system', null);
insert into `purchase` values ('369', 'p0511080142', '251', '燕京无醇', '', '10000', '15', '瓶', '1', '2005-11-08 21:01:05', 'system', null);
insert into `purchase` values ('370', 'p0511080144', '252', '荞麦干啤', '', '10000', '10', '瓶', '1', '2005-11-08 21:02:43', 'system', null);
insert into `purchase` values ('371', 'p0511080145', '253', '燕京纯生', '', '10000', '10', '瓶', '1', '2005-11-08 21:04:01', 'system', null);
insert into `purchase` values ('372', 'p0511080146', '254', '哈干', '', '10000', '10', '瓶', '1', '2005-11-08 21:05:22', 'system', null);
insert into `purchase` values ('373', 'p0511080147', '255', '哈鲜', '', '10000', '8', '瓶', '1', '2005-11-08 21:05:44', 'system', null);
insert into `purchase` values ('374', 'p0511080148', '256', '燕京普啤', '', '10000', '2', '瓶', '1', '2005-11-08 21:06:49', 'system', null);
insert into `purchase` values ('375', 'p0511080149', '257', '汇源高纤维', '', '10000', '25', '盒', '1', '2005-11-08 21:08:00', 'system', null);
insert into `purchase` values ('376', 'p0511080150', '258', '汇源果汁100%', '', '10000', '20', '盒', '1', '2005-11-08 21:09:15', 'system', null);
insert into `purchase` values ('377', 'p0511080151', '259', '汇源果汁50%', '', '10000', '10', '瓶', '1', '2005-11-08 21:10:05', 'system', null);
insert into `purchase` values ('378', 'p0511080152', '260', '雪碧(大)', '', '10000', '10', '瓶', '1', '2005-11-08 21:11:16', 'system', null);
insert into `purchase` values ('381', 'p0511080155', '263', '可口可乐(厅)', '', '10000', '3', '厅', '1', '2005-11-08 21:15:21', 'system', null);
insert into `purchase` values ('382', 'p0511080156', '264', '百事可乐(厅)', '', '10000', '3', '厅', '1', '2005-11-08 21:16:18', 'system', null);
insert into `purchase` values ('383', 'p0511080157', '265', '雪碧(厅)', '', '10000', '3', '厅', '1', '2005-11-08 21:17:10', 'system', null);
insert into `purchase` values ('384', 'p0511080158', '266', '百事可乐(中)', '', '10000', '4', '瓶', '1', '2005-11-08 21:18:27', 'system', null);
insert into `purchase` values ('385', 'p0511080154', '262', '百事可乐(大)', '', '10000', '10', '桶', '1', '2005-11-08 21:18:48', 'system', null);
insert into `purchase` values ('386', 'p0511080153', '261', '可口可乐(大)', '', '10000', '10', '瓶', '1', '2005-11-08 21:19:06', 'system', null);
insert into `purchase` values ('387', 'p0511080159', '267', '矿泉水', '', '10000', '2', '瓶', '1', '2005-11-08 21:20:12', 'system', null);
insert into `purchase` values ('388', 'p0511080160', '268', '杏仁乳', '', '10000', '2', '瓶', '1', '2005-11-08 21:21:32', 'system', null);
insert into `purchase` values ('389', 'p0511080161', '269', '花生奶', '', '10000', '12', '壶', '1', '2005-11-08 21:31:51', 'system', null);
insert into `purchase` values ('390', 'p0511080162', '270', '硬中华', '', '10000', '60', '盒', '1', '2005-11-08 21:33:34', 'system', null);
insert into `purchase` values ('391', 'p0511080163', '271', '苁 蓉', '', '10000', '15', '盒', '1', '2005-11-08 21:34:11', 'system', null);
insert into `purchase` values ('392', 'p0511080164', '272', '红国宾', '', '10000', '13', '盒', '1', '2005-11-08 21:34:49', 'system', null);
insert into `purchase` values ('393', 'p0511080165', '273', '环保白沙', '', '10000', '12', '盒', '1', '2005-11-08 21:35:35', 'system', null);
insert into `purchase` values ('394', 'p0511080166', '274', '红云', '', '10000', '10', ' 盒', '1', '2005-11-08 21:36:21', 'system', null);
insert into `purchase` values ('395', 'p0511080167', '275', '蓝国宾', '', '10000', '8', '盒 ', '1', '2005-11-08 21:36:49', 'system', null);
insert into `purchase` values ('396', 'p0511080168', '019', '精品肥牛', '', '10000', '18', '盘', '1', '2005-11-08 22:23:20', 'system', null);
insert into `purchase` values ('397', 'p0511090001', '048', '羊血', '', '10000', '4', '盘', '1', '2005-11-09 10:08:55', 'system', null);
insert into `purchase` values ('398', 'p0511090002', '095', '牛鞭', '', '10000', '15', '盘', '1', '2005-11-09 10:11:24', 'system', null);
insert into `purchase` values ('399', 'p0511090003', '300', '八宝茶', '', '10000', '1', '杯', '1', '2005-11-09 10:47:18', 'system', null);
insert into `purchase` values ('400', 'p0511090004', '067', '腐竹', '', '10000', '5', '盘', '1', '2005-11-09 10:54:58', 'system', null);
insert into `purchase` values ('401', 'p0511090005', '301', '筷子', '', '100000', '1', '双', '1', '2005-11-09 10:57:18', 'system', null);
insert into `purchase` values ('402', 'p0511090006', '301', '筷子', '', '100000', '1', '双', '1', '2005-11-09 10:58:37', 'system', null);
insert into `purchase` values ('404', 'p0511090007', '276', '山水啤酒', '', '100000', '3', '瓶', '1', '2005-11-09 11:03:16', 'system', null);
insert into `purchase` values ('405', 'p0511090008', '400', '糖醋蒜', '', '100000', '3', '盘', '1', '2005-11-09 11:14:35', 'system', null);
insert into `purchase` values ('406', 'p0511090009', '401', '小葱拌虾仁', '', '10000', '4', '盘', '1', '2005-11-09 11:15:39', 'system', null);
insert into `purchase` values ('407', 'p0511090010', '402', '青瓜牛肉', '', '10000', '6', '盘', '1', '2005-11-09 11:16:37', 'system', null);
insert into `purchase` values ('408', 'p0511090011', '403', '杏仁蕨菜', '', '10000', '5', '盘', '1', '2005-11-09 11:17:28', 'system', null);
insert into `purchase` values ('409', 'p0511090012', '404', '陈醋花生米', '', '10000', '4', '盘', '1', '2005-11-09 11:18:12', 'system', null);
insert into `purchase` values ('410', 'p0511090013', '405', '炝拌干丝', '', '100000', '4', '盘', '1', '2005-11-09 11:19:18', 'system', null);
insert into `purchase` values ('411', 'p0511090014', '406', '椒麻凤爪', '', '10000', '8', '盘', '1', '2005-11-09 11:20:39', 'system', null);
insert into `purchase` values ('412', 'p0511090015', '407', '鲅鱼焖豆', '', '10000', '6', '盘', '1', '2005-11-09 11:22:11', 'system', null);
insert into `purchase` values ('413', 'p0511090016', '408', '脆耳瓜丝', '', '10000', '6', '盘', '1', '2005-11-09 11:23:05', 'system', null);
insert into `purchase` values ('414', 'p0511090017', '409', '美极拌菜', '', '100000', '4', '盘', '1', '2005-11-09 11:24:22', 'system', null);
insert into `purchase` values ('415', 'p0511090018', '410', '干烧银鱼 ', '', '10000', '4', '盘', '1', '2005-11-09 11:25:24', 'system', null);
insert into `purchase` values ('416', 'p0511090019', '411', '三鲜炝菠菜', '', '10000', '5', '盘', '1', '2005-11-09 11:27:11', 'system', null);
insert into `purchase` values ('417', 'p0511090020', '412', '盐爆花生米', '', '10000', '4', '盘', '1', '2005-11-09 11:28:07', 'system', null);
insert into `purchase` values ('418', 'p0511090021', '413', '四喜豆付', '', '10000', '5', '盘', '1', '2005-11-09 11:28:43', 'system', null);
insert into `purchase` values ('419', 'p0511090022', '414', '拌皮冻', '', '10000', '4', '盘', '1', '2005-11-09 11:29:28', 'system', null);
insert into `purchase` values ('420', 'p0511090023', '415', '孜然鸡脖', '', '10000', '8', '盘', '1', '2005-11-09 11:31:13', 'system', null);
insert into `purchase` values ('421', 'p0511090024', '416', '香辣毛肚', '', '10000', '6', '盘', '1', '2005-11-09 11:31:53', 'system', null);
insert into `purchase` values ('422', 'p0511090025', '417', '红梅卧雪', '', '10000', '4', '盘', '1', '2005-11-09 11:33:46', 'system', null);
insert into `purchase` values ('423', 'p0511090026', '418', '凉拌三鲜', '', '10000', '5', '盘', '1', '2005-11-09 11:35:02', 'system', null);
insert into `purchase` values ('424', 'p0511090027', '419', '小白菜拌木耳', '', '100000', '4', '盘', '1', '2005-11-09 11:36:01', 'system', null);
insert into `purchase` values ('425', 'p0511090028', '420', '牛肉耳段', '', '100000', '6', '盘', '1', '2005-11-09 11:37:56', 'system', null);
insert into `purchase` values ('426', 'p0511090029', '277', '海味火锅', '', '10000', '58', '个', '1', '2005-11-09 12:44:35', 'system', null);
insert into `purchase` values ('427', 'p0511090030', '278', '香辣蟹火锅', '', '10000', '48', '个', '1', '2005-11-09 12:45:18', 'system', null);
insert into `purchase` values ('428', 'p0511090031', '279', '花鲢鱼火锅', '', '10000', '36', '个', '1', '2005-11-09 12:46:14', 'system', null);
insert into `purchase` values ('429', 'p0511090032', '280', '水煮鱼', '', '10000', '22', '斤', '1', '2005-11-09 12:47:33', 'system', null);
insert into `purchase` values ('430', 'p0511090033', '281', '黑鱼', '', '10000', '36', '斤', '1', '2005-11-09 12:48:45', 'system', null);
insert into `purchase` values ('431', 'p0511090034', '288', '手擀面', '', '100000', '6', '份', '1', '2005-11-09 12:56:24', 'system', null);
insert into `purchase` values ('432', 'p0511090035', '280', '水煮鱼草鱼', '', '10000', '22', '斤', '1', '2005-11-09 21:46:49', 'system', null);
insert into `purchase` values ('433', 'p0511090036', '281', '水煮黑鱼', '', '10000', '36', '斤', '1', '2005-11-09 21:49:49', 'system', null);
insert into `purchase` values ('434', 'p0511090037', '282', '乌鸡甲鱼锅', '', '10000', '88', '个', '1', '2005-11-09 21:52:49', 'system', null);
insert into `purchase` values ('435', 'p0511090038', '283', '鲜对虾丸', '', '10000', '36', '盘', '1', '2005-11-09 21:54:43', 'system', null);
insert into `purchase` values ('436', 'p0511090039', '284', '辣根', '', '10000', '2', '份', '1', '2005-11-09 21:56:51', 'system', null);
insert into `purchase` values ('437', 'p0511090040', '285', '泥螺', '', '10000', '10', '盘', '1', '2005-11-09 22:00:30', 'system', null);
insert into `purchase` values ('438', 'p0511090041', '286', '果盘', '', '10000', '10', '盘', '1', '2005-11-09 22:03:44', 'system', null);
insert into `purchase` values ('439', 'p0511090042', '287', '扑克', '', '10000', '2', '副', '1', '2005-11-09 22:06:19', 'system', null);
insert into `purchase` values ('440', 'p0511090043', '289', '歌曲', '', '10000', '20', '首', '1', '2005-11-09 22:12:36', 'system', null);
insert into `purchase` values ('441', 'p0511090044', '290', '泡椒 ', '', '10000', '2', '份', '1', '2005-11-09 22:14:13', 'system', null);
insert into `purchase` values ('442', 'p0511090045', '014', '羊脑', '', '10000', '12', '盘', '1', '2005-11-09 22:47:18', 'system', null);
insert into `purchase` values ('443', 'p0511090046', '095', '牛鞭', '', '10000', '15', '盘', '1', '2005-11-09 23:12:50', 'system', null);
insert into `purchase` values ('444', 'p0511100001', '083', '菜汁面条', '', '10000', '6', '份', '1', '2005-11-10 10:52:00', 'system', null);
insert into `purchase` values ('445', 'p0511170001', '201', '银三鞭55', '', '10000', '28', '斤', '1', '2005-11-17 15:48:00', 'system', null);
insert into `purchase` values ('446', 'p0511170002', '500', '酒精', '', '10000', '1', '个', '1', '2005-11-17 17:39:01', 'system', null);
insert into `purchase` values ('447', 'p0511170003', '416', '香辣毛肚', '', '10000', '8', '盘', '1', '2005-11-17 18:00:52', 'system', null);
insert into `purchase` values ('448', 'p0511170004', '501', '玉米饼', '', '10000', '4', '份', '1', '2005-11-17 18:53:20', 'system', null);
insert into `purchase` values ('449', 'p0511170005', '502', '四野泡菜', '', '10000', '4', '盘', '1', '2005-11-17 18:54:22', 'system', null);
insert into `purchase` values ('452', 'p0511190001', '504', '生鸡蛋', '', '10000', '0.5', '个', '1', '2005-11-19 16:57:16', 'system', null);
insert into `purchase` values ('453', 'p0511190002', '011', '锡盟羔羊', '', '10000', '10', '盘', '1', '2005-11-19 16:58:53', 'system', null);
insert into `purchase` values ('454', 'p0511190003', '503', '米饭', '', '10000', '1', '碗', '1', '2005-11-19 18:50:05', 'system', null);
insert into `purchase` values ('455', 'p0511190004', '505', '长寿面', '', '10000', '12', '碗', '1', '2005-11-19 19:41:50', 'system', null);
insert into `purchase` values ('456', 'p0511190005', '506', '油菜', '', '1000', '4', '份', '1', '2005-11-19 19:42:51', 'system', null);
insert into `purchase` values ('457', 'p0511190006', '507', '韭菜', '', '10000', '4', '份', '1', '2005-11-19 19:43:25', 'system', null);
insert into `purchase` values ('458', 'p0511190007', '083', '菜汁面条', '', '10000', '6', '份', '1', '2005-11-19 22:33:00', 'system', null);
insert into `purchase` values ('459', 'p0511190008', '012', '新西兰肥羊', '', '10000', '10', '盘', '1', '2005-11-19 22:37:56', 'system', null);
insert into `purchase` values ('460', 'p0511190009', '017', '国蜀鲜嫩羊肉', '', '10100', '12', '盘', '1', '2005-11-19 22:46:24', 'system', null);
insert into `purchase` values ('461', 'p0511190010', '018', '国蜀鲜嫩牛肉', '', '1000', '16', '盘', '1', '2005-11-19 22:46:48', 'system', null);
insert into `purchase` values ('462', 'p0511190011', '018', '国蜀鲜嫩牛肉', '', '1000', '16', '盘', '1', '2005-11-19 22:48:54', 'system', null);
insert into `purchase` values ('463', 'p0511200001', '508', '面包排', '', '10000', '2', '份', '1', '2005-11-20 12:31:41', 'system', null);
insert into `purchase` values ('464', 'p0511200002', '073', '生菜', '', '10000', '4', '盘', '1', '2005-11-20 12:40:26', 'system', null);
insert into `purchase` values ('465', 'p0511200003', '093', '羊尾', '', '10000', '12', '盘', '1', '2005-11-20 12:41:48', 'system', null);
insert into `purchase` values ('466', 'p0511200004', '021', '肥牛眼肉', '', '10000', '25', '盘', '1', '2005-11-20 12:42:39', 'system', null);
insert into `purchase` values ('467', 'p0511200005', '040', '鲜虾滑', '', '100000', '28', '盘', '1', '2005-11-20 12:43:28', 'system', null);
insert into `purchase` values ('468', 'p0511200006', '509', '黄瓜', '', '10000', '1', '根', '1', '2005-11-20 12:46:59', 'system', null);
insert into `purchase` values ('469', 'p0511210001', '421', '小葱', '', '10000', '2', '份', '1', '2005-11-21 19:41:49', 'system', null);
insert into `purchase` values ('470', 'p0511210002', '422', '拍黄瓜', '', '10000', '4', '盘', '1', '2005-11-21 20:13:25', 'system', null);
insert into `purchase` values ('471', 'p0511220001', '423', '萝卜', '', '10000', '3', '份', '1', '2005-11-22 13:00:27', '002', null);
insert into `purchase` values ('472', 'p0511220002', '510', '纯牛奶', '', '2', '1.5', '袋', '1', '2005-11-22 18:34:49', '002', null);
insert into `purchase` values ('473', 'p0511230001', '511', '川椒', '', '10000', '2', '份', '1', '2005-11-23 19:32:07', '002', null);
insert into `purchase` values ('474', 'p0511230002', '511', '川椒', '', '10000', '6', '份', '1', '2005-11-23 20:17:16', '002', null);
insert into `purchase` values ('475', 'p0511250001', '512', '单饼', '', '1', '1', '张', '1', '2005-11-25 20:39:03', '002', null);
insert into `purchase` values ('476', 'p1307220001', '001', '鸳鸯锅', '11', '0', '15', '个', '0', '2013-07-22 12:30:09', '001', 'u1307220002');
insert into `purchase` values ('477', 'p1307220002', '005', '小锅', '11', '3', '5', '个', '1', '2013-07-22 12:32:08', '001', 'u1307220001');

-- ----------------------------
-- table structure for `sell_main`
-- ----------------------------
drop table if exists `sell_main`;
create table `sell_main` (
  `id` int(11) not null auto_increment,
  `invoiceid` varchar(10) default null,
  `ar` double default '0',
  `pu` double default '0',
  `hang` tinyint(1) default null comment '售卖标志',
  `selldate` datetime default null,
  `username` varchar(12) default null,
  `remark` double default '0',
  primary key (`id`),
  key `id` (`id`),
  key `invoiceid` (`invoiceid`)
) engine=innodb auto_increment=672 default charset=utf8;

-- ----------------------------
-- records of sell_main
-- ----------------------------
insert into `sell_main` values ('669', '1307200001', '40', '41', '1', '2013-07-20 17:23:33', '001', '0');
insert into `sell_main` values ('670', '1307200002', '0', '0', '0', '2013-07-20 17:24:50', '001', '0');
insert into `sell_main` values ('671', '1307220001', '25', '29', '1', '2013-07-22 10:47:04', '001', '0');

-- ----------------------------
-- table structure for `sell_minor`
-- ----------------------------
drop table if exists `sell_minor`;
create table `sell_minor` (
  `id` int(11) not null auto_increment comment '主键',
  `invoiceid` varchar(10) default null comment '出库编号',
  `barcode` varchar(13) default null comment '条形码',
  `goodsname` varchar(40) default null comment '产品名称',
  `unit` varchar(10) default null comment '计量单位',
  `sellscalar` double default '0' comment '数量',
  `agio` smallint(6) default '0',
  `purchaseprice` double default '0' comment '进价',
  `sellprice` double default '0' comment '售价',
  `subtotal` double default '0' comment '折扣',
  `gift` varchar(4) default null comment '赠品',
  `untreadflag` varchar(4) default null,
  primary key (`id`),
  key `barcode` (`barcode`),
  key `id` (`id`),
  key `invoiceid` (`invoiceid`)
) engine=innodb auto_increment=7887 default charset=utf8;

-- ----------------------------
-- records of sell_minor
-- ----------------------------
insert into `sell_minor` values ('7881', '1307200001', '001', '鸳鸯锅', '个', '1', '100', '14.95', '15', '15', '-', '-');
insert into `sell_minor` values ('7882', '1307200001', '002', '香辣中锅', '个', '1', '100', '14', '14', '14', '-', '-');
insert into `sell_minor` values ('7883', '1307200001', '003', '白汤中锅', '个', '1', '100', '12', '12', '12', '-', '-');
insert into `sell_minor` values ('7884', '1307200002', '001', '鸳鸯锅', '个', '1', '1', '14.95', '15', '0.15', '-', '-');
insert into `sell_minor` values ('7885', '1307220001', '001', '鸳鸯锅', '个', '1', '100', '14.95', '15', '15', '-', '-');
insert into `sell_minor` values ('7886', '1307220001', '002', '香辣中锅', '个', '1', '100', '14', '14', '14', '-', '-');

-- ----------------------------
-- table structure for `stock`
-- ----------------------------
drop table if exists `stock`;
create table `stock` (
  `id` int(11) not null auto_increment comment '主键',
  `barcode` varchar(15) default null comment '条形码',
  `goodsname` varchar(40) default null comment '产品名称',
  `pybrevity` varchar(20) default null comment '拼音简称',
  `unit` varchar(10) default null comment '计量单位',
  `purchaseprice` double default '0' comment '进价',
  `sellprice` double default '0' comment '售价',
  `stockscalar` double default '0' comment '库存数量',
  `agio` smallint(6) default '0' comment '最高折扣',
  `stockbaseline` double default '0' comment '最低库存',
  `untreaddate` smallint(6) default '0' comment '退货期限',
  primary key (`id`),
  key `barcode` (`barcode`),
  key `id` (`id`)
) engine=innodb auto_increment=298 default charset=utf8;

-- ----------------------------
-- records of stock
-- ----------------------------
insert into `stock` values ('25', '001', '鸳鸯锅', 'yyg', '个', '14.95', '15', '609', '100', '10', '3');
insert into `stock` values ('26', '005', '小锅', 'xg', '个', '5', '5', '9784', '66', '10', '3');
insert into `stock` values ('27', '002', '香辣中锅', 'xlzg', '个', '14', '14', '977', '100', '10', '3');
insert into `stock` values ('28', '003', '白汤中锅', 'btzg', '个', '12', '12', '923', '100', '10', '3');
insert into `stock` values ('29', '004', '滋补锅', 'zbg', '个', '36', '36', '984', '100', '10', '3');
insert into `stock` values ('30', '006', '国蜀调料', 'gstl', '份', '2', '2', '9276', '100', '10', '3');
insert into `stock` values ('31', '007', '香辣调料', 'xltl', '份', '2', '2', '9759', '100', '10', '3');
insert into `stock` values ('32', '008', '麻酱调料', 'mjtl', '份', '2', '2', '9283', '100', '10', '3');
insert into `stock` values ('33', '009', '香油蒜泥', 'xysn', '份', '2', '2', '9963', '100', '10', '3');
insert into `stock` values ('34', '010', '小料', 'xl', '份', '1', '1', '9901', '100', '10', '3');
insert into `stock` values ('36', '013', '羔羊腿肉', 'gytr', '盘', '12', '12', '9907', '100', '10', '3');
insert into `stock` values ('37', '012', '新西兰肥羊', 'fy', '盘', '10', '10', '19880', '100', '10', '3');
insert into `stock` values ('38', '016', '羊肉滑', 'yrh', '盘', '18', '18', '9956', '100', '10', '3');
insert into `stock` values ('40', '015', '羊腰', 'yy', '盘', '12', '12', '9986', '100', '10', '3');
insert into `stock` values ('41', '017', '国蜀鲜嫩羊肉', 'xyr', '盘', '12', '12', '19994', '100', '10', '3');
insert into `stock` values ('42', '018', '国蜀鲜嫩牛肉', 'xnr', '盘', '16', '16', '11983', '100', '10', '3');
insert into `stock` values ('44', '023', '牛肉滑', 'nrh', '盘', '22', '22', '9986', '100', '10', '3');
insert into `stock` values ('45', '020', '肥牛上脑', 'fnsn', '盘', '22', '22', '9992', '100', '10', '3');
insert into `stock` values ('47', '022', 'a外脊肥牛', 'awjfn', '盘', '26', '26', '9995', '100', '10', '3');
insert into `stock` values ('48', '024', '猪五花', 'zwh', '盘', '10', '10', '9988', '100', '10', '3');
insert into `stock` values ('49', '025', '腰花', 'yh', '盘', '10', '10', '9988', '100', '10', '3');
insert into `stock` values ('50', '026', '青虾', 'qx', '盘', '18', '18', '9857.44', '100', '10', '3');
insert into `stock` values ('51', '027', '扇贝', 'sb', '盘', '16', '16', '9997', '100', '10', '3');
insert into `stock` values ('52', '031', '花鲢鱼片', 'hlyp', '盘', '10', '10', '9981', '100', '10', '3');
insert into `stock` values ('53', '028', '蛎蝗', 'lh', '盘', '12', '12', '9992', '100', '10', '3');
insert into `stock` values ('54', '029', '海兔', 'ht', '盘', '12', '12', '9999', '100', '10', '3');
insert into `stock` values ('55', '030', '墨鱼仔', 'myz', '盘', '15', '15', '9981', '100', '10', '3');
insert into `stock` values ('56', '032', '三文鱼生吃(小)', 'swyscx', '盘', '22', '22', '9993', '100', '10', '3');
insert into `stock` values ('57', '033', '三文鱼生吃(大)', 'swyscd', '盘', '38', '38', '9996', '100', '10', '3');
insert into `stock` values ('58', '034', '鲜鱿鱼卷', 'xyyj', '盘', '16', '16', '9983', '100', '10', '3');
insert into `stock` values ('59', '035', '基围虾', 'jwx', '斤', '108', '108', '9998', '100', '10', '3');
insert into `stock` values ('60', '036', '河蟹', 'hx', '斤', '38', '38', '9998', '100', '10', '3');
insert into `stock` values ('61', '037', '海蟹', 'hx', '斤', '200', '200', '9999', '100', '10', '3');
insert into `stock` values ('62', '038', '黑鱼两吃', 'hylc', '斤', '22', '22', '9994.2', '100', '10', '3');
insert into `stock` values ('63', '039', '鲜鱼滑', 'xyh', '盘', '22', '22', '9945', '100', '10', '3');
insert into `stock` values ('65', '041', '百叶', 'by', '盘', '12', '12', '9961', '100', '10', '3');
insert into `stock` values ('66', '042', '毛肚', 'md', '盘', '12', '12', '9915', '100', '10', '3');
insert into `stock` values ('67', '043', '鸭肠', 'yc', '盘', '12', '12', '9995', '100', '10', '3');
insert into `stock` values ('68', '044', '午餐肉', 'wcr', '盘', '12', '12', '9993', '100', '10', '3');
insert into `stock` values ('69', '045', '黄喉', 'hh', '盘', '15', '15', '9981', '100', '10', '3');
insert into `stock` values ('70', '046', '牛骨髓', 'ngs', '盘', '15', '15', '9995', '100', '10', '3');
insert into `stock` values ('71', '047', '鸭血', 'yx', '盘', '4', '4', '9920', '100', '10', '3');
insert into `stock` values ('73', '049', '鲜蘑', 'xm', '盘', '4', '4', '9948', '100', '10', '3');
insert into `stock` values ('74', '050', '香菇蘑', 'xgm', '盘', '5', '5', '9964', '100', '10', '3');
insert into `stock` values ('76', '052', '鸡腿蘑', 'jtm', '盘', '8', '8', '9992', '100', '10', '3');
insert into `stock` values ('77', '053', '乳牛肝蘑', 'rngm', '盘', '12', '12', '9992', '100', '10', '3');
insert into `stock` values ('78', '054', '彩云蘑', 'cym', '盘', '12', '12', '9999', '100', '10', '3');
insert into `stock` values ('79', '055', '鲍鱼菇', 'byg', '盘', '12', '12', '9998', '100', '10', '3');
insert into `stock` values ('80', '056', '猴头菇', 'htg', '盘', '12', '12', '9994', '100', '10', '3');
insert into `stock` values ('81', '057', '罗汉竹笋', 'lhzs', '盘', '5', '5', '9989', '100', '10', '3');
insert into `stock` values ('82', '058', '黑木耳', 'hme', '盘', '6', '6', '9956', '100', '10', '3');
insert into `stock` values ('83', '059', '海带片', 'hdp', '盘', '4', '4', '9967', '100', '10', '3');
insert into `stock` values ('84', '060', '海带根', 'hdg', '盘', '5', '5', '9846', '100', '10', '3');
insert into `stock` values ('85', '061', '宽粉', 'kf', '盘', '4', '4', '9837', '100', '10', '3');
insert into `stock` values ('86', '062', '粉丝', 'fs', '盘', '4', '4', '9965', '100', '10', '3');
insert into `stock` values ('87', '063', '水晶粉', 'sjf', '盘', '5', '5', '9954', '100', '10', '3');
insert into `stock` values ('88', '064', '鲜豆腐', 'xdf', '盘', '3', '3', '9945', '100', '10', '3');
insert into `stock` values ('89', '065', '冻豆腐 ', 'ddf', '盘', '3', '3', '9767', '100', '10', '3');
insert into `stock` values ('90', '066', '油豆腐皮', 'ydfp', '盘', '4', '4', '9956', '100', '10', '3');
insert into `stock` values ('92', '068', '土豆片', 'tdp', '盘', '4', '4', '9937', '100', '10', '3');
insert into `stock` values ('93', '069', '红薯 ', 'hs', '盘', '4', '4', '9890', '100', '10', '3');
insert into `stock` values ('94', '070', '冬瓜', 'dg', '盘', '4', '4', '9942', '100', '10', '3');
insert into `stock` values ('95', '071', '茼蒿', 'th', '盘', '4', '4', '9762', '100', '10', '3');
insert into `stock` values ('96', '072', '菠菜', 'bc', '盘', '4', '4', '9883', '100', '10', '3');
insert into `stock` values ('98', '074', '香菜', 'xc', '盘', '4', '4', '9812', '100', '10', '3');
insert into `stock` values ('99', '075', '大白菜', 'dbc', '盘', '4', '4', '9838', '100', '10', '3');
insert into `stock` values ('101', '077', '西饼', 'xb', '个', '1', '1', '9981', '100', '10', '3');
insert into `stock` values ('102', '078', '金馒头', 'jmt', '份', '6', '6', '9944', '100', '10', '3');
insert into `stock` values ('103', '079', '油炸麻团', 'yzmt', '份', '8', '8', '9988', '100', '10', '3');
insert into `stock` values ('104', '080', '红薯饼', 'hsb', '份', '8', '8', '9989.75', '100', '10', '3');
insert into `stock` values ('105', '081', '南瓜饼', 'ngb', '份', '8', '8', '9964', '100', '10', '3');
insert into `stock` values ('106', '082', '虾饺', 'xj', '份', '8', '8', '9985', '100', '10', '3');
insert into `stock` values ('108', '084', '龙须面', 'lxm', '份', '3', '3', '9973.98', '100', '10', '3');
insert into `stock` values ('109', '085', '娃娃菜', 'wwc', '盘', '6', '6', '9995', '100', '10', '3');
insert into `stock` values ('110', '086', '酸菜丝', 'scs', '盘', '3', '3', '9981', '100', '10', '3');
insert into `stock` values ('111', '087', '藕片', 'op', '盘', '5', '5', '9995', '100', '10', '3');
insert into `stock` values ('112', '088', '西红柿', 'xhs', '盘', '4', '4', '9980', '100', '10', '3');
insert into `stock` values ('113', '089', '蟹足棒', 'xzb', '盘', '8', '8', '9977', '100', '10', '3');
insert into `stock` values ('114', '090', '鱼丸', 'yw', '盘', '10', '10', '9991', '100', '10', '3');
insert into `stock` values ('115', '091', '虾丸', 'xw', '盘', '10', '10', '9997', '100', '10', '3');
insert into `stock` values ('116', '092', '蟹肉', 'xr', '份', '10', '10', '9999', '100', '10', '3');
insert into `stock` values ('118', '094', '羊宝', 'yb', '盘', '18', '18', '9997', '100', '10', '3');
insert into `stock` values ('120', '096', '牛宝', 'nb', '盘', '12', '12', '9996', '100', '10', '3');
insert into `stock` values ('121', '097', '意粉', 'yf', '盘', '3', '3', '9999', '100', '10', '3');
insert into `stock` values ('122', '098', '疙瘩汤', 'gdt', '份', '10', '10', '9990.5', '100', '10', '3');
insert into `stock` values ('123', '099', '三鲜烙合', 'sxlh', '个', '2', '2', '9838', '100', '10', '3');
insert into `stock` values ('124', '100', '豆沙饼', 'dsb', '个', '1', '1', '9997', '100', '10', '3');
insert into `stock` values ('125', '101', '葱油饼', 'cyb', '个', '1', '1', '9947', '100', '10', '3');
insert into `stock` values ('126', '102', '扬州炒饭', 'yzcf', '盘', '10', '10', '9987.8', '100', '10', '3');
insert into `stock` values ('127', '076', '小白菜', 'xbc', '盘', '4', '4', '9935', '100', '10', '3');
insert into `stock` values ('128', '051', '金针蘑', 'jzm', '盘', '10', '10', '9947', '100', '10', '3');
insert into `stock` values ('129', '202', '珍酒三年陈酿', 'zjsncl', '瓶', '45', '45', '99998', '100', '10', '3');
insert into `stock` values ('130', '200', '金三鞭55', 'jsb55', '斤', '48', '48', '9973.7', '100', '10', '3');
insert into `stock` values ('132', '203', '珍酒五年陈酿', 'zjwncl', '瓶', '58', '58', '9999', '100', '10', '3');
insert into `stock` values ('133', '204', '珍酒十年陈酿(半斤)', 'zjsncnbj', '瓶', '68', '68', '9998', '100', '10', '3');
insert into `stock` values ('134', '205', '珍酒十年陈酿 ', 'zjsncn', '瓶', '108', '108', '9996', '100', '10', '3');
insert into `stock` values ('135', '206', '宁城老窖八年陈酿', 'ncljbncn', '瓶', '78', '78', '9998', '100', '10', '3');
insert into `stock` values ('136', '207', '宁城老窖五年陈酿', 'ncljwncn', '瓶', '48', '48', '9997', '100', '10', '3');
insert into `stock` values ('137', '208', '宁城老窖极品38', 'ncljjp38', '瓶', '68', '68', '10000', '100', '10', '3');
insert into `stock` values ('138', '209', '宁城老窖极品36', 'ncljjp36', '瓶', '32', '32', '9996', '100', '10', '3');
insert into `stock` values ('139', '210', '宁城老窖二星', 'ncljex', '瓶', '52', '52', '10000', '100', '10', '3');
insert into `stock` values ('140', '211', '宁城老窖福星', 'ncljfx', '瓶', '15', '15', '9987', '100', '10', '3');
insert into `stock` values ('141', '212', '裕井烧坊经典', 'yjsfjd', '瓶', '128', '128', '10000', '100', '10', '3');
insert into `stock` values ('142', '213', '裕井三百年陈酿', 'yjsbncn', '瓶', '48', '48', '9998', '100', '10', '3');
insert into `stock` values ('143', '214', '裕井十年陈酿 ', 'yjsncn', '瓶', '24', '24', '10000', '100', '10', '3');
insert into `stock` values ('144', '215', '裕井烧坊简装', 'yjsfjz', '瓶', '18', '18', '9997', '100', '10', '3');
insert into `stock` values ('145', '216', '裕井小酒蒌', 'yjxjl', '瓶', '10', '10', '9982', '100', '10', '3');
insert into `stock` values ('146', '217', '裕井小酒壶', 'yjxjh', '瓶', '6', '6', '9993', '100', '10', '3');
insert into `stock` values ('147', '218', '精品河套王', 'jphtw', '瓶', '128', '128', '9999', '100', '10', '3');
insert into `stock` values ('148', '219', '河套金尊', 'htjz', '瓶', '68', '68', '10000', '100', '10', '3');
insert into `stock` values ('149', '220', '河套银尊', 'htyz', '瓶', '48', '48', '9999', '100', '10', '3');
insert into `stock` values ('150', '221', '河套合口福', 'hthkf', '瓶', '58', '58', '10000', '100', '10', '3');
insert into `stock` values ('151', '222', '河套福星52', 'htfx52', '瓶', '30', '30', '10000', '100', '10', '3');
insert into `stock` values ('152', '223', '河套福星38', 'htfx38', '瓶', '28', '28', '9996', '100', '10', '3');
insert into `stock` values ('153', '224', '河套纯粮', 'htcl', '瓶', '15', '15', '9935', '100', '10', '3');
insert into `stock` values ('154', '225', '太白毫杰酒', 'tbhjj', '瓶', '48', '48', '10000', '100', '10', '3');
insert into `stock` values ('155', '226', '太白巴乡村', 'tbbxc', '瓶', '28', '28', '10000', '100', '10', '3');
insert into `stock` values ('156', '227', '诗仙太白简装', 'sxtbjz', '瓶', '18', '18', '9999', '100', '10', '3');
insert into `stock` values ('157', '228', '凤城老窖一星', 'fcljyx', '瓶', '58', '58', '10000', '100', '10', '3');
insert into `stock` values ('158', '229', '凤城老窖金蒙', 'fcljjm', '瓶', '48', '48', '10000', '100', '10', '3');
insert into `stock` values ('159', '230', '凤城老窖银蒙', 'fcljym', '瓶', '38', '38', '10000', '100', '10', '3');
insert into `stock` values ('160', '231', '凤城原浆', 'fcyj', '瓶', '15', '15', '10000', '100', '10', '3');
insert into `stock` values ('161', '232', '五粮醇', 'wlc', '瓶', '58', '58', '10000', '100', '10', '3');
insert into `stock` values ('162', '233', '五粮醇(三)', 'wlcs', '瓶', '108', '108', '10000', '100', '10', '3');
insert into `stock` values ('163', '234', '小火爆', 'xhb', '瓶', '8', '8', '10000', '100', '10', '3');
insert into `stock` values ('164', '235', '三星杞浓', 'sxqn', '瓶', '98', '98', '10000', '100', '10', '3');
insert into `stock` values ('165', '236', '老池酒 ', 'lcj', '瓶', '288', '288', '10000', '100', '10', '3');
insert into `stock` values ('166', '237', '乾豫兴老窖精品', 'qyxljjp', '瓶', '108', '108', '9998', '100', '10', '3');
insert into `stock` values ('167', '238', '乾豫兴', 'qyx', '瓶', '58', '58', '10000', '100', '10', '3');
insert into `stock` values ('168', '239', '烧锅酒', 'sgj', '瓶', '20', '20', '9996', '100', '10', '3');
insert into `stock` values ('169', '240', '四特陈酿', 'stcn', '瓶', '68', '68', '10000', '100', '10', '3');
insert into `stock` values ('170', '241', '国宾四特', 'gbst', '瓶', '48', '48', '9999', '100', '10', '3');
insert into `stock` values ('171', '242', '店小二38', 'dxe38', '瓶', '36', '36', '9997', '100', '10', '3');
insert into `stock` values ('172', '243', '店小二46', 'dxe46', '瓶', '46', '46', '9997', '100', '10', '3');
insert into `stock` values ('173', '244', '庄家汉简装', 'zjhjz', '瓶', '18', '18', '9985', '100', '10', '3');
insert into `stock` values ('174', '245', '庄家汉盒装', 'zjhhz', '瓶', '58', '58', '10000', '100', '10', '3');
insert into `stock` values ('175', '246', '长城红色庄园', 'cchszy', '瓶', '128', '128', '10000', '100', '10', '3');
insert into `stock` values ('176', '247', '长城干红赤霞珠', 'ccghcxz', '瓶', '98', '98', '10000', '100', '10', '3');
insert into `stock` values ('177', '248', '长城干红葡萄酒制醇', 'ccghptjzc', '瓶', '38', '38', '10000', '100', '10', '3');
insert into `stock` values ('178', '249', '解佰纳干红葡萄酒', 'jbnghptj', '瓶', '78', '78', '10000', '100', '10', '3');
insert into `stock` values ('179', '250', '简农达红酒', 'jndhj', '瓶', '38', '38', '9996', '100', '10', '3');
insert into `stock` values ('180', '251', '燕京无醇', 'yjwc', '瓶', '15', '15', '10000', '100', '10', '3');
insert into `stock` values ('181', '252', '荞麦干啤', 'qmgp', '瓶', '10', '10', '9996', '100', '10', '3');
insert into `stock` values ('182', '253', '燕京纯生', 'yjcs', '瓶', '10', '10', '9995', '100', '10', '3');
insert into `stock` values ('183', '254', '哈干', 'hg', '瓶', '10', '10', '9991', '100', '10', '3');
insert into `stock` values ('184', '255', '哈鲜', 'hx', '瓶', '8', '8', '10000', '100', '10', '3');
insert into `stock` values ('185', '256', '燕京普啤', 'yjpp', '瓶', '2', '2', '9791', '100', '10', '3');
insert into `stock` values ('186', '257', '汇源高纤维', 'hygxw', '盒', '25', '25', '9999', '100', '10', '3');
insert into `stock` values ('187', '258', '汇源果汁100%', 'hygz100%', '盒', '20', '20', '9995', '100', '10', '3');
insert into `stock` values ('188', '259', '汇源果汁50%', 'hygz50%', '瓶', '10', '10', '9995', '100', '10', '3');
insert into `stock` values ('189', '260', '雪碧(大)', 'xbd', '瓶', '10', '10', '9994', '100', '10', '3');
insert into `stock` values ('190', '263', '可口可乐(厅)', 'kkklt', '厅', '3', '3', '9997', '100', '10', '3');
insert into `stock` values ('191', '264', '百事可乐(厅)', 'bsklt', '厅', '3', '3', '9991', '100', '10', '3');
insert into `stock` values ('192', '265', '雪碧(厅)', 'xbt', '厅', '3', '3', '9981', '100', '10', '3');
insert into `stock` values ('193', '266', '百事可乐(中)', 'bsklz', '瓶', '4', '4', '9987', '100', '10', '3');
insert into `stock` values ('194', '262', '百事可乐(大)', 'bskld', '桶', '10', '10', '10000', '100', '10', '3');
insert into `stock` values ('195', '261', '可口可乐(大)', 'kkkld', '瓶', '10', '10', '9998', '100', '10', '3');
insert into `stock` values ('196', '267', '矿泉水', 'kqs', '瓶', '2', '2', '9988', '100', '10', '3');
insert into `stock` values ('197', '268', '杏仁乳', 'xrr', '瓶', '2', '2', '9993', '100', '10', '3');
insert into `stock` values ('198', '269', '花生奶', 'hsn', '壶', '12', '12', '9948', '100', '10', '3');
insert into `stock` values ('199', '270', '硬中华', 'yzh', '盒', '60', '60', '9998', '100', '10', '3');
insert into `stock` values ('200', '271', '苁 蓉', 'cr', '盒', '15', '15', '9988', '100', '10', '3');
insert into `stock` values ('201', '272', '红国宾', 'hgb', '盒', '13', '13', '9970', '100', '10', '3');
insert into `stock` values ('202', '273', '环保白沙', 'hbbs', '盒', '12', '12', '9998', '100', '10', '3');
insert into `stock` values ('203', '274', '红云', 'hy', ' 盒', '10', '10', '9985', '100', '10', '3');
insert into `stock` values ('204', '275', '蓝国宾', 'lgb', '盒 ', '8', '8', '9997', '100', '10', '3');
insert into `stock` values ('205', '019', '精品肥牛', 'jpfn', '盘', '18', '18', '9957', '100', '10', '3');
insert into `stock` values ('206', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('207', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('208', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('209', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('210', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('211', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('212', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('213', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('214', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('215', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('216', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('217', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('218', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('219', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('220', '048', '羊血', 'yangx', '盘', '4', '4', '9960', '100', '10', '3');
insert into `stock` values ('221', '095', '牛鞭', 'nb', '盘', '15', '15', '19995', '100', '10', '3');
insert into `stock` values ('222', '300', '八宝茶', 'bbc', '杯', '1', '1', '9838', '100', '10', '3');
insert into `stock` values ('223', '067', '腐竹', 'fz', '盘', '5', '5', '9984', '100', '10', '3');
insert into `stock` values ('225', '301', '筷子', 'kz', '双', '1', '1', '98086', '100', '10', '3');
insert into `stock` values ('226', '276', '山水啤酒', 'sspj', '瓶', '3', '3', '97922', '100', '10', '3');
insert into `stock` values ('227', '401', '小葱拌虾仁', 'xcbxr', '盘', '4', '4', '9971', '100', '10', '3');
insert into `stock` values ('228', '400', '糖醋蒜', 'tcs', '盘', '3', '3', '99920.6', '100', '10', '3');
insert into `stock` values ('229', '402', '青瓜牛肉', 'qgnr', '盘', '6', '6', '9994', '100', '10', '3');
insert into `stock` values ('230', '403', '杏仁蕨菜', 'xrjc', '盘', '5', '5', '10000', '100', '10', '3');
insert into `stock` values ('231', '404', '陈醋花生米', 'cchsm', '盘', '4', '4', '9999', '100', '10', '3');
insert into `stock` values ('232', '405', '炝拌干丝', 'qbgs', '盘', '4', '4', '99990', '100', '10', '3');
insert into `stock` values ('233', '406', '椒麻凤爪', 'jmfz', '盘', '8', '8', '10000', '100', '10', '3');
insert into `stock` values ('234', '407', '鲅鱼焖豆', 'bymd', '盘', '6', '6', '10000', '100', '10', '3');
insert into `stock` values ('235', '408', '脆耳瓜丝', 'crgs', '盘', '6', '6', '9998.5', '100', '10', '3');
insert into `stock` values ('236', '409', '美极拌菜', 'mjbc', '盘', '4', '4', '100000', '100', '10', '3');
insert into `stock` values ('237', '410', '干烧银鱼 ', 'gsyy', '盘', '4', '4', '9996', '100', '10', '3');
insert into `stock` values ('238', '411', '三鲜炝菠菜', 'sxqbc', '盘', '5', '5', '10000', '100', '10', '3');
insert into `stock` values ('239', '412', '盐爆花生米', 'ybhsm', '盘', '4', '4', '9979', '100', '10', '3');
insert into `stock` values ('240', '413', '四喜豆付', 'sxdf', '盘', '5', '5', '9993', '100', '10', '3');
insert into `stock` values ('241', '414', '拌皮冻', 'bpd', '盘', '4', '4', '9989', '100', '10', '3');
insert into `stock` values ('242', '415', '孜然鸡脖', 'zrjb', '盘', '8', '8', '10000', '100', '10', '3');
insert into `stock` values ('243', '416', '香辣毛肚', 'xlmd', '盘', '7', '8', '19996', '100', '10', '3');
insert into `stock` values ('244', '417', '红梅卧雪', 'hmwx', '盘', '4', '4', '10000', '100', '10', '3');
insert into `stock` values ('245', '418', '凉拌三鲜', 'lbsx', '盘', '5', '5', '9987', '100', '10', '3');
insert into `stock` values ('246', '419', '小白菜拌木耳', 'xbcbme', '盘', '4', '4', '100000', '100', '10', '3');
insert into `stock` values ('247', '420', '牛肉耳段', 'nred', '盘', '6', '6', '99994', '100', '10', '3');
insert into `stock` values ('248', '281', '水煮黑鱼', 'szhy', '斤', '36', '36', '19999', '100', '10', '3');
insert into `stock` values ('249', '277', '海味火锅', 'hwhg', '个', '58', '58', '10000', '100', '10', '3');
insert into `stock` values ('250', '278', '香辣蟹火锅', 'xlxhg', '个', '48', '48', '9991', '100', '10', '3');
insert into `stock` values ('251', '279', '花鲢鱼火锅', 'hlyhg', '个', '36', '36', '9997', '100', '10', '3');
insert into `stock` values ('253', '288', '手擀面', 'sgm', '份', '6', '6', '99991', '100', '10', '3');
insert into `stock` values ('256', '280', '水煮鱼草鱼', 'szcy', '斤', '22', '22', '9990.7', '100', '10', '3');
insert into `stock` values ('257', '282', '乌鸡甲鱼锅', 'wjjyg', '个', '88', '88', '9999', '100', '10', '3');
insert into `stock` values ('258', '283', '鲜对虾丸', 'xdxw', '盘', '36', '36', '9999', '100', '10', '3');
insert into `stock` values ('259', '284', '辣根', 'lg', '份', '2', '2', '9995', '100', '10', '3');
insert into `stock` values ('260', '285', '泥螺', 'nl', '盘', '10', '10', '9997', '100', '10', '3');
insert into `stock` values ('261', '286', '果盘', 'gp', '盘', '10', '10', '9988', '100', '10', '3');
insert into `stock` values ('262', '287', '扑克', 'pk', '副', '2', '2', '9992', '100', '10', '3');
insert into `stock` values ('263', '289', '歌曲', 'gq', '首', '20', '20', '9993', '100', '10', '3');
insert into `stock` values ('264', '290', '泡椒 ', 'pj', '份', '2', '2', '9993', '100', '10', '3');
insert into `stock` values ('265', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('266', '014', '羊脑', 'yn', '盘', '12', '12', '9988', '100', '10', '3');
insert into `stock` values ('267', '083', '菜汁面条', 'czm', '份', '6', '6', '19907', '100', '10', '3');
insert into `stock` values ('268', '201', '银三鞭55', 'ysb55', '斤', '28', '28', '9977.1', '100', '10', '3');
insert into `stock` values ('269', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('270', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('271', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('272', '500', '酒精', 'jj', '个', '1', '1', '9942', '100', '10', '3');
insert into `stock` values ('273', '501', '玉米饼', 'ymb', '份', '4', '4', '9997', '100', '10', '3');
insert into `stock` values ('274', '502', '四野泡菜', 'sypc', '盘', '4', '4', '9994.5', '100', '10', '3');
insert into `stock` values ('275', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('276', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('277', '504', '生鸡蛋', 'sjd', '个', '0.5', '0.5', '10000', '100', '10', '3');
insert into `stock` values ('278', '011', '锡盟羔羊', 'gy', '盘', '10', '10', '9078', '100', '10', '3');
insert into `stock` values ('279', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('280', '503', '米饭', 'mf', '碗', '1', '1', '9986', '100', '10', '3');
insert into `stock` values ('281', '505', '长寿面', 'csm', '碗', '12', '12', '9996', '100', '10', '3');
insert into `stock` values ('282', '506', '油菜', 'y', '份', '4', '4', '983', '100', '10', '3');
insert into `stock` values ('283', '507', '韭菜', 'jc', '份', '4', '4', '10000', '100', '10', '3');
insert into `stock` values ('284', '508', '面包排', 'mbp', '份', '2', '2', '9999', '100', '10', '3');
insert into `stock` values ('285', '073', '生菜', 'sc', '盘', '4', '4', '9936', '100', '10', '3');
insert into `stock` values ('286', '093', '羊尾', 'yw', '盘', '12', '12', '9998', '100', '10', '3');
insert into `stock` values ('287', '021', '肥牛眼肉', 'yr', '盘', '25', '25', '9996', '100', '10', '3');
insert into `stock` values ('288', '040', '鲜虾滑', 'xh', '盘', '28', '28', '99988', '100', '10', '3');
insert into `stock` values ('289', '509', '黄瓜', 'hg', '根', '1', '1', '9984', '100', '10', '3');
insert into `stock` values ('290', '421', '小葱', 'xc', '份', '2', '2', '9998', '100', '10', '3');
insert into `stock` values ('291', '422', '拍黄瓜', 'phg', '盘', '4', '4', '9996', '100', '10', '3');
insert into `stock` values ('292', null, null, null, null, '0', '0', '0', '0', '0', '0');
insert into `stock` values ('293', '423', '萝卜', 'lb', '份', '3', '3', '9996', '100', '10', '3');
insert into `stock` values ('294', '510', '纯牛奶', 'cnn', '袋', '1.5', '1.5', '0', '100', '10', '3');
insert into `stock` values ('295', '511', '川椒', 'cj', '份', '4', '6', '19999', '100', '10', '3');
insert into `stock` values ('296', '512', '单饼', 'db', '张', '1', '1', '0', '100', '10', '3');
insert into `stock` values ('297', null, null, null, null, '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- table structure for `unit`
-- ----------------------------
drop table if exists `unit`;
create table `unit` (
  `id` int(11) not null auto_increment comment '主键',
  `unitname` varchar(10) default null comment '计量名称',
  primary key (`id`),
  key `id` (`id`)
) engine=innodb auto_increment=17 default charset=utf8;

-- ----------------------------
-- records of unit
-- ----------------------------
insert into `unit` values ('7', '盒');
insert into `unit` values ('10', '瓶');
insert into `unit` values ('12', '盘');
insert into `unit` values ('13', '份');
insert into `unit` values ('14', '个');
insert into `unit` values ('15', '斤');
insert into `unit` values ('16', 'sha');

-- ----------------------------
-- table structure for `unstock`
-- ----------------------------
drop table if exists `unstock`;
create table `unstock` (
  `id` int(11) not null auto_increment comment '主键',
  `invoiceid` varchar(11) default null comment '退货单号',
  `pid` varchar(11) default null comment '采购单号',
  `barcode` varchar(15) default null comment '条形码',
  `goodsname` varchar(40) default null comment '产品名称',
  `unit` varchar(10) default null comment '计量单位',
  `unitprice` double default '0' comment '采购价格',
  `unscalar` double default '0' comment '退货数量',
  `undate` datetime default null comment '退货日期',
  `username` varchar(12) default null comment '操作员',
  primary key (`id`),
  key `barcode` (`barcode`),
  key `id` (`id`),
  key `invoiceid` (`invoiceid`),
  key `pid` (`pid`)
) engine=innodb auto_increment=4 default charset=utf8;

-- ----------------------------
-- records of unstock
-- ----------------------------
insert into `unstock` values ('1', 'u1307220001', 'p1307220002', '005', '小锅', '个', '5', '1', '2013-07-22 12:36:40', '001');
insert into `unstock` values ('2', 'u1307220002', 'p1307220001', '001', '鸳鸯锅', '个', '15', '1', '2013-07-22 12:37:25', '001');
insert into `unstock` values ('3', 'u1307230001', 'p0511070013', '011', '锡盟羔羊', '盘', '10', '23', '2013-07-23 11:45:47', '002');

-- ----------------------------
-- table structure for `vip_1`
-- ----------------------------
drop table if exists `vip_1`;
create table `vip_1` (
  `id` int(11) not null auto_increment comment '主键',
  `name` varchar(12) default null comment '会员姓名',
  `address` varchar(40) default null comment '地址',
  `tel` varchar(15) default null comment '电话',
  `money` double default '0' comment '卡片余额',
  `vipid` varchar(15) default null comment '卡号',
  `remark` varchar(50) default null comment '备注',
  `state` varchar(4) default null comment '状态',
  `username` varchar(12) default null comment '发卡员',
  primary key (`id`),
  key `id` (`id`),
  key `vipid` (`vipid`)
) engine=innodb auto_increment=2 default charset=utf8;

-- ----------------------------
-- records of vip_1
-- ----------------------------
insert into `vip_1` values ('1', '1', '1', '1', '124456', '111111111111111', '1', '挂失', '001');

-- ----------------------------
-- table structure for `vip_2`
-- ----------------------------
drop table if exists `vip_2`;
create table `vip_2` (
  `id` int(11) not null auto_increment,
  `vipid` varchar(15) default null,
  `invoiceid` varchar(10) default null,
  `money` double default '0',
  `username` varchar(12) default null,
  primary key (`id`),
  key `id` (`id`),
  key `invoiceid` (`invoiceid`),
  key `vipid` (`vipid`)
) engine=innodb default charset=utf8;

-- ----------------------------
-- records of vip_2
-- ----------------------------

-- ----------------------------
-- table structure for `vip_3`
-- ----------------------------
drop table if exists `vip_3`;
create table `vip_3` (
  `id` int(11) not null auto_increment comment '主键',
  `vipid` varchar(15) default null comment '卡号',
  `money` double default '0' comment '充值金额',
  `date` datetime default null comment '充值日期',
  `username` varchar(12) default null comment '充值员',
  primary key (`id`),
  key `id` (`id`),
  key `vipid` (`vipid`)
) engine=innodb auto_increment=3 default charset=utf8;

-- ----------------------------
-- records of vip_3
-- ----------------------------
insert into `vip_3` values ('1', '111111111111111', '1000', '2013-07-22 16:21:02', '001');
insert into `vip_3` values ('2', '111111111111111', '123456', '2013-07-23 10:26:42', '002');

-- ----------------------------
-- table structure for `vip_4`
-- ----------------------------
drop table if exists `vip_4`;
create table `vip_4` (
  `id` int(11) not null auto_increment,
  `vipid` varchar(15) default null,
  `newid` varchar(15) default null,
  `date` varchar(50) default null,
  `username` varchar(12) default null,
  primary key (`id`),
  key `id` (`id`),
  key `newid` (`newid`),
  key `vipid` (`vipid`)
) engine=innodb default charset=utf8;

-- ----------------------------
-- records of vip_4
-- ----------------------------
