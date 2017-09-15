using System.Web.Http;
using Himall.Web.Framework;

namespace Himall.Web
{
    public static class WebApiConfig 
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API 配置和服务

            // Web API 路由
            config.MapHttpAttributeRoutes();
            config.Filters.Add(new Himall.Web.Framework.ApiExceptionFilterAttribute());
            config.Formatters.Remove(config.Formatters.XmlFormatter);
            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{action}/{id}",
                defaults: new { Controller = "Test", Action = "Get", id = RouteParameter.Optional }
            );
        }

    }
}
