using Himall.Core;
using Himall.Core.Helper;
using Himall.IServices;
using Himall.Model;
using Himall.Web.Framework;
using System;
using System.Collections.Generic;

namespace Himall.Web.Framework
{
    /// <summary>
    /// 移动端控制器基类
    /// </summary>
    public abstract class BaseMobileController : BaseController
    {

        static Dictionary<string, string> platformTypesStringMap = null;

        public BaseMobileController()
        {
            if (platformTypesStringMap == null)
            {
                var types = EnumHelper.ToDictionary<PlatformType>();
                platformTypesStringMap = new Dictionary<string, string>();
                foreach (var type in types)
                    platformTypesStringMap[type.Value.ToLower()] = type.Value;
            }
        }


        /// <summary>
        /// 当前用户
        /// </summary>
        //public UserMemberInfo CurrentUser
        //{
        //    get
        //    {
        //        //long userId = UserCookieEncryptHelper.Decrypt(WebHelper.GetCookie(CookieKeysCollection.HIMALL_USER), "Mobile");
        //        //if (userId != 0)
        //        //{
        //        //    return ServiceHelper.Create<IMemberService>().GetMember(userId);
        //        //}
        //        return null;
        //    }
        //}

        /// <summary>
        /// 当前访问的平台类型
        /// </summary>
        public PlatformType PlatformType
        {
            get
            {
                var platformTypeLowerString = RouteData.Values["platform"].ToString().ToLower();//获取平台类型传入值并转为小写

                var mapper = platformTypesStringMap;//获取枚举小写与标准值之间的对应关系

                //获取对应的枚举
                var platformType = PlatformType.Mobile;
                if (visitorTerminalInfo.Terminal == EnumVisitorTerminal.WeiXin)
                {
                    platformTypeLowerString = "weixin";
                }
                if (mapper.ContainsKey(platformTypeLowerString))
                    platformType = (PlatformType)Enum.Parse(typeof(PlatformType), mapper[platformTypeLowerString]);
                return platformType;
            }
        }

        protected override void OnActionExecuting(System.Web.Mvc.ActionExecutingContext filterContext)
        {
            /*
            ViewBag.AreaName = string.Format("m-{0}", PlatformType.ToString());
            ViewBag.Logo = CurrentSiteSetting.Logo;
            ViewBag.SiteName = CurrentSiteSetting.SiteName;
            //区分平台还是商家
            var MAppType = WebHelper.GetCookie(CookieKeysCollection.MobileAppType);
            var MVshopId = WebHelper.GetCookie(CookieKeysCollection.HIMALL_VSHOPID);
            if (MAppType == string.Empty)
            {
                if (filterContext.HttpContext.Request["shop"] != null)
                {//微信菜单中是否存在店铺ID
                    MAppType = filterContext.HttpContext.Request["shop"].ToString();
                    long shopid = 0;
                    if (long.TryParse(MAppType,out shopid))
                    {//记录当前微店（从微信菜单进来，都带有shop参数）
                        var vshop = ServiceHelper.Create<IVShopService>().GetVShopByShopId(shopid) ?? new VShopInfo(){};
                        WebHelper.SetCookie(CookieKeysCollection.HIMALL_VSHOPID, vshop.Id.ToString());
                    }
                    WebHelper.SetCookie(CookieKeysCollection.MobileAppType, MAppType);
                }
            }
            ViewBag.MAppType = MAppType;
            ViewBag.MVshopId = MVshopId;*/
            base.OnActionExecuting(filterContext);
        }


    }
}
