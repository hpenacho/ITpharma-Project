using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Client.isLogged)
                Response.Redirect("storeFront-Index.aspx");

            else
            {

                SqlSmallCartDetails.SelectParameters["ID_cliente"].DefaultValue = Client.userID.ToString();

                lbl_totQty.InnerText = Session["qtdTotal"].ToString();
                lbl_SubTotal.InnerText = Session["clientSubTotal"].ToString();
                lbl_Tax.InnerText = Session["Taxed"].ToString();
                lbl_finalTotal.InnerText = Session["finalTotal"].ToString();

                SqlCommand myCommand = Tools.SqlProcedure("usp_ClientInfoToCheckout");
                myCommand.Parameters.AddWithValue("@id_cliente", Client.userID);
                SqlDataReader reader = null;
                try
                  {
                        Tools.myConn.Open();
                        myCommand.ExecuteNonQuery();
                        reader = myCommand.ExecuteReader();

                      if (reader.Read())
                      {

                        userName.Text = reader["Name"].ToString();
                        email.Text = reader["email"].ToString();
                        address.Text = reader["Address"].ToString();
                        zip.Value = reader["ZipCode"].ToString();

                      }
                      reader.Close();

                  }
                  catch (Exception m)
                  {
                    System.Diagnostics.Debug.WriteLine(m.Message);
                }
                  finally
                  {
                      Tools.myConn.Close();
                  } 

            }
        }

        protected void rpt_compactCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void btn_finalizePurchase_Click(object sender, EventArgs e)
        {
            string receiverFullName = firstName.Value + " " + lastName.Value;

            SqlCommand myCommand = Tools.SqlProcedure("usp_encomenda");
            myCommand.Parameters.AddWithValue("@IDcliente", Client.userID);
            myCommand.Parameters.AddWithValue("@MoradaEntrega", address.Text);
            myCommand.Parameters.AddWithValue("@Pickup", DBNull.Value); //ddl_pickUp.SelectedValue
            //myCommand.Parameters.AddWithValue("@PDF", DBNull.Value);
            myCommand.Parameters.AddWithValue("@zip_code", zip.Value);
            myCommand.Parameters.AddWithValue("@receiver", receiverFullName);


            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
                Response.Redirect("storeFront-OrderSuccess.aspx"); //tirar daqui qd se for tratar dos emails
            }
            catch (Exception m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }

            // API de pdf e envio de email
            
        }
    }
}