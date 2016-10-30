using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using GMPRestApi.Models;
using GMPRestApi.Models.Data;

namespace GMPRestApi.Controllers
{
    [System.Web.Mvc.RoutePrefix("api/Profiles")]
    public class ProfilesController : ApiController
    {
        // GET: Profiles
        // GET api/<controller>

        
        public List<Profile> Get(int startIndex, int endIndex)
        {
            return GetProfiles(startIndex, endIndex);
        }
        public List<Profile> Get()
        {
            return GetProfiles(1,500);
        }

        public List<Profile> Get(double latitude,
            double longitude,
            double distanceKM)
        {
            List<Profile> retProfiles = new List<Profile>();
            List<Profile> allProfiles = GetProfiles(0, 0);
            foreach (var profile in allProfiles)
            {
                if (IsInRange(profile, latitude, longitude, distanceKM))
                {
                    retProfiles.Add(profile);
                }
            }
            return retProfiles;
        }
        private List<Profile>GetProfiles(int startIndex, int endIndex)
        {
            List<Profile> retProfiles = new List<Profile>();
            bool defaultMan = false;
            int manCount = 0;
            int womanCount = 0;
            bool malePic = false;
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            foreach (var person in entities.misper_.Where(x => x.Misper_Extended.Count > 0 && x.ID>=startIndex && (x.ID<=endIndex || endIndex==0 )))
            {
                Profile profile = new Profile();
                Misper_Extended extended = person.Misper_Extended.FirstOrDefault();
                profile.LastSeen = person.Date_Went_Missing.Value;
                profile.Latitude = extended.Latitude.Value;
                profile.Longitude = extended.Longitude.Value;
                switch (person.Gender)
                {
                    case "F":
                        malePic = false;
                        break;
                    case "M":
                        malePic = true;
                        break;
                    default:
                        malePic = defaultMan;
                        defaultMan = !defaultMan;
                        break;
                }
                if (malePic)
                {
                    manCount += 1;
                    switch (manCount)
                    {
                        case 1:
                            profile.ProfileURL =
                                "http://static4.businessinsider.com/image/56c640526e97c625048b822a-480/donald-trump.jpg";
                            break;
                        case 2:
                            profile.ProfileURL =
                                "http://i2.cdn.turner.com/cnnnext/dam/assets/150827102252-donald-trump-july-10-2015-super-169.jpg";
                            break;
                        case 3:
                            profile.ProfileURL = "https://assets.donaldjtrump.com/site/about_body_img_1.jpg";
                            break;
                        default:
                            manCount = 0;
                            profile.ProfileURL =
                                "http://img.wonkette.com/wp-content/uploads/2016/08/nbc-fires-donald-trump-after-he-calls-mexicans-rapists-and-drug-runners.jpg";
                            break;
                    }
                }
                else
                {
                    womanCount += 1;
                    switch (womanCount)
                    {
                        case 1:
                            profile.ProfileURL =
                                "http://static4.businessinsider.com/image/55fad9869dd7cc15008bb1ba-480/hillary-clinton-thumbs-up.jpg";
                            break;
                        case 2:
                            profile.ProfileURL =
                                "http://twt-thumbs.washtimes.com/media/image/2015/12/08/DEM_2016_Clinton.JPEG-09fe7_c0-174-2166-1436_s885x516.jpg?9867f27f8024a954e67a9f6c533524dcb1e43d0d";
                            break;
                        case 3:
                            profile.ProfileURL = "https://mises.org/sites/default/files/23158392405_d3e3b60cb8_o.jpg";
                            break;
                        default:
                            profile.ProfileURL =
                                "http://jtf.org/wp-content/uploads/2015/08/hillary-clinton-laughing.jpg";
                            break;
                    }
                }
                profile.UserID = person.Unique_ID;
                if (!string.IsNullOrEmpty(person.Birth_Year))
                {
                    profile.Age = DateTime.Now.Year - int.Parse(person.Birth_Year);
                }
                profile.Forename = person.Forenames;
                profile.Surname = person.Surname;
                profile.IsDangerous = extended.Is_Dangerous == "Y";
                if (person.PeopleTags != null && person.PeopleTags.Count > 0)
                {
                    foreach (var tag in person.PeopleTags)
                    {
                        profile.Tags.Add(tag.Tag.TagName);
                    }
                }
                retProfiles.Add(profile);
            }

            return retProfiles;
        }

        private bool IsInRange(Profile profile,
            double latitude,
            double longitude,
            double distanceKM)
        {
            var lat1 = profile.Latitude;
            var lat2 = latitude;
            var lon1 = profile.Longitude;
            var lon2 = longitude;
            var R = 6371e3; // metres
            var φ1 = ToRadians(lat1);
            var φ2 = ToRadians(lat2);
            var Δφ = ToRadians(lat2 - lat1);
            var Δλ = ToRadians(lon2 - lon1);

            var a = Math.Sin(Δφ / 2) * Math.Sin(Δφ / 2) +
                    Math.Cos(φ1) * Math.Cos(φ2) *
                    Math.Sin(Δλ / 2) * Math.Sin(Δλ / 2);
            var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));

            var d = R * c;
            return d/1000 <= distanceKM;
        }
        private static double ToRadians(double val)
        {
            return (Math.PI / 180) * val;
        }
    }
}