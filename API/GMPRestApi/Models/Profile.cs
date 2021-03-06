﻿using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace GMPRestApi.Models
{
    public class Profile
    {
        public Profile()
        {
            Tags=new StringCollection();
        }
        public string UserID { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public DateTime LastSeen { get; set; }
        public string ProfileURL { get; set; }
        public string Forename { get; set; }
        public string Surname { get; set; }
        public int Age { get; set; }
        public bool IsDangerous { get; set; }
        public StringCollection Tags { get; set; }
        public string Status { get; set; }
        public string FacebookID { get; set; }
        public string InstagramName { get; set; }
    }
}