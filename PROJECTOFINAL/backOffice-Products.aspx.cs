using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Common.CommandTrees;
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


        private void updateBrandsCategories()
        {
            SQLcategory.DataBind();
            SQLbrand.DataBind();

            ddl_category.DataBind();
            ddl_brand.DataBind();
        }


        static byte[] uploadedFile;
        static byte[] updateUploadedFile;
        string updatedGen;

        protected void link_insertProduct_Click(object sender, EventArgs e)
        {

            lbl_errors.InnerText = "";

            if (tb_name.Value.Trim().Length < 1 || tb_reference.Value.Trim().Length < 1 || tb_summary.Value.Trim().Length < 1 || tb_price.Value.Trim().Length < 1)
            {
                lbl_errors.InnerText = "One or more fields are missing, please fill in all available fields.";
                return;
            }

            try{
                if (Convert.ToDecimal(tb_price.Value) < 0){ 
                    lbl_errors.InnerText = "Only positive numbers allowed.";
                    return;
                }
            }
            catch (Exception)
                {lbl_errors.InnerText = "Only positive numbers allowed."; return;}


            if (uploadedFile == null)
            {
                lbl_errors.InnerText = "Please upload an image before product insertion.";
                return;
            }

            SqlCommand myCommand = Tools.SqlProcedure("usp_insertBackofficeProducts");

            myCommand.Parameters.AddWithValue("@Codreferencia", tb_reference.Value);
            myCommand.Parameters.AddWithValue("@nome", tb_name.Value);
            myCommand.Parameters.AddWithValue("@preco", tb_price.Value);
            myCommand.Parameters.AddWithValue("@resumo", tb_summary.Value);
            myCommand.Parameters.AddWithValue("@descricao", ckeditorInsertProduct.Text);
            myCommand.Parameters.AddWithValue("@imagem", uploadedFile);
            myCommand.Parameters.AddWithValue("@ID_Categoria", ddl_category.SelectedValue);
            myCommand.Parameters.AddWithValue("@ID_Marca", ddl_brand.SelectedValue);
            myCommand.Parameters.AddWithValue("@precisaReceita", check_prescription.Checked);
            myCommand.Parameters.AddWithValue("@ref_generico", check_generic.Checked ? ddl_genericParent.SelectedValue : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@Activo", check_active.Checked);
            myCommand.Parameters.AddWithValue("@Qtd", tb_qty.Value);
            myCommand.Parameters.AddWithValue("@QtdMin", tb_minQty.Value);
            myCommand.Parameters.AddWithValue("@QtdMax", tb_maxQty.Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

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
                fl_insertProductImage.ClearAllFilesFromPersistedStore();
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }

        }


        protected void fl_insertProductImage_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            uploadedFile = null;
            uploadedFile = Tools.imageUpload(fl_insertProductImage);
        }

        protected void fl_updateProductImage_UploadedComplete(object sender, AsyncFileUploadEventArgs e)
        {
            updateUploadedFile = null;
            updateUploadedFile = Tools.imageUpload(fl_updateProductImage);
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
                ckeditorUpdateProduct.Text = reader["descricao"].ToString();
                ddl_updateCategory.SelectedValue = reader["ID_Categoria"].ToString();
                ddl_updateBrand.SelectedValue = reader["ID_Marca"].ToString();

                //OPTIONS
                check_updatePrescription.Checked = Convert.ToBoolean(reader["precisaReceita"]);
                check_updateActive.Checked = Convert.ToBoolean(reader["Activo"]);

                if (reader["ref_generico"] == DBNull.Value)
                {
                    ddl_updateGenericParent.SelectedIndex = 0;
                    check_updateGeneric.Checked = false;
                }
                else
                {
                    ddl_updateGenericParent.SelectedValue = reader["ref_generico"].ToString();
                    check_updateGeneric.Checked = true;
                }
            }

            reader.Close();
            Tools.myConn.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "Javascript", "javascript:openModal(); ", true);
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
                SQLrptArchived.DataBind();
            }
        }

        protected void link_updateProductDetails_Click(object sender, EventArgs e)
        {

            lbl_updateErrors.InnerText = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_updateBackofficeProducts");

            myCommand.Parameters.AddWithValue("@Codreferencia", tb_updateReference.Value);
            myCommand.Parameters.AddWithValue("@nome", tb_updateName.Value);
            myCommand.Parameters.AddWithValue("@preco", tb_updatePrice.Value);
            myCommand.Parameters.AddWithValue("@resumo", tb_updateSummary.Value);
            myCommand.Parameters.AddWithValue("@descricao", ckeditorUpdateProduct.Text);
            myCommand.Parameters.AddWithValue("@ID_Categoria", ddl_updateCategory.SelectedValue);
            myCommand.Parameters.AddWithValue("@ID_Marca", ddl_updateBrand.SelectedValue);
            myCommand.Parameters.AddWithValue("@precisaReceita", check_updatePrescription.Checked);
            myCommand.Parameters.AddWithValue("@ref_generico", check_updateGeneric.Checked ? ddl_updateGenericParent.SelectedValue : (object)DBNull.Value);
            myCommand.Parameters.AddWithValue("@Activo", check_updateActive.Checked);
            myCommand.Parameters.AddWithValue("@imagem", updateUploadedFile == null ? new byte[] { } : updateUploadedFile);


            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_updateErrors.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
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

            rpt_produtosBackoffice.DataBind();
        }

        protected void link_insertCategoryBrand(object sender, EventArgs e)
        {
            lbl_BrandMessage.InnerText = "";
            lbl_CategoryMessage.InnerText = "";
            
            SqlCommand myCommand = Tools.SqlProcedure(((LinkButton)sender).CommandArgument);
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            if (((LinkButton)sender).CommandName == "brand")
            {
                if(tb_insertBrand.Value.Trim() == "")
                {
                    lbl_BrandMessage.InnerText = "You need to write something";
                    return;
                }

                myCommand.Parameters.AddWithValue("@descricao", tb_insertBrand.Value);
            }
            else
            {

                if (tb_insertCategory.Value.Trim() == "")
                {
                    lbl_CategoryMessage.InnerText = "You need to write something";
                    return;
                }
                myCommand.Parameters.AddWithValue("@descricao", tb_insertCategory.Value);
            }
               


            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (((LinkButton)sender).CommandName == "brand")
                {
                    lbl_BrandMessage.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                    SQLbrand.DataBind();
                    ddl_allBrands.DataBind();
                    ddl_allBrands.SelectedIndex = 0;
                }
                else
                {
                    lbl_CategoryMessage.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                    SQLcategory.DataBind();
                    ddl_allCategories.DataBind();
                    ddl_allCategories.SelectedIndex = 0;
                }

            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
                updateBrandsCategories();
            }
        }


        //[ BRANDS ]

        protected void link_deleteBrand_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_deleteBrand");
            myCommand.Parameters.AddWithValue("@ID", ddl_allBrands.SelectedValue);

            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));
            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_BrandMessage.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                }
            }
            catch (SqlException m)
            {
                System.Diagnostics.Debug.WriteLine(m.Message);
            }
            finally
            {
                Tools.myConn.Close();
                ddl_allBrands.DataBind();
                ddl_allBrands.SelectedIndex = 0;
            }

        }

        protected void link_updateBrand_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_updateBrand");
            myCommand.Parameters.AddWithValue("@ID", ddl_allBrands.SelectedValue);
            myCommand.Parameters.AddWithValue("@descricao", tb_updateBrand.Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_BrandMessage.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                }

                tb_updateBrand.Value = "";
                ddl_allBrands.DataBind();
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

        //[ CATEGORIES ]

        protected void link_deleteCategory_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_deleteCategory");
            myCommand.Parameters.AddWithValue("@ID", ddl_allCategories.SelectedValue);

            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));
            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();
                ddl_allCategories.DataBind();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_CategoryMessage.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
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

        protected void link_updateCategory_Click(object sender, EventArgs e)
        {
            SqlCommand myCommand = Tools.SqlProcedure("usp_updateCategory");
            myCommand.Parameters.AddWithValue("@ID", ddl_allCategories.SelectedValue);
            myCommand.Parameters.AddWithValue("@descricao", tb_updateCategory.Value);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {
                    lbl_CategoryMessage.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();
                }

                tb_updateCategory.Value = "";
                ddl_allCategories.DataBind();
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