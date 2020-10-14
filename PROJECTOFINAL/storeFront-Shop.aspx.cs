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
    public partial class storeFront_Shop : System.Web.UI.Page
    {
        //Number of Products on Display
        const int numberOfItems = 9;

        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (Session["searchQuery"] != null)
            {
                searchProducts();
                return;
            }

            if (!Page.IsPostBack)
            {
                sqlShopProducts.SelectParameters["Pagina"].DefaultValue = "1";
                sqlShopProducts.SelectParameters["Marca"].DefaultValue = "All";
                sqlShopProducts.SelectParameters["Categoria"].DefaultValue = "All";
            }

            productFiltering();
            generatePaging();
        }

        private void searchProducts()
        {
            sqlSearchProducts.SelectParameters["query"].DefaultValue = Session["searchQuery"].ToString(); ; 
            rptShopProducts.DataSourceID = sqlSearchProducts.ID;
            rptShopProducts.DataBind();
            Session["searchQuery"] = null;
        }

        protected void rptCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectCategory"))
            {
                sqlShopProducts.SelectParameters["Categoria"].DefaultValue = e.CommandArgument.ToString();
                sqlShopProducts.SelectParameters["Marca"].DefaultValue = "All";
                sqlShopProducts.SelectParameters["Pagina"].DefaultValue = "1";
                productFiltering();
            }
        }

        protected void rptBrands_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectBrand"))
            {
                sqlShopProducts.SelectParameters["Marca"].DefaultValue = e.CommandArgument.ToString();
                sqlShopProducts.SelectParameters["Categoria"].DefaultValue = "All";
                sqlShopProducts.SelectParameters["Pagina"].DefaultValue = "1";
                productFiltering();
            }
        }

        protected void ddl_filters_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddl_filters.SelectedValue)
            {
                case "NASC":
                    sqlShopProducts.SelectParameters["Campo"].DefaultValue = "Nome";
                    sqlShopProducts.SelectParameters["Ordem"].DefaultValue = "ASC";
                    break;
                case "NDESC":
                    sqlShopProducts.SelectParameters["Campo"].DefaultValue = "Nome";
                    sqlShopProducts.SelectParameters["Ordem"].DefaultValue = "DESC";
                    break;
                case "PASC":
                    sqlShopProducts.SelectParameters["Campo"].DefaultValue = "Preco";
                    sqlShopProducts.SelectParameters["Ordem"].DefaultValue = "ASC";
                    break;
                case "PDESC":
                    sqlShopProducts.SelectParameters["Campo"].DefaultValue = "Preco";
                    sqlShopProducts.SelectParameters["Ordem"].DefaultValue = "DESC";
                    break;
            }

            rptShopProducts.DataBind();
        }

        private void productFiltering()
        {
            generatePaging();

            sqlShopProducts.SelectParameters["ItemsPagina"].DefaultValue = numberOfItems.ToString();
            rptShopProducts.DataSourceID = sqlShopProducts.ID;

            sqlShopProducts.DataBind();
            rptShopProducts.DataBind();
        }


        // PAGINATION
        private void generatePaging()
        {
            int totalItems = 1;

            DataView dv = (DataView)sqlShopProducts.Select(new DataSourceSelectArguments());
            DataTable groupsTable = dv.ToTable();
            
            foreach (DataRow dr in groupsTable.Rows)
            {
                totalItems = Convert.ToInt32(dr[0].ToString());
                break;
            }

            pageButtonTemplate( (int) Math.Ceiling( (double) totalItems / (double) numberOfItems));
        }

        private void pageButtonTemplate(int nrPages)
        {
            pagePanel.Controls.Clear();

            LinkButton pageBefore = new LinkButton
            {
                CssClass = "btn btn-light text-dark ml-2 mr-2",
                Text = "«"
            };

            pageBefore.Click += new EventHandler(pageBackwards);
            pagePanel.Controls.Add(pageBefore);

            for (int i = 1; i <= nrPages; i++)
            {
                LinkButton pageButton = new LinkButton
                {
                    CssClass = i == Convert.ToInt32(sqlShopProducts.SelectParameters["Pagina"].DefaultValue) ? "btn btn-outline-light text-dark ml-2 mr-2" : "btn btn-light text-dark ml-2 mr-2",
                    Text = i.ToString()
                };

                pageButton.Click += new EventHandler(mudarPagina);
                pagePanel.Controls.Add(pageButton);
            }

            LinkButton pageAfter = new LinkButton
            {
                CssClass = "btn btn-light text-dark ml-2 mr-2",
                Text = "»"
            };

            pageAfter.Click += new EventHandler(pageForward);
            pagePanel.Controls.Add(pageAfter);
        }


        protected void mudarPagina(object sender, EventArgs e)
        {
            sqlShopProducts.SelectParameters["Pagina"].DefaultValue = ((LinkButton)sender).Text;
        }

        protected void pageBackwards(object sender, EventArgs e)
        {

            if (Convert.ToInt32(sqlShopProducts.SelectParameters["Pagina"].DefaultValue) > 1)
            {
                sqlShopProducts.SelectParameters["Pagina"].DefaultValue = (Convert.ToInt32(sqlShopProducts.SelectParameters["Pagina"].DefaultValue) - 1).ToString();
            }

        }

        protected void pageForward(object sender, EventArgs e)
        {

            if (Convert.ToInt32(sqlShopProducts.SelectParameters["Pagina"].DefaultValue) < pagePanel.Controls.Count - 2)
            {
                sqlShopProducts.SelectParameters["Pagina"].DefaultValue = (Convert.ToInt32(sqlShopProducts.SelectParameters["Pagina"].DefaultValue) + 1).ToString();
            }
        }




    }
}