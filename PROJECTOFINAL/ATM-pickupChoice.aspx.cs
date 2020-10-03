using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class ATM_pickupChoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtn_loadChosenATM_Click(object sender, EventArgs e)
        {
            Session["ChosenATM_id"] = ddl_ATMchoice.SelectedValue;
            Session["ChosenATM_name"]= ddl_ATMchoice.SelectedItem.Text;

            Response.Redirect("ATM-Front.aspx");
        }
    }
}