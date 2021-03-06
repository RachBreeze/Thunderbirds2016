//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Location
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Location()
        {
            this.PhoneDatas = new HashSet<PhoneData>();
        }
    
        public int ID { get; set; }
        public int LocationTypeID { get; set; }
        public string Unique_ID { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string ContactNumber { get; set; }
        public string Verified { get; set; }
        public System.DateTime SightingDate { get; set; }
    
        public virtual misper_ misper_ { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PhoneData> PhoneDatas { get; set; }
    }
}
