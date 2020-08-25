using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class backOffice_AdvertsSeasonal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void link_insertSeasonlAd_Click(object sender, EventArgs e)
        {
            lbl_errors.InnerText = "";

            //Inserts the image binary
            Stream imgstream = fl_insertAdvertisementImage.PostedFile.InputStream;
            int imgLen = fl_insertAdvertisementImage.PostedFile.ContentLength;
            byte[] imgBinaryData = new byte[imgLen];
            imgstream.Read(imgBinaryData, 0, imgLen);

            SqlCommand myCommand = Tools.SqlProcedure("usp_insertAdSeasonal");

            myCommand.Parameters.AddWithValue("@imagem", imgBinaryData);
            myCommand.Parameters.AddWithValue("@id_pub_sazonal", ddl_SeasonalTypes.SelectedValue);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_errors.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                }
                else
                {
                    rpt_SeasonalAdvertsBackoffice.DataBind();
                }

            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
                System.Diagnostics.Debug.WriteLine(lbl_errors.InnerText.ToString());
            }
            finally
            {
                Tools.myConn.Close();
            }
        }

        protected void rpt_SeasonalAdvertsBackoffice_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void rpt_SeasonalAdvertsBackoffice_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }
    }
}