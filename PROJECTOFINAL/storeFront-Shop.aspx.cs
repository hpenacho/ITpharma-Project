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
        static string field = "Nome";
        static string order = "ASC";
        static string brand = "All";
        static string category = "All";
        static int currentPage = 1;
        const double numberOfItems = 9;


        protected void rptCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectCategory"))
            {
                category = e.CommandArgument.ToString();
                brand = "All";
                productFiltering();
            }
        }

        protected void rptBrands_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("linkSelectBrand"))
            {
                brand = e.CommandArgument.ToString();
                category = "All";
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

            sqlShopProducts.SelectParameters["Campo"].DefaultValue = field;
            sqlShopProducts.SelectParameters["Ordem"].DefaultValue = order;
            sqlShopProducts.SelectParameters["Categoria"].DefaultValue = category;
            sqlShopProducts.SelectParameters["Marca"].DefaultValue = brand;
            sqlShopProducts.SelectParameters["Pagina"].DefaultValue = currentPage.ToString();
            sqlShopProducts.SelectParameters["ItemsPagina"].DefaultValue = numberOfItems.ToString();

            sqlShopProducts.DataBind();
            rptShopProducts.DataBind();

            //Pagination 

            DataView dv = (DataView)sqlShopProducts.Select(DataSourceSelectArguments.Empty);
            int totalItems = (int)dv.Table.Rows[0][0];
            pageButtonTemplate((int)Math.Ceiling((double)totalItems / (double)numberOfItems));
            System.Diagnostics.Debug.WriteLine(totalItems);
        }



        // PAGINATION

        private void pageButtonTemplate(int nrPages)
        {
            pagePanel.Controls.Clear();

            LinkButton pageBefore = new LinkButton();
            pageBefore.Click += new EventHandler(mudarBefore);
            pageBefore.CssClass = "btn btn-dark ml-2 mr-2";
            pageBefore.Text = "«";


            pagePanel.Controls.Add(pageBefore);

            for (int i = 1; i <= nrPages; i++)
            {
                LinkButton pageButton = new LinkButton();
                pageButton.Click += new EventHandler(mudarPagina);
                pageButton.CssClass = "btn btn-outline-dark border-white ml-2 mr-2";
                pageButton.Text = i.ToString();

                if (currentPage == 1 && i == 1)
                    pageButton.CssClass = "btn btn-dark border-white ml-2 mr-2";

                pagePanel.Controls.Add(pageButton);
            }

            LinkButton pageAfter = new LinkButton();
            pageAfter.Click += new EventHandler(mudarAfter);
            pageAfter.CssClass = "btn btn-dark ml-2 mr-2";
            pageAfter.Text = "»";

            pagePanel.Controls.Add(pageAfter);
        }

        private void activePage(LinkButton button)
        {
            foreach (LinkButton control in pagePanel.Controls)
            {

                if (control != button)
                    control.CssClass = "btn btn-outline-dark border-white ml-2 mr-2";
                if (control.Text == "»" || control.Text == "«" || button == control)
                    control.CssClass = "btn btn-dark ml-2 mr-2";
                if (control.Text == currentPage.ToString())
                    control.CssClass = "btn btn-dark ml-2 mr-2";
            }
        }

        protected void mudarPagina(object sender, EventArgs e)
        {
            currentPage = Convert.ToInt32(((LinkButton)sender).Text);
            activePage(((LinkButton)sender));
            productFiltering();
        }

        protected void mudarBefore(object sender, EventArgs e)
        {
            if (currentPage > 1)
            {
                currentPage--;
                activePage((LinkButton)sender);
                productFiltering();
            }

        }

        protected void mudarAfter(object sender, EventArgs e)
        {
            if (currentPage < pagePanel.Controls.Count - 2)
            {
                currentPage++;
                activePage((LinkButton)sender);
                productFiltering();
            }

        }




    }
}