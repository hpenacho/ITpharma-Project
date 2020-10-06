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
    public partial class ATM_Purchase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlSourceCart.SelectParameters["id_cliente"].DefaultValue = ATM.anonTunnelID.ToString();
        }

        protected void rptATMCart_ItemCommand(object source, RepeaterCommandEventArgs e)
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

        //-----------------
        private void deleteItemCart(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_DeleteSelectedCartItem");

            myCommand.Parameters.AddWithValue("@id_cliente", ATM.anonTunnelID);
            myCommand.Parameters.AddWithValue("@Prod_Ref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@Cookie", (object)DBNull.Value);

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
            }
        }




        private void addItemQty(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_increaseCartQty");

            myCommand.Parameters.AddWithValue("@clientid", ATM.anonTunnelID);
            myCommand.Parameters.AddWithValue("@prodref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@cookie", (object)DBNull.Value);

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

            myCommand.Parameters.AddWithValue("@clientid", ATM.anonTunnelID);
            myCommand.Parameters.AddWithValue("@prodref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@cookie", (object)DBNull.Value);

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
        //-----------------------------

        Decimal total = 0;
        int qtdTotal = 0;
        protected void rptATMCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
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
        }

        public void updateCart()
        {
            rptATMCart.DataBind();
        }

        protected void lbtn_finalizeOrder_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_encomenda");
            myCommand.Parameters.AddWithValue("@IDcliente", ATM.anonTunnelID);
            myCommand.Parameters.AddWithValue("@MoradaEntrega", (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@Pickup", ATM.ID);
            myCommand.Parameters.AddWithValue("@zip_code", (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@receiver", (object)DBNull.Value);


            //OUTPUT - ORDER NUMBER
            myCommand.Parameters.Add(Tools.errorOutput("@orderNumber", SqlDbType.VarChar, 200));
            myCommand.Parameters.Add(Tools.errorOutput("@ERROR_MESSAGE", SqlDbType.VarChar, 200));
            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
                //---------------------------------------------------------
                System.Diagnostics.Debug.WriteLine(myCommand.Parameters["@ERROR_MESSAGE"].Value.ToString());

            }
            catch (Exception m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
                
            }
            Response.Redirect("ATM-OrderRetrieved.aspx");
        }
    }
}