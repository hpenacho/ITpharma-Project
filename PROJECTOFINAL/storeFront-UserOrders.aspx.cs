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
            //nao esquecer redirects se houver tentativa forçada de acesso à pagina sem id_cliente ou ENC_REF fornecido
             //ptencialmente podem ficar no CATCH os redirects mediante excepçao

            SqlCommand myCommand = Tools.SqlProcedure("usp_returnStoreFrontUserOrderDetails");
            myCommand.Parameters.AddWithValue("@ID_cliente", Client.userID);
            myCommand.Parameters.AddWithValue("@Enc_reference", Request.QueryString["order"]);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));

            SqlDataReader reader = null;
            try
            {
                Tools.myConn.Open();
                reader = myCommand.ExecuteReader();

                if (reader.Read())
                {
                    Decimal total = Convert.ToDecimal(reader["orderTotal"].ToString());
                    Decimal tax = Decimal.Multiply(total, 0.06m);
                    Decimal subTotal = total - tax;
                    lbl_EncRef.Text = reader["Ref"].ToString();
                    lbl_orderDate.Text = reader["OrderDate"].ToString();
                    lbl_orderStatus.Text = reader["Status"].ToString();
                    lbl_customerName.Text = reader["clientName"].ToString();
                    lbl_address.Text = reader["Address"].ToString();
                    lbl_zip.Text = reader["zipCode"].ToString();
                    lbl_subTotal.Text = subTotal.ToString();
                    lbl_tax.Text = tax.ToString();
                    lbl_Total.Text = total.ToString();
                }
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
    }
}