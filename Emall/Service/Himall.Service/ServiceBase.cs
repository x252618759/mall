
using System;

namespace Himall.Service
{
    public class ServiceBase
    {
        //protected Entities context = null;

        public ServiceBase()
        {
            //context = new Entities();
            //   Himall.Core.Log.Debug("S-"+this.GetType().ToString()+":"+DateTime.Now.ToString());
        }

        public void Dispose()
        {
            //if (context != null)
            //{
            //    //  Himall.Core.Log.Debug("E-" + this.GetType().ToString() + ":" + DateTime.Now.ToString());
            //    context.Dispose();
            //}
        }
    }
}
