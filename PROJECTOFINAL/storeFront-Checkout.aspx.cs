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
                {
                    fillClientInfo();
                }
                
                lbl_expiryPickup.InnerText = DateTime.Now.AddDays(4).ToShortDateString(); ;

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

            SqlCommand myCommand = Tools.SqlProcedure("usp_encomenda");
            myCommand.Parameters.AddWithValue("@IDcliente", Client.userID);
            myCommand.Parameters.AddWithValue("@MoradaEntrega", address.Value);
            myCommand.Parameters.AddWithValue("@Pickup", DBNull.Value); //ddl_pickUp.SelectedValue
            //myCommand.Parameters.AddWithValue("@PDF", DBNull.Value);
            myCommand.Parameters.AddWithValue("@zip_code", zip.Value);
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

            string item = "";
            string price = "";
            string qty = "";
            string total = "";


            string localhost = WebConfigurationManager.AppSettings["localhost"];
            string pdfpath = AppDomain.CurrentDomain.BaseDirectory + WebConfigurationManager.AppSettings["pdfpath"];
            string pdfTemplate = pdfpath + "ITpharmaInvoice.pdf";
            string encryptedPDForder = Tools.EncryptString(myCommand.Parameters["@orderNumber"].Value.ToString()) + ".pdf";
            Session["orderNumber"] = Tools.EncryptString(myCommand.Parameters["@orderNumber"].Value.ToString());
            string newFile = pdfpath + "\\invoices\\" + encryptedPDForder;
            // string location = LocationZone.Items[LocationZone.SelectedIndex].Text;

            string finalDelivery="";
            System.Diagnostics.Debug.WriteLine(inpHide.Value);

            if (inpHide.Value == "Pickup")
            {
                finalDelivery = ddl_pickUp.SelectedItem.Text + Environment.NewLine + "Pick up by: " + DateTime.Now.AddDays(4).ToShortDateString();
            }
            else
            {
                finalDelivery = address.Value + " " + zip.Value;
            }

             

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
                total += ((HtmlGenericControl)rpt_compactCart.Items[i].FindControl("itemTotalPrice")).InnerText+ " €" + Environment.NewLine;
            }

            pdfformfields.SetField("item", item);
            pdfformfields.SetField("Qty", qty);
            pdfformfields.SetField("price", price);
            pdfformfields.SetField("totalitem", total);

            pdfstamper.Close();
            //Response.Redirect("\\Resources\\invoices\\" + encryptedPDForder);
            //---------------------------------------------------------
            Response.Redirect("storeFront-OrderSuccess.aspx",false); //tirar daqui qd se for tratar dos emails

        }

    }
}