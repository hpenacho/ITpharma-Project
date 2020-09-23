using System;
using System.Collections;
using System.Collections.Generic;
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

        private void bannerAds()
        {
            bool hasGender = false;
            if (Client.gender == 'M' || Client.gender == 'F')
                hasGender = true;

            SqlCommand myCommand = Tools.SqlProcedure("usp_getRelevantAds");

            myCommand.Parameters.AddWithValue("@clientGender", hasGender ? Client.gender : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@clientBirthday", Client.birthday == null ? (object)DBNull.Value : Convert.ToDateTime(Client.birthday));

            
            List<Advertisements> advertList = new List<Advertisements>();
            
            try
            {
                Tools.myConn.Open();
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
                Tools.myConn.Close();
            }

            imgSlotSeasonal.Src = advertList.Where(x => x.Description == )



        }
    
    
    
    }

    public class Advertisements
    {
        public byte[] binaryImg { get; set; }
        public string Description { get; set; }
        public bool type { get; set; }

    }
}