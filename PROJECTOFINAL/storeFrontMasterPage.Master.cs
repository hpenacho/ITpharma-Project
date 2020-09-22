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
    public partial class storeFrontMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            generateCookie();
            initiateRegistry();
            loginCheck();
            switchIcons();

        }

        protected void searchBox_TextChanged(object sender, EventArgs e)
        {
            Session["searchQuery"] = searchBox.Text;
            Response.Redirect("storeFront-Shop.aspx");
        }


        private void loginCheck()
        {
            if (Client.isLogged)
                SqlSourceCart.SelectParameters["ID_cliente"].DefaultValue = Client.userID.ToString();
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

        public void updateCart()
        {
            rptModalCart.DataBind();
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            lbl_loginWarning.InnerText = "";

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



        // CART

        protected void btn_checkout_Click(object sender, EventArgs e)
        {
            Response.Redirect("storeFront-Checkout.aspx");
        }

        Decimal total = 0;
        int qtdTotal = 0;

        protected void rptModalCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Decimal tax = 0;
            Decimal subTotal = 0;

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                total += Convert.ToDecimal(dr["itemTotalPrice"].ToString());
                qtdTotal += int.Parse(dr["Qty"].ToString());
            }

            System.Diagnostics.Debug.WriteLine(qtdTotal);
            tax = Decimal.Multiply(total, 0.06m);
            subTotal = total - tax;

            lbl_SubTotal.InnerText = Math.Round(subTotal, 2).ToString() + " €";
            lbl_tax.InnerText = Math.Round(tax, 2).ToString() + " €";
            lbl_Total.InnerText = total.ToString() + " €";
            //Session variables for carrying totals to the checkout Page easily
            Session["qtdTotal"] = qtdTotal;
            Session["clientSubTotal"] = Math.Round(subTotal, 2).ToString();
            Session["Taxed"] = Math.Round(tax, 2).ToString();
            Session["finalTotal"] = total.ToString();
        }

        protected void rptModalCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkDeleteCartItem"))
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
                    System.Diagnostics.Debug.WriteLine(myCommand.Parameters["@warning"].Value.ToString());
                }
                catch (SqlException m)
                {
                    System.Diagnostics.Debug.WriteLine(m.Message);
                }
                finally
                {
                    Tools.myConn.Close();
                    updateCart();
                }

            }
        }
    }
}

