using System;
using System.Collections.Generic;
using System.Data.Entity.Core;
using System.Data.Entity.Migrations;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using GMPRestApi.Models.Data;
using Tweetinvi;
using Tweetinvi.Models;
using Tweetinvi.Parameters;

namespace GMPRestApi.Controllers
{
    [System.Web.Mvc.RoutePrefix("api/Twitter")]
    public class TwitterController : ApiController
    {
        public List<Models.Tweet> Get(string uniqueID)
        {
            List<Models.Tweet> retTweets = new List<Models.Tweet>();
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            var person = entities.misper_.Where(x => x.Unique_ID == uniqueID).FirstOrDefault();
            if (person != null)
            {
                var extended = person.Misper_Extended.Where(x=>!string.IsNullOrEmpty(x.TwitterName)).FirstOrDefault();
                if (extended != null)
                {
                    String consumerKey = "I9VmfLMWVDuYQYhfxfuYUG0YU"; // The application's consumer key
                    String consumerSecret = "wJynbdgQ5PqqEXCcwIsHDy1bH7eHP4OJzsfqTvmt6g8mDxLrKq";
                    // The application's consumer secret
                    String accessToken = "611965091-N6OJDeeIQ9lYbyLkjLZML23HlrzuzoMWyYSpwRXQ";
                    // The access token granted after OAuth authorization
                    String accessTokenSecret = "GO8wnqElRIdvSUntnHQTgaldyrRLQCisPqKH4FGwGCtLT";
                    // The access token secret granted after OAuth authorization

                    // Create a new set of credentials for the application.
                    Auth.ApplicationCredentials = new TwitterCredentials(consumerKey, consumerSecret, accessToken,
                        accessTokenSecret);
                    string since_id = "";
                    if (person.Tweets.Count > 0)
                    {
                        since_id =
                            person.Tweets.OrderByDescending(x => x.TweetDate)
                                .Take(1)
                                .FirstOrDefault()
                                .TweetID.ToString();
                    }
                        string query = HttpUtility.UrlEncode("from:" + extended.TwitterName);
                    if (!string.IsNullOrEmpty(since_id))
                    {
                        query += "&since_id" + since_id;
                    }
                    var tweets = Search.SearchTweets(query);
                    foreach (var tweet in tweets)
                    {
                       Models.Data.Tweet dataTweet=new Models.Data.Tweet();
                        dataTweet.TweetDate = tweet.CreatedAt;
                        dataTweet.TweetID =tweet.Id;
                        dataTweet.Unique_id = uniqueID;
                        person.Tweets.Add(dataTweet);
                        entities.Tweets.Add(dataTweet);
                        entities.Tweets.AddOrUpdate();
                    }
                    entities.SaveChanges();
                    foreach (var tweet in person.Tweets.OrderByDescending(x=>x.TweetDate))
                    {
                        Models.Tweet displayTweet = new Models.Tweet();
                        displayTweet.DateTime = tweet.TweetDate;
                        displayTweet.TweetId = tweet.TweetID;
                        displayTweet.UserID = tweet.Unique_id;
                        displayTweet.TwitterHandle = extended.TwitterName;
                        retTweets.Add(displayTweet);
                    }
                }
            }
            return retTweets;
        }
    }
}
