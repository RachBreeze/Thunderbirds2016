using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Tweetinvi;
using Tweetinvi.Models;
using Tweetinvi.Parameters;

namespace GMPRestApi.Controllers
{
    [System.Web.Mvc.RoutePrefix("api/Twitter")]
    public class TwitterController : ApiController
    {
        public string Get(double latitude,
            double longitude,
            double distanceKM)
        {
            String consumerKey = "I9VmfLMWVDuYQYhfxfuYUG0YU"; // The application's consumer key
            String consumerSecret = "wJynbdgQ5PqqEXCcwIsHDy1bH7eHP4OJzsfqTvmt6g8mDxLrKq"; // The application's consumer secret
            String accessToken = "611965091-N6OJDeeIQ9lYbyLkjLZML23HlrzuzoMWyYSpwRXQ"; // The access token granted after OAuth authorization
            String accessTokenSecret = "GO8wnqElRIdvSUntnHQTgaldyrRLQCisPqKH4FGwGCtLT"; // The access token secret granted after OAuth authorization

            // Create a new set of credentials for the application.
            Auth.ApplicationCredentials = new TwitterCredentials(consumerKey, consumerSecret, accessToken, accessTokenSecret);
            //var appCredentials = new TwitterCredentials(consumerKey, consumerSecret);

            //// Init the authentication process and store the related `AuthenticationContext`.
            //var authenticationContext = AuthFlow.InitAuthentication(appCredentials);

            //// Go to the URL so that Twitter authenticates the user and gives him a PIN code.
            //Process.Start(authenticationContext.AuthorizationURL);

            //// Ask the user to enter the pin code given by Twitter
            //var pinCode = "0609543";

            //// With this pin code it is now possible to get the credentials back from Twitter
            //var userCredentials = AuthFlow.CreateCredentialsFromVerifierCode(pinCode, authenticationContext);


            //// Use the user credentials in your application
            //Auth.SetCredentials(userCredentials);

           // var searchParameter = new SearchTweetsParameters("tweetinvi")
           // {
           //     GeoCode = new GeoCode(latitude, longitude, distanceKM, DistanceMeasure.Kilometers),
           //     Lang = LanguageFilter.English,
           //     MaximumNumberOfResults = 100,
           //     Since=new DateTime(2016,10,25)
           // };
           //// searchParameter.SearchQuery = "from=@breezerachel";
            string query = "from:prosseras";
            query = HttpUtility.UrlEncode(query)+ "&geocode = " + latitude + "," + longitude + "," + distanceKM +
                           "km";
            var tweets = Search.SearchTweets(query);
            foreach (var tweet in tweets)
            {
                System.Diagnostics.Debugger.Break();
            }
            return "";
        }
    }
}
