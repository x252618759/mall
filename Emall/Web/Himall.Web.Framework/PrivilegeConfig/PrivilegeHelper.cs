using Himall.Model;
using Himall.Web.Framework;
using System;
using System.IO;
using System.Reflection;
using System.Xml.Serialization;
using System.Linq;
using System.Collections.Generic;
using System.Configuration;

namespace Himall.Web.Framework
{
    public class PrivilegeHelper
    {
        private static Privileges adminPrivileges;

        private static Privileges sellerAdminPrivileges;

        private static Privileges userPrivileges;
        public static Privileges UserPrivileges
        {
            set
            {
                userPrivileges = value;
            }
            get
            {
                if (userPrivileges == null)
                {
                    userPrivileges = GetPrivileges<UserPrivilege>();
                }
                return userPrivileges;
            }
        }

        public static Privileges AdminPrivileges
        {
            set
            {
                adminPrivileges = value;
            }
            get
            {
                if (adminPrivileges == null)
                {
                    adminPrivileges = GetPrivileges<AdminPrivilege>();
                }
                return adminPrivileges;
            }
        }


        public static Privileges SellerAdminPrivileges
        {
            set
            {
                sellerAdminPrivileges = value;
            }
            get
            {
                if (sellerAdminPrivileges == null)
                {
                    sellerAdminPrivileges = GetPrivileges<SellerPrivilege>();
                }
                return sellerAdminPrivileges;
            }
        }

        /// <summary>
        /// 相当于根目录的路径
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static Privileges GetPrivileges<TEnum>()
        {
            Type type = typeof(TEnum);
            FieldInfo[] fields = type.GetFields();
            if (fields.Length == 1)
            {
                return null;
            }
            Privileges p = new Privileges();
            foreach (var field in fields)
            {
                var attributes = field.GetCustomAttributes(typeof(PrivilegeAttribute), true);
                if(attributes.Length==0)
                {
                    continue;
                }
                #region 根据config配置是否显示导航
                if (field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("分销"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenDistribution"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                if (Convert.ToInt32(field.CustomAttributes.FirstOrDefault().ConstructorArguments[2].Value) == 4007 && field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("会员"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenMemberInvite"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                if (field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("营销"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenLimitTime"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                if (field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("微商城"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenVshop"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                if (field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("APP"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenAPP"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                if (field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("微信"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenWeiXin"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                if (field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("微店"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenVshop"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                if (Convert.ToInt32(field.CustomAttributes.FirstOrDefault().ConstructorArguments[2].Value) == 4008 && field.CustomAttributes.FirstOrDefault().ConstructorArguments[0].Value.Equals("店铺"))
                {
                    var IsOpen = ConfigurationManager.AppSettings["IsOpenBTwoB"];
                    if (IsOpen != null && !bool.Parse(IsOpen))
                    {
                        continue;
                    }
                }
                #endregion
                GroupActionItem group = new GroupActionItem();
                ActionItem item = new ActionItem();
                List<string> actions = new List<string>();
                List<PrivilegeAttribute> attrs = new List<PrivilegeAttribute>();
                List<Controllers> ctrls = new List<Controllers>();
                foreach (var attr in attributes)
                {
                    Controllers ctrl=new Controllers();
                    var attribute = attr as PrivilegeAttribute;
                    ctrl.ControllerName = attribute.Controller;
                    ctrl.ActionNames.AddRange(attribute.Action.Split(','));
                    ctrls.Add(ctrl);
                    attrs.Add(attribute);
                }
                var groupInfo=attrs.FirstOrDefault(a => !string.IsNullOrEmpty(a.GroupName));
                group.GroupName = groupInfo.GroupName;
                item.PrivilegeId = groupInfo.Pid;
                item.Name = groupInfo.Name;
                item.Url = groupInfo.Url;
                item.Controllers.AddRange(ctrls);
                var currentGroup = p.Privilege.FirstOrDefault(a => a.GroupName == group.GroupName);
                if (currentGroup == null)
                {   group.Items.Add(item);
                    p.Privilege.Add(group);
                }
                else
                {
                    currentGroup.Items.Add(item);
                }
                
            }
            return p;
        }
    }
}
