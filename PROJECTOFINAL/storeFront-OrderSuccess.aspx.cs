using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_OrderSuccess : System.Web.UI.Page
    {
        string orderNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Client.isLogged || Session["orderNumber"] == null)             
                Response.Redirect("storeFront-Index.aspx");

            if (Session["PickupID"] != null) //a pickup was chosen during checkout
            {
                string pickupExpiry = "";
                if (Session["pickupExpiry"] != null)
                {
                    pickupExpiry = Session["pickupExpiry"].ToString();
                    Session["pickupExpiry"] = null;
                }

                lbl_msgTypeOrder.InnerText = "The items you've purchased are ready for pick up at your chosen ATM, please retrieve them by " + pickupExpiry + " the latest.";
                lbl_qrInstructions.Visible = true;
                lbtn_emailQR.Visible = true;
            }          
            orderNumber = Session["orderNumber"].ToString();
            lbl_orderNumber.InnerText = orderNumber;                    

        }

        protected void lbtn_pdf_Click(object sender, EventArgs e)
        {
            Response.Redirect("\\Resources\\invoices\\" + Tools.EncryptString(orderNumber) + ".pdf");
        }

        protected void lbtn_emailQR_Click(object sender, EventArgs e)
        {

            string qrLink = "https://api.qrserver.com/v1/create-qr-code/?data=" + Request.QueryString["oID"].ToString() + "_" + Request.QueryString["cID"].ToString() +"-" + Request.QueryString["pID"].ToString();
            string eSubject = "Your QR code (Order #" + orderNumber + ")";
            string eBody = " <br>" + "<img src=\"" + qrLink + "\"/>" + "<br> <hr> <b>Instructions</b> <br> 1) This unique QR code can be used to receive your items at the ATM specified during checkout. <br/> 2) For your convenience, you may save this image to your device or print it, it must then be presented at the ATM's QR Scanner. <br/> 3) If you decide not to use the QR code, you will have to submit your Order Number, Username and Password for authentication. <br/> 4) You can request a copy of your QR code in this Order's Details Page, under your Personal User Area.";
            Tools.email(Client.email,eBody,eSubject);

           // Session["PickupID"] = Session["orderNumber"] = null;
            
        }
    }
}