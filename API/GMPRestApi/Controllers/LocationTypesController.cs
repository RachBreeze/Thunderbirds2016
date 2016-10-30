using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GMPRestApi.Models;

namespace GMPRestApi.Controllers
{
    [System.Web.Mvc.RoutePrefix("api/LocationTypes")]
    public class LocationTypesController : ApiController
    {
        public List<LocationType> Get()
        {
            List<LocationType> locationTypes = new List<LocationType>();
            GMPRestApi.Models.Data.GMPMissingPersonEntities entities = new GMPRestApi.Models.Data.GMPMissingPersonEntities();
            foreach (var locationType in entities.LocationTypes)
            {
                LocationType locationInfo = new LocationType();
                locationInfo.Id = locationType.ID;
                locationInfo.Name = locationType.LocationType1;
                locationTypes.Add(locationInfo);
            }
            return locationTypes;
        }
    }
}
