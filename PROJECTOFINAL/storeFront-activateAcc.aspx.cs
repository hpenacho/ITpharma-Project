using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_activateAcc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            string email = Tools.DecryptString(Request.QueryString["num"].ToString());
            SqlCommand myCommand = Tools.SqlProcedure("usp_activateAcc");
            myCommand.Parameters.AddWithValue("@email", email);


            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 200));
            try
                {
                    Tools.myConn.Open();
                    myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_message.ForeColor = Color.Red; lbl_message.Text = myCommand.Parameters["@errorMessage"].Value.ToString();
                }
                else
                {
                    lbl_message.ForeColor = Color.ForestGreen; lbl_message.Text = "Account Activated Successfully";
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