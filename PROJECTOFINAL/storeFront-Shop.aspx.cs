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
        protected void Page_Load(object sender, EventArgs e)
        {

            if(Session["searchQuery"] != null)
            {
                searchProducts();
                return;
            }

            if (!Page.IsPostBack)
            {
                currentPage = 1;
                category = "All";
                brand = "All";
            }

            productFiltering();
        }

        private void searchProducts()
        {
            sqlSearchProducts.SelectParameters["query"].DefaultValue = Session["searchQuery"].ToString(); ; 
            rptShopProducts.DataSourceID = sqlSearchProducts.ID;
            rptShopProducts.DataBind();
            Session["searchQuery"] = null;
        }


        //FILTERING PRODUCTS
        string field = "Nome";
        string order = "ASC";
        string brand = "All";
        string category = "All";
        int currentPage = 1;
        const double numberOfItems = 9;


        protected void rptCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectCategory"))
            {
                category = e.CommandArgument.ToString();
                brand = "All";
                currentPage = 1;
                productFiltering();
            }
        }

        protected void rptBrands_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectBrand"))
            {
                brand = e.CommandArgument.ToString();
                category = "All";
                currentPage = 1;
                productFiltering();
            }
        }

        protected void ddl_filters_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddl_filters.SelectedValue)
            {
                case "NASC":
                    field = "Nome";
                    order = "ASC";
                    break;
                case "NDESC":
                    field = "Nome";
                    order = "DESC";
                    break;
                case "PASC":
                    field = "Preco";
                    order = "ASC";
                    break;
                case "PDESC":
                    field = "Preco";
                    order = "DESC";
                    break;
            }

            productFiltering();
        }

        private void productFiltering()
        {
            rptShopProducts.DataSourceID = sqlShopProducts.ID;

            System.Diagnostics.Debug.WriteLine("Product Filtering current Page " + currentPage);

            sqlShopProducts.SelectParameters["Campo"].DefaultValue = field;
            sqlShopProducts.SelectParameters["Ordem"].DefaultValue = order;
            sqlShopProducts.SelectParameters["Categoria"].DefaultValue = category;
            sqlShopProducts.SelectParameters["Marca"].DefaultValue = brand;
            sqlShopProducts.SelectParameters["Pagina"].DefaultValue = currentPage.ToString();
            sqlShopProducts.SelectParameters["ItemsPagina"].DefaultValue = numberOfItems.ToString();

            generatePaging();
        }



        // PAGINATION

        private void generatePaging()
        {
            DataView dv = (DataView)sqlShopProducts.Select(new DataSourceSelectArguments());
            DataTable groupsTable = dv.ToTable();
            int totalItems = 1;

            foreach (DataRow dr in groupsTable.Rows)
            {
                totalItems = Convert.ToInt32(dr[0].ToString());
            }

            pageButtonTemplate((int)Math.Ceiling((double)totalItems / (double)numberOfItems));

            sqlShopProducts.DataBind();
            rptShopProducts.DataBind();
        }

        private void pageButtonTemplate(int nrPages)
        {
            pagePanel.Controls.Clear();

            LinkButton pageBefore = new LinkButton();
            pageBefore.Click += new EventHandler(pageBackwards);
            pageBefore.CssClass = "btn btn-light ml-2 mr-2";
            pageBefore.Text = "«";

            pagePanel.Controls.Add(pageBefore);

            for (int i = 1; i <= nrPages; i++)
            {
                LinkButton pageButton = new LinkButton();
                pageButton.Click += new EventHandler(mudarPagina);
                pageButton.CssClass = "btn btn-outline-light border-white ml-2 mr-2";
                pageButton.Text = i.ToString();

                if (i == currentPage)
                    pageButton.CssClass = "btn btn-light border-white ml-2 mr-2";

                pagePanel.Controls.Add(pageButton);
            }

            LinkButton pageAfter = new LinkButton();
            pageAfter.Click += new EventHandler(pageForward);
            pageAfter.CssClass = "btn btn-light ml-2 mr-2";
            pageAfter.Text = "»";

            pagePanel.Controls.Add(pageAfter);
        }


        protected void mudarPagina(object sender, EventArgs e)
        {
            currentPage = Convert.ToInt32(((LinkButton)sender).Text);
            productFiltering();
        }

        protected void pageBackwards(object sender, EventArgs e)
        {
            if (currentPage > 0)
            {
                currentPage -= 1;
            }
        }


        protected void pageForward(object sender, EventArgs e)
        {

            if (currentPage < pagePanel.Controls.Count - 2)
            {
                currentPage = currentPage + 1;
                productFiltering();
            }
        }




    }
}