using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_ItemPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["ref"] == null)
            {
                Response.Redirect("storeFront-Shop.aspx");
            }

            if(!Page.IsPostBack)
                cartAmount.Text = "1";

            loadItem();
        }

        private void loadItem()
        {

            SqlCommand myCommand = Tools.SqlProcedure("usp_returnItemDetailPage");
            myCommand.Parameters.AddWithValue("@Reference", Request.QueryString["ref"].ToString());

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                SqlDataReader dr = myCommand.ExecuteReader();

                if (dr.Read())
                {

                    mainImage.ImageUrl = "data:image;base64," + Convert.ToBase64String((byte[])dr["imagem"]);
                    txt_itemTitle.InnerText = dr["nome"].ToString();
                    control_itemPrice.InnerText = dr["preco"].ToString() + "€";
                    control_productCategory.InnerText = dr["Categoria"].ToString();
                    control_productBrand.InnerText = dr["Marca"].ToString();
                    control_description.Text = dr["descricao"].ToString();
                    txt_itemSummary.InnerText = dr["resumo"].ToString();

                }

            }
            catch(SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }



        }

        protected void link_addToCart_Click(object sender, EventArgs e)
        {

        }

        protected void link_addToCart_Click1(object sender, EventArgs e)
        {

            System.Diagnostics.Debug.WriteLine(cartAmount.Text);

            SqlCommand myCommand = Tools.SqlProcedure("usp_addDetailItemProduct");
            myCommand.Parameters.AddWithValue("@ClientID", Client.userID == 0 ? (object)DBNull.Value : Client.userID);
            myCommand.Parameters.AddWithValue("@cookie", Request.Cookies["noLogID"].Value);
            myCommand.Parameters.AddWithValue("@reference", Request.QueryString["ref"].ToString());
            myCommand.Parameters.AddWithValue("@qty", Convert.ToInt32(cartAmount.Text));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
            }
            catch (SqlException v)
            {
                System.Diagnostics.Debug.WriteLine(v.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }

        }
    }
}