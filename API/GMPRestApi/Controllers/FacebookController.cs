using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GMPRestApi.Models;
using GMPRestApi.Models.Data;

namespace GMPRestApi.Controllers
{

    [System.Web.Mvc.RoutePrefix("api/Facebook")]
    public class FacebookController : ApiController
    {
        // GET: Profiles
        // GET api/<controller>

        private bool _defaultMan { get; set; }
        private int _manCount { get; set; }
        private int _womanCount { get; set; }

        public FacebookController()
        {
            _defaultMan = false;
            _manCount = 0;
            _womanCount = 0;
        }

        public List<Profile> Get()
        {
            List<Profile> retProfiles = new List<Profile>();
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            foreach (var extended in entities.Misper_Extended.Where(x=>!string.IsNullOrEmpty(x.FacebookName)))
            {
                Profile profile = ReadProfile(extended.misper_);
                retProfiles.Add(profile);

            }
            return retProfiles;
        }

        private Profile ReadProfile(misper_ person)
        {
            bool malePic = false;
            Profile profile = new Profile();
            Misper_Extended extended = person.Misper_Extended.FirstOrDefault();
            profile.LastSeen = person.Date_Went_Missing.Value;
            profile.Latitude = extended.Latitude.Value;
            profile.Longitude = extended.Longitude.Value;
            profile.UserID = person.Unique_ID;
            profile.ProfileURL = GetProfilePicURL(person.Gender);
            if (!string.IsNullOrEmpty(person.Birth_Year))
            {
                profile.Age = DateTime.Now.Year - int.Parse(person.Birth_Year);
            }
            profile.Forename = person.Forenames;
            profile.Surname = person.Surname;
            profile.IsDangerous = extended.Is_Dangerous == "Y";
            profile.FacebookID = extended.FacebookName;
            if (person.PeopleTags != null && person.PeopleTags.Count > 0)
            {
                foreach (var tag in person.PeopleTags)
                {
                    profile.Tags.Add(tag.Tag.TagName);
                }
            }
            profile.Status = person.Status;
            profile.Tags.Add(person.Category);
            return profile;
        }

        private string GetProfilePicURL(string gender)
        {
            bool malePic = false;
            switch (gender)
            {
                case "F":
                    malePic = false;
                    break;
                case "M":
                    malePic = true;
                    break;
                default:
                    malePic = _defaultMan;
                    _defaultMan = !_defaultMan;
                    break;
            }
            if (malePic)
            {
                _manCount += 1;
                switch (_manCount)
                {
                    case 1:
                        return
                            "http://static4.businessinsider.com/image/56c640526e97c625048b822a-480/donald-trump.jpg";
                    case 2:
                        return
                            "http://i2.cdn.turner.com/cnnnext/dam/assets/150827102252-donald-trump-july-10-2015-super-169.jpg";
                    case 3:
                        return "https://assets.donaldjtrump.com/site/about_body_img_1.jpg";
                    default:
                        _manCount = 0;
                        return
                            "http://img.wonkette.com/wp-content/uploads/2016/08/nbc-fires-donald-trump-after-he-calls-mexicans-rapists-and-drug-runners.jpg";
                }
            }
            _womanCount += 1;
            switch (_womanCount)
            {
                case 1:
                    return
                        "http://static4.businessinsider.com/image/55fad9869dd7cc15008bb1ba-480/hillary-clinton-thumbs-up.jpg";
                case 2:
                    return
                        "http://twt-thumbs.washtimes.com/media/image/2015/12/08/DEM_2016_Clinton.JPEG-09fe7_c0-174-2166-1436_s885x516.jpg?9867f27f8024a954e67a9f6c533524dcb1e43d0d";
                case 3:
                    return "https://mises.org/sites/default/files/23158392405_d3e3b60cb8_o.jpg";
                default:
                    _womanCount = 0;
                    return
                        "http://jtf.org/wp-content/uploads/2015/08/hillary-clinton-laughing.jpg";
            }
        }

    }
}
