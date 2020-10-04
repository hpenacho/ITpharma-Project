using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class ATM_Front : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ATM.name != null)
                lbl_chosenATM_title.InnerText = ATM.name;
            else
                Response.Redirect("ATM-ChoicePickup.aspx");

        }

        protected void searchbutton_Click(object sender, EventArgs e)
        {
            Session["search"] = searchfield.Value;
            Response.Redirect("ATM-Search.aspx");
        }
    }
}