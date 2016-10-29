using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Migrations;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DataTidy.Models;

namespace DataTidy
{
    public partial class DataTidyForm : Form
    {
        public DataTidyForm()
        {
            InitializeComponent();
        }

        private void LatLong_Click(object sender, EventArgs e)
        {
            int i = 0;
            int saveCount = 0;
            int total = 0;
            int personCount = 0;
            //https://code.google.com/archive/p/geocoordconversion/downloads
            DataTidy.Models.GMPMissingPersonEntities entities=new DataTidy.Models.GMPMissingPersonEntities();
            total = entities.misper_.Count();
            foreach (var person in entities.misper_)
            {
                personCount += 1;
                lblCount.Text = "Processing " + personCount + " of " + total;
                lblCount.Refresh();
                string xcoord = person.Output_Area_CenX_EPSG27700;
                int index;
                index= xcoord.IndexOf(".");
                if (index>0)
                { 
                    xcoord = xcoord.Substring(0,index);
                }
                string ycoord = person.Output_Area_CenY_EPSG27700;
                index = ycoord.IndexOf(".");
                if (index > 0)
                {
                    ycoord = ycoord.Substring(0, index);
                }
                long x = long.Parse(xcoord);
                long y = long.Parse(ycoord);
                var geo = new TDPG.GeoCoordConversion.GridReference(x,y);
                Misper_Extended extendedInfo;
                if (person.Misper_Extended == null  || person.Misper_Extended.Count==0)
                {
                    extendedInfo=new Misper_Extended();
                    extendedInfo.UniqueID = person.Unique_ID;
                    entities.Misper_Extended.Add(extendedInfo);
                }
                else
                {
                    extendedInfo = person.Misper_Extended.FirstOrDefault();
                }
                var latong = TDPG.GeoCoordConversion.GridReference.ChangeToPolarGeo(geo);
                extendedInfo.Latitude = latong.Lat;
                extendedInfo.Longitude = latong.Lon;
                extendedInfo.FacebookName = "";
                extendedInfo.InstagramName = "";
                extendedInfo.Is_Dangerous = "N";
                if (i == 3)
                {
                    i = 0;
                    extendedInfo.Is_Dangerous = "Y";
                }
                    extendedInfo.TwitterName = "";
                extendedInfo.image = null;
                entities.Misper_Extended.AddOrUpdate();
                i++;
            }
            entities.SaveChanges();
            MessageBox.Show("Completed");
        }

    }
}
