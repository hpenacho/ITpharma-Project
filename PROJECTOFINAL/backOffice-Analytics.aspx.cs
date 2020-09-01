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
    public partial class backOffice_Analytics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            SqlCommand myCommand = Tools.SqlProcedure("usp_gatherStatistics");

            try
            {
                Tools.myConn.Open();
                SqlDataAdapter MultipleQueries = new SqlDataAdapter(myCommand);
                DataRow dr;
                DataSet dataSet = new DataSet("QueriesArray");
                MultipleQueries.Fill(dataSet);

                ContentPlaceHolder Main = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                for (int i = 0; i < dataSet.Tables.Count ; i++)
                {                    
                    dr = dataSet.Tables[i].Rows[0];

                    if(((Label)Main.FindControl("lbl_stats" + i)) != null)
                    ((Label)Main.FindControl("lbl_stats" + i)).Text = dr[0].ToString();
          
                }
                
                dr = dataSet.Tables[19].Rows[0]; lbl_PopProdRef.Text = dr[0].ToString();
                dr = dataSet.Tables[19].Rows[0]; lbl_PopProdName.Text = dr[1].ToString();
                dr = dataSet.Tables[19].Rows[0]; img_popProd.ImageUrl = "data:image;base64," + Convert.ToBase64String((byte[])dr[2]);
                //----------
                dr = dataSet.Tables[20].Rows[0]; lbl_bsRef.Text = dr[0].ToString();
                dr = dataSet.Tables[20].Rows[0]; lbl_bsName.Text = dr[1].ToString();
                dr = dataSet.Tables[20].Rows[0]; img_bsProd.ImageUrl = "data:image;base64," + Convert.ToBase64String((byte[])dr[2]);
                dr = dataSet.Tables[20].Rows[0]; lbl_bsQty.Text = dr[3].ToString();
                //----------
                dr = dataSet.Tables[21].Rows[0]; lbl_newShopperName.Text = dr[0].ToString();
                dr = dataSet.Tables[21].Rows[0]; lbl_newShopperAge.Text = dr[1].ToString();



            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
            }
        }
    }
}