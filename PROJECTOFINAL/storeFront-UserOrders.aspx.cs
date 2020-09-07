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
    public partial class storeFront_UserOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Client.isLogged)
            {
                Response.Redirect("storeFront-Index.aspx");
            }

            SqlDataSource1.SelectParameters["ID_cliente"].DefaultValue = Client.userID.ToString();


            SqlCommand myCommand = Tools.SqlProcedure("usp_returnStoreFrontUserOrderDetails");
            myCommand.Parameters.AddWithValue("@ID_cliente", Client.userID);
            myCommand.Parameters.AddWithValue("@Enc_reference", Request.QueryString["order"]);

            SqlDataReader reader = null;
            try
            {
                Tools.myConn.Open();
                reader = myCommand.ExecuteReader();

                if (reader.Read())
                {
                    
                    lbl_EncRef.Text = reader["Ref"].ToString();
                    lbl_orderDate.Text = reader["OrderDate"].ToString();
                    lbl_orderStatus.Text = reader["Status"].ToString();
                    lbl_customerName.Text = reader["clientName"].ToString();
                    lbl_email.Text = reader["email"].ToString();
                    lbl_address.Text = reader["Address"].ToString();
                    lbl_zip.Text = reader["zipCode"].ToString();
                    lbl_nif.Text = reader["nif"].ToString();
                    
                }
            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            catch (IndexOutOfRangeException x)
            {
                System.Diagnostics.Debug.WriteLine(x.Message);
                Response.Redirect("storeFront-UserPage.aspx");
            }
            finally
            {
                Tools.myConn.Close();
            } 


           
        }

        Decimal total = 0;
        protected void rpt_orderItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Decimal tax = 0;
            Decimal subTotal = 0;

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                total += Convert.ToDecimal(dr["itemTotalPrice"].ToString());
            }
            
            tax = Decimal.Multiply(total, 0.06m);
            subTotal = total - tax;

            lbl_subTotal.Text = Math.Round(subTotal, 2).ToString();
            lbl_tax.Text = Math.Round(tax, 2).ToString();
            lbl_Total.Text = total.ToString();

        }

    }
}