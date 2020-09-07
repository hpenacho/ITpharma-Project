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
            myCommand.Parameters.AddWithValue("@Cookie", "1234"); //ATENÇÃO COLOCAR A COOKIE DEPOIS DO MERGE FEITO

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
            }
        }




     
    }
}