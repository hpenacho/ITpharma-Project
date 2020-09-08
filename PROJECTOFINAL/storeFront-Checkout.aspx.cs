using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Client.isLogged)
                Response.Redirect("storeFront-Index.aspx");

            else
            {
                lbl_totQty.InnerText = Session["qtdTotal"].ToString();
                lbl_SubTotal.InnerText = Session["clientSubTotal"].ToString();
                lbl_Tax.InnerText = Session["Taxed"].ToString();
                lbl_finalTotal.InnerText = Session["finalTotal"].ToString();
            }
        }

        protected void rpt_compactCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void btn_finalizePurchase_Click(object sender, EventArgs e)
        {

        }
    }
}