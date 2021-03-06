﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Himall.Model
{
    public enum SellerPrivilege
    {
        /* 首页*/
        //[Description("控制台")]
        //Console = 1001,
        //[Description("平台公告")]
        //Notice = 1002,
        /*商品*/
        [Privilege("商品", "商品发布", 2001, "product/PublicStepOne", "product", "PublicStepOne")]
        ProductAdd = 2001,
        [Privilege("商品", "商品管理", 2002, "product/management", "product")]
        ProductManage = 2002,
        [Privilege("商品", "分类管理", 2003, "category/management", "category")]
        ProductCategory = 2003,
        [Privilege("商品", "经营品牌申请", 2004, "brand/management", "brand")]
        BrandManage = 2004,
        [Privilege("商品", "关联版式", 2005, "productDescriptiontemplate/management", "productDescriptiontemplate")]
        ProductDescriptionTemplate = 2005,
        [Privilege("商品", "咨询管理", 2006, "productconsultation/management", "productconsultation")]
        ConsultationManage = 2006,
        [Privilege("商品", "评价管理", 2007, "ProductComment/management", "ProductComment")]
        CommentManage = 2007,
        [Privilege("商品", "商品数据导入", 2008, "ProductImport/ImportManage", "ProductImport")]
        ProductImportManage = 2008,
        [Privilege("商品", "预约到店", 2009, "Reservation/management", "Reservation")]
        ReservationManage = 2009,
        [Privilege("商品", "详情模板", 2010, "TemplateProductDetail/Management", "TemplateProductDetail")]
        TemplateProductDetailManage = 2010,
        [Privilege("商品", "当日金价", 2011, "GoldPrice/Index", "GoldPrice")]
        GoldPriceManage = 2011,
        [Privilege("商品", "素金规格", 2012, "ShopSpecificationValue/Index", "ShopSpecificationValue")]
        GoldTypeSpecification = 2012,


        /*交易*/
        [Privilege("交易", "订单管理", 3001, "order/management", "order")]
        OrderManage = 3001,
        [Privilege("交易", "退款处理", 3002, "orderrefund/management?showtype=2", "orderrefund")]
        OrderRefund = 3002,
        [Privilege("交易", "退货处理", 3003, "orderrefund/management?showtype=3", "orderrefund")]
        OrderGoodsRefund = 3003,
        [Privilege("交易", "交易投诉", 3004, "ordercomplaint/management", "ordercomplaint")]
        OrderComplaint = 3004,

        [Privilege("交易", "运费模板管理", 3006, "FreightTemplate/Index", "FreightTemplate")]
        FreightTemplate = 3006,
        [Privilege( "交易" , "支付方式" , 3007 , "PaymentConfig/Index" , "PaymentConfig" )]
        PaymentConfig = 3007 , 
        /*店铺*/
        [Privilege("店铺", "页面设置", 4001, "PageSettings/management", "PageSettings")]
        PageSetting = 4001,
        [Privilege("店铺", "店铺管理", 4002, "shop/Renew", "shop", "Renew")]
        ShopInfo = 4002,
        [Privilege("店铺", "客服管理", 4004, "CustomerService/management", "CustomerService")]
        CustomerService = 4004,
        [Privilege("店铺", "结算管理", 4005, "Account/management", "Account")]
        SettlementManage = 4005,
        [Privilege("店铺", "保证金管理", 4006, "CashDeposit/Management", "CashDeposit")]
        CashDepositManagement = 4006,
        [Privilege("店铺", "经营类目管理", 4007, "BussinessCategory/Management", "BussinessCategory")]
        BussinessCategoryManagement = 4007,
        [Privilege("店铺", "批发须知", 4008, "shop/Instructions", "shop")]
        Instructions = 4008,

        
        /*统计*/
        [Privilege("统计", "流量统计", 5001, "statistics/shopflow", "statistics", "shopflow")]
        TrafficStatistics = 5001,
        [Privilege("统计", "店铺统计", 5002, "statistics/shopsale", "statistics", "shopsale")]
        ShopStatistics = 5002,
        [Privilege("统计", "成交转化率", 5003, "statistics/DealConversionRate", "statistics", "DealConversionRate")]
        SalesAnalysis = 5003,
        /*系统*/
        [Privilege("系统", "管理员", 6001, "Manager/management", "Manager")]
        AdminManage = 6001,
        [Privilege("系统", "权限组", 6002, "Privilege/management", "Privilege")]
        PrivilegesManage = 6002,
        [Privilege("系统", "操作日志", 6003, "OperationLog/management", "OperationLog")]
        OperationLog = 6003,

        /*营销*/
        [Privilege("营销", "限时购", 7001, "LimitTimeBuy/management", "LimitTimeBuy")]
        LimitTimeBuy = 7001,
        [Privilege("营销", "优惠券", 7002, "Coupon/management", "Coupon")]
        Coupon = 7002,

        [Privilege("营销", "组合购", 7003, "Collocation/management", "Collocation")]
        Collocation = 7003,

        [Privilege("营销", "移动端专题", 7004, "MobileTopic/Management", "MobileTopic")]
        MobileTopic = 7004,

        [Privilege("营销", "满额免运费", 7005, "shop/FreightSetting", "shop", "FreightSetting")]
        FreightSetting = 7005,

        [Privilege( "营销" , "代金红包" , 7006 , "ShopBonus/Management" , "ShopBonus" )]
        ShopBonus = 7006,

        /*分销*/
        [Privilege("分销", "分销规则管理", 10001, "DistributionRules/Manage", "DistributionRules", "Manage")]
        DistributionRules = 10001,
        [Privilege("分销", "分销业绩管理", 10002, "DistributionFeat/Order", "DistributionFeat", "Order")]
        DistributionFeat = 10002,

        /*微信*/
        [Privilege("微信", "微信配置", 8002, "WeiXin/BasicVShopSettings", "WeiXin")]
        weixinSetting = 8002,
        [Privilege("微信", "微信菜单", 8003, "WeiXin/MenuManage", "WeiXin")]
        weixinMenu = 8003,
        [Privilege("微信", "门店管理", 8004, "Poi/Index", "Poi")]
        Poi = 8004,
        [Privilege("微信", "iBeacon设备", 8005, "ShakeAround/Index", "ShakeAround")]
        ShakeAroundDev = 8005,
        [Privilege("微信", "摇一摇周边页面", 8006, "ShakeAround/PageIndex", "ShakeAround")]
        ShakeAroundPage = 8006,

        //微店
        [Privilege("微店", "我的微店", 9001, "Vshop/management", "Vshop")]
        VShop = 9001,

        [Privilege("微店", "首页配置", 9002, "Vshop/VshopHomeSite", "TemplateVisualizationAjax")]
        [Privilege("微店", "首页配置", 9002, "Vshop/VshopHomeSite", "Vshop")]
        VshopHomeSite = 9002,
        [Privilege("微店", "App首页配置", 9003, "Vshop/VshopHomeSiteApp", "Vshop")]
        VshopHomeSiteApp = 9003
    }
}
