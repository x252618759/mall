using Himall.Core;
using Himall.IServices;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Himall.Web.Controllers
{
    public class PublicOperationController : Controller
    {
        // GET: PublicOperation
        [HttpPost]
        public ActionResult UploadPic()
        {
            string test = "";
            string path = "";
            string filename = "";
           // var maxRequestLength = 15360*1024;
            List<string> files = new List<string>();
            if (Request.Files.Count == 0) return Content("NoFile", "text/html");
            else
            {
                for (var i = 0; i < Request.Files.Count; i++)
                {
                    var file = Request.Files[i];
                    if (null == file || file.ContentLength <= 0) return Content("格式不正确！", "text/html");
                    //if(Request.ContentLength > maxRequestLength)
                    //{
                    //    return Content("文件大小超出限制！", "text/html");
                    //}
                    Random ra = new Random();
                    filename = DateTime.Now.ToString("yyyyMMddHHmmssffffff") + i
                        + Path.GetExtension(file.FileName);

                    string DirUrl = Server.MapPath("~/temp/");
                    if (!System.IO.Directory.Exists(DirUrl))      //检测文件夹是否存在，不存在则创建
                    {
                        System.IO.Directory.CreateDirectory(DirUrl);
                    }
                    path = AppDomain.CurrentDomain.BaseDirectory + "/temp/";
                    files.Add("/temp/" + filename);
                    try
                    {
                        file.SaveAs(Path.Combine(path, filename));
                    }
                    catch (Exception)
                    {

                    }
                }
            }
            return Content(string.Join(",", files), "text/html");
        }


        public ActionResult UploadPictures()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UploadFile()
        {
            string strResult = "NoFile";
            if (Request.Files.Count > 0)
            {
                var file = Request.Files[0];
                if (file.ContentLength == 0)
                {
                    strResult = "文件长度为0,格式异常。";
                }
                else
                {
                    Random ra = new Random();
                    string filename = DateTime.Now.ToString("yyyyMMddHHmmssfff") + ra.Next(1000, 9999) + file.FileName.Substring(file.FileName.LastIndexOf("\\") + 1);

                    string DirUrl = Server.MapPath("~/temp/");
                    if (!System.IO.Directory.Exists(DirUrl))      //检测文件夹是否存在，不存在则创建
                    {
                        System.IO.Directory.CreateDirectory(DirUrl);
                    }
                    string strfile = filename;
                    try
                    {
                        object opcount = Core.Cache.Get(CacheKeyCollection.UserImportOpCount);
                        if (opcount == null)
                        {
                            Core.Cache.Insert(CacheKeyCollection.UserImportOpCount, 1);
                        }
                        else
                        {
                            Core.Cache.Insert(CacheKeyCollection.UserImportOpCount, int.Parse(opcount.ToString()) + 1);
                        }
                        file.SaveAs(Path.Combine(DirUrl, filename));
                    }
                    catch (Exception e)
                    {
                        object opcount = Core.Cache.Get(CacheKeyCollection.UserImportOpCount);
                        if (opcount != null)
                        {
                            Core.Cache.Insert(CacheKeyCollection.UserImportOpCount, int.Parse(opcount.ToString()) - 1);
                        }
                        Core.Log.Error("商品导入上传文件异常：" + e.Message);
                        strfile = "Error";
                    }
                    strResult = strfile;
                }
            }
            return Content(strResult, "text/html");
        }


        public ActionResult TestCache()
        {
            string result = "无";
            if( Himall.Core.Cache.Get( "tt" ) == null )
            {
                result = "失效";
                Log.Info( "缓存已经失效" );
                Himall.Core.Cache.Insert( "tt" , "zhangsan" , 7000 );
            }

            return Json( result , JsonRequestBehavior.AllowGet );
        }
    }
}