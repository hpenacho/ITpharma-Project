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

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {    
            
                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ITpharmaConnectionString"].ConnectionString);
                SqlCommand myCommand = new SqlCommand();
                myCommand.Parameters.AddWithValue("@adminName",inputUserName.Value );
                myCommand.Parameters.AddWithValue("@pw", inputPassword.Value);  //nao esquecer --> Tools.EncryptString(inputPassword.Value)

                myCommand.CommandType = CommandType.StoredProcedure;
                myCommand.CommandText = "usp_loginAdmins";

                myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));
                myCommand.Connection = myConn;

                try
                {
                    myConn.Open();
                    myCommand.ExecuteNonQuery();
                     
                    if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                    lbl_errorMessage.Text = myCommand.Parameters["@errorMessage"].Value.ToString();

                    else
                    {
                        Session["activeUser"] = inputUserName.Value;
                        Session["AdminAuthentication"] = "validAuth";
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
            }
            
        }
}