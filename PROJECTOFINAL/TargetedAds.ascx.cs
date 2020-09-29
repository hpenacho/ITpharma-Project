using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class TargetedAds : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {



            sqlTargetedAds.SelectParameters["ClienteID"].DefaultValue = Client.userID == 0 ? "0" : Client.userID.ToString();
            sqlTargetedAds.SelectParameters["Cookie"].DefaultValue = Request.Cookies["noLogID"] == null ? "" : Request.Cookies["noLogID"].Value.ToString();

            sqlTargetedAds2.SelectParameters["ClienteID"].DefaultValue = Client.userID == 0 ? "0" : Client.userID.ToString();
            sqlTargetedAds2.SelectParameters["Cookie"].DefaultValue = Request.Cookies["noLogID"] == null ? "" : Request.Cookies["noLogID"].Value.ToString();
        }

    }
}