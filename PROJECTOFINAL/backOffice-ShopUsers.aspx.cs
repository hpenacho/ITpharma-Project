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
    public partial class backOffice_ShopUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void rpt_ShopUsersBackOffice_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void rpt_ShopUsersBackOffice_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {              
                case "link_updateShopUser": updateUser(e); break;
                //case "link_deleteShopUser": deleteItem(e); break;
            }
             rpt_ShopUsersBackOffice.DataBind();

        }
       
        private void updateUser(RepeaterCommandEventArgs e)
        {
            lbl_updateError.InnerText = "";

            SqlCommand myCommand = Tools.SqlProcedure("usp_updateShopUser");
            myCommand.Parameters.AddWithValue("@id", ((Label)e.Item.FindControl("lbl_ID")).Text);
            myCommand.Parameters.AddWithValue("@nome", ((TextBox)e.Item.FindControl("tb_updateName")).Text);
            myCommand.Parameters.AddWithValue("@email", ((TextBox)e.Item.FindControl("tb_updateEmail")).Text);
            myCommand.Parameters.AddWithValue("@active", ((CheckBox)e.Item.FindControl("check_userIsActive")).Checked);
            myCommand.Parameters.AddWithValue("@firstActivation", ((CheckBox)e.Item.FindControl("check_isFirstActivation")).Checked);

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@errorMessage", SqlDbType.VarChar, 300));

            try
            {
                Tools.myConn.Open();
                myCommand.ExecuteNonQuery();

                if (myCommand.Parameters["@errorMessage"].Value.ToString() != "")
                {            
                   lbl_updateError.InnerText = myCommand.Parameters["@errorMessage"].Value.ToString();                    
                }

                rpt_ShopUsersBackOffice.DataBind();

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
        protected void link_insertShopUser_Click(object sender, EventArgs e)
        {
            lbl_errors.InnerText = "";
            string pwTemp = Tools.EncryptString(tb_email.Value);
            SqlCommand myCommand = Tools.SqlProcedure("usp_insertShopUser");

            myCommand.Parameters.AddWithValue("@nome", tb_name.Value);
            myCommand.Parameters.AddWithValue("@email", tb_email.Value);
            myCommand.Parameters.AddWithValue("@password", Tools.EncryptString(pwTemp));
            myCommand.Parameters.AddWithValue("@morada", tb_address.Value);
            myCommand.Parameters.AddWithValue("@nif", tb_NIF.Value);
            myCommand.Parameters.AddWithValue("@nrSaude", tb_healthNumber.Value);
            myCommand.Parameters.AddWithValue("@sexo", rbtn_male.Checked ? 'M' : 'F');
            myCommand.Parameters.AddWithValue("@dataNascimento", Convert.ToDateTime(tb_dateofbirth.Value));

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
                    rpt_ShopUsersBackOffice.DataBind();
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
    }
}