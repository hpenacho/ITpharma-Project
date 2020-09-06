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

            if (Client.isLogged)
            {
                fillDetails();
            }
            else
            {
                Response.Redirect("storeFront-Index.aspx");
            }



        }

        private void fillDetails()
        {
            txt_altername.Value = Client.name;
            txt_alteremail.Value = Client.email;
            txt_alteraddress.Value = Client.address;
            txt_alternif.Value = Client.NIF;
            sqlOrderSource.SelectParameters["ID"].DefaultValue = Client.userID.ToString();
        }


        protected void btn_alterPassword_Click(object sender, EventArgs e)
        {

            lbl_errorPassword.Text = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_clientAlterPassword");

            myCommand.Parameters.AddWithValue("@ID", Client.userID);
            myCommand.Parameters.AddWithValue("@oldPassword", Tools.EncryptString(txt_oldPassword.Value));
            myCommand.Parameters.AddWithValue("@newPassword", Tools.EncryptString(txt_newPassword.Value));

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
            lbl_changeDetailsError.Text = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_alterClientDetails");
            myCommand.Parameters.AddWithValue("@ID", Client.userID);
            myCommand.Parameters.AddWithValue("@nome", txt_altername.Value);
            myCommand.Parameters.AddWithValue("@email", txt_alteremail.Value);
            myCommand.Parameters.AddWithValue("@morada", txt_alteraddress.Value);
            myCommand.Parameters.AddWithValue("@nif", txt_alternif.Value);
            myCommand.Parameters.AddWithValue("@cod_postal", txt_zipCode.Value);


            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                var reader = myCommand.ExecuteReader();

                while (reader.Read())
                {
                    Client.name = reader["nome"].ToString();
                    Client.email = reader["email"].ToString();
                    Client.address = reader["morada"].ToString();
                    Client.NIF = reader["NIF"].ToString();

                    fillDetails();
                }

                lbl_changeDetailsError.Text = myCommand.Parameters["@output"].Value.ToString();

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


        protected void link_activeOrders_Click(object sender, EventArgs e)
        {
            sqlOrderSource.SelectParameters["estado"].DefaultValue = "0";
            rpt_orders.DataBind();
        }

        protected void link_pastOrders_Click(object sender, EventArgs e)
        {
            sqlOrderSource.SelectParameters["estado"].DefaultValue = "4";
            rpt_orders.DataBind();
        }
    }
}