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

            if (!Client.isLogged)
                Response.Redirect("storeFront-Index.aspx");
            else
                fillDetails();
        }

        protected void link_logout_Click(object sender, EventArgs e)
        {
            //ATENÇÃO PODE HAVER CONFLICTOS COM O CHECKOUT E A INFORMAÇÃO
            Client.resetClient();
            Response.Redirect("storeFront-Index.aspx");
        }

        public void fillDetails()
        {
            txt_altername.Value = Client.name;
            txt_alteremail.Value = Client.email;
            txt_alterAddress.Value = Client.address;
            txt_alternif.Value = Client.NIF;
            txt_zipCode.Value = Client.codPostal;
            welcomeUser.InnerText = "Welcome " + Client.name;
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
            string nome = txt_altername.Value;

            System.Diagnostics.Debug.WriteLine("String :" + nome);

            Client.name = txt_altername.Value;
            Client.email = txt_alteremail.Value;
            Client.address = txt_alterAddress.Value;
            Client.NIF = txt_alternif.Value;
            Client.codPostal = txt_zipCode.Value;

            System.Diagnostics.Debug.WriteLine("Variavel :" + Client.name);

            SqlCommand myCommand = Tools.SqlProcedure("usp_editClientDetails");
            myCommand.Parameters.AddWithValue("@ID", Client.userID);
            myCommand.Parameters.AddWithValue("@nome", Client.name);
            myCommand.Parameters.AddWithValue("@email", Client.email);
            myCommand.Parameters.AddWithValue("@morada", Client.address);
            myCommand.Parameters.AddWithValue("@nif", Client.NIF);
            myCommand.Parameters.AddWithValue("@codPostal", Client.codPostal);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
            }
            catch (Exception m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message.ToString());
            }
            finally
            {
                Tools.myConn.Close();
                fillDetails();
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

        protected void link_validatePrescription_Click(object sender, EventArgs e)
        {
            lbl_message.InnerText = "";

            if (Client.nrSaude.ToString() != healthNumber.Value)
                lbl_message.InnerText = "You can only validate prescriptions whose health number matches the health number supplied upon an ITpharma account creation.";

            else
            {

                SqlCommand myCommand = Tools.SqlProcedure("usp_validatePrescription");
                myCommand.Parameters.AddWithValue("@prescription_ref", prescriptionNumber.Value);
                myCommand.Parameters.AddWithValue("@healthNumber", healthNumber.Value);


                //OUTPUT - ERROR MESSAGES
                myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 200));

                try
                {
                    Tools.myConn.Open();
                    myCommand.ExecuteNonQuery();

                    lbl_message.InnerText = "Prescription items were added to your cart! Proceed to checkout to finalize your purchase.";
                }
                catch (SqlException m)
                {
                    System.Diagnostics.Debug.WriteLine(m.Message);
                    lbl_message.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                }
                finally
                {
                    Tools.myConn.Close();
                }

            }

        }

    
    }
}