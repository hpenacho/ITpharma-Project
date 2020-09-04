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
    public partial class storeFrontMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            lbl_loginWarning.InnerText = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_clientLogin");
            myCommand.Parameters.AddWithValue("@email", txt_loginEmail.Value);
            myCommand.Parameters.AddWithValue("@password", Tools.EncryptString(txt_loginPassword.Value));

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 200));
        
            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if(myCommand.Parameters["@errorMessage"].Value.ToString() == "")
                {
                    var reader = myCommand.ExecuteReader();

                    while(reader.Read())
                    {
                        Client.userID = (int)reader["ID"];
                        Client.name = reader["nome"].ToString();
                        Client.email = reader["email"].ToString();
                        Client.address = reader["morada"].ToString();
                        Client.NIF = reader["NIF"].ToString();
                        Client.nrSaude = reader["nrSaude"].ToString();
                        Client.gender = Convert.ToChar(reader["sexo"]);
                        Client.birthday = (DateTime)reader["dataNascimento"];

                        Client.isLogged = true;
                    }

                    Response.Redirect("storeFront-UserPage.aspx");
                }
                else
                {
                    lbl_loginWarning.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
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

        protected void btn_recoverPassword_Click(object sender, EventArgs e)
        {
            Random random = new Random();
            string pass = Tools.EncryptString(random.Next(100000).ToString());
            string body = "A request for account recovery was recently made at ITpharma. <br> Please find your temporary account login details below, we strongly advise changing the password upon Login, for security reasons. <br> Temporary Password:  ";
            string subject = "ITpharma Account recovery";

            lbl_loginWarning.InnerText = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_recoverLoginPassword");
            myCommand.Parameters.AddWithValue("@email", txt_recoverPassword.Value);
            myCommand.Parameters.AddWithValue("@password", Tools.EncryptString(pass));

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() == "")
                {
                    Tools.email(txt_recoverPassword.Value, body + pass, subject);
                }
                else
                {
                    lbl_recoverWarning.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
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

