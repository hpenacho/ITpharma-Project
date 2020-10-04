using System;

namespace PROJECTOFINAL
{
    public partial class ATM_pickupChoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtn_loadChosenATM_Click(object sender, EventArgs e)
        {

            ATM.setATM(Convert.ToInt32(ddl_ATMchoice.SelectedValue), ddl_ATMchoice.SelectedItem.Text);

            Response.Redirect("ATM-Front.aspx");
        }
    }
}