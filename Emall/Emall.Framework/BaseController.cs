using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Emall.Framework
{
    public class BaseController:Controller
    {
        protected override void OnException(ExceptionContext filterContext)
        {
            base.OnException(filterContext);
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
    }
}
