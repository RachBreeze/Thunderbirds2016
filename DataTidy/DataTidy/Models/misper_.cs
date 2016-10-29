//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataTidy.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class misper_
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public misper_()
        {
            this.Misper_Extended = new HashSet<Misper_Extended>();
            this.Locations = new HashSet<Location>();
        }
    
        public string Unique_ID { get; set; }
        public string Surname { get; set; }
        public string Forenames { get; set; }
        public string Gender { get; set; }
        public string Birth_Year { get; set; }
        public string Status { get; set; }
        public string Status_Prior_To_Dormant { get; set; }
        public string Category { get; set; }
        public string Accomodation_Type { get; set; }
        public string Borough { get; set; }
        public string Output_Area { get; set; }
        public string Output_Area_CenX_EPSG27700 { get; set; }
        public string Output_Area_CenY_EPSG27700 { get; set; }
        public Nullable<System.DateTime> Date_Went_Missing { get; set; }
        public Nullable<System.DateTime> Date_Record_Created { get; set; }
        public Nullable<System.DateTime> Date_Record_Updated { get; set; }
        public Nullable<System.DateTime> Date_Last_Seen { get; set; }
        public Nullable<System.DateTime> Date_Status_Changed_To_Unconfi { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Misper_Extended> Misper_Extended { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Location> Locations { get; set; }
    }
}
