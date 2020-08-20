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
                System.Diagnostics.Debug.WriteLine(lbl_errors.InnerText.ToString());
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
            switch (e.CommandName)
            {
                case "link_deleteProduct": deleteItem(e); break;
                case "link_updateProduct": updateItem(e); break;
            }

            rpt_produtosBackoffice.DataBind();
        }

        private void updateItem(RepeaterCommandEventArgs e)
        {

            //FILL MODAL
            SqlCommand myCommand = Tools.SqlProcedure("usp_listBackofficeProductDetails");
            Tools.myConn.Open();
            myCommand.Parameters.AddWithValue("@item", e.CommandArgument.ToString());
            var reader = myCommand.ExecuteReader();

            if (reader.Read())
            {
                tb_updateReference.Value = reader["Codreferencia"].ToString();
                tb_updateName.Value = reader["nome"].ToString();
                tb_updatePrice.Value = reader["preco"].ToString();
                tb_updateSummary.Value = reader["resumo"].ToString();
                tb_updateDescription.Value = reader["descricao"].ToString();
                ddl_updateCategory.SelectedValue = reader["ID_Categoria"].ToString();
                ddl_updateBrand.SelectedValue = reader["ID_Marca"].ToString();
                tb_updateCurQty.Value = reader["Qtd"].ToString();
                tb_updateMinQty.Value = reader["QtdMin"].ToString();
                tb_updateMaxQty.Value = reader["QtdMax"].ToString();

                //OPTIONS
                check_updatePrescription.Checked = Convert.ToBoolean(reader["precisaReceita"]);
                check_updateActive.Checked = Convert.ToBoolean(reader["Activo"]);


                if (reader["ref_generico"] == DBNull.Value)
                {
                    ddl_updateGenericParent.SelectedIndex = 0;
                }
                else
                {
                    ddl_updateGenericParent.SelectedValue = reader["ref_generico"].ToString();
                    check_updateGeneric.Checked = true;
                }
               
              

            }

            reader.Close();
            Tools.myConn.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "Pop", "$('#modal-update-product').modal()", true);
        }


        private void deleteItem(RepeaterCommandEventArgs e)
        {

            SqlCommand myCommand = Tools.SqlProcedure("usp_disableBackofficeProduct");
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

        protected void link_updateProductDetails_Click(object sender, EventArgs e)
        {
            lbl_updateErrors.InnerText = "";

            //Inserts the image binary
            Stream imgstream = fl_updateProductImage.PostedFile.InputStream;
            int imgLen = fl_updateProductImage.PostedFile.ContentLength;
            byte[] imgBinaryData = new byte[imgLen];
            imgstream.Read(imgBinaryData, 0, imgLen);

            SqlCommand myCommand = Tools.SqlProcedure("usp_updateBackofficeProducts");

            myCommand.Parameters.AddWithValue("@Codreferencia", tb_updateReference.Value);
            myCommand.Parameters.AddWithValue("@nome", tb_updateName.Value);
            myCommand.Parameters.AddWithValue("@preco", tb_updatePrice.Value);
            myCommand.Parameters.AddWithValue("@resumo", tb_updateSummary.Value);
            myCommand.Parameters.AddWithValue("@descricao", tb_updateDescription.Value);
            myCommand.Parameters.AddWithValue("@imagem", imgBinaryData);
            myCommand.Parameters.AddWithValue("@pdfFolheto", imgBinaryData); // alterar no futuro
            myCommand.Parameters.AddWithValue("@ID_Categoria", ddl_updateCategory.SelectedValue);
            myCommand.Parameters.AddWithValue("@ID_Marca", ddl_updateBrand.SelectedValue);
            myCommand.Parameters.AddWithValue("@precisaReceita", check_updatePrescription.Checked);
            myCommand.Parameters.AddWithValue("@ref_generico", check_updateGeneric.Checked ? ddl_genericParent.SelectedValue : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@Activo", check_updateActive.Checked);
            myCommand.Parameters.AddWithValue("@Qtd", tb_updateCurQty.Value);
            myCommand.Parameters.AddWithValue("@QtdMin", tb_updateMinQty.Value);
            myCommand.Parameters.AddWithValue("@QtdMax", tb_updateMaxQty.Value);

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
                      lbl_updateErrors.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                } 

                rpt_produtosBackoffice.DataBind();
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