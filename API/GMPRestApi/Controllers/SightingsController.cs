﻿using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using GMPRestApi.Models;

namespace GMPRestApi.Controllers
{
    [System.Web.Mvc.RoutePrefix("api/Sightings")]
    public class SightingsController : ApiController
    {
        [HttpPost]
        public void Post([FromBody]Sighting sighting)
        {
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            Models.Data.misper_ person = entities.misper_.Where(x => x.Unique_ID == sighting.UserID).FirstOrDefault();
            if (person == null )
            {
                throw new HttpException("Person not found");
            }
            else
            {
                var socialMediaType = entities.LocationTypes.Where(x => x.LocationCode == "APSIG").FirstOrDefault();
                var location=new Models.Data.Location();
                location.Unique_ID = person.Unique_ID;
                location.ContactNumber = sighting.ContactNumber;
                location.Latitude = sighting.Latitude;
                location.LocationTypeID = socialMediaType.ID;
                person.Locations.Add(location);
                entities.Locations.Add(location);
                entities.Locations.AddOrUpdate();
                var phoneData=new Models.Data.PhoneData();
                location.PhoneDatas.Add(phoneData);
                phoneData.LocationID = location.ID;
                phoneData.DeviceID = sighting.DeviceID;
                person.Locations.Add(location);
            }
        }
    }
}
