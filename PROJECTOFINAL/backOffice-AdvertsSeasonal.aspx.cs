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

            SqlCommand myCommand = Tools.SqlProcedure("usp_insertAdSeasonal");

            myCommand.Parameters.AddWithValue("@imagem", Tools.imageUpload(fl_insertAdvertisementImage));
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

        protected void link_insertSeasonalType_Click(object sender, EventArgs e)
        {
            lbl_errors2.InnerText = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_insertSeasonalType");

            myCommand.Parameters.AddWithValue("@Description",tb_typeName.Value);
            myCommand.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(dateStart.Value));
            myCommand.Parameters.AddWithValue("@DateExpire", Convert.ToDateTime(dateExpire.Value));

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_errors2.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                }
                else
                {
                    ddl_SeasonalTypes.DataBind();
                }

            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
                System.Diagnostics.Debug.WriteLine(lbl_errors2.InnerText.ToString());
            }
            finally
            {
                Tools.myConn.Close();
            }
        }

        protected void rpt_SeasonalAdvertsBackoffice_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "link_deleteAdvert": deleteItem(e); break;
                case "link_updateAdvert": updateItem(e); break;
            }

            rpt_SeasonalAdvertsBackoffice.DataBind();
        }
        private void updateItem(RepeaterCommandEventArgs e)
        {
        }

        private void deleteItem(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_deleteAdvertisement");
            myCommand.Parameters.AddWithValue("@id_advert", e.CommandArgument.ToString());

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
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


        protected void rpt_SeasonalAdvertsBackoffice_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void ddl_filterByType_TextChanged(object sender, EventArgs e)
        {
            if (ddl_filterByType.SelectedItem.Text == "Show All")
            {
                SqlSourceSeasonAds.SelectCommand = null;
                SqlSourceSeasonAds.SelectCommand = "SELECT Publicidade.ID, Publicidade.imagem, publicidade.ID_Pub_Sazonal, Pub_Sazonal.Descricao,Pub_Sazonal.DataStart, Pub_Sazonal.DataExpiracao from Publicidade inner join Pub_Sazonal on Publicidade.ID_Pub_Sazonal = Pub_Sazonal.id where Publicidade.Tipo = 1";
            }                

            else
                SqlSourceSeasonAds.SelectCommand = SqlSourceSeasonAds.SelectCommand.ToString() + "AND Pub_Sazonal.Descricao = '" + ddl_filterByType.SelectedItem.Text + "'";
        }
    }
}