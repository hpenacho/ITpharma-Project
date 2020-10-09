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
               Response.Redirect("storeFront-Shop.aspx");

            if(!Page.IsPostBack)
                cartAmount.Text = "1";

            loadItem();
        }

        private void loadItem()
        {

            SqlCommand myCommand = Tools.SqlProcedure("usp_returnItemDetailPage");
            myCommand.Parameters.AddWithValue("@Reference", Request.QueryString["ref"].ToString());
            lbl_codRef.InnerHtml = "Reference Code: " + Request.QueryString["ref"].ToString();

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                SqlDataReader dr = myCommand.ExecuteReader();

                if (dr.Read())
                {
                    productImg.Src = "data:image;base64," + Convert.ToBase64String((byte[])dr["imagem"]);
                    txt_itemTitle.InnerText = dr["nome"].ToString();
                    control_itemPrice.InnerText = dr["preco"].ToString() + "€";
                    control_productCategory.InnerText = dr["Categoria"].ToString();
                    control_productBrand.InnerText = dr["Marca"].ToString();
                    control_description.Text = dr["descricao"].ToString();
                    txt_itemSummary.InnerText = dr["resumo"].ToString();
                    if((bool)dr["precisaReceita"])
                    {
                        link_addToCart.Text = "Prescription Item";
                        link_addToCart.CssClass = "btn btn-secondary";
                        link_addToCart.Enabled = false;
                        link_addToCart.ToolTip = "Prescription Items can only be purchased via your personal user page, under the Prescriptions section.";
                        panel_prescribed.Visible = true;
                        panel_overcounter.Visible = false;
                    }
                    else
                    {
                        panel_prescribed.Visible = false;
                        panel_overcounter.Visible = true;
                    }

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

        protected void link_addToCart_Click1(object sender, EventArgs e)
        {

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
                cartAmount.Text = "1";
                (this.Master as storeFrontMasterPage).updateHoverCart();
            }

        }

        protected void rpt_availability_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                if (((Label)e.Item.FindControl("lblStock")).Text == "Low Stock")
                    ((Label)e.Item.FindControl("lblStock")).CssClass = "badge badge-pill badge-warning";
                else if (((Label)e.Item.FindControl("lblStock")).Text == "Out of Stock")
                    ((Label)e.Item.FindControl("lblStock")).CssClass = "badge badge-pill badge-danger";
                else if (((Label)e.Item.FindControl("lblStock")).Text == "In Stock")
                    ((Label)e.Item.FindControl("lblStock")).CssClass = "badge badge-pill badge-success";
            }

        }
    }
}