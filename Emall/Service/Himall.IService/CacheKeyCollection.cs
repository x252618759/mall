
namespace Himall.IServices
{
    /// <summary>
    /// 缓存键值集合
    /// </summary>
    public static class CacheKeyCollection
    {
        /// <summary>
        /// 管理员账号信息缓存键
        /// </summary>
        /// <param name="managerId">管理员id</param>
        /// <returns></returns>
        public static string Manager(long managerId)
        {
            return string.Format("Cache-Manager-{0}", managerId);
        }

        /// <summary>
        /// 商家账号信息缓存键
        /// </summary>
        /// <param name="sellerId">商家id</param>
        /// <returns></returns>
        public static string Seller(long sellerId)
        {
            return string.Format("Cache-Seller-{0}", sellerId);
        }

        /// <summary>
        /// 会员信息缓存键
        /// </summary>
        /// <param name="memberId">会员id</param>
        /// <returns></returns>
        public static string Member(long memberId)
        {
            return string.Format("Cache-Member-{0}", memberId);
        }

        /// <summary>
        /// 抽奖活动
        /// </summary>
        public static string Activity(long? activityId)
        {
            return string.Format("Cache-Activity-{0}", activityId);
        }
        /// <summary>
        /// 奖品
        /// </summary>
        public static string ActivityProduct(long? activityProductId)
        {
            return string.Format("Cache-ActivityProduct-{0}", activityProductId);
        }

        /// <summary>
        /// 中奖用户列表
        /// </summary>
        public static string AwardUserList(long?memberId,long? activityId)
        {
            return string.Format("Cache-AwardUser-List-{0}-{1}", memberId, activityId);
        }
        

        
       
        /// <summary>
        /// 用户导入产品计数
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public static string UserImportProductCount(long userid)
        {
            return string.Format("Cache-{0}-ImportProductCount", userid);
        }
        public static string UserImportProductTotal(long userid)
        {
            return string.Format("Cache-{0}-ImportProductTotal", userid);
        }
        /// <summary>
        /// 同时导入限制
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public const string UserImportOpCount = "Cache-UserImportOpCount";
 
        /// <summary>
        /// 店铺关注人数缓存
        /// </summary>
        /// <param name="shopId"></param>
        /// <returns></returns>
        public static string ShopConcerned(long shopId)
        {
            return string.Format("Cache-ShopConcerned-{0}", shopId);
        }

        /// <summary>
        /// 店铺热销的前N件商品
        /// </summary>
        /// <param name="shopId"></param>
        /// <returns></returns>
        public static string HotSaleProduct(long shopId)
        {
            return string.Format("Cache-HotSaleProduct-{0}", shopId);
        }


        /// <summary>
        /// 店铺最新上架的前N件商品
        /// </summary>
        /// <param name="shopId"></param>
        /// <returns></returns>
        public static string NewSaleProduct(long shopId)
        {
            return string.Format("Cache-NewSaleProduct-{0}", shopId);
        }


        /// <summary>
        /// 店铺最受关注的前N件商品
        /// </summary>
        /// <param name="shopId"></param>
        /// <returns></returns>
        public static string HotConcernedProduct(long shopId)
        {
            return string.Format("Cache-HotConcernedProduct-{0}", shopId);
        }

        /// <summary>
        /// 登录错误缓存（一般保留15分钟）
        /// </summary>
        /// <param name="username">出错时用户名</param>
        /// <returns></returns>
        public static string ManagerLoginError(string username)
        {
            return string.Format("Cache-Manager-Login-{0}", username);
        }

        /// <summary>
        /// 登录错误缓存（一般保留15分钟）
        /// </summary>
        /// <param name="username">出错时用户名</param>
        /// <returns></returns>
        public static string MemberLoginError(string username)
        {
            return string.Format("Cache-Member-Login-{0}", username);
        }

        /// <summary>
        /// 验证码短信发送次数
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public static string MessageSendNum(string username)
        {
            return string.Format("Cache-Message-Send-{0}", username);
        }


        public static string MemberPluginCheck(string username,string pluginId)
        {
            return string.Format("Cache-Member-{0}-{1}", username,pluginId);
        }
        public static string MemberPluginCheckTime(string username, string pluginId)
        {
            return string.Format("Cache-CheckTime-{0}-{1}", username, pluginId);
        }
        public static string MemberPluginFindPassWordTime(string username, string pluginId)
        {
            return string.Format("Cache-FindPasswordTime-{0}-{1}", username, pluginId);
        }

        public static string MemberPluginReBindTime(string username, string pluginId)
        {
            return string.Format("Cache-ReBindTime-{0}-{1}", username, pluginId);
        }
        public static string MemberPluginReBindStepTime(string username, string pluginId)
        {
            return string.Format("Cache-ReBindStepTime-{0}-{1}", username, pluginId);
        }

        public static string MemberFindPassWordCheck(string username, string pluginId)
        {
            return string.Format("Cache-Member-PassWord-{0}-{1}", username,pluginId);
        }

        /// <summary>
        /// 支付状态缓存
        /// </summary>
        /// <param name="orderIds">订单编号</param>
        /// <returns></returns>
        public static string PaymentState(string orderIds)
        {
            return string.Format("Cache-PaymentState-{0}", orderIds);
        }

        /// <summary>
        /// 场景值缓存
        /// </summary>
        /// <param name="sceneid"></param>
        /// <returns></returns>
        public static string SceneState(string sceneid)
        {
            return string.Format("Cache-SceneState-{0}", sceneid);
        }
        public static string ChargeOrderKey(string id)
        {
            return string.Format("Cache-ChargeOrder-{0}", id);
        }

        /// <summary>
        /// 场景返回结果
        /// </summary>
        /// <param name="sceneid"></param>
        /// <returns></returns>
        public static string SceneReturn(string sceneid)
        {
            return string.Format("Cache-SceneReturn-{0}", sceneid);
        }
        /// <summary>
        /// 省市区
        /// </summary>
        public const string Region = "Cache-Regions";

        /// <summary>
        /// 商品分类
        /// </summary>
        public const string Category = "Cache-Categories";

        public const string HomeCategory = "Cache-HomeCategories";

        /// <summary>
        /// 品牌
        /// </summary>
        public const string Brand = "Cache-Brands";

        /// <summary>
        /// 站点设置
        /// </summary>
        public const string SiteSettings = "Cache-SiteSettings";

        /// <summary>
        /// 首页菜单导航
        /// </summary>
        public const string Banners = "Cache-Banners";

        /// <summary>
        /// 广告
        /// </summary>
        public const string Advertisement = "Cache-Adverts";

        /// <summary>
        /// 询问菜单
        /// </summary>
        public const string BottomHelpers = "Cache-Helps";

        /// <summary>
        /// 快递单模板
        /// </summary>
        public const string ExpressTemplate = "Cache-ExperssTemplate";

        
       
        
        
    }
}
