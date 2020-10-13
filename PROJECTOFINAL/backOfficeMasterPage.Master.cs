using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class backOfficeMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           if (Session["AdminAuthentication"] == null)
                Response.Redirect("backOffice-Login.aspx");

            else
                lbl_activeUser.Text = Session["activeUser"].ToString();
        }

        protected void lbtn_logout_Click(object sender, EventArgs e)
        {
            Session["activeUser"] = null;
            Session["AdminAuthentication"] = null;
            Response.Redirect("backOffice-Login.aspx");
        }
    }
}