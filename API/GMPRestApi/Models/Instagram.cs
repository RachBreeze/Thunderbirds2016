using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Tweetinvi.Logic.DTO;

namespace GMPRestApi.Models
{
    public class Instagram
    {
        public string UserID { get; set; }
        public string ImageURL { get; set; }
        public DateTime DateTime { get; set; }
        public string InstagramName { get; set; }
        public string PostUrl { get; set; }
    }
}