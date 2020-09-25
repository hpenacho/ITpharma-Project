using Nemiro.OAuth;
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
    public partial class storeFront_SocialBridge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var result = OAuthWeb.VerifyAuthorization();

            if (result.IsSuccessfully)
            {
                var user = result.UserInfo;
                auth_success(user);

            }
        }
        private void auth_success(UserInfo user)
        {

            SqlCommand myCommand = Tools.SqlProcedure("usp_socialLogin");
            myCommand.Parameters.AddWithValue("@nome", user.UserName ?? "Customer");
            myCommand.Parameters.AddWithValue("@email", user.Email);
            myCommand.Parameters.AddWithValue("@token", Tools.EncryptString(user.UserId));
            myCommand.Parameters.AddWithValue("@cookie", Request.Cookies["noLogID"].Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                var reader = myCommand.ExecuteReader();
                
                if(reader.Read())
                {
                   Client.userID = (int)reader["ID"];
                   Client.name = reader["nome"].ToString();
                   Client.email = reader["email"].ToString();
                   Client.address = reader["morada"].ToString();
                   Client.codPostal = reader["codPostal"].ToString();
                   Client.NIF = reader["nif"].ToString();
                   Client.nrSaude = reader["nrSaude"].ToString();

                   if(reader["dataNascimento"].ToString() != "" && reader["dataNascimento"].ToString() != null)
                   Client.birthday = Convert.ToDateTime(reader["dataNascimento"].ToString());

                   if(reader["sexo"].ToString() != "" && reader["sexo"].ToString() != null)
                   Client.gender = Convert.ToChar(reader["sexo"].ToString());

                   Client.isLogged = true;
                   Client.social = true;
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

            Response.Redirect("storeFront-UserPage.aspx", false);

        }
    }
}