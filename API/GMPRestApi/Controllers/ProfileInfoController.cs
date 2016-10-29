using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GMPRestApi.Models;

namespace GMPRestApi.Controllers
{
    [System.Web.Mvc.RoutePrefix("api/ProfileInfo")]
    public class ProfileInfoController : ApiController
    {
        public ProfileInfo GetProfileInfo()
        {
            ProfileInfo profileInfo = new ProfileInfo();
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            var person = entities.misper_.OrderBy(x => x.ID).Take(1);
            profileInfo.MinProfileID = person.FirstOrDefault().ID;

            person = entities.misper_.OrderByDescending(x => x.ID).Take(1);
            profileInfo.MaxProfileID = person.FirstOrDefault().ID;

            return profileInfo;
        }
    }
}
