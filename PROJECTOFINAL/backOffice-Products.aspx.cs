using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class backOffice_Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }





        protected void link_insertProduct_Click(object sender, EventArgs e)
        {

            lbl_errors.InnerText = "";

            //Inserts the image binary
            Stream imgstream = fl_insertProductImage.PostedFile.InputStream;
            int imgLen = fl_insertProductImage.PostedFile.ContentLength;
            byte[] imgBinaryData = new byte[imgLen];
            imgstream.Read(imgBinaryData, 0, imgLen);


            SqlCommand myCommand = Tools.SqlProcedure("usp_insertBackofficeProducts");

            myCommand.Parameters.AddWithValue("@Codreferencia", tb_reference.Value);
            myCommand.Parameters.AddWithValue("@nome", tb_name.Value);
            myCommand.Parameters.AddWithValue("@preco", tb_price.Value);
            myCommand.Parameters.AddWithValue("@resumo", tb_summary.Value);
            myCommand.Parameters.AddWithValue("@descricao", tb_description.Value);
            myCommand.Parameters.AddWithValue("@imagem", imgBinaryData);
            myCommand.Parameters.AddWithValue("@pdfFolheto", imgBinaryData); // alterar no futuro
            myCommand.Parameters.AddWithValue("@ID_Categoria", ddl_category.SelectedValue);
            myCommand.Parameters.AddWithValue("@ID_Marca", ddl_brand.SelectedValue);
            myCommand.Parameters.AddWithValue("@precisaReceita", check_prescription.Checked);
            myCommand.Parameters.AddWithValue("@ref_generico", check_generic.Checked ? ddl_genericParent.SelectedValue : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@Activo", check_active.Checked);
            myCommand.Parameters.AddWithValue("@Qtd", tb_qty.Value);
            myCommand.Parameters.AddWithValue("@QtdMin", tb_minQty.Value);
            myCommand.Parameters.AddWithValue("@QtdMax", tb_maxQty.Value);

            //OUTPUT - ERROR MESSAGES
            SqlParameter errorMessage = new SqlParameter();
            errorMessage.ParameterName = "@errorMessage";
            errorMessage.Direction = ParameterDirection.Output;
            errorMessage.SqlDbType = SqlDbType.VarChar;
            errorMessage.Size = 300;
            myCommand.Parameters.Add(errorMessage);

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_errors.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                }
                else
                {
                    rpt_produtosBackoffice.DataBind();
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


        }

        protected void rpt_produtosBackoffice_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {



        }

        protected void rpt_produtosBackoffice_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            if (e.CommandName.Equals("link_deleteProduct"))
            {
                deleteItem(e);
            }

            rpt_produtosBackoffice.DataBind();
        }


        private void deleteItem(RepeaterCommandEventArgs e)
        {

            SqlCommand myCommand = Tools.SqlProcedure("usp_updateBackofficeProducts");
            myCommand.Parameters.AddWithValue("@item", e.CommandArgument.ToString());

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
        }


    }
}