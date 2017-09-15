﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Himall.API
{
    public class CartProductModel
    {
        public string CartItemId { get; set; }
        public string SkuId { get; set; }
        public string Id { get; set; }
        public string ImgUrl { get; set; }
        public string Name { get; set; }
        public string Price { get; set; }
        public string Count { get; set; }
        public string Size { get; set; }
        public string Color { get; set; }
        public string Version { get; set; }
        public string ShopId { get; set; }
        public string VShopId { get; set; }
        public string ShopName { get; set; }
        public string ShopLogo { get; set; }
        public string Url { get; set; }
        public int Status { get; set; }
    }
}
