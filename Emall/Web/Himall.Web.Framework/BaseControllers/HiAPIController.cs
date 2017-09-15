using Himall.Core;
using Himall.Core.Helper;
using Himall.IServices;
using Himall.Model;
using System;
using System.Collections.Generic;
using System.Web.Http;
using System.Web.Routing;

namespace Himall.Web.Framework
{
    public abstract class HiAPIController : ApiController
    {
        /// <summary>
        /// 当前用户
        /// </summary>
        //public UserMemberInfo CurrentUser
        //{
        //    get
        //    {
        //        long userId = UserCookieEncryptHelper.Decrypt(WebHelper.GetCookie(CookieKeysCollection.HIMALL_USER_KEY(platformType)), "Mobile");
        //        if (userId != 0)
        //        {
        //            //return ServiceProvider.Instance<IMemberService>.Create.GetMember(userId);
        //        }
        //        return null;
        //    }
        //}
        public string platformType
        {
            get
            {
                return "App";
            }
        }
    }
}
