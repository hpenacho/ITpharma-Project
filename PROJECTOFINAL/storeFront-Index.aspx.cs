using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bannerAds();
        }

        //test comment
        private void bannerAds()
        {
            bool hasGender = false;

            if (Client.gender == 'M' || Client.gender == 'F')
                hasGender = true;

            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ITpharmaConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand();
        
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "usp_getRelevantAds";
            myCommand.Connection = myConn;

            myCommand.Parameters.AddWithValue("@clientGender", hasGender ? Client.gender : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@clientBirthday", Client.birthday == null ? (object)DBNull.Value : Convert.ToDateTime(Client.birthday));

            
            List<Advertisements> advertList = new List<Advertisements>();
            
            try
            {
                myConn.Open();
                myCommand.ExecuteNonQuery();

                var reader = myCommand.ExecuteReader();

                while (reader.Read())
                {
                    var ad = new Advertisements();

                    ad.binaryImg = (byte[])reader["imagem"];
                    ad.Description = reader["descricao"].ToString();
                    ad.type = (bool)reader["adType"];
                    advertList.Add(ad);
                    System.Diagnostics.Debug.WriteLine(ad.Description.ToString()) ;
                }

            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);

            }
            finally
            {
                myConn.Close();
            }

            Random random = new Random();

            List<Advertisements> seasonalAds = advertList.Where(x => x.type == true).ToList();
            imgSlotSeasonal.Src = "data:image;base64," + Convert.ToBase64String(seasonalAds[random.Next(0,seasonalAds.Count())].binaryImg);

            List<Advertisements> genderAds = advertList.Where(x => x.type == false && (x.Description.Equals("Male") || x.Description.Equals("Female"))).ToList();
            imgSlotGender.Src = "data:image;base64," + Convert.ToBase64String(genderAds[random.Next(0, genderAds.Count())].binaryImg);

            List<Advertisements> ageAds = advertList.Where(x => x.type == false).ToList();
            ageAds = ageAds.Except(genderAds).ToList();
            imgSlotAge.Src = "data:image;base64," + Convert.ToBase64String(ageAds[random.Next(0, ageAds.Count())].binaryImg);

        }
    
    
    
    }

    public class Advertisements
    {
        public byte[] binaryImg { get; set; }
        public string Description { get; set; }
        public bool type { get; set; }

    }
}