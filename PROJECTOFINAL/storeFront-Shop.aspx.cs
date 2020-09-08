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
    public partial class storeFront_Shop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["q"] != null)
            {
                searchProducts();
            }
        }


        private void searchProducts()
        {
            rptShopProducts.DataSourceID = sqlSearchProducts.ID;
            rptShopProducts.DataBind();
        }


        protected void rptShopProducts_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
          
        }

        protected void rptShopProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("link_addProduct"))
            {
                addItemCart(e);
            }
        }


        //ADDS A PRODUCT TO THE CART

        private void addItemCart(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_addProdToCart");

            myCommand.Parameters.AddWithValue("@ID", Client.isLogged ? Client.userID : (object) DBNull.Value);
            myCommand.Parameters.AddWithValue("@product", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@Cookie", Request.Cookies["noLogID"].Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "popupalert();", true); para activar um alerta de confirmação
                System.Diagnostics.Debug.WriteLine(myCommand.Parameters["@output"].Value.ToString());
            }
            catch (SqlException x)
            {
                System.Diagnostics.Debug.WriteLine(x.ToString());
            }
            finally
            {
                Tools.myConn.Close();
                (this.Master as storeFrontMasterPage).updateCart();
            }
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

            sqlShopProducts.DataBind();
            rptShopProducts.DataBind();
        }

      
    }
}