using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class ATM_MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            setHeaderName();
        }

        //Sets both the name and visibility of the cart panel once it loads
        private void setHeaderName()
        {
            atmTitle.InnerText = ATM.name ?? "ITPharma";
            atmCartPanel.Visible = (ATM.name != null);
        }


    }
}