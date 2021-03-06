﻿using Nemiro.OAuth;
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
            if(Client.userID != 0)
                sqlMiniCart.SelectParameters["id_cliente"].DefaultValue = Client.userID.ToString();

            generateCookie();
            initiateRegistry();
            switchIcons();
            updateHoverCart();
        }

        public void socialLoginError()
        {
            lbl_loginWarning.InnerText = "This account is inactive.";
        }

        protected void searchBox_TextChanged(object sender, EventArgs e)
        {
            Session["searchQuery"] = searchBox.Text;
            Response.Redirect("storeFront-Shop.aspx");
        }


        private void initiateRegistry()
        {
            if (Tools.registry == false)
            {
                Tools.initiateAuth();
                Tools.registry = true;
            }
        }


        protected void socialLogin(object sender, EventArgs e)
        {
            string provider = ((LinkButton)sender).Attributes["data-provider"];
            string returnUrl = new Uri(Request.Url, "storeFront-SocialBridge.aspx").AbsoluteUri;
            OAuthWeb.RedirectToAuthorization(provider, returnUrl);
        }


        private void generateCookie()
        {

            HttpCookie userCookie = Request.Cookies["noLogID"];
            Random random = new Random();

            if (userCookie == null)
            {
                userCookie = new HttpCookie("noLogID");
                userCookie.Value = random.Next(1000).ToString();
                Response.Cookies.Add(userCookie);
            }

        }


        protected void btn_login_Click(object sender, EventArgs e)
        {
            lbl_loginWarning.InnerText = "";

            if(txt_loginEmail.Value.Trim().Length < 1 || txt_loginPassword.Value.Trim().Length < 1)
            {
                lbl_loginWarning.InnerText = "Please fill all available fields";
                return;
            }

            SqlCommand myCommand = Tools.SqlProcedure("usp_clientLogin");
            myCommand.Parameters.AddWithValue("@email", txt_loginEmail.Value);
            myCommand.Parameters.AddWithValue("@password", Tools.EncryptString(txt_loginPassword.Value));
            myCommand.Parameters.AddWithValue("@cookie", Request.Cookies["noLogID"].Value);

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
                        Client.codPostal = reader["codPostal"].ToString();
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

        public void switchIcons()
        {
            userLogin.Visible = !Client.isLogged;
            userPage.Visible = Client.isLogged;
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
                    lbl_recoverWarning.InnerText = "You'll receive a recovery email soon.";
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

        protected void rpt_hoverCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "link_deleteFromHoverCart":
                    deleteItemCart(e);
                    break;
            }
        }


        decimal total;

        public void updateHoverCart()
        {
          
            rpt_hoverCart.DataBind();


            if (rpt_hoverCart.Items.Count < 1)
            {
                hoverCartTotal.Value = "";
            }

            total = 0;

        }

        public void updateSqlHoverCart()
        {
            sqlMiniCart.DataBind();
        }

        protected void rpt_hoverCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                DataRowView dr = (DataRowView)e.Item.DataItem;

                total += Convert.ToDecimal(dr["itemTotalPrice"].ToString());
               
            }

            hoverCartTotal.Value = total.ToString() + " €";
        }


        private void deleteItemCart(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_DeleteSelectedCartItem");

            myCommand.Parameters.AddWithValue("@id_cliente", Client.userID);
            myCommand.Parameters.AddWithValue("@Prod_Ref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@Cookie", Request.Cookies["noLogID"].Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@warning", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
                updateHoverCart();
            }
        }



    }
}

