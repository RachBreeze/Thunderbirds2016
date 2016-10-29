using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace GMPRestApi.Models
{
    public class Profile
    {
        public string UserID { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public DateTime LastSeen { get; set; }
        public string ProfileURL { get; set; }
        public string Forename { get; set; }
        public string Surname { get; set; }
        public int Age { get; set; }
        public bool IsDangerous { get; set; }
    }
}