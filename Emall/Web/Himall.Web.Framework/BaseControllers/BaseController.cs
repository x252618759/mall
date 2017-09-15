using Himall.Core;
using Himall.Core.Helper;
using Himall.IServices;
using Himall.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Mvc;
using System.Text;
using System.Text.RegularExpressions;
using System.Net;
using System.Web.Routing;

namespace Himall.Web.Framework
{

    public abstract class BaseController : Controller
    {
        
        public BaseController()
        {
            var curhttp = System.Web.HttpContext.Current;
            //记录当前域名
            //SiteStaticInfo.CurDomainUrl = curhttp.Request.Url.Scheme + "://" + curhttp.Request.Url.Authority;

            if (!IsInstalled())
            {
                RedirectToAction("/Web/Installer/Agreement");
            }
            else
            {
                //ViewBag.SEODescription = CurrentSiteSetting.Site_SEODescription;
                //ViewBag.SEOKeyword = CurrentSiteSetting.Site_SEOKeywords;
                //ViewBag.FlowScript = CurrentSiteSetting.FlowScript;
            }
        }

        #region 来源终端信息
        /// <summary>
        /// 是否自动跳到移动端
        /// </summary>
        public bool IsAutoJumpMobile = false;
        //Add:Dzy[150720]
        /// <summary>
        /// 访问终端信息
        /// </summary>
        public VisitorTerminal visitorTerminalInfo { get; set; }
        /// <summary>
        /// 是否当前为移动端访问
        /// </summary>
        public bool IsMobileTerminal { get; set; }
        /// <summary>
        /// 获取访问终端信息
        /// </summary>
        protected void InitVisitorTerminal()
        {
            VisitorTerminal result = new VisitorTerminal();
            string sUserAgent = Request.UserAgent;
            if (string.IsNullOrWhiteSpace(sUserAgent))
            {
                sUserAgent = "";
            }
            sUserAgent = sUserAgent.ToLower();
            //终端类型
            bool IsIpad = sUserAgent.Contains("ipad");
            bool IsIphoneOs = sUserAgent.Contains("iphone os");
            bool IsMidp = sUserAgent.Contains("midp");
            bool IsUc = sUserAgent.Contains("rv:1.2.3.4");
            IsUc = IsUc ? IsUc : sUserAgent.Contains("ucweb");
            bool IsAndroid = sUserAgent.Contains("android");
            bool IsCE = sUserAgent.Contains("windows ce");
            bool IsWM = sUserAgent.Contains("windows mobile");
            bool IsWeiXin = sUserAgent.Contains("micromessenger");
            bool IsWP = sUserAgent.Contains("windows phone ");
            bool IsIosApp = sUserAgent.Contains("appwebview(ios)");
            //初始为电脑端
            result.Terminal = EnumVisitorTerminal.PC;
            //所有移动平台
            if (IsIpad || IsIphoneOs || IsMidp || IsUc || IsAndroid || IsCE || IsWM || IsWP)
            {
                result.Terminal = EnumVisitorTerminal.Moblie;
            }
            if (IsIpad || IsIphoneOs)
            {
                //苹果系统
                result.OperaSystem = EnumVisitorOperaSystem.IOS;
                result.Terminal = EnumVisitorTerminal.Moblie;
                if (IsIpad)
                {
                    result.Terminal = EnumVisitorTerminal.PAD;
                }
                if (IsIosApp)
                {
                    result.Terminal = EnumVisitorTerminal.IOS;
                }
            }
            if (IsAndroid)
            {
                //安卓
                result.OperaSystem = EnumVisitorOperaSystem.Android;
                result.Terminal = EnumVisitorTerminal.Moblie;
            }
            if (IsWeiXin)
            {
                //微信特殊化
                result.Terminal = EnumVisitorTerminal.WeiXin;
            }

            //TODO:DZY[150731] 整合移动端请求
            /* zjt  
             * TODO可移除，保留注释即可
             */
            #region  移动端判定
            if (result.Terminal == EnumVisitorTerminal.Moblie
                || result.Terminal == EnumVisitorTerminal.PAD
                || result.Terminal == EnumVisitorTerminal.WeiXin
                || result.Terminal == EnumVisitorTerminal.IOS
                )
            {
                IsMobileTerminal = true;
            }
            #endregion

            visitorTerminalInfo = result;
        }
        /// <summary>
        /// 跳转到手机URL
        /// </summary>
        /// <param name="JumpUrl">为空表示自动处理</param>
        //TODO:DZY[150730] 统一跳转
        /* zjt  
         * Url请改为小写 【参数命名规范】
         */
        protected void JumpMobileUrl(RouteData route, string url = "")
        {
            string curUrl = Request.Url.PathAndQuery;
            string jumpUrl = curUrl;
            //无路由信息不跳转
            if (route == null) return;

            //路由处理
            string controller = route.Values["controller"].ToString().ToLower();
            string action = route.Values["action"].ToString().ToLower();
            string area = (route.DataTokens["area"] == null ? "" : route.DataTokens["area"].ToString().ToLower());

            if (area == "mobile")
            {
                return;  //在移动端跳出
            }
            //Web区域跳转移动端
            if (area == "web") IsAutoJumpMobile = true;

            if (this.IsAutoJumpMobile && IsMobileTerminal)
            {
                if (Regex.Match(curUrl, @"\/m(\-.*)?").Length < 1)
                {
                    JumpUrlRoute jurdata = GetRouteUrl(controller, action, area, curUrl);
                    //非手机端跳转
                    switch (visitorTerminalInfo.Terminal)
                    {
                        case EnumVisitorTerminal.WeiXin:
                            if (jurdata != null)
                            {
                                jumpUrl = jurdata.WX;
                            }
                            jumpUrl = @"/m-weixin" + jumpUrl;
                            break;
                        case EnumVisitorTerminal.IOS:
                            if (jurdata != null)
                            {
                                jumpUrl = jurdata.WAP;
                            }
                            jumpUrl = @"/m-ios" + jumpUrl;
                            break;
                        default:
                            if (jurdata != null)
                            {
                                jumpUrl = jurdata.WAP;
                            }
                            jumpUrl = @"/m-wap" + jumpUrl;
                            break;
                    }

                    #region 参数特殊处理
                    if (jurdata.IsSpecial)
                    {
                        #region 店铺参数转换
                        if (jurdata.PC.ToLower() == @"/shop")
                        {
                            //商家首页参数处理
                            string strid = route.Values["id"].ToString();
                            long shopId = 0;
                            long vshopId = 0;
                            if (!long.TryParse(strid, out shopId))
                            {
                                shopId = 0;
                            }
                            if (shopId > 0)
                            {
                                //var vshop = ServiceHelper.Create<IVShopService>().GetVShopByShopId(shopId);
                                //if (vshop != null) vshopId = vshop.Id;
                            }
                            jumpUrl = jumpUrl + "/" + vshopId.ToString();
                        }
                        #endregion

                        //TODO:LRL 订单页面参数转换
                        /* zjt  
                         * TODO可移除，保留注释即可
                         */
                        #region 下单页面参数转换
                        if (jurdata.PC.ToLower() == @"/order/submit")
                        {
                            //商家首页参数处理
                            var strcartid = string.Empty;
                            var arg = route.Values["cartitemids"];
                            if (arg == null)
                            {
                                strcartid = Request.QueryString["cartitemids"];
                            }
                            else
                            {
                                strcartid = arg.ToString();
                            }
                            jumpUrl = jumpUrl + "/?cartItemIds=" + strcartid;
                        }
                        #endregion

                    }
                    #endregion

                    if (!string.IsNullOrWhiteSpace(url)) jumpUrl = url;
                    string testurl = jumpUrl;
                    testurl = Request.Url.Scheme + "://" + Request.Url.Authority + testurl;
                    //页面不存在
                    if (!IsExistPage(testurl))
                    {
                        if (visitorTerminalInfo.Terminal == EnumVisitorTerminal.WeiXin)
                        {
                            jumpUrl = @"/m-weixin/";
                        }
                        else
                        {
                            jumpUrl = @"/m-wap/";
                        }

                    }
                    //跳转
                    Response.Redirect(jumpUrl);
                }
            }
        }
        /// <summary>
        /// 页面是否存在
        /// <para>包括200、302、301</para>
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        //TODO:DZY[150730] 页面访问判定
        /* zjt  
         * TODO可移除
         */
        private bool IsExistPage(string url)
        {
            bool result = false;
            HttpWebResponse urlresponse = Himall.Core.Helper.WebHelper.GetURLResponse(url);
            if (urlresponse != null)
            {
                if (urlresponse.StatusCode == HttpStatusCode.OK || (int)urlresponse.StatusCode == 302 || (int)urlresponse.StatusCode == 301)
                {
                    result = true;
                }
            }
            return result;
        }
        /// <summary>
        /// 移动页面跳转路由列表(保护)
        /// </summary>
        protected List<JumpUrlRoute> _JumpUrlRouteData { get; set; }
        /// <summary>
        /// 移动页面跳转路由列表
        /// </summary>
        public List<JumpUrlRoute> JumpUrlRouteData
        {
            get
            {
                return _JumpUrlRouteData;
            }
        }
        /// <summary>
        /// 初始移动页面跳转路由列表
        /// </summary>
        //TODO:DZY[150730] 路由初始
        /*
         * _JumpUrlRouteData , 是否需要确认带下划线的成员变量规范 
         */
        public void InitJumpUrlRoute()
        {
            _JumpUrlRouteData = new System.Collections.Generic.List<JumpUrlRoute>();
            JumpUrlRoute _tmp = new JumpUrlRoute() { Action = "Index", Area = "Web", Controller = "UserOrder", PC = @"/userorder", WAP = @"/member/orders", WX = @"/member/orders" };
            _JumpUrlRouteData.Add(_tmp);
            _tmp = new JumpUrlRoute() { Action = "Index", Area = "Web", Controller = "UserCenter", PC = @"/usercenter", WAP = @"/member/center", WX = @"/member/center" };
            _JumpUrlRouteData.Add(_tmp);
            _tmp = new JumpUrlRoute() { Action = "Index", Area = "Web", Controller = "Login", PC = @"/login", WAP = @"/login/entrance", WX = @"/login/entrance" };
            _JumpUrlRouteData.Add(_tmp);
            _tmp = new JumpUrlRoute() { Action = "Home", Area = "Web", Controller = "Shop", PC = @"/shop", WAP = @"/vshop/detail", WX = @"/vshop/detail", IsSpecial = true };
            _JumpUrlRouteData.Add(_tmp);
            _tmp = new JumpUrlRoute() { Action = "Submit", Area = "Web", Controller = "Order", PC = @"/order/submit", WAP = @"/order/SubmiteByCart", WX = @"/order/SubmiteByCart", IsSpecial = true };
            _JumpUrlRouteData.Add(_tmp);
        }
        /// <summary>
        /// 返回URL对应路由信息
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        //TODO:DZY[150730] 路由信息获取
        /*
         * TODO可移除
         */
        public JumpUrlRoute GetRouteUrl(string controller, string action, string area, string url)
        {
            InitJumpUrlRoute();
            JumpUrlRoute result = null;
            url = url.ToLower();
            controller = controller.ToLower();
            action = action.ToLower();
            area = area.ToLower();
            List<JumpUrlRoute> sql = JumpUrlRouteData;
            if (!string.IsNullOrWhiteSpace(area))
            {
                sql = sql.FindAll(d => d.Area.ToLower() == area);
            }
            if (!string.IsNullOrWhiteSpace(controller))
            {
                sql = sql.FindAll(d => d.Controller.ToLower() == controller);
            }
            if (!string.IsNullOrWhiteSpace(action))
            {
                sql = sql.FindAll(d => d.Action.ToLower() == action);
            }
            result = sql.Count > 0 ? sql[0] : null;

            if (result == null)
            {
                result = new JumpUrlRoute() { PC = url, WAP = url, WX = url };
            }
            return result;
        }
        #endregion

