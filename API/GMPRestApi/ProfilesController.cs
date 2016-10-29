using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.AccessControl;
using System.Web.Http;
using GMPRestApi.Models;

namespace GMPRestApi
{
    public class ProfilesController : ApiController
    {
        
        // GET api/<controller>
        public List<Profile> Get()
        {
            List<Profile> retProfiles =new List<Profile>();

            GMPRestApi.Models.GMPMissingPersonEntities entities = new GMPRestApi.Models.GMPMissingPersonEntities();
            foreach (var person in entities.misper_.Where(x=>x.Misper_Extended.Count>0))
            {
                Profile profile=new Profile();
                Misper_Extended extended = person.Misper_Extended.FirstOrDefault();
                profile.LastSeen = person.Date_Last_Seen.Value;
                profile.Latitude = extended.Latitude.Value;
                profile.Longtitude = extended.Longitude.Value;
                profile.ProfileURL = "tbd";
                profile.UserID = person.Unique_ID;
                retProfiles.Add(profile);
            }

            return retProfiles;
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}