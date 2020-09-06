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
    public partial class storeFront_UserOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //nao esquecer redirects se houver tentativa forçada de acesso à pagina sem id_cliente ou ENC_REF fornecido
             //ptencialmente podem ficar no CATCH os redirects mediante excepçao

           /* SqlCommand myCommand = Tools.SqlProcedure("usp_returnStoreFrontUserOrderDetails");
            myCommand.Parameters.AddWithValue("@ID_cliente", Client.userID);
            //myCommand.Parameters.AddWithValue("@Enc_reference", // captar query string );

            //OUTPUT - ERROR MESSAGES
            myCommand.Parameters.Add(Tools.errorOutput("@output", SqlDbType.VarChar, 200));

            SqlDataReader reader = null;
            try
            {
                Tools.myConn.Open();
                reader = myCommand.ExecuteReader();

                if (reader.Read())
                {
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
           */
        }
    }
}