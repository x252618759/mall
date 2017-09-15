using Himall.Core;
using Himall.Core.Helper;
using Himall.IServices;
using Himall.Model;
using Himall.Web.Framework;
using System;
using System.Web;
using System.Web.Mvc;

namespace Himall.Web.Framework
{
    public abstract class BaseWebController : BaseController
    {

        /// <summary>
        /// 当前登录的会员
        /// </summary>
        //public UserMemberInfo CurrentUser
        //{
        //    get
        //    {
                
        //        long userId = UserCookieEncryptHelper.Decrypt(WebHelper.GetCookie(CookieKeysCollection.HIMALL_USER), "Web"); ;
        //        Log.Debug(userId.ToString());
        //        if (userId != 0)
        //        {
        //            return ServiceHelper.Create<IMemberService>().GetUserByCache(userId);
        //        }
        //        return null;
        //    }
        //}

        /// <summary>
        /// 当前管理员
        /// </summary>
        //public ISellerManager CurrentSellerManager
        //{
        //    get
        //    {
        //        ISellerManager sellerManager = null;
        //        long userId = UserCookieEncryptHelper.Decrypt(WebHelper.GetCookie(CookieKeysCollection.SELLER_MANAGER), "SellerAdmin");
        //        if (userId != 0)
        //        {
        //            sellerManager = ServiceHelper.Create<IManagerService>().GetSellerManager(userId);
        //        }
        //        return sellerManager;
        //    }
        //}
    }
}
