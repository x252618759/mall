

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for Himall_AccountDetails
-- ----------------------------
DROP TABLE IF EXISTS `Himall_AccountDetails`;
CREATE TABLE `Himall_AccountDetails` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccountId` bigint(20) NOT NULL COMMENT '结算记录外键',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `Date` datetime NOT NULL COMMENT '完成日期',
  `OrderDate` datetime NOT NULL COMMENT '订单下单日期',
  `OrderType` int(11) NOT NULL COMMENT '枚举 完成订单1，退订单0',
  `OrderId` bigint(20) NOT NULL COMMENT '订单ID',
  `ProductActualPaidAmount` decimal(18,2) NOT NULL COMMENT '商品实付总额',
  `FreightAmount` decimal(18,2) NOT NULL COMMENT '运费金额',
  `CommissionAmount` decimal(18,2) NOT NULL COMMENT '佣金',
  `RefundTotalAmount` decimal(18,2) NOT NULL COMMENT '退款金额',
  `RefundCommisAmount` decimal(18,2) NOT NULL COMMENT '退还佣金',
  `OrderRefundsDates` varchar(300) NOT NULL COMMENT '退单的日期集合以;分隔',
  `BrokerageAmount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '分销佣金',
  `ReturnBrokerageAmount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '退分销佣金',
  PRIMARY KEY (`Id`),
  KEY `himall_accountdetails_ibfk_1` (`AccountId`) USING BTREE,
  CONSTRAINT `himall_accountdetails_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `Himall_Accounts` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_AccountMeta
-- ----------------------------
DROP TABLE IF EXISTS `Himall_AccountMeta`;
CREATE TABLE `Himall_AccountMeta` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccountId` bigint(20) NOT NULL,
  `MetaKey` varchar(100) NOT NULL,
  `MetaValue` text NOT NULL,
  `ServiceStartTime` datetime NOT NULL COMMENT '营销服务开始时间',
  `ServiceEndTime` datetime NOT NULL COMMENT '营销服务结束时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_AccountPurchaseAgreement
-- ----------------------------
DROP TABLE IF EXISTS `Himall_AccountPurchaseAgreement`;
CREATE TABLE `Himall_AccountPurchaseAgreement` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccountId` bigint(20) DEFAULT NULL,
  `ShopId` bigint(20) NOT NULL,
  `Date` datetime NOT NULL COMMENT '日期',
  `PurchaseAgreementId` bigint(20) NOT NULL,
  `AdvancePayment` decimal(18,2) NOT NULL COMMENT '预付款金额',
  `FinishDate` datetime NOT NULL COMMENT '平台审核时间',
  `ApplyDate` datetime DEFAULT NULL COMMENT '申请',
  PRIMARY KEY (`Id`),
  KEY `AccountId` (`AccountId`) USING BTREE,
  CONSTRAINT `himall_accountpurchaseagreement_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `Himall_Accounts` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Accounts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Accounts`;
CREATE TABLE `Himall_Accounts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  `AccountDate` datetime NOT NULL COMMENT '出账日期',
  `StartDate` datetime NOT NULL COMMENT '开始时间',
  `EndDate` datetime NOT NULL COMMENT '结束时间',
  `Status` int(11) NOT NULL COMMENT '枚举 0未结账，1已结账',
  `ProductActualPaidAmount` decimal(18,2) NOT NULL COMMENT '商品实付总额',
  `FreightAmount` decimal(18,2) NOT NULL COMMENT '运费',
  `CommissionAmount` decimal(18,2) NOT NULL COMMENT '佣金',
  `RefundCommissionAmount` decimal(18,2) NOT NULL COMMENT '退还佣金',
  `RefundAmount` decimal(18,2) NOT NULL COMMENT '退款金额',
  `AdvancePaymentAmount` decimal(18,2) NOT NULL COMMENT '预付款总额',
  `PeriodSettlement` decimal(18,2) NOT NULL COMMENT '本期应结',
  `Remark` text,
  `Brokerage` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '分销佣金',
  `ReturnBrokerage` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '退还分销佣金',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ActiveMarketService
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ActiveMarketService`;
CREATE TABLE `Himall_ActiveMarketService` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `TypeId` int(11) NOT NULL COMMENT '营销服务类型ID',
  `ShopId` bigint(20) NOT NULL,
  `ShopName` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_AgentProducts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_AgentProducts`;
CREATE TABLE `Himall_AgentProducts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ProductId` bigint(20) NOT NULL COMMENT '推销商品ID',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺Id',
  `UserId` bigint(20) NOT NULL COMMENT '用户名',
  `AddTime` datetime NOT NULL COMMENT '代理时间',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_AgentProducts_ProductId` (`ProductId`) USING BTREE,
  KEY `FK_Himall_AgentProducts_UserId` (`UserId`) USING BTREE,
  CONSTRAINT `FK_Himall_AgentProducts_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Himall_AgentProducts_UserId` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Agreement
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Agreement`;
CREATE TABLE `Himall_Agreement` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AgreementType` int(4) NOT NULL COMMENT '协议类型 枚举 AgreementType：0买家注册协议，1卖家入驻协议',
  `AgreementContent` text NOT NULL COMMENT '协议内容',
  `LastUpdateTime` datetime DEFAULT NULL COMMENT '最后修改日期',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ApplyWithDraw
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ApplyWithDraw`;
CREATE TABLE `Himall_ApplyWithDraw` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MemId` bigint(20) NOT NULL COMMENT '会员ID',
  `NickName` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `OpenId` varchar(50) DEFAULT NULL COMMENT 'OpenId',
  `ApplyStatus` int(11) NOT NULL COMMENT '申请状态',
  `ApplyAmount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '提现金额',
  `ApplyTime` datetime NOT NULL COMMENT '申请时间',
  `ConfirmTime` datetime DEFAULT NULL COMMENT '处理时间',
  `PayTime` datetime DEFAULT NULL COMMENT '付款时间',
  `PayNo` varchar(50) DEFAULT NULL COMMENT '付款流水号',
  `OpUser` varchar(50) DEFAULT NULL COMMENT '操作人',
  `Remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ArticleCategories
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ArticleCategories`;
CREATE TABLE `Himall_ArticleCategories` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ParentCategoryId` bigint(20) NOT NULL,
  `Name` varchar(100) DEFAULT NULL COMMENT '文章类型名称',
  `DisplaySequence` bigint(20) NOT NULL COMMENT '显示顺序',
  `IsDefault` tinyint(1) NOT NULL COMMENT '是否为默认',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Articles
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Articles`;
CREATE TABLE `Himall_Articles` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `CategoryId` bigint(20) NOT NULL DEFAULT '0' COMMENT '文章分类ID',
  `Title` varchar(100) NOT NULL COMMENT '文章标题',
  `IconUrl` varchar(100) DEFAULT NULL,
  `Content` mediumtext NOT NULL COMMENT '文档内容',
  `AddDate` datetime NOT NULL,
  `DisplaySequence` bigint(20) NOT NULL,
  `Meta_Title` text COMMENT 'SEO标题',
  `Meta_Description` text COMMENT 'SEO说明',
  `Meta_Keywords` text COMMENT 'SEO关键字',
  `IsRelease` tinyint(1) NOT NULL COMMENT '是否显示',
  PRIMARY KEY (`Id`),
  KEY `FK_ArticleCategory_Article` (`CategoryId`) USING BTREE,
  CONSTRAINT `himall_articles_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `Himall_ArticleCategories` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Attributes
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Attributes`;
CREATE TABLE `Himall_Attributes` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `TypeId` bigint(20) NOT NULL,
  `Name` varchar(100) NOT NULL COMMENT '名称',
  `DisplaySequence` bigint(20) NOT NULL,
  `IsMust` tinyint(1) NOT NULL COMMENT '是否为必选',
  `IsMulti` tinyint(1) NOT NULL COMMENT '是否可多选',
  PRIMARY KEY (`Id`),
  KEY `FK_Type_Attribute` (`TypeId`) USING BTREE,
  CONSTRAINT `himall_attributes_ibfk_1` FOREIGN KEY (`TypeId`) REFERENCES `Himall_Types` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_AttributeValues
-- ----------------------------
DROP TABLE IF EXISTS `Himall_AttributeValues`;
CREATE TABLE `Himall_AttributeValues` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AttributeId` bigint(20) NOT NULL COMMENT '属性ID',
  `Value` varchar(100) NOT NULL COMMENT '属性值',
  `DisplaySequence` bigint(20) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Attribute_AttributeValue` (`AttributeId`) USING BTREE,
  CONSTRAINT `himall_attributevalues_ibfk_1` FOREIGN KEY (`AttributeId`) REFERENCES `Himall_Attributes` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=741 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Banners
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Banners`;
CREATE TABLE `Himall_Banners` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `Name` varchar(100) NOT NULL COMMENT '导航名称',
  `Position` int(11) NOT NULL COMMENT '导航显示位置',
  `DisplaySequence` bigint(20) NOT NULL,
  `Url` varchar(1000) NOT NULL COMMENT '跳转URL',
  `Platform` int(11) NOT NULL DEFAULT '0' COMMENT '显示在哪个终端',
  `UrlType` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Bonus
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Bonus`;
CREATE TABLE `Himall_Bonus` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Type` int(11) NOT NULL COMMENT '类型，活动红包，关注送红包',
  `Style` int(11) NOT NULL COMMENT '样式，模板一（源生风格），模板二',
  `Name` varchar(100) DEFAULT NULL COMMENT '名称',
  `MerchantsName` varchar(50) DEFAULT NULL COMMENT '商户名称',
  `Remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `Blessing` varchar(100) DEFAULT NULL COMMENT '祝福语',
  `TotalPrice` decimal(18,2) NOT NULL COMMENT '总面额',
  `StartTime` datetime NOT NULL COMMENT '开始日期',
  `EndTime` datetime NOT NULL COMMENT '结束日期',
  `QRPath` varchar(100) DEFAULT NULL COMMENT '二维码',
  `PriceType` int(11) DEFAULT NULL COMMENT '是否固定金额',
  `FixedAmount` decimal(18,2) DEFAULT NULL COMMENT '固定金额',
  `RandomAmountStart` decimal(18,2) DEFAULT NULL COMMENT '随机金额起止范围',
  `RandomAmountEnd` decimal(18,2) DEFAULT NULL COMMENT '随机金额起止范围',
  `ReceiveCount` int(11) NOT NULL,
  `ImagePath` varchar(100) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `IsInvalid` tinyint(1) NOT NULL,
  `ReceivePrice` decimal(18,2) NOT NULL,
  `ReceiveHref` varchar(200) NOT NULL,
  `IsAttention` tinyint(1) NOT NULL,
  `IsGuideShare` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_BonusReceive
-- ----------------------------
DROP TABLE IF EXISTS `Himall_BonusReceive`;
CREATE TABLE `Himall_BonusReceive` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `BonusId` bigint(20) NOT NULL COMMENT '红包Id',
  `OpenId` varchar(100) DEFAULT NULL COMMENT '领取人微信Id',
  `ReceiveTime` datetime DEFAULT NULL COMMENT '领取日期',
  `Price` decimal(18,2) NOT NULL COMMENT '领取金额',
  `IsShare` tinyint(1) DEFAULT NULL,
  `IsTransformedDeposit` tinyint(1) NOT NULL COMMENT '红包金额是否已经转入了预存款',
  `UserId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Reference_1` (`BonusId`) USING BTREE,
  KEY `FK_UserId` (`UserId`) USING BTREE,
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`BonusId`) REFERENCES `Himall_Bonus` (`Id`),
  CONSTRAINT `FK_UserId` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Brands
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Brands`;
CREATE TABLE `Himall_Brands` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL COMMENT '品牌名称',
  `DisplaySequence` bigint(20) NOT NULL COMMENT '顺序',
  `Logo` varchar(1000) DEFAULT NULL COMMENT 'LOGO',
  `RewriteName` varchar(50) DEFAULT NULL COMMENT '未使用',
  `Description` varchar(1000) DEFAULT NULL COMMENT '说明',
  `Meta_Title` varchar(1000) DEFAULT NULL COMMENT 'SEO',
  `Meta_Description` varchar(1000) DEFAULT NULL,
  `Meta_Keywords` varchar(1000) DEFAULT NULL,
  `IsRecommend` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_BrokerageIncome
-- ----------------------------
DROP TABLE IF EXISTS `Himall_BrokerageIncome`;
CREATE TABLE `Himall_BrokerageIncome` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `OrderId` bigint(20) DEFAULT NULL COMMENT '订单编号',
  `OrderItemId` bigint(20) DEFAULT NULL COMMENT '订单条目编号',
  `SkuID` varchar(100) NOT NULL COMMENT 'SKUID',
  `ProductID` bigint(20) NOT NULL COMMENT '产品ID',
  `ProductName` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `SkuInfo` varchar(100) DEFAULT NULL COMMENT 'SKU信息',
  `Brokerage` decimal(18,2) NOT NULL COMMENT '获得佣金',
  `TotalPrice` decimal(18,2) DEFAULT NULL COMMENT '分销比例',
  `ShopId` bigint(20) DEFAULT NULL COMMENT '店铺ID',
  `CreateTime` datetime DEFAULT NULL COMMENT '时间',
  `OrderTime` datetime NOT NULL COMMENT '订单创建时间',
  `BuyerUserId` bigint(20) NOT NULL COMMENT '消费者ID',
  `Status` int(11) NOT NULL COMMENT '结算状态 -1不可结算 未结算，已结算',
  `SettlementTime` datetime DEFAULT NULL COMMENT '结算时间',
  `UserId` bigint(20) NOT NULL COMMENT '推广会员ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_BrokerageRefund
-- ----------------------------
DROP TABLE IF EXISTS `Himall_BrokerageRefund`;
CREATE TABLE `Himall_BrokerageRefund` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `IncomeId` bigint(20) DEFAULT NULL COMMENT '收入表外键',
  `Brokerage` decimal(18,2) NOT NULL COMMENT '退还佣金',
  `RefundAmount` decimal(18,2) DEFAULT NULL COMMENT '退款金额',
  `RefundTime` datetime DEFAULT NULL COMMENT '退款时间',
  `RefundId` bigint(20) NOT NULL DEFAULT '0' COMMENT '退款Id',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_Brund_IncomeId` (`IncomeId`) USING BTREE,
  CONSTRAINT `FK_Himall_Brund_IncomeId` FOREIGN KEY (`IncomeId`) REFERENCES `Himall_BrokerageIncome` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_BrowsingHistory
-- ----------------------------
DROP TABLE IF EXISTS `Himall_BrowsingHistory`;
CREATE TABLE `Himall_BrowsingHistory` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MemberId` bigint(20) NOT NULL COMMENT '会员ID',
  `ProductId` bigint(20) NOT NULL,
  `BrowseTime` datetime NOT NULL COMMENT '浏览时间',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_BrowsingHistory_Himall_BrowsingHistory` (`MemberId`) USING BTREE,
  KEY `FK_Himall_BrowsingHistory_Himall_Products` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_browsinghistory_ibfk_1` FOREIGN KEY (`MemberId`) REFERENCES `Himall_Members` (`Id`),
  CONSTRAINT `himall_browsinghistory_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2123 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_BusinessCategories
-- ----------------------------
DROP TABLE IF EXISTS `Himall_BusinessCategories`;
CREATE TABLE `Himall_BusinessCategories` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `CategoryId` bigint(20) NOT NULL COMMENT '分类ID',
  `CommisRate` decimal(8,2) NOT NULL COMMENT '分佣比例',
  PRIMARY KEY (`Id`),
  KEY `FK_Category_BusinessCategory` (`CategoryId`) USING BTREE,
  CONSTRAINT `himall_businesscategories_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `Himall_Categories` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2405 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_BusinessCategoriesApply
