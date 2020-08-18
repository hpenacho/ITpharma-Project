using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class backOffice_Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //comment do testaBranch 23

            //Qualquer coisa qualquer coisa lorem ipsum
        }

       /* protected void btn_login_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjectoFinalConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand();
            myCommand.Parameters.AddWithValue("@adminName", userName.Value);
            myCommand.Parameters.AddWithValue("@pw", Tools.EncryptString(password.Value));

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "usp_loginAdmins";
          
            myCommand.Connection = myConn;

            try
            {
                myConn.Open();
                myCommand.ExecuteNonQuery();
                string errorMessage = myCommand.Parameters["@OUTPUT"].ToString();

                if (errorMessage != null)
                    lbl_errorMessage.Text = errorMessage;

                else
                {
                    Session["activeUser"] = userName.Value;
                    Session["AdminAuthentication"] = "sim";
                    Response.Redirect("backOffice-Index.aspx");
                }

            }
            catch (Exception m)
            {
                Response.Write(m.Message);
            }
            finally
            {
                myConn.Close();
            }
            //----------------- 
        } */

    }
}