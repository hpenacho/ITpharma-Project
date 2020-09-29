﻿using System;
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

            if (!Page.IsPostBack)
            {
                fillDetails();
                txt_bloodSchedule.Value = DateTime.Now.ToString("yyyy-MM-dd");
            }
               
            txt_oldPassword.ReadOnly = Client.social;
            txt_newPassword.ReadOnly = Client.social;
            txt_repeatPassword.ReadOnly = Client.social;

            noExam.Visible = rpt_exams.Items.Count > 0;
        }


        public static bool rptRow;


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
            txt_alterhealthnumber.Value = Client.nrSaude;
            txt_alterBirth.Value = Convert.ToDateTime(Client.birthday).ToString("dd/MM/yyyy");
            if (Client.birthday == null || Client.birthday.ToString() == "")
                {txt_alterBirth.Visible = false; txt_alterBirth2.Disabled = false; txt_alterBirth2.Visible = true;}
            if (Client.gender.ToString() == "M")
                gender_male.Checked = true;
            else if (Client.gender.ToString() == "F")
                gender_female.Checked = true;
            if (Client.nrSaude != null || Client.nrSaude.ToString() != "")
                txt_alterhealthnumber.Attributes.Add("readonly", "readonly");

            //UTILITY
            welcomeUser.InnerText = "Welcome " + Client.name;
            sqlOrderSource.SelectParameters["ID"].DefaultValue = Client.userID.ToString();
            sqlExams.SelectParameters["ClientID"].DefaultValue = Client.userID.ToString();
        }

        protected void btn_alterPassword_Click1(object sender, EventArgs e)
        {
            lbl_errorPassword.Text = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_clientAlterPassword");

            myCommand.Parameters.AddWithValue("@ID", Client.userID);
            myCommand.Parameters.AddWithValue("@oldPassword", Tools.EncryptString(txt_oldPassword.Text));
            myCommand.Parameters.AddWithValue("@newPassword", Tools.EncryptString(txt_newPassword.Text));

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                lbl_errorPassword.Text = myCommand.Parameters["@errorMessage"].Value.ToString();

                txt_oldPassword.Text = "";
                txt_repeatPassword.Text = "";
                txt_newPassword.Text = "";

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
            DateTime birthdate = Client.birthday.ToString() != "" ? Convert.ToDateTime(txt_alterBirth.Value) : Convert.ToDateTime(txt_alterBirth2.Value);
            char gender = ' ';
            if (gender_male.Checked)
                gender = 'M';
            else if (gender_female.Checked)
                gender = 'F';

            SqlCommand myCommand = Tools.SqlProcedure("usp_editClientDetails");
            myCommand.Parameters.AddWithValue("@ID", Client.userID);
            myCommand.Parameters.AddWithValue("@nome", txt_altername.Value);
            myCommand.Parameters.AddWithValue("@email", txt_alteremail.Value);
            myCommand.Parameters.AddWithValue("@morada", txt_alterAddress.Value);
            myCommand.Parameters.AddWithValue("@nif", txt_alternif.Value);
            myCommand.Parameters.AddWithValue("@healthNumber", txt_alterhealthnumber.Value);
            myCommand.Parameters.AddWithValue("@codPostal", txt_zipCode.Value);
            myCommand.Parameters.AddWithValue("@birthDate", birthdate);
            myCommand.Parameters.AddWithValue("@gender", !gender_male.Checked && !gender_female.Checked ? (object)DBNull.Value : gender );

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if(myCommand.Parameters["@output"].Value.ToString() != "")
                {
                    Client.name = txt_altername.Value;
                    Client.email = txt_alteremail.Value;
                    Client.address = txt_alterAddress.Value;
                    Client.NIF = txt_alternif.Value;
                    Client.nrSaude = txt_alterhealthnumber.Value;
                    Client.codPostal = txt_zipCode.Value;
                    Client.birthday = birthdate;
                    /* if (gender_male.Checked)
                         Client.gender = 'M';
                     else if (gender_female.Checked)
                         Client.gender = 'F'; */
                    if (gender != ' ')
                        Client.gender = gender;

                    welcomeUser.InnerText = "Welcome " + Client.name;
                    lbl_changeDetailsError.Text = "Your details were changed.";
                }
                else
                {
                    lbl_changeDetailsError.Text = myCommand.Parameters["@output"].Value.ToString();
                }

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

        protected void btn_scheduleBlood_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_scheduleExam");
            myCommand.Parameters.AddWithValue("ClientID", Client.userID);
            myCommand.Parameters.AddWithValue("DataPedido", txt_bloodSchedule.Value);
            myCommand.Parameters.AddWithValue("ParceiroID", ddl_bloodPartners.SelectedValue);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));


            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                lblExameWarning.InnerText = myCommand.Parameters["@output"].Value.ToString();

            }
            catch (SqlException s)
            {
                System.Diagnostics.Debug.WriteLine(s.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }


        }

       
    }
}