-- ----------------------------
DROP TABLE IF EXISTS `Himall_BusinessCategoriesApply`;
CREATE TABLE `Himall_BusinessCategoriesApply` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ApplyDate` datetime NOT NULL COMMENT '申请日期',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  ` AuditedStatus` int(11) NOT NULL COMMENT '审核状态',
  `AuditedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_BusinessCategoriesApplyDetail
-- ----------------------------
DROP TABLE IF EXISTS `Himall_BusinessCategoriesApplyDetail`;
CREATE TABLE `Himall_BusinessCategoriesApplyDetail` (
  `Id` bigint(11) NOT NULL AUTO_INCREMENT,
  `CommisRate` decimal(8,2) NOT NULL COMMENT '分佣比例',
  `CategoryId` bigint(20) NOT NULL COMMENT '类目ID',
  `ApplyId` bigint(20) NOT NULL COMMENT '申请Id',
  PRIMARY KEY (`Id`),
  KEY `FR_BussinessCateApply` (`ApplyId`),
  KEY `FR_BussinessCateApply_Cid` (`CategoryId`),
  CONSTRAINT `FR_BussinessCateApply` FOREIGN KEY (`ApplyId`) REFERENCES `Himall_BusinessCategoriesApply` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FR_BussinessCateApply_Cid` FOREIGN KEY (`CategoryId`) REFERENCES `Himall_Categories` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_Capital
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Capital`;
CREATE TABLE `Himall_Capital` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MemId` bigint(20) NOT NULL COMMENT '会员ID',
  `Balance` decimal(18,2) DEFAULT '0.00' COMMENT '可用余额',
  `FreezeAmount` decimal(18,2) DEFAULT '0.00' COMMENT '冻结资金',
  `ChargeAmount` decimal(18,2) DEFAULT '0.00' COMMENT '累计充值总金额',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CapitalDetail
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CapitalDetail`;
CREATE TABLE `Himall_CapitalDetail` (
  `Id` bigint(20) NOT NULL,
  `CapitalID` bigint(20) NOT NULL COMMENT '资产主表ID',
  `SourceType` int(11) NOT NULL COMMENT '资产类型',
  `Amount` decimal(18,2) NOT NULL COMMENT '金额',
  `SourceData` varchar(100) DEFAULT NULL COMMENT '来源数据',
  `CreateTime` datetime DEFAULT NULL COMMENT '交易时间',
  `Remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`Id`),
  KEY `FK_Reference_Himall_CapitalDetail` (`CapitalID`) USING BTREE,
  CONSTRAINT `FK_Reference_Himall_CapitalDetail` FOREIGN KEY (`CapitalID`) REFERENCES `Himall_Capital` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CashDeposit
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CashDeposit`;
CREATE TABLE `Himall_CashDeposit` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ShopId` bigint(20) NOT NULL COMMENT 'Shop表外键',
  `CurrentBalance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '可用金额',
  `TotalBalance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已缴纳金额',
  `Date` datetime NOT NULL COMMENT '最后一次缴纳时间',
  `EnableLabels` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示标志，只有保证金欠费该字段才有用，默认显示',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_CashDeposit_Himall_Shops` (`ShopId`) USING BTREE,
  CONSTRAINT `himall_cashdeposit_ibfk_1` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CashDepositDetail
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CashDepositDetail`;
CREATE TABLE `Himall_CashDepositDetail` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `CashDepositId` bigint(20) NOT NULL DEFAULT '0',
  `AddDate` datetime NOT NULL,
  `Balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Operator` varchar(50) NOT NULL COMMENT '操作类型',
  `Description` varchar(1000) DEFAULT NULL COMMENT '说明',
  `RechargeWay` int(11) DEFAULT NULL COMMENT '充值类型（银联、支付宝之类的）',
  PRIMARY KEY (`Id`),
  KEY `KF_Himall_CashDeposit_Himall_CashDepositDetail` (`CashDepositId`) USING BTREE,
  CONSTRAINT `himall_cashdepositdetail_ibfk_1` FOREIGN KEY (`CashDepositId`) REFERENCES `Himall_CashDeposit` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Categories
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Categories`;
CREATE TABLE `Himall_Categories` (
  `Id` bigint(20) NOT NULL,
  `Name` varchar(100) NOT NULL COMMENT '分类名称',
  `Icon` varchar(1000) DEFAULT NULL COMMENT '分类图标',
  `DisplaySequence` bigint(20) NOT NULL,
  `ParentCategoryId` bigint(20) NOT NULL,
  `Depth` int(11) NOT NULL COMMENT '分类的深度',
  `Path` varchar(100) NOT NULL COMMENT '分类的路径（以|分离）',
  `RewriteName` varchar(50) DEFAULT NULL COMMENT '未使用',
  `HasChildren` tinyint(1) NOT NULL COMMENT '是否有子分类',
  `TypeId` bigint(20) NOT NULL DEFAULT '0',
  `CommisRate` decimal(8,2) NOT NULL COMMENT '分佣比例',
  `Meta_Title` varchar(1000) DEFAULT NULL,
  `Meta_Description` varchar(1000) DEFAULT NULL,
  `Meta_Keywords` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Type_Category` (`TypeId`) USING BTREE,
  CONSTRAINT `himall_categories_ibfk_1` FOREIGN KEY (`TypeId`) REFERENCES `Himall_Types` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CategoryCashDeposit
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CategoryCashDeposit`;
CREATE TABLE `Himall_CategoryCashDeposit` (
  `Id` bigint(20) DEFAULT NULL COMMENT '主键Id',
  `CategoryId` bigint(20) NOT NULL COMMENT '分类Id',
  `NeedPayCashDeposit` decimal(10,2) DEFAULT '0.00' COMMENT '需要缴纳保证金',
  `EnableNoReasonReturn` tinyint(1) DEFAULT '0' COMMENT '允许七天无理由退货',
  PRIMARY KEY (`CategoryId`),
  KEY `FK_Himall_CategoriesObligation_Categories` (`CategoryId`) USING BTREE,
  CONSTRAINT `FK_Himall_CategoriesObligation_Categories` FOREIGN KEY (`CategoryId`) REFERENCES `Himall_Categories` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ChargeDetail
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ChargeDetail`;
CREATE TABLE `Himall_ChargeDetail` (
  `Id` bigint(20) NOT NULL,
  `MemId` bigint(20) NOT NULL COMMENT '会员ID',
  `ChargeTime` datetime DEFAULT NULL COMMENT '充值时间',
  `ChargeAmount` decimal(18,2) NOT NULL COMMENT '充值金额',
  `ChargeWay` varchar(50) DEFAULT NULL COMMENT '充值方式',
  `ChargeStatus` int(11) NOT NULL COMMENT '充值状态',
  `CreateTime` datetime DEFAULT NULL COMMENT '提交充值时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Collocation
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Collocation`;
CREATE TABLE `Himall_Collocation` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID自增',
  `Title` varchar(100) NOT NULL COMMENT '组合购标题',
  `StartTime` datetime NOT NULL COMMENT '开始日期',
  `EndTime` datetime NOT NULL COMMENT '结束日期',
  `ShortDesc` varchar(1000) DEFAULT NULL COMMENT '组合描述',
  `ShopId` bigint(20) NOT NULL COMMENT '组合购店铺ID',
  `CreateTime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CollocationPoruducts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CollocationPoruducts`;
CREATE TABLE `Himall_CollocationPoruducts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID自增',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `ColloId` bigint(20) NOT NULL COMMENT '组合购ID',
  `IsMain` tinyint(1) NOT NULL COMMENT '是否主商品',
  `DisplaySequence` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`Id`),
  KEY `FK_Collocation_CollPoruducts` (`ColloId`) USING BTREE,
  KEY `FK_Product_CollPoruducts` (`ProductId`) USING BTREE,
  CONSTRAINT `FK_Collocation_CollPoruducts` FOREIGN KEY (`ColloId`) REFERENCES `Himall_Collocation` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Product_CollPoruducts` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CollocationSkus
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CollocationSkus`;
CREATE TABLE `Himall_CollocationSkus` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID自增',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `SkuID` varchar(100) NOT NULL COMMENT '商品SkuId',
  `ColloProductId` bigint(20) NOT NULL COMMENT '组合商品表ID',
  `Price` decimal(18,2) NOT NULL COMMENT '组合购价格',
  `SkuPirce` decimal(18,2) DEFAULT NULL COMMENT '原始价格',
  PRIMARY KEY (`Id`),
  KEY `FK_Product_CollSkus` (`ProductId`) USING BTREE,
  KEY `FK_ColloPoruducts_CollSkus` (`ColloProductId`) USING BTREE,
  CONSTRAINT `FK_ColloProuducts_Skus` FOREIGN KEY (`ColloProductId`) REFERENCES `Himall_CollocationPoruducts` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Product_ColloSkus` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Coupon
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Coupon`;
CREATE TABLE `Himall_Coupon` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `ShopName` varchar(100) DEFAULT NULL COMMENT '店铺名称',
  `Price` decimal(18,0) NOT NULL COMMENT '价格',
  `PerMax` int(11) NOT NULL COMMENT '最大可领取张数',
  `OrderAmount` decimal(18,0) NOT NULL COMMENT '订单金额（满足多少钱才能使用）',
  `Num` int(11) NOT NULL COMMENT '发行张数',
  `StartTime` datetime NOT NULL COMMENT '开始时间',
  `EndTime` datetime NOT NULL,
  `CouponName` varchar(100) NOT NULL COMMENT '优惠券名称',
  `CreateTime` datetime NOT NULL,
  `ReceiveType` int(11) NOT NULL DEFAULT '0' COMMENT '领取方式 0 店铺首页 1 积分兑换 2 主动发放',
  `NeedIntegral` int(11) NOT NULL COMMENT '所需积分',
  `EndIntegralExchange` datetime DEFAULT NULL COMMENT '兑换截止时间',
  `IntegralCover` varchar(200) DEFAULT NULL COMMENT '积分商城封面',
  `IsSyncWeiXin` int(11) NOT NULL DEFAULT '0' COMMENT '是否同步到微信',
  `WXAuditStatus` int(11) NOT NULL DEFAULT '0' COMMENT '微信状态',
  `CardLogId` bigint(20) DEFAULT NULL COMMENT '微信卡券记录号 与微信卡券记录关联',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_Coupon_Himall_Shops` (`ShopId`) USING BTREE,
  CONSTRAINT `himall_coupon_ibfk_1` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CouponRecord
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CouponRecord`;
CREATE TABLE `Himall_CouponRecord` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `CouponId` bigint(20) NOT NULL,
  `CounponSN` varchar(50) NOT NULL COMMENT '优惠券的SN标示',
  `CounponTime` datetime NOT NULL,
  `UserName` varchar(100) NOT NULL COMMENT '用户名称',
  `UserId` bigint(20) NOT NULL,
  `UsedTime` datetime DEFAULT NULL,
  `OrderId` bigint(20) DEFAULT NULL COMMENT '使用的订单ID',
  `ShopId` bigint(20) NOT NULL,
  `ShopName` varchar(100) NOT NULL,
  `CounponStatus` int(11) NOT NULL COMMENT '优惠券状态',
  `WXCodeId` bigint(20) DEFAULT NULL COMMENT '微信Code记录号 与微信卡券投放记录关联',
  PRIMARY KEY (`Id`),
  KEY `fk_couponrecord_couponid` (`CouponId`) USING BTREE,
  KEY `FK_couponrecord_shopid` (`ShopId`) USING BTREE,
  CONSTRAINT `himall_couponrecord_ibfk_1` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`),
  CONSTRAINT `himall_couponrecord_ibfk_2` FOREIGN KEY (`CouponId`) REFERENCES `Himall_Coupon` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CouponSetting
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CouponSetting`;
CREATE TABLE `Himall_CouponSetting` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PlatForm` int(11) NOT NULL COMMENT '优惠券的发行平台',
  `CouponID` bigint(20) NOT NULL,
  `Display` int(11) DEFAULT NULL COMMENT '是否显示',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_CustomerServices
-- ----------------------------
DROP TABLE IF EXISTS `Himall_CustomerServices`;
CREATE TABLE `Himall_CustomerServices` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `Tool` int(11) NOT NULL COMMENT '工具类型（QQ、旺旺）',
  `Type` int(11) NOT NULL,
  `Name` varchar(1000) NOT NULL COMMENT '客服名称',
  `AccountCode` varchar(1000) NOT NULL COMMENT '通信账号',
  `TerminalType` int(11) NOT NULL DEFAULT '0' COMMENT '终端类型',
  `ServerStatus` int(11) NOT NULL DEFAULT '1' COMMENT '客服状态',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_DistributionShareSetting
-- ----------------------------
DROP TABLE IF EXISTS `Himall_DistributionShareSetting`;
CREATE TABLE `Himall_DistributionShareSetting` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProShareLogo` varchar(150) DEFAULT NULL,
  `ShopShareLogo` varchar(150) DEFAULT NULL,
  `ProShareTitle` varchar(200) DEFAULT NULL,
  `ShopShareTitle` varchar(200) DEFAULT NULL,
  `ProShareDesc` varchar(2000) DEFAULT NULL,
  `ShopShareDesc` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_DistributionUserLink
-- ----------------------------
DROP TABLE IF EXISTS `Himall_DistributionUserLink`;
CREATE TABLE `Himall_DistributionUserLink` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `PartnerId` bigint(20) NOT NULL COMMENT '销售员',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺',
  `LinkTime` datetime DEFAULT NULL,
  `BuyUserId` bigint(20) NOT NULL DEFAULT '0' COMMENT '买家',
  PRIMARY KEY (`Id`),
  KEY `himall_DistributionUserLink_FK_User` (`PartnerId`),
  CONSTRAINT `himall_DistributionUserLink_FK_User` FOREIGN KEY (`PartnerId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分销用户与店铺关联表';

-- ----------------------------
-- Table structure for Himall_DistributorSetting
-- ----------------------------
DROP TABLE IF EXISTS `Himall_DistributorSetting`;
CREATE TABLE `Himall_DistributorSetting` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Enable` tinyint(1) NOT NULL COMMENT '模块开关',
  `SellerRule` varchar(2000) DEFAULT NULL COMMENT '商家规则',
  `PromoterRule` varchar(2000) DEFAULT NULL COMMENT '推广员规则',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Favorites
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Favorites`;
CREATE TABLE `Himall_Favorites` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `ProductId` bigint(20) NOT NULL,
  `Tags` varchar(100) DEFAULT NULL COMMENT '分类标签',
  `Date` datetime NOT NULL COMMENT '收藏日期',
  PRIMARY KEY (`Id`),
  KEY `FK_Member_Favorite` (`UserId`) USING BTREE,
  KEY `FK_Product_Favorite` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_favorites_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_favorites_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FavoriteShops
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FavoriteShops`;
CREATE TABLE `Himall_FavoriteShops` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `ShopId` bigint(20) NOT NULL,
  `Tags` varchar(100) DEFAULT NULL COMMENT '分类标签',
  `Date` datetime NOT NULL COMMENT '收藏日期',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FlashSale
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FlashSale`;
CREATE TABLE `Himall_FlashSale` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Title` varchar(30) NOT NULL,
  `ShopId` bigint(20) NOT NULL,
  `ProductId` bigint(20) NOT NULL,
  `Status` int(11) NOT NULL COMMENT '待审核,进行中,已结束,审核未通过,管理员取消',
  `BeginDate` datetime NOT NULL COMMENT '活动开始日期',
  `EndDate` datetime NOT NULL COMMENT '活动结束日期',
  `LimitCountOfThePeople` int(11) NOT NULL COMMENT '限制每人购买的数量',
  `SaleCount` int(11) NOT NULL COMMENT '仅仅只计算在限时购里的销售数',
  `CategoryName` varchar(255) NOT NULL,
  `ImagePath` varchar(255) NOT NULL,
  `MinPrice` decimal(18,2) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_FSShopId3` (`ShopId`),
  KEY `FK_FSProductId3` (`ProductId`),
  CONSTRAINT `FK_FSProductId` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`),
  CONSTRAINT `FK_FSProductId3` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`),
  CONSTRAINT `FK_FSShopId` FOREIGN KEY (`ShopId`) REFERENCES `himall_shops` (`Id`),
  CONSTRAINT `FK_FSShopId3` FOREIGN KEY (`ShopId`) REFERENCES `himall_shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_FlashSaleConfig
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FlashSaleConfig`;
CREATE TABLE `Himall_FlashSaleConfig` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Preheat` int(11) NOT NULL COMMENT '预热时间',
  `IsNormalPurchase` tinyint(1) NOT NULL COMMENT '是否允许正常购买',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_FlashSaleDetail
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FlashSaleDetail`;
CREATE TABLE `Himall_FlashSaleDetail` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProductId` bigint(20) NOT NULL,
  `SkuId` varchar(100) NOT NULL,
  `Price` decimal(18,2) DEFAULT NULL COMMENT '限时购时金额',
  `FlashSaleId` bigint(20) NOT NULL COMMENT '对应FlashSale表主键',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_FlashSaleRemind
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FlashSaleRemind`;
CREATE TABLE `Himall_FlashSaleRemind` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OpenId` varchar(200) NOT NULL,
  `RecordDate` datetime NOT NULL,
  `FlashSaleId` bigint(20) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_FloorBrands
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FloorBrands`;
CREATE TABLE `Himall_FloorBrands` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `FloorId` bigint(20) NOT NULL COMMENT '楼层ID',
  `BrandId` bigint(20) NOT NULL COMMENT '品牌ID',
  PRIMARY KEY (`Id`),
  KEY `FK_Brand_FloorBrand` (`BrandId`) USING BTREE,
  KEY `FK_HomeFloor_FloorBrand` (`FloorId`) USING BTREE,
  CONSTRAINT `himall_floorbrands_ibfk_1` FOREIGN KEY (`BrandId`) REFERENCES `Himall_Brands` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_floorbrands_ibfk_2` FOREIGN KEY (`FloorId`) REFERENCES `Himall_HomeFloors` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FloorCategories
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FloorCategories`;
CREATE TABLE `Himall_FloorCategories` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `FloorId` bigint(20) NOT NULL,
  `CategoryId` bigint(20) NOT NULL,
  `Depth` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Category_FloorCategory` (`CategoryId`) USING BTREE,
  KEY `FK_HomeFloor_FloorCategory` (`FloorId`) USING BTREE,
  CONSTRAINT `himall_floorcategories_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `Himall_Categories` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_floorcategories_ibfk_2` FOREIGN KEY (`FloorId`) REFERENCES `Himall_HomeFloors` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FloorProducts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FloorProducts`;
CREATE TABLE `Himall_FloorProducts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `FloorId` bigint(20) NOT NULL COMMENT '楼层ID',
  `Tab` int(11) NOT NULL COMMENT '楼层标签',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  PRIMARY KEY (`Id`),
  KEY `FK_HomeFloor_FloorProduct` (`FloorId`) USING BTREE,
  KEY `FK_Product_FloorProduct` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_floorproducts_ibfk_1` FOREIGN KEY (`FloorId`) REFERENCES `Himall_HomeFloors` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_floorproducts_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FloorTablDetails
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FloorTablDetails`;
CREATE TABLE `Himall_FloorTablDetails` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `TabId` bigint(20) NOT NULL COMMENT 'TabID',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  PRIMARY KEY (`Id`),
  KEY `TabIdFK` (`TabId`) USING BTREE,
  KEY `ProductIdFK` (`ProductId`) USING BTREE,
  CONSTRAINT `TabIdFK` FOREIGN KEY (`TabId`) REFERENCES `Himall_FloorTabls` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FloorTabls
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FloorTabls`;
CREATE TABLE `Himall_FloorTabls` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `FloorId` bigint(20) NOT NULL COMMENT '楼层ID',
  `Name` varchar(50) NOT NULL COMMENT '楼层名称',
  PRIMARY KEY (`Id`),
  KEY `Id` (`Id`) USING BTREE,
  KEY `FloorIdFK` (`FloorId`) USING BTREE,
  CONSTRAINT `FloorIdFK` FOREIGN KEY (`FloorId`) REFERENCES `Himall_HomeFloors` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FloorTopics
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FloorTopics`;
CREATE TABLE `Himall_FloorTopics` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `FloorId` bigint(20) NOT NULL COMMENT '楼层ID',
  `TopicType` int(11) NOT NULL COMMENT '专题类型',
  `TopicImage` varchar(100) NOT NULL COMMENT '专题封面图片',
  `TopicName` varchar(100) NOT NULL COMMENT '专题名称',
  `Url` varchar(1000) NOT NULL COMMENT '专题跳转URL',
  PRIMARY KEY (`Id`),
  KEY `FK_HomeFloor_FloorTopic` (`FloorId`) USING BTREE,
  CONSTRAINT `himall_floortopics_ibfk_1` FOREIGN KEY (`FloorId`) REFERENCES `Himall_HomeFloors` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3566 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FreightAreaContent
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FreightAreaContent`;
CREATE TABLE `Himall_FreightAreaContent` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `FreightTemplateId` bigint(20) NOT NULL COMMENT '运费模板ID',
  `AreaContent` varchar(4000) DEFAULT NULL COMMENT '地区选择',
  `FirstUnit` int(11) DEFAULT NULL COMMENT '首笔单元计量',
  `FirstUnitMonry` float DEFAULT NULL COMMENT '首笔单元费用',
  `AccumulationUnit` int(11) DEFAULT NULL COMMENT '递增单元计量',
  `AccumulationUnitMoney` float DEFAULT NULL COMMENT '递增单元费用',
  `IsDefault` tinyint(4) DEFAULT NULL COMMENT '是否为默认',
  PRIMARY KEY (`Id`),
  KEY `FK_Freighttemalate_FreightAreaContent` (`FreightTemplateId`) USING BTREE,
  CONSTRAINT `himall_freightareacontent_ibfk_1` FOREIGN KEY (`FreightTemplateId`) REFERENCES `Himall_FreightTemplate` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_FreightTemplate
-- ----------------------------
DROP TABLE IF EXISTS `Himall_FreightTemplate`;
CREATE TABLE `Himall_FreightTemplate` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL COMMENT '运费模板名称',
  `SourceAddress` int(11) DEFAULT NULL COMMENT '宝贝发货地',
  `SendTime` varchar(100) DEFAULT NULL COMMENT '发送时间',
  `IsFree` int(11) NOT NULL COMMENT '是否商家负责运费',
  `ValuationMethod` int(11) NOT NULL COMMENT '定价方法(按体积、重量计算）',
  `ShippingMethod` int(11) DEFAULT NULL COMMENT '运送类型（物流、快递）',
  `ShopID` bigint(20) NOT NULL COMMENT '店铺ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_GiftOrderItem
-- ----------------------------
DROP TABLE IF EXISTS `Himall_GiftOrderItem`;
CREATE TABLE `Himall_GiftOrderItem` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `OrderId` bigint(20) DEFAULT NULL COMMENT '订单编号',
  `GiftId` bigint(20) NOT NULL COMMENT '礼品编号',
  `Quantity` int(11) NOT NULL COMMENT '数量',
  `SaleIntegral` int(11) DEFAULT NULL COMMENT '积分单价',
  `GiftName` varchar(100) DEFAULT NULL COMMENT '礼品名称',
  `GiftValue` decimal(8,3) DEFAULT NULL COMMENT '礼品价值',
  `ImagePath` varchar(100) DEFAULT NULL COMMENT '图片存放地址',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_Gitem_OrderId` (`OrderId`) USING BTREE,
  CONSTRAINT `FK_Himall_Gitem_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `Himall_GiftsOrder` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Gifts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Gifts`;
CREATE TABLE `Himall_Gifts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `GiftName` varchar(100) NOT NULL COMMENT '名称',
  `NeedIntegral` int(11) NOT NULL COMMENT '需要积分',
  `LimtQuantity` int(11) NOT NULL COMMENT '限制兑换数量 0表示不限兑换数量',
  `StockQuantity` int(11) NOT NULL COMMENT '库存数量',
  `EndDate` datetime NOT NULL COMMENT '兑换结束时间',
  `NeedGrade` int(11) NOT NULL DEFAULT '0' COMMENT '等级要求 0表示不限定',
  `VirtualSales` int(11) NOT NULL DEFAULT '0' COMMENT '虚拟销量',
  `RealSales` int(11) NOT NULL DEFAULT '0' COMMENT '实际销量',
  `SalesStatus` int(11) NOT NULL COMMENT '状态',
  `ImagePath` varchar(100) DEFAULT NULL COMMENT '图片存放地址',
  `Sequence` int(11) NOT NULL DEFAULT '100' COMMENT '顺序 默认100 数字越小越靠前',
  `GiftValue` decimal(8,2) DEFAULT NULL COMMENT '礼品价值',
  `Description` longtext COMMENT '描述',
  `AddDate` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_GiftsOrder
-- ----------------------------
DROP TABLE IF EXISTS `Himall_GiftsOrder`;
CREATE TABLE `Himall_GiftsOrder` (
  `Id` bigint(20) NOT NULL COMMENT '编号',
  `OrderStatus` int(11) NOT NULL COMMENT '订单状态',
  `UserId` bigint(20) NOT NULL COMMENT '用户编号',
  `UserRemark` varchar(200) DEFAULT NULL COMMENT '会员留言',
  `ShipTo` varchar(100) DEFAULT NULL COMMENT '收货人',
  `CellPhone` varchar(100) DEFAULT NULL COMMENT '收货人电话',
  `TopRegionId` int(11) DEFAULT NULL COMMENT '一级地区',
  `RegionId` int(11) DEFAULT NULL COMMENT '地区编号',
  `RegionFullName` varchar(100) DEFAULT NULL COMMENT '地区全称',
  `Address` varchar(100) DEFAULT NULL COMMENT '地址',
  `ExpressCompanyName` varchar(4000) DEFAULT NULL COMMENT '快递公司',
  `ShipOrderNumber` varchar(4000) DEFAULT NULL COMMENT '快递单号',
  `ShippingDate` datetime DEFAULT NULL COMMENT '发货时间',
  `OrderDate` datetime NOT NULL COMMENT '下单时间',
  `FinishDate` datetime DEFAULT NULL COMMENT '完成时间',
  `TotalIntegral` int(11) DEFAULT NULL COMMENT '积分总价',
  `CloseReason` varchar(200) DEFAULT NULL COMMENT '关闭原因',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_HandSlideAds
-- ----------------------------
DROP TABLE IF EXISTS `Himall_HandSlideAds`;
CREATE TABLE `Himall_HandSlideAds` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ImageUrl` varchar(100) NOT NULL COMMENT '图片URL',
  `Url` varchar(1000) NOT NULL COMMENT '图片跳转URL',
  `DisplaySequence` bigint(20) NOT NULL COMMENT '排序',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_HomeCategories
-- ----------------------------
DROP TABLE IF EXISTS `Himall_HomeCategories`;
CREATE TABLE `Himall_HomeCategories` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `RowId` int(11) NOT NULL COMMENT '分类所属行数',
  `CategoryId` bigint(20) NOT NULL COMMENT '分类ID',
  `Depth` int(11) NOT NULL COMMENT '分类深度(最深3）',
  PRIMARY KEY (`Id`),
  KEY `FK_Category_HomeCategory` (`CategoryId`) USING BTREE,
  CONSTRAINT `himall_homecategories_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `Himall_Categories` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2527 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_HomeCategoryRows
-- ----------------------------
DROP TABLE IF EXISTS `Himall_HomeCategoryRows`;
CREATE TABLE `Himall_HomeCategoryRows` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `RowId` int(11) NOT NULL COMMENT '行ID',
  `Image1` varchar(100) NOT NULL COMMENT '所属行推荐图片1',
  `Url1` varchar(100) NOT NULL COMMENT '所属行推荐图片1的URL',
  `Image2` varchar(100) NOT NULL COMMENT '所属行推荐图片2',
  `Url2` varchar(100) NOT NULL COMMENT '所属行推荐图片2的URL',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_HomeFloors
-- ----------------------------
DROP TABLE IF EXISTS `Himall_HomeFloors`;
CREATE TABLE `Himall_HomeFloors` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `FloorName` varchar(100) NOT NULL COMMENT '楼层名称',
  `SubName` varchar(100) DEFAULT NULL COMMENT '楼层小标题',
  `DisplaySequence` bigint(20) NOT NULL COMMENT '显示顺序',
  `IsShow` tinyint(1) NOT NULL COMMENT '是否显示的首页',
  `StyleLevel` int(10) unsigned NOT NULL COMMENT '楼层所属样式（目前支持2套）',
  `DefaultTabName` varchar(50) DEFAULT NULL COMMENT '楼层的默认tab标题',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ImageAds
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ImageAds`;
CREATE TABLE `Himall_ImageAds` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `ImageUrl` varchar(100) NOT NULL COMMENT '图片的存放URL',
  `Url` varchar(1000) NOT NULL COMMENT '图片的调整地址',
  `IsTransverseAD` tinyint(1) NOT NULL COMMENT '是否是横向长广告',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1115 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_InviteRecord
-- ----------------------------
DROP TABLE IF EXISTS `Himall_InviteRecord`;
CREATE TABLE `Himall_InviteRecord` (
  `Id` bigint(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(100) NOT NULL COMMENT '用户名',
  `RegName` varchar(100) NOT NULL COMMENT '邀请的用户',
  `InviteIntegral` int(11) NOT NULL COMMENT '邀请获得的积分',
  `RegIntegral` int(11) DEFAULT NULL COMMENT '被邀请获得的积分',
  `RegTime` datetime DEFAULT NULL COMMENT '注册时间',
  `UserId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `RegUserId` bigint(20) DEFAULT NULL COMMENT '被邀请的用户ID',
  `RecordTime` datetime DEFAULT NULL COMMENT '获得积分时间',
  PRIMARY KEY (`Id`),
  KEY `InviteMember` (`UserId`) USING BTREE,
  KEY `RegMember` (`RegUserId`) USING BTREE,
  CONSTRAINT `InviteMember` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `RegMember` FOREIGN KEY (`RegUserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_InviteRule
-- ----------------------------
DROP TABLE IF EXISTS `Himall_InviteRule`;
CREATE TABLE `Himall_InviteRule` (
  `Id` bigint(11) NOT NULL AUTO_INCREMENT,
  `InviteIntegral` int(11) DEFAULT NULL COMMENT '邀请能获得的积分',
  `RegIntegral` int(11) DEFAULT NULL COMMENT '被邀请能获得的积分',
  `ShareTitle` varchar(100) DEFAULT NULL COMMENT '分享标题',
  `ShareDesc` varchar(1000) DEFAULT NULL COMMENT '分享详细',
  `ShareIcon` varchar(200) DEFAULT NULL COMMENT '分享图标',
  `ShareRule` varchar(1000) DEFAULT NULL COMMENT '分享规则',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_InvoiceContext
-- ----------------------------
DROP TABLE IF EXISTS `Himall_InvoiceContext`;
CREATE TABLE `Himall_InvoiceContext` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL COMMENT '发票名称',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_InvoiceTitle
-- ----------------------------
DROP TABLE IF EXISTS `Himall_InvoiceTitle`;
CREATE TABLE `Himall_InvoiceTitle` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `Name` varchar(200) DEFAULT NULL COMMENT '抬头名称',
  `IsDefault` tinyint(4) NOT NULL COMMENT '是否默认',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Label
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Label`;
CREATE TABLE `Himall_Label` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `LabelName` varchar(50) NOT NULL COMMENT '标签名称',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_LimitTimeMarket
-- ----------------------------
DROP TABLE IF EXISTS `Himall_LimitTimeMarket`;
CREATE TABLE `Himall_LimitTimeMarket` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) NOT NULL COMMENT '标题',
  `ProductId` bigint(20) NOT NULL,
  `ProductName` varchar(100) NOT NULL COMMENT '商品名称',
  `CategoryName` varchar(100) NOT NULL COMMENT '分类名称',
  `AuditStatus` smallint(6) NOT NULL COMMENT '审核状态',
  `AuditTime` datetime NOT NULL COMMENT '审核时间',
  `ShopId` bigint(20) NOT NULL,
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  `Price` decimal(18,2) NOT NULL COMMENT '价格',
  `RecentMonthPrice` decimal(18,2) NOT NULL COMMENT '最近一个月的价格',
  `StartTime` datetime NOT NULL COMMENT '开始日期',
  `EndTime` datetime NOT NULL COMMENT '结束日期',
  `Stock` int(11) NOT NULL COMMENT '库存',
  `SaleCount` int(11) NOT NULL COMMENT '销售数量',
  `CancelReson` text NOT NULL COMMENT '取消原因',
  `MaxSaleCount` int(11) NOT NULL COMMENT '限量购买',
  `ProductAd` varchar(100) NOT NULL COMMENT '商品广告',
  `MinPrice` decimal(18,2) NOT NULL COMMENT '最小价格',
  `ImagePath` varchar(100) NOT NULL COMMENT '图片Path',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Logs
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Logs`;
CREATE TABLE `Himall_Logs` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `PageUrl` varchar(1000) NOT NULL,
  `Date` datetime NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `IPAddress` varchar(100) NOT NULL,
  `Description` varchar(1000) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3500 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Managers
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Managers`;
CREATE TABLE `Himall_Managers` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `RoleId` bigint(20) NOT NULL COMMENT '角色ID',
  `UserName` varchar(100) NOT NULL COMMENT '用户名称',
  `Password` varchar(100) NOT NULL COMMENT '密码',
  `PasswordSalt` varchar(100) NOT NULL COMMENT '密码加盐',
  `CreateDate` datetime NOT NULL COMMENT '创建日期',
  `Remark` varchar(1000) DEFAULT NULL,
  `RealName` varchar(1000) DEFAULT NULL COMMENT '真实名称',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MarketServiceRecord
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MarketServiceRecord`;
CREATE TABLE `Himall_MarketServiceRecord` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MarketServiceId` bigint(20) NOT NULL,
  `StartTime` datetime NOT NULL COMMENT '开始时间',
  `EndTime` datetime NOT NULL COMMENT '结束时间',
  `SettlementFlag` int(16) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_MarketServiceRecord_Himall_ActiveMarketService` (`MarketServiceId`) USING BTREE,
  CONSTRAINT `himall_marketservicerecord_ibfk_1` FOREIGN KEY (`MarketServiceId`) REFERENCES `Himall_ActiveMarketService` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MarketSetting
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MarketSetting`;
CREATE TABLE `Himall_MarketSetting` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TypeId` int(11) NOT NULL COMMENT '营销类型ID',
  `Price` decimal(18,2) NOT NULL COMMENT '营销使用价格（/月）',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MarketSettingMeta
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MarketSettingMeta`;
CREATE TABLE `Himall_MarketSettingMeta` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MarketId` int(11) NOT NULL,
  `MetaKey` varchar(100) NOT NULL,
  `MetaValue` text,
  PRIMARY KEY (`Id`),
  KEY `FK_Hiamll_MarketSettingMeta_ToSetting` (`MarketId`) USING BTREE,
  CONSTRAINT `himall_marketsettingmeta_ibfk_1` FOREIGN KEY (`MarketId`) REFERENCES `Himall_MarketSetting` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberContacts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberContacts`;
CREATE TABLE `Himall_MemberContacts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `UserType` int(11) NOT NULL COMMENT '用户类型(0 Email  1 SMS)',
  `ServiceProvider` varchar(100) NOT NULL COMMENT '插件名称',
  `Contact` varchar(100) NOT NULL COMMENT '联系号码',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberGrade
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberGrade`;
CREATE TABLE `Himall_MemberGrade` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `GradeName` varchar(100) NOT NULL COMMENT '会员等级名称',
  `Integral` int(11) NOT NULL COMMENT '该等级所需积分',
  `Remark` varchar(1000) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberIntegral
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberIntegral`;
CREATE TABLE `Himall_MemberIntegral` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MemberId` bigint(20) DEFAULT NULL COMMENT '会员ID',
  `UserName` varchar(100) NOT NULL COMMENT '用户名称',
  `HistoryIntegrals` int(11) NOT NULL COMMENT '用户历史积分',
  `AvailableIntegrals` int(11) NOT NULL COMMENT '用户可用积分',
  PRIMARY KEY (`Id`),
  KEY `FK_Member_MemberIntegral` (`MemberId`) USING BTREE,
  CONSTRAINT `himall_memberintegral_ibfk_1` FOREIGN KEY (`MemberId`) REFERENCES `Himall_Members` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberIntegralExchangeRules
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberIntegralExchangeRules`;
CREATE TABLE `Himall_MemberIntegralExchangeRules` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `IntegralPerMoney` int(11) NOT NULL COMMENT '一块钱对应多少积分',
  `MoneyPerIntegral` int(11) NOT NULL COMMENT '一个积分对应多少钱',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberIntegralRecord
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberIntegralRecord`;
CREATE TABLE `Himall_MemberIntegralRecord` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MemberId` bigint(20) NOT NULL,
  `UserName` varchar(100) NOT NULL COMMENT '用户名称',
  `TypeId` int(11) NOT NULL COMMENT '兑换类型（登录、下单等）',
  `Integral` int(11) NOT NULL COMMENT '积分数量',
  `RecordDate` datetime DEFAULT NULL COMMENT '记录日期',
  `ReMark` varchar(100) DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`Id`),
  KEY `fk_MemberId_Members` (`MemberId`) USING BTREE,
  CONSTRAINT `himall_memberintegralrecord_ibfk_1` FOREIGN KEY (`MemberId`) REFERENCES `Himall_Members` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=723 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberIntegralRecordAction
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberIntegralRecordAction`;
CREATE TABLE `Himall_MemberIntegralRecordAction` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `IntegralRecordId` bigint(20) NOT NULL COMMENT '积分兑换ID',
  `VirtualItemTypeId` int(11) DEFAULT NULL COMMENT '兑换虚拟物l类型ID',
  `VirtualItemId` bigint(20) NOT NULL COMMENT '虚拟物ID',
  PRIMARY KEY (`Id`),
  KEY `fk_IntegralRecordId_MemberIntegralRecord` (`IntegralRecordId`) USING BTREE,
  CONSTRAINT `himall_memberintegralrecordaction_ibfk_1` FOREIGN KEY (`IntegralRecordId`) REFERENCES `Himall_MemberIntegralRecord` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberIntegralRule
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberIntegralRule`;
CREATE TABLE `Himall_MemberIntegralRule` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `TypeId` int(11) NOT NULL COMMENT '积分规则类型ID',
  `Integral` int(11) NOT NULL COMMENT '规则对应的积分数量',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberLabel
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberLabel`;
CREATE TABLE `Himall_MemberLabel` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `MemId` bigint(20) NOT NULL COMMENT '会员ID',
  `LabelId` bigint(20) NOT NULL COMMENT '标签Id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_MemberOpenIds
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberOpenIds`;
CREATE TABLE `Himall_MemberOpenIds` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `OpenId` varchar(100) DEFAULT NULL COMMENT '微信OpenID',
  `UnionOpenId` varchar(100) DEFAULT NULL COMMENT '开发平台Openid',
  `UnionId` varchar(100) DEFAULT NULL COMMENT '开发平台Unionid',
  `ServiceProvider` varchar(100) NOT NULL COMMENT '插件名称（Himall.Plugin.OAuth.WeiXin）',
  `AppIdType` int(255) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Member_MemberOpenId` (`UserId`) USING BTREE,
  CONSTRAINT `himall_memberopenids_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Members
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Members`;
CREATE TABLE `Himall_Members` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(100) NOT NULL COMMENT '名称',
  `Password` varchar(100) NOT NULL COMMENT '密码',
  `PasswordSalt` varchar(100) NOT NULL COMMENT '密码加盐',
  `Nick` varchar(50) DEFAULT NULL COMMENT '昵称',
  `Sex` int(11) DEFAULT NULL COMMENT '性别',
  `Email` varchar(100) DEFAULT NULL COMMENT '邮件',
  `CreateDate` datetime NOT NULL COMMENT '创建日期',
  `TopRegionId` int(11) NOT NULL COMMENT '省份ID',
  `RegionId` int(11) NOT NULL COMMENT '省市区ID',
  `RealName` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `CellPhone` varchar(100) DEFAULT NULL COMMENT '电话',
  `QQ` varchar(100) DEFAULT NULL COMMENT 'QQ',
  `Address` varchar(100) DEFAULT NULL COMMENT '街道地址',
  `Disabled` tinyint(1) NOT NULL COMMENT '是否禁用',
  `LastLoginDate` datetime NOT NULL COMMENT '最后登录日期',
  `OrderNumber` int(11) NOT NULL COMMENT '下单次数',
  `Expenditure` decimal(18,2) NOT NULL COMMENT '未使用',
  `Points` int(11) NOT NULL,
  `Photo` varchar(100) DEFAULT NULL COMMENT '头像',
  `ParentSellerId` bigint(20) NOT NULL DEFAULT '0' COMMENT '商家父账号ID',
  `Remark` varchar(1000) DEFAULT NULL,
  `PayPwd` varchar(100) DEFAULT NULL COMMENT '支付密码',
  `PayPwdSalt` varchar(100) DEFAULT NULL COMMENT '支付密码加密字符',
  `InviteUserId` bigint(20) DEFAULT NULL,
  `ShareUserId` bigint(20) DEFAULT NULL COMMENT '分销员Id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MemberSignIn
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MemberSignIn`;
CREATE TABLE `Himall_MemberSignIn` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `LastSignTime` datetime DEFAULT NULL COMMENT '最近签到时间',
  `DurationDay` int(11) NOT NULL DEFAULT '0' COMMENT '持续签到天数 每周期后清零',
  `DurationDaySum` int(11) NOT NULL DEFAULT '0' COMMENT '持续签到天数总数 非连续周期清零',
  `SignDaySum` bigint(20) NOT NULL DEFAULT '0' COMMENT '签到总天数',
  PRIMARY KEY (`Id`),
  KEY `IDX_Himall_MenIn_UserId` (`UserId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Menus
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Menus`;
CREATE TABLE `Himall_Menus` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ParentId` bigint(20) NOT NULL COMMENT '上级ID',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `Title` varchar(10) NOT NULL COMMENT '标题',
  `Url` varchar(200) DEFAULT NULL COMMENT '链接地址',
  `Depth` smallint(6) NOT NULL COMMENT '深度',
  `Sequence` smallint(6) NOT NULL,
  `FullIdPath` varchar(100) NOT NULL COMMENT '全路径',
  `Platform` int(11) NOT NULL COMMENT '终端',
  `UrlType` int(11) DEFAULT NULL COMMENT 'url类型',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MessageLog
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MessageLog`;
CREATE TABLE `Himall_MessageLog` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) DEFAULT NULL,
  `TypeId` varchar(100) DEFAULT NULL,
  `MessageContent` char(1) DEFAULT NULL,
  `SendTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MobileHomeProducts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MobileHomeProducts`;
CREATE TABLE `Himall_MobileHomeProducts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `PlatFormType` int(11) NOT NULL COMMENT '终端类型(微信、WAP）',
  `Sequence` smallint(6) NOT NULL COMMENT '顺序',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_MobileHomeProducts_Himall_Products` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_mobilehomeproducts_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_MobileHomeTopics
-- ----------------------------
DROP TABLE IF EXISTS `Himall_MobileHomeTopics`;
CREATE TABLE `Himall_MobileHomeTopics` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `Platform` int(11) NOT NULL COMMENT '终端',
  `TopicId` bigint(20) NOT NULL COMMENT '专题ID',
  `Sequence` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `FK__Himall_Mo__Topic__02C769E9` (`TopicId`) USING BTREE,
  CONSTRAINT `himall_mobilehometopics_ibfk_1` FOREIGN KEY (`TopicId`) REFERENCES `Himall_Topics` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ModuleProducts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ModuleProducts`;
CREATE TABLE `Himall_ModuleProducts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ModuleId` bigint(20) NOT NULL COMMENT '模块ID',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `DisplaySequence` bigint(20) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Product_ModuleProduct` (`ProductId`) USING BTREE,
  KEY `FK_TopicModule_ModuleProduct` (`ModuleId`) USING BTREE,
  CONSTRAINT `himall_moduleproducts_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_moduleproducts_ibfk_2` FOREIGN KEY (`ModuleId`) REFERENCES `Himall_TopicModules` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=383 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_OpenIds
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OpenIds`;
CREATE TABLE `Himall_OpenIds` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OpenId` varchar(100) NOT NULL,
  `SubscribeTime` date NOT NULL COMMENT '关注时间',
  `IsSubscribe` tinyint(1) NOT NULL COMMENT '是否关注',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_OrderComments
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OrderComments`;
CREATE TABLE `Himall_OrderComments` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderId` bigint(20) NOT NULL COMMENT '订单ID',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `UserName` varchar(100) NOT NULL COMMENT '用户名称',
  `CommentDate` datetime NOT NULL COMMENT '评价日期',
  `PackMark` int(11) NOT NULL COMMENT '包装评分',
  `DeliveryMark` int(11) NOT NULL COMMENT '物流评分',
  `ServiceMark` int(11) NOT NULL COMMENT '服务评分',
  PRIMARY KEY (`Id`),
  KEY `FK_Order_OrderComment` (`OrderId`) USING BTREE,
  CONSTRAINT `himall_ordercomments_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `Himall_Orders` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_OrderComplaints
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OrderComplaints`;
CREATE TABLE `Himall_OrderComplaints` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderId` bigint(20) NOT NULL COMMENT '订单ID',
  `Status` int(11) NOT NULL COMMENT '审核状态',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  `ShopPhone` varchar(100) NOT NULL COMMENT '店铺联系方式',
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `UserName` varchar(100) NOT NULL COMMENT '用户名称',
  `UserPhone` varchar(100) DEFAULT NULL COMMENT '用户联系方式',
  `ComplaintDate` datetime NOT NULL COMMENT '投诉日期',
  `ComplaintReason` varchar(1000) NOT NULL COMMENT '投诉原因',
  `SellerReply` varchar(1000) DEFAULT NULL COMMENT '商家反馈信息',
  PRIMARY KEY (`Id`),
  KEY `FK_Order_OrderComplaint` (`OrderId`) USING BTREE,
  CONSTRAINT `himall_ordercomplaints_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `Himall_Orders` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_OrderExpressData
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OrderExpressData`;
CREATE TABLE `Himall_OrderExpressData` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `CompanyCode` varchar(50) NOT NULL,
  `ExpressNumber` varchar(50) NOT NULL,
  `DataContent` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_OrderItems
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OrderItems`;
CREATE TABLE `Himall_OrderItems` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderId` bigint(20) NOT NULL COMMENT '订单ID',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `SkuId` varchar(100) DEFAULT NULL COMMENT 'SKUId',
  `SKU` varchar(20) DEFAULT NULL COMMENT '未使用',
  `Quantity` bigint(20) NOT NULL COMMENT '购买数量',
  `ReturnQuantity` bigint(20) NOT NULL COMMENT '退货数量',
  `CostPrice` decimal(18,2) NOT NULL COMMENT '成本价',
  `SalePrice` decimal(18,2) NOT NULL COMMENT '销售价',
  `DiscountAmount` decimal(18,2) NOT NULL COMMENT '优惠金额',
  `RealTotalPrice` decimal(18,2) NOT NULL COMMENT '实际应付金额',
  `RefundPrice` decimal(18,2) NOT NULL COMMENT '退款价格',
  `ProductName` varchar(100) NOT NULL COMMENT '商品名称',
  `Color` varchar(100) DEFAULT NULL COMMENT 'SKU颜色',
  `Size` varchar(100) DEFAULT NULL COMMENT 'SKU尺寸',
  `Version` varchar(100) DEFAULT NULL COMMENT 'SKU版本',
  `ThumbnailsUrl` varchar(100) DEFAULT NULL COMMENT '缩略图',
  `CommisRate` decimal(18,2) NOT NULL COMMENT '分佣比例',
  `EnabledRefundAmount` decimal(18,2) DEFAULT NULL COMMENT '可退金额',
  `IsLimitBuy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为限时购商品',
  `DistributionRate` decimal(6,2) DEFAULT NULL COMMENT '分销比例',
  `EnabledRefundIntegral` decimal(18,2) DEFAULT NULL COMMENT '可退积分抵扣金额',
  `CouponDiscount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '优惠券抵扣金额',
  PRIMARY KEY (`Id`),
  KEY `FK_Order_OrderItem` (`OrderId`) USING BTREE,
  CONSTRAINT `himall_orderitems_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `Himall_Orders` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23707 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_OrderOperationLogs
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OrderOperationLogs`;
CREATE TABLE `Himall_OrderOperationLogs` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderId` bigint(20) NOT NULL COMMENT '订单ID',
  `Operator` varchar(100) NOT NULL COMMENT '操作者',
  `OperateDate` datetime NOT NULL COMMENT '操作日期',
  `OperateContent` varchar(1000) DEFAULT NULL COMMENT '操作内容',
  PRIMARY KEY (`Id`),
  KEY `FK_Order_OrderOperationLog` (`OrderId`) USING BTREE,
  CONSTRAINT `himall_orderoperationlogs_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `Himall_Orders` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_OrderPay
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OrderPay`;
CREATE TABLE `Himall_OrderPay` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayId` bigint(20) NOT NULL,
  `OrderId` bigint(20) NOT NULL,
  `PayState` tinyint(1) unsigned zerofill NOT NULL COMMENT '支付状态',
  `PayTime` datetime DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=368 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for himall_orderrefundlogs
-- ----------------------------
DROP TABLE IF EXISTS `himall_orderrefundlogs`;
CREATE TABLE `himall_orderrefundlogs` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `RefundId` bigint(20) NOT NULL COMMENT '售后编号',
  `Operator` varchar(100) NOT NULL COMMENT '操作者',
  `OperateDate` datetime NOT NULL COMMENT '操作日期',
  `OperateContent` varchar(1000) DEFAULT NULL COMMENT '操作内容',
  `ApplyNumber` int(11) DEFAULT NULL COMMENT '申请次数',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COMMENT='订单售后日志表';

-- ----------------------------
-- Table structure for Himall_OrderRefunds
-- ----------------------------
DROP TABLE IF EXISTS `Himall_OrderRefunds`;
CREATE TABLE `Himall_OrderRefunds` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderId` bigint(20) NOT NULL COMMENT '订单ID',
  `OrderItemId` bigint(20) NOT NULL COMMENT '订单详情ID',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `Applicant` varchar(100) NOT NULL COMMENT '申请内容',
  `ContactPerson` varchar(100) DEFAULT NULL COMMENT '联系人',
  `ContactCellPhone` varchar(100) DEFAULT NULL COMMENT '联系电话',
  `RefundAccount` varchar(100) DEFAULT NULL COMMENT '退款金额',
  `ApplyDate` datetime NOT NULL COMMENT '申请时间',
  `Amount` decimal(18,2) NOT NULL COMMENT '金额',
  `Reason` varchar(1000) NOT NULL COMMENT '退款原因',
  `SellerAuditStatus` int(11) NOT NULL COMMENT '商家审核状态',
  `SellerAuditDate` datetime NOT NULL COMMENT '商家审核时间',
  `SellerRemark` varchar(1000) DEFAULT NULL COMMENT '商家注释',
  `ManagerConfirmStatus` int(11) NOT NULL COMMENT '平台审核状态',
  `ManagerConfirmDate` datetime NOT NULL COMMENT '平台审核时间',
  `ManagerRemark` varchar(1000) DEFAULT NULL COMMENT '平台注释',
  `IsReturn` tinyint(1) NOT NULL COMMENT '是否已经退款',
  `ExpressCompanyName` varchar(100) DEFAULT NULL COMMENT '快递公司',
  `ShipOrderNumber` varchar(100) DEFAULT NULL COMMENT '快递单号',
  `Payee` varchar(200) DEFAULT NULL COMMENT '收款人',
  `PayeeAccount` varchar(200) DEFAULT NULL COMMENT '收款人账户',
  `RefundMode` int(11) NOT NULL COMMENT '退款方式',
  `RefundPayStatus` int(11) DEFAULT NULL COMMENT '退款支付状态',
  `RefundPayType` int(11) DEFAULT NULL COMMENT '退款支付类型',
  `BuyerDeliverDate` datetime DEFAULT NULL COMMENT '买家发货时间',
  `SellerConfirmArrivalDate` datetime DEFAULT NULL COMMENT '卖家确认到货时间',
  `RefundBatchNo` varchar(30) DEFAULT NULL COMMENT '退款批次号',
  `RefundPostTime` datetime DEFAULT NULL COMMENT '退款异步提交时间',
  `ReturnQuantity` bigint(20) DEFAULT '0' COMMENT '退货数量',
  `ReturnBrokerage` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '退还分销佣金',
  `ApplyNumber` int(11) DEFAULT NULL COMMENT '申请次数',
  `CertPic1` varchar(200) DEFAULT NULL COMMENT '凭证图片1',
  `CertPic2` varchar(200) DEFAULT NULL COMMENT '凭证图片2',
  `CertPic3` varchar(200) DEFAULT NULL COMMENT '凭证图片3',
  PRIMARY KEY (`Id`),
  KEY `FK_OrderItem_OrderRefund` (`OrderItemId`) USING BTREE,
  CONSTRAINT `himall_orderrefunds_ibfk_1` FOREIGN KEY (`OrderItemId`) REFERENCES `Himall_OrderItems` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Orders
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Orders`;
CREATE TABLE `Himall_Orders` (
  `Id` bigint(20) NOT NULL,
  `OrderStatus` int(11) NOT NULL COMMENT '订单状态 [Description("待付款")]WaitPay = 1,[Description("待发货")]WaitDelivery,[Description("待收货")]WaitReceiving,[Description("已关闭")]Close,[Description("已完成")]Finish',
  `OrderDate` datetime NOT NULL COMMENT '订单创建日期',
  `CloseReason` varchar(1000) DEFAULT NULL COMMENT '关闭原因',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  `SellerPhone` varchar(100) DEFAULT NULL COMMENT '商家电话',
  `SellerAddress` varchar(100) DEFAULT NULL COMMENT '商家发货地址',
  `SellerRemark` varchar(1000) DEFAULT NULL COMMENT '商家说明',
  `UserId` bigint(20) NOT NULL COMMENT '会员ID',
  `UserName` varchar(100) NOT NULL COMMENT '会员名称',
  `UserRemark` varchar(1000) DEFAULT NULL COMMENT '会员留言',
  `ShipTo` varchar(100) NOT NULL COMMENT '收货人',
  `CellPhone` varchar(100) DEFAULT NULL COMMENT '收货人电话',
  `TopRegionId` int(11) NOT NULL COMMENT '收货人地址省份ID',
  `RegionId` int(11) NOT NULL COMMENT '收货人区域ID',
  `RegionFullName` varchar(100) NOT NULL COMMENT '全名的收货地址',
  `Address` varchar(100) NOT NULL COMMENT '收货具体街道信息',
  `ExpressCompanyName` varchar(100) DEFAULT NULL COMMENT '快递公司',
  `Freight` decimal(8,2) NOT NULL COMMENT '运费',
  `ShipOrderNumber` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '物流订单号',
  `ShippingDate` datetime DEFAULT NULL COMMENT '发货日期',
  `IsPrinted` tinyint(1) NOT NULL COMMENT '是否打印快递单',
  `PaymentTypeName` varchar(100) DEFAULT NULL COMMENT '付款类型名称',
  `PaymentTypeGateway` varchar(100) DEFAULT NULL COMMENT '付款类型使用 插件名称',
  `PaymentType` int(11) NOT NULL,
  `GatewayOrderId` varchar(100) DEFAULT NULL COMMENT '支付接口返回的ID',
  `PayRemark` varchar(1000) DEFAULT NULL COMMENT '付款注释',
  `PayDate` datetime DEFAULT NULL COMMENT '付款日期',
  `InvoiceType` int(11) NOT NULL COMMENT '发票类型',
  `InvoiceTitle` varchar(100) DEFAULT NULL COMMENT '发票抬头',
  `Tax` decimal(8,2) NOT NULL COMMENT '税钱，但是未使用',
  `FinishDate` datetime DEFAULT NULL COMMENT '完成订单日期',
  `ProductTotalAmount` decimal(18,2) NOT NULL COMMENT '商品总金额',
  `RefundTotalAmount` decimal(18,2) NOT NULL COMMENT '退款金额',
  `CommisTotalAmount` decimal(18,2) NOT NULL COMMENT '佣金总金额',
  `RefundCommisAmount` decimal(18,2) NOT NULL COMMENT '退还佣金总金额',
  `ActiveType` int(11) NOT NULL DEFAULT '0' COMMENT '未使用',
  `Platform` int(11) NOT NULL DEFAULT '0' COMMENT '来自哪个终端的订单',
  `DiscountAmount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '针对该订单的优惠金额（用于优惠券）',
  `IntegralDiscount` decimal(18,2) NOT NULL COMMENT '积分优惠金额',
  `InvoiceContext` varchar(50) DEFAULT NULL COMMENT '发票明细',
  `OrderType` int(11) DEFAULT NULL,
  `ShareUserId` bigint(20) DEFAULT NULL COMMENT '分销员Id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_PaymentConfig
-- ----------------------------
DROP TABLE IF EXISTS `Himall_PaymentConfig`;
CREATE TABLE `Himall_PaymentConfig` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `IsCashOnDelivery` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_PhotoSpace
-- ----------------------------
DROP TABLE IF EXISTS `Himall_PhotoSpace`;
CREATE TABLE `Himall_PhotoSpace` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `PhotoCategoryId` bigint(20) NOT NULL COMMENT '图片分组ID',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `PhotoName` varchar(2000) DEFAULT NULL COMMENT '图片名称',
  `PhotoPath` varchar(2000) DEFAULT NULL COMMENT '图片路径',
  `FileSize` bigint(20) DEFAULT NULL COMMENT '图片大小',
  `UploadTime` datetime DEFAULT NULL COMMENT '图片上传时间',
  `LastUpdateTime` datetime DEFAULT NULL COMMENT '图片最后更新时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_PhotoSpaceCategory
-- ----------------------------
DROP TABLE IF EXISTS `Himall_PhotoSpaceCategory`;
CREATE TABLE `Himall_PhotoSpaceCategory` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `PhotoSpaceCatrgoryName` varchar(255) DEFAULT NULL COMMENT '图片空间分类名称',
  `DisplaySequence` bigint(20) DEFAULT NULL COMMENT '显示顺序',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_ProductAttributes
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductAttributes`;
CREATE TABLE `Himall_ProductAttributes` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `AttributeId` bigint(20) NOT NULL COMMENT '属性ID',
  `ValueId` bigint(20) NOT NULL COMMENT '属性值ID',
  PRIMARY KEY (`Id`),
  KEY `FK_Attribute_ProductAttribute` (`AttributeId`) USING BTREE,
  KEY `FK_Product_ProductAttribute` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_productattributes_ibfk_1` FOREIGN KEY (`AttributeId`) REFERENCES `Himall_Attributes` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_productattributes_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6173 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ProductBrokerage
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductBrokerage`;
CREATE TABLE `Himall_ProductBrokerage` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ProductId` bigint(20) DEFAULT NULL COMMENT '商品Id',
  `rate` decimal(6,2) NOT NULL COMMENT '百分比',
  `ShopId` bigint(20) DEFAULT NULL COMMENT '店铺Id',
  `CreateTime` datetime DEFAULT NULL COMMENT '添加时间',
  `SaleNum` int(11) DEFAULT NULL COMMENT '成交数 *是卖出的数量，还是成交订单数，退货时是否需要维护',
  `AgentNum` int(11) DEFAULT NULL COMMENT '代理数 *清退的时候是否需要维护此字段',
  `ForwardNum` int(11) DEFAULT NULL COMMENT '转发数',
  `Status` int(11) NOT NULL COMMENT '状态 上架、下架、移除',
  `Sort` int(11) DEFAULT NULL COMMENT '排序',
  `saleAmount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '销售额',
  `BrokerageAmount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '商品已结佣金',
  `BrokerageTotal` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '商品佣金(包含已结未结)',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_ProductBrokerage_ProductId` (`ProductId`),
  KEY `FK_Himall_ProductBrokerage_ShopId` (`ShopId`),
  CONSTRAINT `FK_Himall_ProductBrokerage_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Himall_ProductBrokerage_ShopId` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ProductComments
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductComments`;
CREATE TABLE `Himall_ProductComments` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `SubOrderId` bigint(20) DEFAULT NULL COMMENT '订单详细ID',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ShopName` varchar(100) DEFAULT NULL COMMENT '店铺名称',
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `UserName` varchar(100) DEFAULT NULL COMMENT '用户名称',
  `Email` varchar(1000) DEFAULT NULL COMMENT 'Email',
  `ReviewContent` varchar(1000) DEFAULT NULL COMMENT '评价内容',
  `ReviewDate` datetime NOT NULL COMMENT '评价日期',
  `ReviewMark` int(11) NOT NULL COMMENT '评价说明',
  `ReplyContent` varchar(1000) DEFAULT NULL,
  `ReplyDate` datetime DEFAULT NULL,
  `AppendContent` varchar(1000) DEFAULT NULL COMMENT '追加内容',
  `AppendDate` datetime DEFAULT NULL COMMENT '追加时间',
  `ReplyAppendContent` varchar(1000) DEFAULT NULL COMMENT '追加评论回复',
  `ReplyAppendDate` datetime DEFAULT NULL COMMENT '追加评论回复时间',
  `IsHidden` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `FK_Product_ProductComment` (`ProductId`) USING BTREE,
  KEY `SubOrderId` (`SubOrderId`) USING BTREE,
  KEY `ShopId` (`ShopId`) USING BTREE,
  KEY `UserId` (`UserId`) USING BTREE,
  CONSTRAINT `himall_productcomments_ibfk_1` FOREIGN KEY (`SubOrderId`) REFERENCES `Himall_OrderItems` (`Id`),
  CONSTRAINT `himall_productcomments_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`),
  CONSTRAINT `himall_productcomments_ibfk_3` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`),
  CONSTRAINT `himall_productcomments_ibfk_4` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ProductCommentsImages
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductCommentsImages`;
CREATE TABLE `Himall_ProductCommentsImages` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增物理主键',
  `CommentImage` varchar(200) NOT NULL COMMENT '评论图片',
  `CommentId` bigint(20) NOT NULL COMMENT '评论ID',
  `CommentType` int(11) NOT NULL COMMENT '评论类型（首次评论/追加评论）',
  PRIMARY KEY (`Id`),
  KEY `FR_CommentImages` (`CommentId`),
  CONSTRAINT `FR_CommentImages` FOREIGN KEY (`CommentId`) REFERENCES `Himall_ProductComments` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_ProductConsultations
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductConsultations`;
CREATE TABLE `Himall_ProductConsultations` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProductId` bigint(20) NOT NULL,
  `ShopId` bigint(20) NOT NULL,
  `ShopName` varchar(100) DEFAULT NULL COMMENT '店铺名称',
  `UserId` bigint(20) NOT NULL,
  `UserName` varchar(100) DEFAULT NULL COMMENT '用户名称',
  `Email` varchar(1000) DEFAULT NULL,
  `ConsultationContent` varchar(1000) DEFAULT NULL COMMENT '咨询内容',
  `ConsultationDate` datetime NOT NULL COMMENT '咨询时间',
  `ReplyContent` varchar(1000) DEFAULT NULL COMMENT '回复内容',
  `ReplyDate` datetime DEFAULT NULL COMMENT '回复日期',
  PRIMARY KEY (`Id`),
  KEY `FK_Product_ProductConsultation` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_productconsultations_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ProductDescriptions
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductDescriptions`;
CREATE TABLE `Himall_ProductDescriptions` (
  `Id` bigint(20) DEFAULT NULL,
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `AuditReason` varchar(1000) DEFAULT NULL COMMENT '审核原因',
  `Description` text COMMENT '详情',
  `DescriptionPrefixId` bigint(20) NOT NULL COMMENT '关联版式',
  `DescriptiondSuffixId` bigint(20) NOT NULL,
  `Meta_Title` varchar(1000) DEFAULT NULL COMMENT 'SEO',
  `Meta_Description` varchar(1000) DEFAULT NULL,
  `Meta_Keywords` varchar(1000) DEFAULT NULL,
  `MobileDescription` text COMMENT '移动端描述',
  PRIMARY KEY (`ProductId`),
  KEY `FK_Product_ProductDescription` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_productdescriptions_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ProductDescriptionTemplates
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductDescriptionTemplates`;
CREATE TABLE `Himall_ProductDescriptionTemplates` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `Name` varchar(100) NOT NULL COMMENT '板式名称',
  `Position` int(11) NOT NULL COMMENT '位置（上、下）',
  `Content` varchar(4000) NOT NULL COMMENT '板式内容',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Products
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Products`;
CREATE TABLE `Himall_Products` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `CategoryId` bigint(20) NOT NULL COMMENT '分类ID',
  `CategoryPath` varchar(100) NOT NULL COMMENT '分类路径',
  `TypeId` bigint(20) NOT NULL COMMENT '类型ID',
  `BrandId` bigint(20) NOT NULL COMMENT '品牌ID',
  `ProductName` varchar(100) NOT NULL COMMENT '商品名称',
  `ProductCode` varchar(100) DEFAULT NULL COMMENT '商品编号',
  `ShortDescription` varchar(4000) DEFAULT NULL COMMENT '广告词',
  `SaleStatus` int(11) NOT NULL COMMENT '销售状态',
  `AuditStatus` int(11) NOT NULL COMMENT '审核状态',
  `AddedDate` datetime NOT NULL COMMENT '添加日期',
  `DisplaySequence` bigint(20) NOT NULL COMMENT '显示顺序',
  `ImagePath` varchar(100) DEFAULT NULL COMMENT '存放图片的目录',
  `MarketPrice` decimal(18,2) NOT NULL COMMENT '市场价',
  `MinSalePrice` decimal(18,2) NOT NULL COMMENT '最小销售价',
  `HasSKU` tinyint(1) NOT NULL COMMENT '是否有SKU',
  `VistiCounts` bigint(20) NOT NULL COMMENT '浏览次数',
  `SaleCounts` bigint(20) NOT NULL COMMENT '销售量',
  `FreightTemplateId` bigint(20) NOT NULL COMMENT '运费模板ID',
  `Weight` decimal(18,2) DEFAULT NULL COMMENT '重量',
  `Volume` decimal(18,2) DEFAULT NULL COMMENT '体积',
  `Quantity` int(11) DEFAULT NULL COMMENT '数量',
  `MeasureUnit` varchar(20) DEFAULT NULL COMMENT '计量单位',
  `EditStatus` int(11) NOT NULL DEFAULT '0' COMMENT '修改状态 0 正常 1己修改 2待审核 3 己修改并待审核',
  PRIMARY KEY (`Id`),
  KEY `FK_SHOPID` (`ShopId`) USING BTREE,
  KEY `FK_CategoryId` (`CategoryId`) USING BTREE,
  CONSTRAINT `FK_CategoryId` FOREIGN KEY (`CategoryId`) REFERENCES `Himall_Categories` (`Id`),
  CONSTRAINT `FK_SHOPID` FOREIGN KEY (`ShopId`) REFERENCES `himall_shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=558 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ProductShopCategories
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductShopCategories`;
CREATE TABLE `Himall_ProductShopCategories` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProductId` bigint(20) NOT NULL,
  `ShopCategoryId` bigint(20) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Product_ProductShopCategory` (`ProductId`) USING BTREE,
  KEY `FK_ShopCategory_ProductShopCategory` (`ShopCategoryId`) USING BTREE,
  CONSTRAINT `himall_productshopcategories_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_productshopcategories_ibfk_2` FOREIGN KEY (`ShopCategoryId`) REFERENCES `Himall_ShopCategories` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1793 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ProductVistis
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ProductVistis`;
CREATE TABLE `Himall_ProductVistis` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProductId` bigint(20) NOT NULL,
  `Date` datetime NOT NULL,
  `VistiCounts` bigint(20) NOT NULL COMMENT '浏览次数',
  `SaleCounts` bigint(20) NOT NULL COMMENT '销售量',
  `SaleAmounts` decimal(18,2) NOT NULL COMMENT '销售额',
  `OrderCounts` bigint(20) unsigned DEFAULT '0' COMMENT '订单总数',
  PRIMARY KEY (`Id`),
  KEY `FK_Product_ProductVisti` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_productvistis_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2927 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Promoter
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Promoter`;
CREATE TABLE `Himall_Promoter` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserId` bigint(20) DEFAULT NULL COMMENT '会员编号',
  `ShopName` varchar(100) DEFAULT NULL COMMENT '店铺名称',
  `Status` int(11) NOT NULL COMMENT '推销员状态 0审核 1通过 2注销',
  `ApplyTime` datetime DEFAULT NULL COMMENT '申请时间',
  `PassTime` datetime DEFAULT NULL COMMENT '通过时间',
  `Remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_Promoter_UserId` (`UserId`) USING BTREE,
  CONSTRAINT `FK_Himall_Promoter_UserId` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ReceivingAddressConfig
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ReceivingAddressConfig`;
CREATE TABLE `Himall_ReceivingAddressConfig` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AddressId_City` text,
  `AddressId` text NOT NULL COMMENT '逗号分隔',
  `ShopId` bigint(20) NOT NULL COMMENT '预留字段，防止将来其他商家一并支持货到付款',
  PRIMARY KEY (`Id`),
  KEY `FK_RACShopId` (`ShopId`) USING BTREE,
  CONSTRAINT `FK_RACShopId` FOREIGN KEY (`ShopId`) REFERENCES `himall_shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_RecruitPlan
-- ----------------------------
DROP TABLE IF EXISTS `Himall_RecruitPlan`;
CREATE TABLE `Himall_RecruitPlan` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Title` varchar(300) DEFAULT NULL COMMENT '招募标题',
  `Content` varchar(2000) DEFAULT NULL COMMENT '招募内容',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_RecruitSetting
-- ----------------------------
DROP TABLE IF EXISTS `Himall_RecruitSetting`;
CREATE TABLE `Himall_RecruitSetting` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Enable` tinyint(1) NOT NULL COMMENT '招募开关',
  `MustMobile` tinyint(1) NOT NULL COMMENT '手机是否必填',
  `MustAddress` tinyint(1) NOT NULL COMMENT '地址必填',
  `MustRealName` tinyint(1) NOT NULL COMMENT '姓名必填',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_RefundReason
-- ----------------------------
DROP TABLE IF EXISTS `Himall_RefundReason`;
CREATE TABLE `Himall_RefundReason` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `AfterSalesText` varchar(100) DEFAULT NULL COMMENT '售后原因',
  `Sequence` int(11) DEFAULT '100' COMMENT '排序',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='售后原因';

-- ----------------------------
-- Table structure for Himall_RolePrivileges
-- ----------------------------
DROP TABLE IF EXISTS `Himall_RolePrivileges`;
CREATE TABLE `Himall_RolePrivileges` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Privilege` int(11) NOT NULL COMMENT '权限ID',
  `RoleId` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`Id`),
  KEY `FK_Role_RolePrivilege` (`RoleId`) USING BTREE,
  CONSTRAINT `himall_roleprivileges_ibfk_1` FOREIGN KEY (`RoleId`) REFERENCES `Himall_Roles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=633 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Roles
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Roles`;
CREATE TABLE `Himall_Roles` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `RoleName` varchar(100) NOT NULL COMMENT '角色名称',
  `Description` varchar(1000) NOT NULL COMMENT '说明',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_SellerSpecificationValues
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SellerSpecificationValues`;
CREATE TABLE `Himall_SellerSpecificationValues` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ValueId` bigint(20) NOT NULL COMMENT '规格值ID',
  `Specification` int(11) NOT NULL COMMENT '规格（颜色、尺寸、版本）',
  `TypeId` bigint(20) NOT NULL COMMENT '类型ID',
  `Value` varchar(100) NOT NULL COMMENT '商家的规格值',
  PRIMARY KEY (`Id`),
  KEY `FK_SpecificationValue_SellerSpecificationValue` (`ValueId`) USING BTREE,
  CONSTRAINT `himall_sellerspecificationvalues_ibfk_1` FOREIGN KEY (`ValueId`) REFERENCES `Himall_SpecificationValues` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_SendMessageRecord
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SendMessageRecord`;
CREATE TABLE `Himall_SendMessageRecord` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MessageType` int(11) NOT NULL COMMENT '消息类别',
  `ContentType` int(11) NOT NULL COMMENT '内容类型',
  `SendContent` varchar(600) NOT NULL COMMENT '发送内容',
  `ToUserLabel` varchar(200) DEFAULT NULL COMMENT '发送对象',
  `SendState` int(11) DEFAULT NULL COMMENT '发送状态',
  `SendTime` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_SensitiveWords
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SensitiveWords`;
CREATE TABLE `Himall_SensitiveWords` (
  `Id` int(4) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `SensitiveWord` varchar(100) DEFAULT NULL COMMENT '敏感词',
  `CategoryName` varchar(100) DEFAULT NULL COMMENT '敏感词类别',
  PRIMARY KEY (`Id`),
  KEY `Id` (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShippingAddresses
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShippingAddresses`;
CREATE TABLE `Himall_ShippingAddresses` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `RegionId` int(11) NOT NULL COMMENT '区域ID',
  `ShipTo` varchar(100) NOT NULL COMMENT '收货人',
  `Address` varchar(100) NOT NULL COMMENT '收货具体街道信息',
  `Phone` varchar(100) NOT NULL COMMENT '收货人电话',
  `IsDefault` tinyint(1) NOT NULL COMMENT '是否为默认',
  `IsQuick` tinyint(1) NOT NULL COMMENT '是否为轻松购地址',
  PRIMARY KEY (`Id`),
  KEY `FK_Member_ShippingAddress` (`UserId`) USING BTREE,
  CONSTRAINT `himall_shippingaddresses_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=444 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopBonus
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopBonus`;
CREATE TABLE `Himall_ShopBonus` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Count` int(11) NOT NULL COMMENT '红包数量',
  `RandomAmountStart` decimal(18,2) NOT NULL COMMENT '随机范围Start',
  `RandomAmountEnd` decimal(18,2) NOT NULL COMMENT '随机范围End',
  `UseState` int(11) NOT NULL COMMENT '1:满X元使用  2：没有限制',
  `UsrStatePrice` decimal(18,2) NOT NULL COMMENT '满多少元',
  `GrantPrice` decimal(18,2) NOT NULL COMMENT '满多少元才发放红包',
  `DateStart` datetime NOT NULL,
  `DateEnd` datetime NOT NULL,
  `BonusDateStart` datetime NOT NULL,
  `BonusDateEnd` datetime NOT NULL,
  `ShareTitle` varchar(30) NOT NULL COMMENT '分享',
  `ShareDetail` varchar(150) NOT NULL COMMENT '分享',
  `ShareImg` varchar(200) NOT NULL COMMENT '分享',
  `SynchronizeCard` tinyint(1) NOT NULL COMMENT '是否同步到微信卡包，是的话才出现微信卡卷相关UI',
  `CardTitle` varchar(30) DEFAULT NULL COMMENT '微信卡卷相关',
  `CardColor` varchar(20) DEFAULT NULL COMMENT '微信卡卷相关',
  `CardSubtitle` varchar(30) DEFAULT NULL COMMENT '微信卡卷相关',
  `IsInvalid` tinyint(1) NOT NULL COMMENT '是否失效',
  `ReceiveCount` int(11) DEFAULT NULL COMMENT '领取数量',
  `QRPath` varchar(80) NOT NULL COMMENT '二维码路径',
  `WXCardState` int(255) NOT NULL COMMENT '微信卡卷审核状态',
  PRIMARY KEY (`Id`),
  KEY `FK_zzzShopId` (`ShopId`) USING BTREE,
  CONSTRAINT `FK_zzzShopId` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopBonusGrant
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopBonusGrant`;
CREATE TABLE `Himall_ShopBonusGrant` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopBonusId` bigint(20) NOT NULL COMMENT '红包Id',
  `UserId` bigint(20) NOT NULL COMMENT '发放人',
  `OrderId` bigint(20) NOT NULL,
  `BonusQR` varchar(255) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_ShopBonusId` (`ShopBonusId`) USING BTREE,
  KEY `FK_zzzUserID` (`UserId`) USING BTREE,
  CONSTRAINT `FK_ShopBonusId` FOREIGN KEY (`ShopBonusId`) REFERENCES `Himall_ShopBonus` (`Id`),
  CONSTRAINT `FK_zzzUserID` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopBonusReceive
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopBonusReceive`;
CREATE TABLE `Himall_ShopBonusReceive` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `BonusGrantId` bigint(20) NOT NULL COMMENT '红包Id',
  `OpenId` varchar(100) DEFAULT NULL,
  `Price` decimal(18,2) DEFAULT NULL COMMENT '面额',
  `State` int(11) NOT NULL COMMENT '1.未使用  2.已使用  3.已过期',
  `ReceiveTime` datetime DEFAULT NULL COMMENT '领取时间',
  `UsedTime` datetime DEFAULT NULL COMMENT '使用时间',
  `UserId` bigint(20) DEFAULT NULL COMMENT 'UserID',
  `UsedOrderId` bigint(20) DEFAULT NULL COMMENT '使用的订单号',
  `WXName` varchar(30) DEFAULT NULL,
  `WXHead` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_BonusGrantId` (`BonusGrantId`) USING BTREE,
  KEY `FK_useUserID` (`UserId`) USING BTREE,
  CONSTRAINT `FK_BonusGrantId` FOREIGN KEY (`BonusGrantId`) REFERENCES `Himall_ShopBonusGrant` (`Id`),
  CONSTRAINT `FK_useUserID` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopBrandApplys
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopBrandApplys`;
CREATE TABLE `Himall_ShopBrandApplys` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ShopId` bigint(20) NOT NULL COMMENT '商家Id',
  `BrandId` bigint(20) DEFAULT NULL COMMENT '品牌Id',
  `BrandName` varchar(100) DEFAULT NULL COMMENT '品牌名称',
  `Logo` varchar(1000) DEFAULT NULL COMMENT '品牌Logo',
  `Description` varchar(1000) DEFAULT NULL COMMENT '描述',
  `AuthCertificate` varchar(4000) DEFAULT NULL COMMENT '品牌授权证书',
  `ApplyMode` int(11) NOT NULL COMMENT '申请类型 枚举 BrandApplyMode',
  `Remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `AuditStatus` int(11) NOT NULL COMMENT '审核状态 枚举 BrandAuditStatus',
  `ApplyTime` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`Id`),
  KEY `FK_ShopId` (`ShopId`) USING BTREE,
  KEY `FK_BrandId` (`BrandId`) USING BTREE,
  KEY `Id` (`Id`) USING BTREE,
  CONSTRAINT `himall_shopbrandapplys_ibfk_1` FOREIGN KEY (`BrandId`) REFERENCES `Himall_Brands` (`Id`),
  CONSTRAINT `himall_shopbrandapplys_ibfk_2` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopBrands
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopBrands`;
CREATE TABLE `Himall_ShopBrands` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ShopId` bigint(20) NOT NULL COMMENT '商家Id',
  `BrandId` bigint(20) NOT NULL COMMENT '品牌Id',
  PRIMARY KEY (`Id`),
  KEY `ShopId` (`ShopId`) USING BTREE,
  KEY `BrandId` (`BrandId`) USING BTREE,
  KEY `Id` (`Id`) USING BTREE,
  CONSTRAINT `himall_shopbrands_ibfk_1` FOREIGN KEY (`BrandId`) REFERENCES `Himall_Brands` (`Id`),
  CONSTRAINT `himall_shopbrands_ibfk_2` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopCategories
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopCategories`;
CREATE TABLE `Himall_ShopCategories` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `ParentCategoryId` bigint(20) NOT NULL COMMENT '上级分类ID',
  `Name` varchar(100) DEFAULT NULL COMMENT '分类名称',
  `DisplaySequence` bigint(20) NOT NULL,
  `IsShow` tinyint(1) NOT NULL COMMENT '是否显示',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopDistributorSetting
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopDistributorSetting`;
CREATE TABLE `Himall_ShopDistributorSetting` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `DistributorDefaultRate` decimal(6,2) NOT NULL COMMENT '分销默认分佣比',
  `DistributorShareName` varchar(100) DEFAULT NULL COMMENT '分销分享名称',
  `DistributorShareContent` varchar(1000) DEFAULT NULL COMMENT '分销分享说明',
  `DistributorShareLogo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopFooter
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopFooter`;
CREATE TABLE `Himall_ShopFooter` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `Footer` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_ShopGrades
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopGrades`;
CREATE TABLE `Himall_ShopGrades` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL COMMENT '店铺等级名称',
  `ProductLimit` int(11) NOT NULL COMMENT '最大上传商品数量',
  `ImageLimit` int(11) NOT NULL COMMENT '最大图片可使用空间数量',
  `TemplateLimit` int(11) NOT NULL,
  `ChargeStandard` decimal(8,2) NOT NULL,
  `Remark` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopHomeModuleProducts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopHomeModuleProducts`;
CREATE TABLE `Himall_ShopHomeModuleProducts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `HomeModuleId` bigint(20) NOT NULL,
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `DisplaySequence` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`Id`),
  KEY `FK_Product_ShopHomeModuleProduct` (`ProductId`) USING BTREE,
  KEY `FK_ShopHomeModule_ShopHomeModuleProduct` (`HomeModuleId`) USING BTREE,
  CONSTRAINT `himall_shophomemoduleproducts_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_shophomemoduleproducts_ibfk_2` FOREIGN KEY (`HomeModuleId`) REFERENCES `Himall_ShopHomeModules` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopHomeModules
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopHomeModules`;
CREATE TABLE `Himall_ShopHomeModules` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `Name` varchar(20) NOT NULL COMMENT '模块名称',
  `IsEnable` tinyint(1) NOT NULL COMMENT '是否启用',
  `DisplaySequence` int(11) NOT NULL COMMENT '排序',
  `Url` varchar(200) DEFAULT NULL COMMENT '楼层链接',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopHomeModulesTopImg
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopHomeModulesTopImg`;
CREATE TABLE `Himall_ShopHomeModulesTopImg` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ImgPath` varchar(200) NOT NULL,
  `Url` varchar(200) DEFAULT NULL,
  `HomeModuleId` bigint(20) NOT NULL,
  `DisplaySequence` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_SFTHomeModuleId` (`HomeModuleId`),
  CONSTRAINT `FK_SFTHomeModuleId` FOREIGN KEY (`HomeModuleId`) REFERENCES `Himall_ShopHomeModules` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_ShoppingCarts
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShoppingCarts`;
CREATE TABLE `Himall_ShoppingCarts` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) NOT NULL COMMENT '用户ID',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `SkuId` varchar(100) DEFAULT NULL COMMENT 'SKUID',
  `Quantity` bigint(20) NOT NULL COMMENT '购买数量',
  `AddTime` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`Id`),
  KEY `FK_Member_ShoppingCart` (`UserId`) USING BTREE,
  KEY `FK_Product_ShoppingCart` (`ProductId`) USING BTREE,
  CONSTRAINT `himall_shoppingcarts_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Himall_Members` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_shoppingcarts_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=964 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopRenewRecord
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopRenewRecord`;
CREATE TABLE `Himall_ShopRenewRecord` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `Operator` varchar(100) NOT NULL COMMENT '操作者',
  `OperateDate` datetime NOT NULL COMMENT '操作日期',
  `OperateContent` varchar(1000) DEFAULT NULL COMMENT '操作明细',
  `OperateType` int(1) NOT NULL COMMENT '类型',
  `Amount` decimal(10,2) NOT NULL COMMENT '支付金额',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺续费记录表';

-- ----------------------------
-- Table structure for Himall_Shops
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Shops`;
CREATE TABLE `Himall_Shops` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `GradeId` bigint(20) NOT NULL COMMENT '店铺等级',
  `ShopName` varchar(100) NOT NULL COMMENT '店铺名称',
  `Logo` varchar(100) DEFAULT NULL COMMENT '店铺LOGO路径',
  `SubDomains` varchar(100) DEFAULT NULL COMMENT '预留子域名，未使用',
  `Theme` varchar(100) DEFAULT NULL COMMENT '预留主题，未使用',
  `IsSelf` tinyint(1) NOT NULL COMMENT '是否是官方自营店',
  `ShopStatus` int(11) NOT NULL COMMENT '店铺状态',
  `RefuseReason` varchar(1000) DEFAULT NULL COMMENT '审核拒绝原因',
  `CreateDate` datetime NOT NULL COMMENT '店铺创建日期',
  `EndDate` datetime DEFAULT NULL COMMENT '店铺过期日期',
  `CompanyName` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `CompanyRegionId` int(11) NOT NULL COMMENT '公司省市区',
  `CompanyAddress` varchar(100) DEFAULT NULL COMMENT '公司地址',
  `CompanyPhone` varchar(100) DEFAULT NULL COMMENT '公司电话',
  `CompanyEmployeeCount` int(11) NOT NULL COMMENT '公司员工数量',
  `CompanyRegisteredCapital` decimal(18,2) NOT NULL COMMENT '公司注册资金',
  `ContactsName` varchar(100) DEFAULT NULL COMMENT '联系人姓名',
  `ContactsPhone` varchar(100) DEFAULT NULL COMMENT '联系电话',
  `ContactsEmail` varchar(100) DEFAULT NULL COMMENT '联系Email',
  `BusinessLicenceNumber` varchar(100) DEFAULT NULL COMMENT '营业执照号',
  `BusinessLicenceNumberPhoto` varchar(100) NOT NULL COMMENT '营业执照',
  `BusinessLicenceRegionId` int(11) NOT NULL COMMENT '营业执照所在地',
  `BusinessLicenceStart` datetime DEFAULT NULL COMMENT '营业执照有效期开始',
  `BusinessLicenceEnd` datetime DEFAULT NULL COMMENT '营业执照有效期',
  `BusinessSphere` varchar(100) DEFAULT NULL COMMENT '法定经营范围',
  `OrganizationCode` varchar(100) DEFAULT NULL COMMENT '组织机构代码',
  `OrganizationCodePhoto` varchar(100) DEFAULT NULL COMMENT '组织机构执照',
  `GeneralTaxpayerPhot` varchar(100) DEFAULT NULL COMMENT '一般纳税人证明',
  `BankAccountName` varchar(100) DEFAULT NULL COMMENT '银行开户名',
  `BankAccountNumber` varchar(100) DEFAULT NULL COMMENT '公司银行账号',
  `BankName` varchar(100) DEFAULT NULL COMMENT '开户银行支行名称',
  `BankCode` varchar(100) DEFAULT NULL COMMENT '支行联行号',
  `BankRegionId` int(11) NOT NULL COMMENT '开户银行所在地',
  `BankPhoto` varchar(100) DEFAULT NULL,
  `TaxRegistrationCertificate` varchar(100) DEFAULT NULL COMMENT '税务登记证',
  `TaxpayerId` varchar(100) DEFAULT NULL COMMENT '税务登记证号',
  `TaxRegistrationCertificatePhoto` varchar(100) DEFAULT NULL COMMENT '纳税人识别号',
  `PayPhoto` varchar(100) DEFAULT NULL COMMENT '支付凭证',
  `PayRemark` varchar(1000) DEFAULT NULL COMMENT '支付注释',
  `SenderName` varchar(100) DEFAULT NULL COMMENT '商家发货人名称',
  `SenderAddress` varchar(100) DEFAULT NULL COMMENT '商家发货人地址',
  `SenderPhone` varchar(100) DEFAULT NULL COMMENT '商家发货人电话',
  `Freight` decimal(18,2) NOT NULL COMMENT '运费',
  `FreeFreight` decimal(18,2) NOT NULL COMMENT '多少钱开始免运费',
  `Stage` int(11) DEFAULT '0' COMMENT '注册步骤',
  `SenderRegionId` int(11) DEFAULT NULL COMMENT '商家发货人省市区',
  `BusinessLicenseCert` varchar(120) DEFAULT NULL COMMENT '营业执照证书',
  `ProductCert` varchar(120) DEFAULT NULL COMMENT '商品证书',
  `OtherCert` varchar(120) DEFAULT NULL COMMENT '其他证书',
  `legalPerson` varchar(50) DEFAULT NULL COMMENT '法人代表',
  `CompanyFoundingDate` datetime DEFAULT NULL COMMENT '公司成立日期',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_ShopVistis
-- ----------------------------
DROP TABLE IF EXISTS `Himall_ShopVistis`;
CREATE TABLE `Himall_ShopVistis` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `Date` datetime NOT NULL COMMENT '日期',
  `VistiCounts` bigint(20) NOT NULL COMMENT '浏览量',
  `SaleCounts` bigint(20) NOT NULL COMMENT '销售量',
  `SaleAmounts` decimal(18,2) NOT NULL COMMENT '销售额',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=781 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_SiteSettings
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SiteSettings`;
CREATE TABLE `Himall_SiteSettings` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Key` varchar(100) NOT NULL,
  `Value` varchar(4000) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_SiteSignInConfig
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SiteSignInConfig`;
CREATE TABLE `Himall_SiteSignInConfig` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `IsEnable` tinyint(1) NOT NULL COMMENT '开启签到',
  `DayIntegral` int(11) NOT NULL DEFAULT '0' COMMENT '签到获得积分',
  `DurationCycle` int(11) NOT NULL DEFAULT '0' COMMENT '持续周期',
  `DurationReward` int(11) NOT NULL DEFAULT '0' COMMENT '周期额外奖励积分',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_SKUs
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SKUs`;
CREATE TABLE `Himall_SKUs` (
  `Id` varchar(100) NOT NULL COMMENT '商品ID_颜色规格ID_颜色规格ID_尺寸规格',
  `AutoId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键Id',
  `ProductId` bigint(20) NOT NULL COMMENT '商品ID',
  `Color` varchar(100) DEFAULT NULL COMMENT '颜色规格',
  `Size` varchar(100) DEFAULT NULL COMMENT '尺寸规格',
  `Version` varchar(100) DEFAULT NULL COMMENT '版本规格',
  `Sku` varchar(100) DEFAULT NULL COMMENT 'SKU',
  `Stock` bigint(20) NOT NULL COMMENT '库存',
  `CostPrice` decimal(18,2) NOT NULL COMMENT '成本价',
  `SalePrice` decimal(18,2) NOT NULL COMMENT '销售价',
  `ShowPic` varchar(200) DEFAULT NULL COMMENT '显示图片',
  PRIMARY KEY (`AutoId`),
  KEY `FK_Product_Sku` (`ProductId`) USING BTREE,
  KEY `AutoId` (`AutoId`),
  KEY `Id` (`Id`),
  CONSTRAINT `himall_skus_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `Himall_Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4568 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_SlideAds
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SlideAds`;
CREATE TABLE `Himall_SlideAds` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID，0：平台轮播图  ',
  `ImageUrl` varchar(100) NOT NULL COMMENT '图片保存URL',
  `Url` varchar(1000) NOT NULL COMMENT '图片跳转URL',
  `DisplaySequence` bigint(20) NOT NULL,
  `TypeId` int(11) NOT NULL DEFAULT '0',
  `Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_SpecificationValues
-- ----------------------------
DROP TABLE IF EXISTS `Himall_SpecificationValues`;
CREATE TABLE `Himall_SpecificationValues` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Specification` int(11) NOT NULL COMMENT '规格名',
  `TypeId` bigint(20) NOT NULL COMMENT '类型ID',
  `Value` varchar(100) NOT NULL COMMENT '规格值',
  PRIMARY KEY (`Id`),
  KEY `FK_Type_SpecificationValue` (`TypeId`) USING BTREE,
  CONSTRAINT `himall_specificationvalues_ibfk_1` FOREIGN KEY (`TypeId`) REFERENCES `Himall_Types` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=685 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_StatisticOrderComments
-- ----------------------------
DROP TABLE IF EXISTS `Himall_StatisticOrderComments`;
CREATE TABLE `Himall_StatisticOrderComments` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL,
  `CommentKey` int(11) NOT NULL COMMENT '评价的枚举（宝贝与描述相符 商家得分）',
  `CommentValue` decimal(10,4) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `himall_statisticordercomments_ibfk_1` (`ShopId`) USING BTREE,
  CONSTRAINT `himall_statisticordercomments_ibfk_1` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_TemplateVisualizationSettings
-- ----------------------------
DROP TABLE IF EXISTS `Himall_TemplateVisualizationSettings`;
CREATE TABLE `Himall_TemplateVisualizationSettings` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `CurrentTemplateName` varchar(2000) NOT NULL COMMENT '当前使用的模板的名称',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺Id（平台为0）',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_TopicModules
-- ----------------------------
DROP TABLE IF EXISTS `Himall_TopicModules`;
CREATE TABLE `Himall_TopicModules` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `TopicId` bigint(20) NOT NULL COMMENT '专题ID',
  `Name` varchar(100) NOT NULL COMMENT '专题名称',
  PRIMARY KEY (`Id`),
  KEY `FK_Topic_TopicModule` (`TopicId`) USING BTREE,
  CONSTRAINT `himall_topicmodules_ibfk_1` FOREIGN KEY (`TopicId`) REFERENCES `Himall_Topics` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Topics
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Topics`;
CREATE TABLE `Himall_Topics` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL COMMENT '专题名称',
  `FrontCoverImage` varchar(100) DEFAULT NULL COMMENT '封面图片',
  `TopImage` varchar(100) NOT NULL COMMENT '主图',
  `BackgroundImage` varchar(100) DEFAULT NULL COMMENT '背景图片',
  `PlatForm` int(11) NOT NULL DEFAULT '0' COMMENT '使用终端',
  `Tags` varchar(100) DEFAULT NULL COMMENT '标签',
  `ShopId` bigint(20) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `IsRecommend` tinyint(1) unsigned zerofill NOT NULL COMMENT '是否推荐',
  `SelfDefineText` text COMMENT '自定义热点',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_TypeBrands
-- ----------------------------
DROP TABLE IF EXISTS `Himall_TypeBrands`;
CREATE TABLE `Himall_TypeBrands` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `TypeId` bigint(20) NOT NULL,
  `BrandId` bigint(20) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Brand_TypeBrand` (`BrandId`) USING BTREE,
  KEY `FK_Type_TypeBrand` (`TypeId`) USING BTREE,
  CONSTRAINT `himall_typebrands_ibfk_1` FOREIGN KEY (`BrandId`) REFERENCES `Himall_Brands` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `himall_typebrands_ibfk_2` FOREIGN KEY (`TypeId`) REFERENCES `Himall_Types` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1606 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_Types
-- ----------------------------
DROP TABLE IF EXISTS `Himall_Types`;
CREATE TABLE `Himall_Types` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL COMMENT '类型名称',
  `IsSupportColor` tinyint(1) NOT NULL COMMENT '是否支持颜色规格',
  `IsSupportSize` tinyint(1) NOT NULL COMMENT '是否支持尺寸规格',
  `IsSupportVersion` tinyint(1) NOT NULL COMMENT '是否支持版本规格',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_VShop
-- ----------------------------
DROP TABLE IF EXISTS `Himall_VShop`;
CREATE TABLE `Himall_VShop` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) DEFAULT NULL COMMENT '名称',
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `CreateTime` datetime NOT NULL COMMENT '创建日期',
  `VisitNum` int(11) NOT NULL COMMENT '历览次数',
  `buyNum` int(11) NOT NULL COMMENT '购买数量',
  `State` int(11) NOT NULL COMMENT '状态',
  `Logo` varchar(200) DEFAULT NULL COMMENT 'LOGO',
  `BackgroundImage` varchar(200) DEFAULT NULL COMMENT '背景图',
  `Description` varchar(30) DEFAULT NULL COMMENT '详情',
  `Tags` varchar(100) DEFAULT NULL COMMENT '标签',
  `HomePageTitle` varchar(20) DEFAULT NULL COMMENT '微信首页显示的标题',
  `WXLogo` varchar(200) DEFAULT NULL COMMENT '微信Logo',
  PRIMARY KEY (`Id`),
  KEY `FK_vshop_shopinfo` (`ShopId`) USING BTREE,
  CONSTRAINT `himall_vshop_ibfk_1` FOREIGN KEY (`ShopId`) REFERENCES `Himall_Shops` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_VShopExtend
-- ----------------------------
DROP TABLE IF EXISTS `Himall_VShopExtend`;
CREATE TABLE `Himall_VShopExtend` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `VShopId` bigint(20) NOT NULL COMMENT '微店ID',
  `Sequence` int(11) DEFAULT NULL COMMENT '顺序',
  `Type` int(11) NOT NULL COMMENT '微店类型（主推微店、热门微店）',
  `AddTime` datetime NOT NULL COMMENT '添加时间',
  `State` int(11) NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`Id`),
  KEY `FK_vshopextend_vshop` (`VShopId`) USING BTREE,
  CONSTRAINT `himall_vshopextend_ibfk_1` FOREIGN KEY (`VShopId`) REFERENCES `Himall_VShop` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_WeiXinBasic
-- ----------------------------
DROP TABLE IF EXISTS `Himall_WeiXinBasic`;
CREATE TABLE `Himall_WeiXinBasic` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Ticket` varchar(100) DEFAULT NULL COMMENT '微信Ticket',
  `TicketOutTime` datetime DEFAULT NULL COMMENT '微信Ticket过期日期',
  `AppId` varchar(50) DEFAULT NULL,
  `AccessToken` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_WeiXinMsgTemplate
-- ----------------------------
DROP TABLE IF EXISTS `Himall_WeiXinMsgTemplate`;
CREATE TABLE `Himall_WeiXinMsgTemplate` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MessageType` int(11) DEFAULT NULL COMMENT '消息类别',
  `TemplateNum` varchar(30) DEFAULT NULL COMMENT '消息模板编号',
  `TemplateId` varchar(100) DEFAULT NULL COMMENT '消息模板ID',
  `UpdateDate` datetime DEFAULT NULL COMMENT '更新日期',
  `IsOpen` tinyint(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Himall_WXAccToken
-- ----------------------------
DROP TABLE IF EXISTS `Himall_WXAccToken`;
CREATE TABLE `Himall_WXAccToken` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AppId` varchar(50) DEFAULT NULL,
  `AccessToken` varchar(150) NOT NULL COMMENT '微信访问令牌',
  `TokenOutTime` datetime NOT NULL COMMENT '微信令牌过期日期',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_WXCardCodeLog
-- ----------------------------
DROP TABLE IF EXISTS `Himall_WXCardCodeLog`;
CREATE TABLE `Himall_WXCardCodeLog` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `CardLogId` bigint(20) DEFAULT NULL COMMENT '卡券记录号',
  `CardId` varchar(50) DEFAULT NULL,
  `Code` varchar(50) DEFAULT NULL COMMENT '标识',
  `SendTime` datetime DEFAULT NULL COMMENT '投放时间',
  `CodeStatus` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `UsedTime` datetime DEFAULT NULL COMMENT '操作时间 失效、核销、删除时间',
  `CouponType` int(11) DEFAULT NULL COMMENT '红包类型',
  `CouponCodeId` bigint(20) DEFAULT NULL COMMENT '红包记录编号',
  `OpenId` varchar(4000) DEFAULT NULL COMMENT '对应OpenId',
  PRIMARY KEY (`Id`),
  KEY `FK_Himall_WXLog_CardLogId` (`CardLogId`) USING BTREE,
  KEY `IDX_Himall_WXLog_CardId` (`CardId`) USING BTREE,
  KEY `IDX_Himall_WXLog_Code` (`Code`) USING BTREE,
  CONSTRAINT `FK_Himall_WXLog_CardLogId` FOREIGN KEY (`CardLogId`) REFERENCES `Himall_WXCardLog` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_WXCardLog
-- ----------------------------
DROP TABLE IF EXISTS `Himall_WXCardLog`;
CREATE TABLE `Himall_WXCardLog` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `CardId` varchar(50) DEFAULT NULL COMMENT '卡券编号',
  `CardTitle` varchar(50) DEFAULT NULL COMMENT '标题 英文27  汉字 9个',
  `CardSubTitle` varchar(100) DEFAULT NULL COMMENT '副标题 英文54  汉字18个',
  `CardColor` varchar(10) DEFAULT NULL COMMENT '卡券颜色 HasTable',
  `AuditStatus` int(11) DEFAULT NULL COMMENT '审核状态',
  `AppId` varchar(50) DEFAULT NULL,
  `AppSecret` varchar(50) DEFAULT NULL,
  `CouponType` int(11) DEFAULT NULL COMMENT '红包类型',
  `CouponId` bigint(20) DEFAULT NULL COMMENT '红包编号 涉及多表，不做外键',
  PRIMARY KEY (`Id`),
  KEY `IDX_Himall_WXCardLog_CardId` (`CardId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for Himall_WXshop
-- ----------------------------
DROP TABLE IF EXISTS `Himall_WXshop`;
CREATE TABLE `Himall_WXshop` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ShopId` bigint(20) NOT NULL COMMENT '店铺ID',
  `AppId` varchar(30) NOT NULL COMMENT '公众号的APPID',
  `AppSecret` varchar(35) NOT NULL COMMENT '公众号的AppSecret',
  `Token` varchar(30) NOT NULL COMMENT '公众号的Token',
  `FollowUrl` varchar(500) DEFAULT NULL COMMENT '跳转的URL',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


ALTER TABLE Himall_Banners ADD COLUMN STATUS int NOT NULL DEFAULT 1 COMMENT '开启或者关闭';
ALTER TABLE Himall_Banners ADD COLUMN EnableDelete int NOT NULL DEFAULT 1 COMMENT '能否删除';

ALTER TABLE `Himall_MarketSetting`
MODIFY COLUMN `Price`  decimal(18,2) NOT NULL COMMENT '营销使用价格（/月）';
ALTER TABLE `Himall_Shops`
MODIFY COLUMN `CompanyRegisteredCapital`  decimal(18,2) NOT NULL COMMENT '公司注册资金'