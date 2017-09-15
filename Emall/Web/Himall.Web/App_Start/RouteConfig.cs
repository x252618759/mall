using System.Web.Mvc;
using System.Web.Routing;

namespace Himall.Web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "common/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints:null
               // namespaces: new string[] { "Himall.Web.Controllers" }
              
            );

        }
    }
}
