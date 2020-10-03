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
            //lbl_chosenATM_title.InnerText = Session["ChosenATM_name"].ToString();

            //(this.Master as ATM_MasterPage).chooseTitle(Session["ChosenATM_name"].ToString());
            (this.Master as ATM_MasterPage).chooseTitle("CHOOSE SESSION LATER");
        }
    }
}