using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class TargetedAds : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            targetedSource();
        }

        private void targetedSource()
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_PersonalizedAds");

            myCommand.Parameters.AddWithValue("@ClienteID", Client.userID);
            myCommand.Parameters.AddWithValue("@Cookie", Request.Cookies["noLogID"] != null ? Request.Cookies["noLogID"].Value : "");

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                SqlDataReader dr = myCommand.ExecuteReader();

                for (int i = 0; dr.Read(); i++)
                {
                    if (i < 8)
                    {
                        ((HtmlGenericControl)this.TemplateControl.FindControl("adTitle" + i)).InnerText = dr["nome"].ToString();
                        ((HtmlAnchor)this.TemplateControl.FindControl("A" + i)).HRef = "storeFront-itemPage.aspx?ref=" + dr["Codreferencia"].ToString();
                        ((HtmlGenericControl)this.TemplateControl.FindControl("adPrice" + i)).InnerText = dr["preco"].ToString() + "€";
                        ((HtmlImage)this.TemplateControl.FindControl("adImage" + i)).Src = "data:image;base64," + Convert.ToBase64String((byte[])dr["imagem"]);
                    }
                }

            }
            catch (SqlException x)
            {
                System.Diagnostics.Debug.WriteLine(x.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }

        }
    }
}