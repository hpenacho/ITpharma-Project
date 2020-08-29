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
                case "link_updateStock": updateStock(e); break;
            }

            rpt_infoStock.DataBind();
        }

        private void updateStock(RepeaterCommandEventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_updateStock");
            myCommand.Parameters.AddWithValue("@prodref", e.CommandArgument.ToString());
            myCommand.Parameters.AddWithValue("@Qtd",   Convert.ToInt32(((HtmlInputControl)e.Item.FindControl("txt_qty")).Value));
            myCommand.Parameters.AddWithValue("@QtdMin", Convert.ToInt32(((HtmlInputControl)e.Item.FindControl("txt_qtyMin")).Value));
            myCommand.Parameters.AddWithValue("@QtdMax", Convert.ToInt32(((HtmlInputControl)e.Item.FindControl("txt_qtyMax")).Value));

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
            string graphic = "rounded-pill pl-3 pr-3 pt-1 pb-1";

            if (Qtd <= QtdMin)
            {
                control.Text = "Restock";
                control.CssClass = graphic + " bg-danger";
            }
            else if (Qtd > QtdMax)
            {
                control.Text = "Clear";
                control.CssClass = graphic + " bg-warning";
            }
            else
            {
                control.Text = "Nominal";
                control.CssClass = graphic + " bg-success";
            }

        }

       
    }
}