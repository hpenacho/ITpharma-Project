using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class backOffice_AdvertsClient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void link_insertClientAd_Click(object sender, EventArgs e)
        {

            lbl_errors.InnerText = "";
                        
            SqlCommand myCommand = Tools.SqlProcedure("usp_insertAdClient");

            myCommand.Parameters.AddWithValue("@imagem", Tools.imageUpload(fl_insertAdvertisementImage));
            myCommand.Parameters.AddWithValue("@id_pub_cliente", ddl_ClientTypes.SelectedValue);

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
                    rpt_ClientAdvertsBackoffice.DataBind();
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

        protected void rpt_ClientAdvertsBackoffice_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "link_deleteAdvert": deleteItem(e); break;
                case "link_updateAdvert": updateItem(e); break;
            }

            rpt_ClientAdvertsBackoffice.DataBind();
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

        protected void rpt_ClientAdvertsBackoffice_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void link_insertClientCentricType_Click(object sender, EventArgs e)
        {

            lbl_errors2.InnerText = "";

            if (tb_typeName.Value == "")
            {
                lbl_errors2.InnerText = "A new type must have a name.";
                return;
            }
            if (Convert.ToDateTime(dateStart.Value) > Convert.ToDateTime(dateExpire.Value))
            {
                lbl_errors2.InnerText = "Expiration date must be chronologically after Start Date.";
                return;
            }

            SqlCommand myCommand = Tools.SqlProcedure("usp_insertClientAdType");

            myCommand.Parameters.AddWithValue("@Description", tb_typeName.Value);
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
                    ddl_ClientTypes.DataBind();
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

        protected void ddl_filterByType_TextChanged(object sender, EventArgs e)
        {
            if (ddl_filterByType.SelectedItem.Text == "Show All")
            {
                SqlSourceClientAds.SelectCommand = null;
                SqlSourceClientAds.SelectCommand = "SELECT Publicidade.ID, Publicidade.imagem, publicidade.ID_Pub_Cliente, Pub_Cliente.Descricao, Pub_Cliente.DataStart, Pub_Cliente.DataExpiracao from Publicidade inner join Pub_Cliente on Publicidade.ID_Pub_Cliente = Pub_Cliente.ID where Publicidade.Tipo = 0";
            }

            else
                SqlSourceClientAds.SelectCommand = SqlSourceClientAds.SelectCommand.ToString() + "AND Pub_Cliente.Descricao = '" + ddl_filterByType.SelectedItem.Text + "'";
        }
    }
}