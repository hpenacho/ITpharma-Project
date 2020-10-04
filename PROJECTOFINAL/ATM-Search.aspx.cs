﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class ATM_Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["search"] == null)
                Response.Redirect("ATM-Front.aspx");

            sqlSearchSource.SelectParameters["PickupID"].DefaultValue = ATM.ID.ToString();
        }
    }
}