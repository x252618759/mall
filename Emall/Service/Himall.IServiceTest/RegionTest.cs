using Himall.Model;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using System.IO;
using System.Threading;

namespace Himall.IServiceTest
{
    [TestClass]
    public class RegionTest
    {
        [TestMethod]
        public void JsonDataToObjectTest()
        {
             string regionString = string.Empty;
            using (FileStream fs = new FileStream(Core.Helper.IOHelper.GetMapPath("/Region.js"), FileMode.Open))
            {
                using (StreamReader streamReader = new StreamReader(fs))
                {
                    regionString = streamReader.ReadToEnd();
                }
            }
            regionString = regionString.Replace("var province = ", "").Replace("\r","").Replace("\n","");
            var provinces = Newtonsoft.Json.JsonConvert.DeserializeObject<IEnumerable<ProvinceMode>>(regionString);
        }

         [TestMethod]

        public void TestGetOrder()
        {
           
        }
    }
}
