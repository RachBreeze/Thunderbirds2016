using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GMPRestApi.Models
{
    public class Tweet
    {
        public long TweetId { get; set; }
        public DateTime DateTime { get; set; }
        public string UserID { get; set; }
        public string TwitterHandle { get; set; }
    }
}