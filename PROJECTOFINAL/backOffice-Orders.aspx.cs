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


        protected void rpt_parent_orders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName.ToString() == "link_updateOrder")
            {

                SqlCommand myCommand = Tools.SqlProcedure("usp_updateOrderStatus");
                myCommand.Parameters.AddWithValue("@IDEncomenda", e.CommandArgument.ToString());
                myCommand.Parameters.AddWithValue("@IDestado", ((DropDownList)e.Item.FindControl("ddl_orderStatus")).SelectedValue);

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
                    rpt_orders.DataBind();
                }


            }

            if(e.CommandName.ToString() == "link_orderDetails")
            {

                sqlSourceOrders.SelectParameters["EncRef"].DefaultValue = e.CommandArgument.ToString();
                sqlSourceOrders.DataBind();
                rpt_orders.DataBind();


                ScriptManager.RegisterStartupScript(this, GetType(), "Pop", "$('#order-contents').modal()", true);
            }

        }

        protected void rpt_orders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;

                ((DropDownList)e.Item.FindControl("ddl_orderStatus")).SelectedValue = dr["id_estado"].ToString();

                if (dr["ID_Pickup"] != DBNull.Value)
                {
                    for (int i = 1; i <= 4; i++)
                    {
                    ((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.Remove(((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.FindByValue(i.ToString()));
                    }
                    ((Label)e.Item.FindControl("lbl_orderType")).Text = "Pickup Retrieval";
                }

                else if (dr["ID_Pickup"] == DBNull.Value)
                {
                    ((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.Remove(((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.FindByValue("5"));
                    ((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.Remove(((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.FindByValue("6"));
                    ((Label)e.Item.FindControl("lbl_orderType")).Text = "Home Delivery";
                }

                if (dr["clientName"].ToString().Contains("ATM -"))
                {
                    ((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.Remove(((DropDownList)e.Item.FindControl("ddl_orderStatus")).Items.FindByValue("0"));
                    ((Label)e.Item.FindControl("lbl_orderType")).Text = "Local Purchase";
                }

            }

        }






    }
}