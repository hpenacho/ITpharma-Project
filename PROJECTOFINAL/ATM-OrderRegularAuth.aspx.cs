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
    public partial class ATM_OrderRegularAuth : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //teste


        }

        protected void btn_regularAuth_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_regularOrderAuth_ATM");

            myCommand.Parameters.AddWithValue("@order_ref", tb_OrderNumber.Value);
            myCommand.Parameters.AddWithValue("@email", tb_clientEmail.Value);
            myCommand.Parameters.AddWithValue("@pw", Tools.EncryptString(tb_password.Value));

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@ERROR_MESSAGE", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@ERROR_MESSAGE"].Value.ToString() != "")
                {
                    lbl_message.InnerText = myCommand.Parameters["@ERROR_MESSAGE"].Value.ToString();
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