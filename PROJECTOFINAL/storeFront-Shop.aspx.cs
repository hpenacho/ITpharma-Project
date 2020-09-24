using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_Shop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["searchQuery"] != null)
            {
                searchProducts();
            }

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

                for(int i = 0; dr.Read(); i++)
                {
                    if (i < 8)
                    {
                        ((HtmlGenericControl)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl("adTitle" + i)).InnerText = dr["nome"].ToString();
                        ((HtmlAnchor)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl("A" + i)).HRef = "storeFront-itemPage.aspx?ref=" + dr["Codreferencia"].ToString();
                        ((HtmlGenericControl)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl("adPrice" + i)).InnerText = dr["preco"].ToString() + "€";
                        ((HtmlImage)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl("adImage" + i)).Src = "data:image;base64," + Convert.ToBase64String((byte[])dr["imagem"]);
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
  


        private void searchProducts()
        {
            sqlSearchProducts.SelectParameters["query"].DefaultValue = Session["searchQuery"].ToString(); ; 
            rptShopProducts.DataSourceID = sqlSearchProducts.ID;
            rptShopProducts.DataBind();
            Session["searchQuery"] = null;
        }


        //FILTERING PRODUCTS
        static string field = "Nome";
        static string order = "ASC";
        static string brand = "All";
        static string category = "All";

        protected void rptCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectCategory"))
            {
                category = e.CommandArgument.ToString();
                brand = "All";
                productFiltering();
               
            }
        }

        protected void rptBrands_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectBrand"))
            {
                brand = e.CommandArgument.ToString();
                category = "All";
                productFiltering();
                
            }
        }

        protected void ddl_filters_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddl_filters.SelectedValue)
            {
                case "NASC":
                    field = "Nome";
                    order = "ASC";
                    break;
                case "NDESC":
                    field = "Nome";
                    order = "DESC";
                    break;
                case "PASC":
                    field = "Preco";
                    order = "ASC";
                    break;
                case "PDESC":
                    field = "Preco";
                    order = "DESC";
                    break;
            }

            productFiltering();
        }

        private void productFiltering()
        {

            sqlShopProducts.SelectParameters["Campo"].DefaultValue = field;
            sqlShopProducts.SelectParameters["Ordem"].DefaultValue = order;
            sqlShopProducts.SelectParameters["Categoria"].DefaultValue = category;
            sqlShopProducts.SelectParameters["Marca"].DefaultValue = brand;

            rptShopProducts.DataSourceID = sqlShopProducts.ID;
            sqlShopProducts.DataBind();
            rptShopProducts.DataBind();
        }

      
    }
}