using Himall.IServices;
using System;

namespace Himall.Web.Framework
{
    public class UserCookieEncryptHelper
    {
        /*
        /// <summary>
        /// 用户标识Cookie加密
        /// </summary>
        /// <param name="userId">用户Id</param>
        /// <returns>返回加密后的Cookie值</returns>
        public static string Encrypt(long userId, string controllerName)
        {

            string key = ServiceProvider.Instance<ISiteSettingService>.Create.GetSiteSettings().UserCookieKey;
            if(string.IsNullOrEmpty(key))
            {
                key = Core.Helper.SecureHelper.MD5(Guid.NewGuid().ToString());
                ServiceProvider.Instance<ISiteSettingService>.Create.SaveSetting("UserCookieKey", key);
            }

            string text = string.Empty;
            try
            {
                string plainText = controllerName + "," + userId.ToString();
                text = Core.Helper.SecureHelper.AESEncrypt(plainText, key);
                text = Core.Helper.SecureHelper.EncodeBase64(text);
                return text;
            }
            catch(Exception ex)
            {
                Core.Log.Error(string.Format("加密用户标识Cookie出错", text), ex);
                throw;
            }
        }

        /// <summary>
        /// 用户标识Cookie解密
        /// </summary>
        /// <param name="userIdCookie">用户IdCookie密文</param>
        /// <returns></returns>
        public static long Decrypt(string userIdCookie, string controllerName)
        {

            string key = ServiceProvider.Instance<ISiteSettingService>.Create.GetSiteSettings().UserCookieKey;
            if (string.IsNullOrEmpty(key))
            {
                key = Core.Helper.SecureHelper.MD5(Guid.NewGuid().ToString());
                ServiceProvider.Instance<ISiteSettingService>.Create.SaveSetting("UserCookieKey", key);
            }
            string plainText = string.Empty;
            try
            {
                if (!string.IsNullOrWhiteSpace(userIdCookie))
                {
                    userIdCookie = System.Web.HttpUtility.UrlDecode(userIdCookie);
                    userIdCookie = Core.Helper.SecureHelper.DecodeBase64(userIdCookie);
                    plainText = Core.Helper.SecureHelper.AESDecrypt(userIdCookie, key);//解密
                    plainText = plainText.Replace(controllerName + ",", "");
                }
            }
            catch (Exception ex)
            {
                Core.Log.Error(string.Format("解密用户标识Cookie出错，Cookie密文：{0}", userIdCookie), ex);
            }

            long userId = 0;
            long.TryParse(plainText, out userId);
            return userId;
        }

    */
    }
}
