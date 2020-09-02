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
    public partial class storeFront_Registry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_register_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_insertShopUser");

            myCommand.Parameters.AddWithValue("@nome", tb_name1.Value + " " + tb_name2.Value);
            myCommand.Parameters.AddWithValue("@email", tb_email.Value);
            myCommand.Parameters.AddWithValue("@password", Tools.EncryptString(tb_password.Value));
            myCommand.Parameters.AddWithValue("@morada", tb_address.Value);
            myCommand.Parameters.AddWithValue("@nif", tb_nif.Value);
            myCommand.Parameters.AddWithValue("@nrSaude", tb_healthNumber.Value);
            myCommand.Parameters.AddWithValue("@sexo", gender_male.Checked ? 'M' : 'F');
            myCommand.Parameters.AddWithValue("@dataNascimento", Convert.ToDateTime(tb_dateOfBirth.Value));

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_message.Text = myCommand.Parameters["@errorMessage"].Value.ToString();
                }

                else
                {
                    string subject = "ITpharma Account Activation";
                    string activationLink = "https://localhost:44391/activateAcc.aspx?num=" + Tools.EncryptString(tb_email.Value);
                    string body = "Thank you for creating an account on ITpharma, please click the link below to finalize your account activation. </br>" + activationLink;
                    Tools.email(tb_email.Value, body, subject);

                    lbl_message.Text = "Account created successfully, please check your email for further instructions.";
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
