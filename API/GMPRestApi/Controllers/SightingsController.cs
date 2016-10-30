using System;
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
                entities.SaveChanges();
            }
        }
        [HttpPost]
        public void Post([FromBody]Sighting sighting,int locationType)
        {
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            Models.Data.misper_ person = entities.misper_.Where(x => x.Unique_ID == sighting.UserID).FirstOrDefault();
            if (person == null)
            {
                throw new HttpException("Person not found");
            }
            else
            {
                var location = new Models.Data.Location();
                location.Unique_ID = person.Unique_ID;
                location.ContactNumber = sighting.ContactNumber;
                location.Latitude = sighting.Latitude;
                location.LocationTypeID = locationType;
                person.Locations.Add(location);
                entities.Locations.Add(location);
                entities.Locations.AddOrUpdate();
                entities.SaveChanges();
            }

        }
        public List<SightingDetails> Get(string uniqueID)
        {
            List<SightingDetails> sightings=new List<SightingDetails>();
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            var person = entities.misper_.Where(x => x.Unique_ID == uniqueID).FirstOrDefault();
            if (person != null)
            {
                foreach (var location in person.Locations)
                {
                  var locationType=entities.LocationTypes.Where(x=>x.ID==location.LocationTypeID).FirstOrDefault();
                    SightingDetails sighting =new SightingDetails();
                    sighting.Latitude = location.Latitude;
                    sighting.Longitude = location.Longitude;
                    sighting.UserID = location.Unique_ID;
                    sighting.ContactNumber = location.ContactNumber;
                    sighting.DateTime = location.SightingDate;
                    sighting.IsVerified = location.Verified == "Y";
                    sighting.LocationType = locationType.LocationType1;
                    sightings.Add(sighting);  
                }
            }
            return sightings;
        }
        }
}
