using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class backOffice_Stock : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rpt_infoStock_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;

                stockStatus( (Label)e.Item.FindControl("lbl_status"), Convert.ToInt32(dr["Qtd"]), Convert.ToInt32(dr["QtdMin"]), Convert.ToInt32(dr["QtdMax"]) );
            }

        }

        protected void rpt_infoStock_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            switch (e.CommandName)
            {
                case "link_updateStock": updateStock(e, "usp_updateStock", "txt_qty", "txt_qtymin", "txt_qtymax", false); 
                    break;
            }

            rpt_infoStock.DataBind();
        }

        private void updateStock(RepeaterCommandEventArgs e, string usp, string qty, string qtyMin, string qtyMax, bool pickup)
        {
            SqlCommand myCommand = Tools.SqlProcedure(usp);
            myCommand.Parameters.AddWithValue("@prodref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@Qtd",   Convert.ToInt32(((HtmlInputControl)e.Item.FindControl(qty)).Value));
            myCommand.Parameters.AddWithValue("@QtdMin", Convert.ToInt32(((HtmlInputControl)e.Item.FindControl(qtyMin)).Value));
            myCommand.Parameters.AddWithValue("@QtdMax", Convert.ToInt32(((HtmlInputControl)e.Item.FindControl(qtyMax)).Value));

            if(pickup)
            {
                myCommand.Parameters.AddWithValue("@pickupID", ddl_pickupstock.SelectedValue);
            }

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 200));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
                System.Diagnostics.Debug.WriteLine(myCommand.Parameters["@errorMessage"].Value.ToString());
            }
            finally
            {
                Tools.myConn.Close();
            }

        }


        private void stockStatus(Label control, int Qtd, int QtdMin, int QtdMax)
        {
            string graphic = "rounded-pill pl-3 pr-3 pt-1 pb-1 text-light";

            if (Qtd < 1)
            {
                control.Text = "Out&nbspof&nbspStock";
                control.CssClass = graphic + " bg-danger";
            }
            else if (Qtd <= QtdMin)
            {
                control.Text = "Low&nbspStock";
                control.CssClass = graphic + " bg-warning";
            }
            else if (Qtd > QtdMax)
            {
                control.Text = "Clear";
                control.CssClass = graphic + " bg-info";
            }
            else
            {
                control.Text = "Nominal";
                control.CssClass = graphic + " bg-success";
            }

        }


        // PICKUP STOCK

        protected void ddl_pickupstock_SelectedIndexChanged(object sender, EventArgs e)
        {
            sqlPickupStock.DataBind();
            rpt_pickupStock.DataBind();
        }

        protected void rpt_pickupStock_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;

                stockStatus((Label)e.Item.FindControl("lbl_PickupStatus"), Convert.ToInt32(dr["Qtd"]), Convert.ToInt32(dr["QtdMin"]), Convert.ToInt32(dr["QtdMax"]));
            }
        }

        protected void rpt_pickupStock_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "link_updatePickupStock": updateStock(e, "usp_alterPickupStock", "txt_PickupQty", "txt_PickupQtymin", "txt_PickupQtymax", true); 
                    break;
            }

            rpt_pickupStock.DataBind();
        }
    }
}