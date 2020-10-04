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
    public partial class ATM_OrderPickup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtn_QRauth_Click(object sender, EventArgs e)
        {
            string orderNumber = "0"; string clientID = "0"; string pickupID = "0";
            try
            {
                string qrString = tb_decrypterInput.Value;
                System.Diagnostics.Debug.WriteLine(tb_decrypterInput.Value);
                 orderNumber = Tools.DecryptString(qrString.Substring(0, qrString.IndexOf("_")));
                 clientID = Tools.DecryptString(qrString.Substring(qrString.IndexOf("_") + 1, qrString.IndexOf("-") - qrString.IndexOf("_") - 1));
                 pickupID = Tools.DecryptString(qrString.Substring(qrString.IndexOf("-") + 1));

                System.Diagnostics.Debug.WriteLine(qrString);
                System.Diagnostics.Debug.WriteLine("order#: " + orderNumber);
                System.Diagnostics.Debug.WriteLine("clientID: " + clientID);
                System.Diagnostics.Debug.WriteLine("pickupID: " + pickupID);
            }
            catch (System.ArgumentOutOfRangeException ex)
            {
                lbl_messageQR.InnerText = "An invalid QR was submitted, please try again.";
                return;
            }

                SqlCommand myCommand = Tools.SqlProcedure("usp_qrOrderAuth_ATM");

                myCommand.Parameters.AddWithValue("@order_ref", orderNumber);
                myCommand.Parameters.AddWithValue("@clientID", clientID);
                myCommand.Parameters.AddWithValue("@pickupID", pickupID);

                //OUTPUT - ERROR MESSAGES
                myCommand.Parameters.Add(Tools.errorOutput("@ERROR_MESSAGE", SqlDbType.VarChar, 200));

                try
                {
                    Tools.myConn.Open();
                    myCommand.ExecuteNonQuery();

                    if (myCommand.Parameters["@ERROR_MESSAGE"].Value.ToString() != "")
                    {
                        lbl_messageQR.InnerText = myCommand.Parameters["@ERROR_MESSAGE"].Value.ToString();
                    }

                    else
                    {
                        Response.Redirect("ATM-OrderRetrieved.aspx");
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