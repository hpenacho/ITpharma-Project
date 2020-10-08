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

                SqlCommand myCommand = Tools.SqlProcedure("usp_loginAdmins");

                myCommand.Parameters.AddWithValue("@adminName",inputUserName.Value );
                myCommand.Parameters.AddWithValue("@pw", Tools.EncryptString(inputPassword.Value));  //nao esquecer --> Tools.EncryptString(inputPassword.Value)
                myCommand.Parameters.Add(Tools.errorOutput("@OUTPUT", SqlDbType.VarChar, 300));

                try
                {
                    Tools.myConn.Open();
                    myCommand.ExecuteNonQuery();
                     
                    if (myCommand.Parameters["@OUTPUT"].Value.ToString() != "")
                    lbl_errorMessage.Text = myCommand.Parameters["@OUTPUT"].Value.ToString();

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
                    Tools.myConn.Close();
                }
                //----------------- 
            }
            
        }
}