        #region 分销功能
        /// <summary>
        /// 获取Cookie内保存的分销销售员编号
        /// </summary>
        public List<long> GetDistributionUserLinkId()
        {
            List<long> result = new List<long>();
            string _tmp = Core.Helper.WebHelper.GetCookie(CookieKeysCollection.HIMALL_DISTRIBUTIONUSERLINKIDS);
            if (!string.IsNullOrWhiteSpace(_tmp))
            {
                string[] _arrtmp = _tmp.Split(',');
                long _puid = 0;
                foreach (var item in _arrtmp)
                {
                    if (long.TryParse(item, out _puid))
                    {
                        if (_puid > 0)
                        {
                            result.Add(_puid);
                        }
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// 清理销售员编号，以减少服务层访问
        /// </summary>
        public void ClearDistributionUserLinkId()
        {
            Core.Helper.WebHelper.GetCookie(CookieKeysCollection.HIMALL_DISTRIBUTIONUSERLINKIDS, "");
        }
       
        #endregion

        ///// <summary>
        ///// 当前站点配置
        ///// </summary>
        //public SiteSettingsInfo CurrentSiteSetting
        //{
        //    get
        //    {
        //        return ServiceHelper.Create<ISiteSettingService>().GetSiteSettings();
        //    }
        //}

        public class Result
        {
            public bool success { get; set; }

            public string msg { get; set; }
            /// <summary>
            /// 状态
            /// <para>1表成功</para>
            /// </summary>
            public int status { get; set; }
        }

        protected Exception GerInnerException(Exception ex)
        {
            if (ex.InnerException != null)
            {
                return GerInnerException(ex.InnerException);
            }
            else
            {
                return ex;
            }
        }

        protected override void OnException(ExceptionContext filterContext)
        {
            Exception innerEx = GerInnerException(filterContext.Exception);
            string msg = innerEx.Message;
            base.OnException(filterContext);
            if (!(innerEx is HimallException))
            {

                var controllerName = filterContext.RouteData.Values["controller"].ToString();
                var actionName = filterContext.RouteData.Values["action"].ToString();
                var areaName = filterContext.RouteData.DataTokens["area"];
                var erroMsg = string.Format("页面未捕获的异常：Area:{0},Controller:{1},Action:{2}", areaName, controllerName, actionName);
                Log.Error(erroMsg, innerEx);
                msg = "系统内部异常";
            }

            if (WebHelper.IsAjax())
            {
                Result result = new Result();
                result.success = false;
                result.msg = msg;
                result.status = -9999;
                filterContext.Result = Json(result);
                //将状态码更新为200，否则在Web.config中配置了CustomerError后，Ajax会返回500错误导致页面不能正确显示错误信息
                filterContext.HttpContext.Response.StatusCode = 200;
                filterContext.ExceptionHandled = true;
                DisposeService(filterContext);
            }
            else
            {
#if !DEBUG          
                    var result = new ViewResult() { ViewName = "Error" };
                    result.TempData.Add("Message", filterContext.Exception.ToString());
                    result.TempData.Add("Title", msg);
                    filterContext.Result = result;
                     //将状态码更新为200，否则在Web.config中配置了CustomerError后，Ajax会返回500错误导致页面不能正确显示错误信息
                    filterContext.HttpContext.Response.StatusCode = 200;
                    filterContext.ExceptionHandled = true;
                    DisposeService(filterContext);
#endif
            }
            if (innerEx is HttpRequestValidationException)
            {
                if (WebHelper.IsAjax())
                {
                    Result result = new Result();
                    result.msg = "您提交了非法字符!";
                    filterContext.Result = Json(result);
                }
                else
                {
                    var result = new ContentResult();
                    result.Content = "<script src='/Scripts/jquery-1.11.1.min.js'></script>";
                    result.Content += "<script src='/Scripts/jquery.artDialog.js'></script>";
                    result.Content += "<script src='/Scripts/artDialog.iframeTools.js'></script>";
                    result.Content += "<link href='/Content/artdialog.css' rel='stylesheet' />";
                    result.Content += "<link href='/Content/bootstrap.min.css' rel='stylesheet' />";
                    result.Content += "<script>$(function(){$.dialog.errorTips('您提交了非法字符！',function(){window.history.back(-1)},2);});</script>";
                    filterContext.Result = result;
                }
                filterContext.HttpContext.Response.StatusCode = 200;
                filterContext.ExceptionHandled = true;
                DisposeService(filterContext);
            }

        }

        #region 自动清理登录状态有关属性方法
        //Add：DZY[150628]

        /// <summary>
        /// 最后操作时间
        /// <para>从cookie获取</para>
        /// </summary>
        protected DateTime? LastOperateTime
        {
            get
            {
                HttpCookie lasttimeck = HttpContext.Request.Cookies[CookieKeysCollection.HIMALL_LASTOPERATETIME];
                DateTime? lastoptime = null;
                if (lasttimeck != null)
                {
                    lastoptime = DateTime.FromBinary(long.Parse(lasttimeck.Value));
                }
                return lastoptime;
            }
        }

        /// <summary>
        /// 是否达到清理登录状态的时间
        /// </summary>
        protected bool isCanClearLoginStatus
        {
            get
            {
                bool result = true;
                DateTime? _time = this.LastOperateTime;
                if (_time != null)
                {
                    var ts = (DateTime.Now - _time.Value);
                    if (ts.TotalMinutes <= CKLoginTimeOut && ts.TotalMinutes >= 0)
                    {
                        result = false;
                    }
                }
                return result;
            }
        }
        /// <summary>
        /// 清理登录的超时时间，单位分钟
        /// </summary>
        private int CKLoginTimeOut = 30;
        /// <summary>
        /// 设定最后操作时间Cookie
        /// </summary>
        /// <param name="date"></param>
        protected void SetLastOperateTime(DateTime? date = null)
        {
            if (date == null) date = DateTime.Now;
            HttpCookie lasttimeck = HttpContext.Request.Cookies[CookieKeysCollection.HIMALL_LASTOPERATETIME];
            DateTime lastoptime = DateTime.Now.AddYears(-1);
            if (lasttimeck == null)
            {
                lasttimeck = new HttpCookie(CookieKeysCollection.HIMALL_LASTOPERATETIME);
            }
            else
            {
                lastoptime = DateTime.FromBinary(long.Parse(lasttimeck.Value));
            }
            lasttimeck.Value = date.Value.Ticks.ToString();
            //lasttimeck.Expires = DateTime.Now.AddMinutes(CKLoginTimeOut);
            HttpContext.Response.AppendCookie(lasttimeck);
        }

        /// <summary>
        /// 清理登录Cookie
        /// </summary>
        private void ClearLoginCookie()
        {
            //清理用户cookie
            HttpCookie lasttimeck = HttpContext.Request.Cookies[CookieKeysCollection.HIMALL_USER];
            if (lasttimeck != null)
            {
                lasttimeck.Expires = DateTime.Now.AddYears(-1);
                HttpContext.Response.AppendCookie(lasttimeck);
            }
            //清理商家cookie
            lasttimeck = HttpContext.Request.Cookies[CookieKeysCollection.SELLER_MANAGER];
            if (lasttimeck != null)
            {
                lasttimeck.Expires = DateTime.Now.AddYears(-1);
                HttpContext.Response.AppendCookie(lasttimeck);
            }
            //清理最后操作时间
            lasttimeck = HttpContext.Request.Cookies[CookieKeysCollection.HIMALL_LASTOPERATETIME];
            if (lasttimeck != null)
            {
                lasttimeck.Expires = DateTime.Now.AddYears(-1);
                HttpContext.Response.AppendCookie(lasttimeck);
            }
        }
        #endregion

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            //跳转移动端
            //TODO:DZY[150730] 跳转移动端
            /*
             * TODO可移除
             */
            JumpMobileUrl(filterContext.RouteData);
            base.OnActionExecuting(filterContext);
        }
        /// <summary>
        /// <para>请在重写时优先调用此方法</para>
        /// </summary>
        /// <param name="filterContext"></param>
        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            //初始获取访问终端信息 Add:Dzy[150731]
            InitVisitorTerminal();
            //if (IsInstalled() && CurrentSiteSetting.SiteIsClose)
            //{ //在已经安装完成的基础上检查站点是否已经关闭

            //    //站点已关闭时，仅可以访问平台中心
            //    string controllerName = filterContext.RouteData.Values["controller"].ToString();
            //    if (controllerName.ToLower() != "admin")
            //        filterContext.Result = new RedirectResult("/common/site/close");
            //}
        }


        private bool IsInstalled()
        {
            var t = ConfigurationManager.AppSettings["IsInstalled"];
            return null == t || bool.Parse(t);
        }

        protected override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            //  DisposeService(filterContext);
        }

        void DisposeService(ControllerContext filterContext)
        {
            if (filterContext.IsChildAction)
                return;

            List<IServices.IService> services = filterContext.HttpContext.Session["_serviceInstace"] as List<IServices.IService>;
            if (services != null)
            {
                foreach (var service in services)
                {
                    try
                    {
                        service.Dispose();
                    }
                    catch (Exception ex)
                    {
                        Log.Error(service.GetType().ToString() + "释放失败！", ex);
                    }
                }
                filterContext.HttpContext.Session["_serviceInstace"] = null;
            }
        }

    }

