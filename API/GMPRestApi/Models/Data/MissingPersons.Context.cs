﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GMPRestApi.Models.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class GMPMissingPersonEntities : DbContext
    {
        public GMPMissingPersonEntities()
            : base("name=GMPMissingPersonEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<misper_> misper_ { get; set; }
        public virtual DbSet<Misper_Extended> Misper_Extended { get; set; }
        public virtual DbSet<Location> Locations { get; set; }
        public virtual DbSet<LocationType> LocationTypes { get; set; }
        public virtual DbSet<PhoneData> PhoneDatas { get; set; }
        public virtual DbSet<PeopleTag> PeopleTags { get; set; }
        public virtual DbSet<Tag> Tags { get; set; }
        public virtual DbSet<Tweet> Tweets { get; set; }
    
        public virtual ObjectResult<CalculateDistance_Result> CalculateDistance(Nullable<decimal> orig_lat, Nullable<decimal> orig_lng)
        {
            var orig_latParameter = orig_lat.HasValue ?
                new ObjectParameter("orig_lat", orig_lat) :
                new ObjectParameter("orig_lat", typeof(decimal));
    
            var orig_lngParameter = orig_lng.HasValue ?
                new ObjectParameter("orig_lng", orig_lng) :
                new ObjectParameter("orig_lng", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CalculateDistance_Result>("CalculateDistance", orig_latParameter, orig_lngParameter);
        }
    
        public virtual ObjectResult<CalculateDistanceFromCoord_Result> CalculateDistanceFromCoord(Nullable<decimal> orig_lat, Nullable<decimal> orig_lng)
        {
            var orig_latParameter = orig_lat.HasValue ?
                new ObjectParameter("orig_lat", orig_lat) :
                new ObjectParameter("orig_lat", typeof(decimal));
    
            var orig_lngParameter = orig_lng.HasValue ?
                new ObjectParameter("orig_lng", orig_lng) :
                new ObjectParameter("orig_lng", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CalculateDistanceFromCoord_Result>("CalculateDistanceFromCoord", orig_latParameter, orig_lngParameter);
        }
    
        public virtual ObjectResult<CalculateCoordDistance_Result> CalculateCoordDistance(Nullable<decimal> orig_lat, Nullable<decimal> orig_lng)
        {
            var orig_latParameter = orig_lat.HasValue ?
                new ObjectParameter("orig_lat", orig_lat) :
                new ObjectParameter("orig_lat", typeof(decimal));
    
            var orig_lngParameter = orig_lng.HasValue ?
                new ObjectParameter("orig_lng", orig_lng) :
                new ObjectParameter("orig_lng", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CalculateCoordDistance_Result>("CalculateCoordDistance", orig_latParameter, orig_lngParameter);
        }
    }
}
