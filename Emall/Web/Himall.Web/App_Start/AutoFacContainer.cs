using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using Autofac;
using Autofac.Integration.Mvc;
using Himall.Core;
using Autofac.Configuration;

namespace Himall.Web
{
    public class AutoFacContainer : IinjectContainer
    {
        private ContainerBuilder builder;
        private IContainer container;

        public AutoFacContainer()
        {
            builder = new ContainerBuilder();
            SetupResolveRules( builder );  //注入
            builder.RegisterControllers( Assembly.GetExecutingAssembly() );  //注入所有Controller
            container = builder.Build();
            DependencyResolver.SetResolver( new AutofacDependencyResolver( container ) );
        }

        public void RegisterType<T>()
        {
            builder.RegisterType<T>();
        }

        public T Resolve<T>()
        {
           //return AutofacDependencyResolver.Current.RequestLifetimeScope.Resolve<T>();
            return container.Resolve<T>();
        }

        private  void SetupResolveRules(ContainerBuilder builder)
        {
            var IServices = Assembly.Load("Himall.IServices");
            var Services = Assembly.Load("Himall.Service");
          //  builder.RegisterAssemblyTypes(Services, IServices).Where(t => t.Name.EndsWith("Service")).AsImplementedInterfaces().InstancePerRequest();
            builder.RegisterAssemblyTypes(Services, IServices).Where(t => t.Name.EndsWith("Service")).AsImplementedInterfaces();
            ConfigurationSettingsReader reader = new ConfigurationSettingsReader( "autofac" );
            builder.RegisterModule(reader);
        }
     
    }
}