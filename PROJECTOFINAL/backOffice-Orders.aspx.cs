using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class backOffice_Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rpt_parent_orders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                ((DropDownList)e.Item.FindControl("ddl_orderStatus")).SelectedValue = dr["id_estado"].ToString();

                string orderRef = ((HiddenField)e.Item.FindControl("hidden_Order_ID")).Value;
                Repeater childRepeater = (Repeater)e.Item.FindControl("rpt_child_orders");

                Tools.myConn.Open();
                DataSet ds = new DataSet();
                SqlDataAdapter sda = new SqlDataAdapter();

                SqlCommand myCommand = Tools.SqlProcedure("usp_returnBackofficeOrderProducts");
                myCommand.Parameters.AddWithValue("@ID", orderRef);

                sda.SelectCommand = myCommand;

                sda.Fill(ds);
                childRepeater.DataSource = ds;
                childRepeater.DataBind();

                Tools.myConn.Close();

            }
        }

        protected void rpt_parent_orders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName.ToString() == "link_updateOrder")
            {



            }





        }
    }
}