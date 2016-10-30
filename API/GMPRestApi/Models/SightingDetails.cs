using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;

namespace GMPRestApi.Models
{
    public class SightingDetails:Sighting
    {
        public        bool IsVerified { get; set; }
        public DateTime DateTime { get; set; }
        public string LocationType { get; set; }
    }
}