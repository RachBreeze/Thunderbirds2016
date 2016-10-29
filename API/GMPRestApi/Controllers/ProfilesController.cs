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
        public List<Profile> Get()
        {
            List<Profile> retProfiles = new List<Profile>();

            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            foreach (var person in entities.misper_.Where(x => x.Misper_Extended.Count > 0))
            {
                Profile profile = new Profile();
                Misper_Extended extended = person.Misper_Extended.FirstOrDefault();
                profile.LastSeen = person.Date_Went_Missing.Value;
                profile.Latitude = extended.Latitude.Value;
                profile.Longtitude = extended.Longitude.Value;
                profile.ProfileURL = "tbd";
                profile.UserID = person.Unique_ID;
                if (!string.IsNullOrEmpty(person.Birth_Year))
                {
                    profile.Age = DateTime.Now.Year - int.Parse(person.Birth_Year);
                }
                profile.Forename = person.Forenames;
                profile.Surname = person.Surname;
                profile.IsDangerous = extended.Is_Dangerous == "Y";
                retProfiles.Add(profile);
            }

            return retProfiles;
        }


   }
}