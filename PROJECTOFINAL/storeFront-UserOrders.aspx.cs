using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_UserOrders : System.Web.UI.Page
    {
        string orderNumber;
        string pickupID;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Client.isLogged)
            {
                Response.Redirect("storeFront-Index.aspx",false);
            }

            SqlDataSource1.SelectParameters["ID_cliente"].DefaultValue = Client.userID.ToString();


            SqlCommand myCommand = Tools.SqlProcedure("usp_returnStoreFrontUserOrderDetails");
            myCommand.Parameters.AddWithValue("@ID_cliente", Client.userID);
            myCommand.Parameters.AddWithValue("@Enc_reference", Request.QueryString["order"]);

            SqlDataReader reader = null;
            try
            {
                Tools.myConn.Open();
                reader = myCommand.ExecuteReader();

                

                if (reader.Read())
                {
                    orderNumber = reader["Ref"].ToString();
                    lbl_EncRef.Text = orderNumber;
                    lbl_orderDate.Text = reader["OrderDate"].ToString();
                    lbl_orderStatus.Text = reader["Status"].ToString();
                    lbl_customerName.Text = reader["clientName"].ToString();
                    lbl_email.Text = reader["email"].ToString();
                    lbl_address.Text = reader["Address"].ToString();
                    lbl_zip.Text = reader["zipCode"].ToString();
                    lbl_nif.Text = reader["nif"].ToString();

                if (reader["pickupID"].ToString() != null && reader["pickupID"].ToString() != "")
                    {
                        pickupID = reader["pickupID"].ToString();
                        lbtn_qr.Visible = true;
                    }
                }
            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            catch (IndexOutOfRangeException x)
            {
                System.Diagnostics.Debug.WriteLine(x.Message);
                Response.Redirect("storeFront-UserPage.aspx",false);
            }
            finally
            {
                Tools.myConn.Close();
            } 
           
        }

        Decimal total = 0;
        protected void rpt_orderItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Decimal tax = 0;
            Decimal subTotal = 0;

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                total += Convert.ToDecimal(dr["itemTotalPrice"].ToString());
            }
            
            tax = Decimal.Multiply(total, 0.06m);
            subTotal = total - tax;

            lbl_subTotal.Text = Math.Round(subTotal, 2).ToString();
            lbl_tax.Text = Math.Round(tax, 2).ToString();
            lbl_Total.Text = total.ToString();

        }


        //string qrLink = "https://api.qrserver.com/v1/create-qr-code/?data=" + Request.QueryString["oID"].ToString() + "_" + Request.QueryString["cID"].ToString() + "_" + Request.QueryString["pID"].ToString();

        protected void lbtn_pdf_Click(object sender, EventArgs e)
        {            
            if (File.Exists(AppDomain.CurrentDomain.BaseDirectory + "\\Resources\\invoices\\" + Tools.EncryptString(Request.QueryString["order"]) + ".pdf"))
                Response.Redirect("\\Resources\\invoices\\" + Tools.EncryptString(Request.QueryString["order"]) + ".pdf",false);

            else if (lbtn_pdf.Enabled)
            {
                lbtn_pdf.CssClass = "btn btn-secondary";
                pdfText.InnerText = "PDF not available";
                lbtn_pdf.Enabled = false;
            }    
        }

        protected void lbtn_qr_Click(object sender, EventArgs e)
        {
            Response.Redirect("https://api.qrserver.com/v1/create-qr-code/?data=" + "Q" + orderNumber + "_" + Client.userID.ToString() + "-" + pickupID, false);            
        }
    }
}