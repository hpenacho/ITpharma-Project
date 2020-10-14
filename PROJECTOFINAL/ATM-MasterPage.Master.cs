using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Threading;

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
            atmCartPanel.Visible = (ATM.name != null);
        }

        protected void btn_newCustomer_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_resetATMcart");
            myCommand.Parameters.AddWithValue("@atmTunnelID", ATM.anonTunnelID);

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }

            Response.Redirect("ATM-Front.aspx", false);
        }
    }
}