    #region 访问设备
    //Add:Dzy[150720]
    public class VisitorTerminal
    {
        /// <summary>
        /// 终端类型
        /// </summary>
        public EnumVisitorTerminal Terminal { get; set; }
        /// <summary>
        /// 浏览器内核[暂不启用]
        /// </summary>
        //public EnumVisitorBrowserCore BrowserCore { get; set; }
        /// <summary>
        /// 操作系统
        /// </summary>
        public EnumVisitorOperaSystem OperaSystem { get; set; }
    }
    /// <summary>
    /// 浏览器内核
    /// </summary>
    public enum EnumVisitorBrowserCore
    {
        /// <summary>
        /// IE系内核
        /// <para>包括大部国产浏览器</para>
        /// </summary>
        Trident = 0,
        /// <summary>
        /// WebKit系
        /// <para>Chrome、Safari及大部份国产浏览器</para>
        /// </summary>
        WebKit = 1,
        /// <summary>
        /// Firefox
        /// </summary>
        Gecko = 2,
        /// <summary>
        /// Google新版
        /// <para>Chrome、Opera及大部份国产浏览器新版本</para>
        /// </summary>
        Blink = 3,
        /// <summary>
        /// Opera老版本
        /// </summary>
        Presto = 4,
        /// <summary>
        /// 微信
        /// </summary>
        WeiXin = 5,
        /// <summary>
        /// 其他
        /// </summary>
        Other = 99
    }
    /// <summary>
    /// 访问终端
    /// <para>判定打开页面的设备与浏览器</para>
    /// </summary>
    public enum EnumVisitorTerminal
    {
        /// <summary>
        /// 电脑端
        /// </summary>
        PC = 0,
        /// <summary>
        /// 手机端
        /// </summary>
        Moblie = 1,
        /// <summary>
        /// 平板
        /// </summary>
        PAD = 2,
        /// <summary>
        /// 微信
        /// <para>独立出微信特征</para>
        /// </summary>
        WeiXin = 3,
        /// IOSApp
        /// </summary>
        IOS = 4,
        /// <summary>
        /// 安卓App
        /// </summary>
        Android = 5,
        /// <summary>
        /// <summary>
        /// 其他
        /// </summary>
        Other = 99
    }
    /// <summary>
    /// 操作系统
    /// </summary>
    public enum EnumVisitorOperaSystem
    {
        /// <summary>
        /// MS出品
        /// </summary>
        Windows = 0,
        /// <summary>
        /// 安卓
        /// </summary>
        Android = 1,
        /// <summary>
        /// 苹果移动
        /// </summary>
        IOS = 2,
        /// <summary>
        /// Linux
        /// <para>Red Hat等</para>
        /// </summary>
        Linux = 3,
        /// <summary>
        /// UNIX
        /// <para>如BSD一类</para>
        /// </summary>
        UNIX = 4,
        /// <summary>
        /// 苹果桌面
        /// </summary>
        MacOS = 5,
        /// <summary>
        /// MS移动
        /// </summary>
        WindowsPhone = 6,
        /// <summary>
        /// Windows CE 嵌入式
        /// </summary>
        WindowsCE = 7,
        /// <summary>
        /// Windows Mobile
        /// </summary>
        WindowsMobile = 8,
        /// <summary>
        /// 其他
        /// </summary>
        Other = 99
    }
    #endregion

    #region 移动页面跳转路由
    //Add:Dzy[150720]
    /// <summary>
    /// 移动页面跳转路由
    /// </summary>
    //TODO:DZY[150730] 重理路由信息
    /*
     * TODO可移除
     */
    public class JumpUrlRoute
    {
        /// <summary>
        /// 控制器
        /// <para>为空表示不参与判断</para>
        /// </summary>
        public string Controller { get; set; }
        /// <summary>
        /// 行为
        /// <para>为空表示不参与判断</para>
        /// </summary>
        public string Action { get; set; }
        /// <summary>
        /// 区域
        /// <para>为空表示不参与判断</para>
        /// </summary>
        public string Area { get; set; }
        /// <summary>
        /// 电脑端
        /// </summary>
        public string PC { get; set; }
        /// <summary>
        /// 移动端
        /// </summary>
        public string WAP { get; set; }
        /// <summary>
        /// 微信
        /// </summary>
        public string WX { get; set; }
        /// <summary>
        /// 是否需要特殊处理
        /// </summary>
        public bool IsSpecial { get; set; }
    }
    #endregion
}
