using Himall.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Himall.Model
{
    public interface ISellerManager:IManager
    {
        long VShopId { get; set; }
        List<SellerPrivilege> SellerPrivileges { set; get; }
    }
}
