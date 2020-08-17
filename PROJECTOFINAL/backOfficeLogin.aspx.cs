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
    public partial class backOfficeLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["lojaOnlineConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand();
            myCommand.Parameters.AddWithValue("@adminName", adminName.Value);
            myCommand.Parameters.AddWithValue("@pw", Tools.EncryptString(password.Value));

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "usp_loginAdmins";

            myCommand.Connection = myConn;

            try
            {
                myConn.Open();
                myCommand.ExecuteNonQuery();
                int resposta = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

                if (resposta == 0)
                {
                    lbl_mensagem.Text = "Password ou nome de admin invalido.";
                }


                else if (resposta == 1)
                {
                    Session["activeUser"] = userName.Value;
                    Session["AutenticadoAdmin"] = "sim";
                    Response.Redirect("indexBackOffice.aspx");
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