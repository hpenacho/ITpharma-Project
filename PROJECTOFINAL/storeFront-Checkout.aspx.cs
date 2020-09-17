using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Client.isLogged)
                Response.Redirect("storeFront-Index.aspx",false);

            else
            {
                SqlSmallCartDetails.SelectParameters["ID_cliente"].DefaultValue = Client.userID.ToString();

                lbl_totQty.InnerText = Session["qtdTotal"].ToString();
                lbl_SubTotal.InnerText = Session["clientSubTotal"].ToString();
                lbl_Tax.InnerText = Session["Taxed"].ToString();
                lbl_finalTotal.InnerText = Session["finalTotal"].ToString();

                if(!Page.IsPostBack)
                    fillClientInfo();
                
                Session["pickupExpiry"] = DateTime.Now.AddDays(4).ToShortDateString();
                lbl_expiryPickup.InnerText = DateTime.Now.AddDays(4).ToShortDateString();
            }
        }


        private void fillClientInfo()
        {
            userName.Text = Client.name;
            email.Text = Client.email;
            address.Value = Client.address;
            zip.Value = Client.codPostal;
        }

        protected void rpt_compactCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void btn_finalizePurchase_Click(object sender, EventArgs e)
        {

            string receiverFullName = firstName.Value + " " + lastName.Value;

            //------------This USP inserts the client's order into the database
            SqlCommand myCommand = Tools.SqlProcedure("usp_encomenda");
            myCommand.Parameters.AddWithValue("@IDcliente", Client.userID);
            myCommand.Parameters.AddWithValue("@MoradaEntrega", (inpHide.Value == "ClientAddress") ? address.Value : ddl_pickUp.SelectedItem.Text);
            myCommand.Parameters.AddWithValue("@Pickup", (inpHide.Value == "Pickup") ? ddl_pickUp.SelectedValue : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@zip_code", (inpHide.Value == "ClientAddress") ? zip.Value : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@receiver", receiverFullName);


            //OUTPUT - ORDER NUMBER
            myCommand.Parameters.Add(Tools.errorOutput("@orderNumber", SqlDbType.VarChar, 200));
            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
                //---------------------------------------------------------

            }
            catch (Exception m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }

            //-----------------------------------------
            //PDF generation starts here

            string item, price, qty, total;
            item = price = qty = total = string.Empty;

            string localhost = WebConfigurationManager.AppSettings["localhost"];
            string pdfpath = AppDomain.CurrentDomain.BaseDirectory + WebConfigurationManager.AppSettings["pdfpath"];
            string pdfTemplate = pdfpath + "ITpharmaInvoice.pdf";
            string encryptedPDForder = Tools.EncryptString(myCommand.Parameters["@orderNumber"].Value.ToString()) + ".pdf";
            string orderNumber = myCommand.Parameters["@orderNumber"].Value.ToString();
            Session["orderNumber"] = orderNumber;
            string newFile = pdfpath + "\\invoices\\" + encryptedPDForder;
            // string location = LocationZone.Items[LocationZone.SelectedIndex].Text;

            string finalDelivery = "";
            if (inpHide.Value == "Pickup")
            {
                finalDelivery = ddl_pickUp.SelectedItem.Text + Environment.NewLine + "Pick up by: " + DateTime.Now.AddDays(4).ToShortDateString();
                Session["PickupID"] = ddl_pickUp.SelectedValue;
            }
            else
                finalDelivery = address.Value + " " + zip.Value;

            PdfReader pdfreader = new PdfReader(pdfTemplate);
            PdfStamper pdfstamper = new PdfStamper(pdfreader, new FileStream(newFile, FileMode.Create));
            AcroFields pdfformfields = pdfstamper.AcroFields;

            pdfformfields.SetField("data", DateTime.Now.ToShortDateString());
            pdfformfields.SetField("invoicenr", myCommand.Parameters["@orderNumber"].Value.ToString());
            pdfformfields.SetField("name", Client.name);
            pdfformfields.SetField("address", finalDelivery);
            pdfformfields.SetField("subtotal", Session["clientSubTotal"].ToString() + " €");
            pdfformfields.SetField("tax", Session["Taxed"].ToString() + " €");
            pdfformfields.SetField("total", Session["finalTotal"].ToString() + " €");
            pdfformfields.SetField("NIF", Client.NIF);
            pdfformfields.SetField("paymentMethod", CreditCard.Checked ? "Credit Card" : "Debit Card");
            pdfformfields.SetField("cardNumber", ccNumber.Value);
            pdfformfields.SetField("cardOwner", ccName.Value);

            for (int i = 0; i < rpt_compactCart.Items.Count; i++)
            {
                item += ((HtmlGenericControl)rpt_compactCart.Items[i].FindControl("lbl_title")).InnerText + Environment.NewLine;
                price += ((HtmlGenericControl)rpt_compactCart.Items[i].FindControl("itemPrice")).InnerText + " €" + Environment.NewLine;
                qty += ((HtmlGenericControl)rpt_compactCart.Items[i].FindControl("lbl_itemQty")).InnerText + Environment.NewLine;
                total += ((HtmlGenericControl)rpt_compactCart.Items[i].FindControl("itemTotalPrice")).InnerText + " €" + Environment.NewLine;
            }

            pdfformfields.SetField("item", item);
            pdfformfields.SetField("Qty", qty);
            pdfformfields.SetField("price", price);
            pdfformfields.SetField("totalitem", total);

            pdfstamper.Close();
            //---------------------------------------------------------
            string e_subject = "Your order details (#" + orderNumber.ToString() + ")";
            string e_Body = "Thank you for your purchase! <br> You can find your order details on your personal user page, or on the PDF attached to this email. <br> Thank you for shopping at ITpharma!";
            string e_pdfPath = "\\Resources\\invoices\\" + encryptedPDForder;

            Tools.email(Client.email, e_Body, e_subject, e_pdfPath);
            //---------------------------------------------------------Email Enviado, abaixo é cleanup final

            Session["qtdTotal"] = Session["clientSubTotal"] = Session["Taxed"] = Session["finalTotal"] = null;

            //--------------------------------------------------------- E depois de limpas as variaveis de sessão, redirecionamos para a pagina OrderSuccess, que será ligeiramente diferente mediante ser ordem para casa ou pickup
            if (inpHide.Value == "Pickup")
             Response.Redirect("storeFront-OrderSuccess.aspx?oID=" + Tools.EncryptString(orderNumber) + "&cID=" + Tools.EncryptString(Client.userID.ToString()) + "&pID=" + Tools.EncryptString(ddl_pickUp.SelectedValue.ToString()), false);

            else
            {
                Response.Redirect("storeFront-OrderSuccess.aspx", false);
                Session["PickupID"] = null;
            }
               
        }

    }
}