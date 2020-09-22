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
        
            SqlCommand myCommand = Tools.SqlProcedure("usp_getRelevantAds");

            myCommand.Parameters.AddWithValue("@clientGender", Client.gender != 'M' || Client.gender != 'F' ? (object)DBNull.Value : Client.gender);
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
        }
    
    
    
    }

    public class Advertisements
    {
        public byte[] binaryImg { get; set; }
        public string Description { get; set; }

    }
}