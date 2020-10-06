using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class ATM_ChoicePickup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtn_loadChosenATM_Click(object sender, EventArgs e)
        {
            int atmTunnelID = 0;

            SqlCommand myCommand = Tools.SqlProcedure("usp_getATMtunnelID");
            myCommand.Parameters.AddWithValue("@atmDesignation", ddl_ATMchoice.SelectedItem.Text);

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                    var reader = myCommand.ExecuteReader();

                    while (reader.Read())
                    {
                    atmTunnelID = (int)reader["atmTunnelID"];
                    }                
            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }

            //System.Diagnostics.Debug.WriteLine(atmTunnelID);
            if (atmTunnelID != 0)
            {
            ATM.setATM(Convert.ToInt32(ddl_ATMchoice.SelectedValue), ddl_ATMchoice.SelectedItem.Text, atmTunnelID);
            Response.Redirect("ATM-Front.aspx",false);
            }
        }
    }
}