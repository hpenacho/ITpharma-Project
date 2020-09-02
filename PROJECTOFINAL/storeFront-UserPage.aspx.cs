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
    public partial class storeFront_UserPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void btn_alterPassword_Click(object sender, EventArgs e)
        {

            lbl_errorPassword.Text = "";

            //(@ID int, @oldPassword varchar(100), @newPassword varchar(100), @errorMessage varchar(200) output) AS
            SqlCommand myCommand = Tools.SqlProcedure("usp_clientAlterPassword");

            myCommand.Parameters.AddWithValue("@ID", Client.userID);
            myCommand.Parameters.AddWithValue("@oldPassword", txt_oldPassword.Value);
            myCommand.Parameters.AddWithValue("@newPassword", txt_newPassword.Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 200));

            
            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                lbl_errorPassword.Text = myCommand.Parameters["@errorMessage"].Value.ToString();
                txt_oldPassword.Value = "";
                txt_repeatPassword.Value = "";
                txt_newPassword.Value = "";

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

        protected void btn_alterarDetails_Click(object sender, EventArgs e)
        {





        }
    }
}