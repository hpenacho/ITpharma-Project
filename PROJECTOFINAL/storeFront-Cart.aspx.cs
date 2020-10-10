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
    public partial class storeFront_Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loginCheck();

        }

  
        private void cleanCart()
        {
            if(rptModalCart.Items.Count < 1)
            {
                lbl_SubTotal.InnerText = "";
                lbl_tax.InnerText = "";
                lbl_Total.InnerText = "";
            }
        }

        private void loginCheck()
        {
            if (Client.isLogged)
                SqlSourceCart.SelectParameters["ID_cliente"].DefaultValue = Client.userID.ToString();
        }

        Decimal total = 0;
        int qtdTotal = 0;

        protected void rptModalCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Decimal tax = 0;
            Decimal subTotal = 0;

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                total += Convert.ToDecimal(dr["itemTotalPrice"].ToString());
                qtdTotal += int.Parse(dr["Qty"].ToString());
            }

            System.Diagnostics.Debug.WriteLine(qtdTotal);
            tax = Decimal.Multiply(total, 0.06m);
            subTotal = total - tax;

            lbl_SubTotal.InnerText = Math.Round(subTotal, 2).ToString() + " €";
            lbl_tax.InnerText = Math.Round(tax, 2).ToString() + " €";
            lbl_Total.InnerText = total.ToString() + " €";
            //Session variables for carrying totals to the checkout Page easily
            Session["qtdTotal"] = qtdTotal;
            Session["clientSubTotal"] = Math.Round(subTotal, 2).ToString();
            Session["Taxed"] = Math.Round(tax, 2).ToString();
            Session["finalTotal"] = total.ToString();
        }

        protected void rptModalCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            switch (e.CommandName)
            {
                case "linkDeleteCartItem":
                    deleteItemCart(e);
                    break;

                case "link_decreaseQty":
                    removeItemQty(e);
                    break;

                case "link_increaseQty":
                    addItemQty(e);
                    break;
            }


        }


        private void updateCart()
        {
            rptModalCart.DataBind();
        }


        private void deleteItemCart(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_DeleteSelectedCartItem");

            myCommand.Parameters.AddWithValue("@id_cliente", Client.userID);
            myCommand.Parameters.AddWithValue("@Prod_Ref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@Cookie", Request.Cookies["noLogID"].Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@warning", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
                System.Diagnostics.Debug.WriteLine(myCommand.Parameters["@warning"].Value.ToString());
            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
                updateCart();
                cleanCart();
            }
        }

        private void addItemQty(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_increaseCartQty");

            myCommand.Parameters.AddWithValue("@clientid", Client.userID == 0 ? (object)DBNull.Value : Client.userID);
            myCommand.Parameters.AddWithValue("@prodref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@cookie", Request.Cookies["noLogID"].Value);

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
                updateCart();
            }
        }


        private void removeItemQty(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_decreaseCartQty");

            myCommand.Parameters.AddWithValue("@clientid", Client.userID);
            myCommand.Parameters.AddWithValue("@prodref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@cookie", Request.Cookies["noLogID"].Value);

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
                updateCart();
            }
        }

        protected void link_clearCart_Click(object sender, EventArgs e)
        {

            SqlCommand myCommand = Tools.SqlProcedure("usp_clearCart");

            myCommand.Parameters.AddWithValue("@clientid", Client.userID);
            myCommand.Parameters.AddWithValue("@cookie", Request.Cookies["noLogID"].Value);

            try
            {
                Tools.myConn.Close();
                myCommand.ExecuteNonQuery();

            }
            catch (SqlException x)
            {
                System.Diagnostics.Debug.WriteLine(x.Message);
            }
            finally
            {
                Tools.myConn.Close();
                rptModalCart.DataBind();
            }



        }

        protected void link_clearPrescriptionItems_Click(object sender, EventArgs e)
        {

        }
    }
}