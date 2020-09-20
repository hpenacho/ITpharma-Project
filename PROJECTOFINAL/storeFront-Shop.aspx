<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Shop.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Shop" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">





</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!-- Page Content -->
    <div class="container">

        <div class="row">

            <div class="col-lg-3 mb-3" style="margin-top: 20vh;">

                <h6 class="my-4">Filtros</h6>

                <div class="list-group list-group-flush">

                        <div class="form-group mb-3">
                            <asp:DropDownList ID="ddl_filters" CssClass="form-control w-100 border-0 bg-light" runat="server" OnSelectedIndexChanged="ddl_filters_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="NASC">A - Z</asp:ListItem>
                                <asp:ListItem Value="NDESC">Z  - A</asp:ListItem>
                                <asp:ListItem Value="PASC">Price ASC</asp:ListItem>
                                <asp:ListItem Value="PDESC">Price DESC</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                </div>


                <h6 class="my-4">Category</h6>

                <div class="list-group list-group-flush">

                     <asp:Repeater ID="rptCategory" runat="server" DataSourceID="sqlCategorySource" OnItemCommand="rptCategory_ItemCommand">
                        <ItemTemplate>

                            <asp:LinkButton runat="server" CommandName="linkSelectCategory" CommandArgument='<%# Eval("Descricao") %>' CssClass="list-group-item list-group-item-action d-flex justify-content-between align-items-center"><%# Eval("descricao") %><span class="badge badge-light badge-pill"><%# Eval("Count") %></span></asp:LinkButton>

                        </ItemTemplate>
                    </asp:Repeater>
                 
                </div>

                <h6 class="my-4">Brand</h6>

                <div class="list-group list-group-flush">

                    <asp:Repeater ID="rptBrands" runat="server" DataSourceID="sqlBrandsSource" OnItemCommand="rptBrands_ItemCommand">
                        <ItemTemplate>

                            <asp:LinkButton runat="server" CommandName="linkSelectBrand" CommandArgument='<%# Eval("Descricao") %>' CssClass="list-group-item list-group-item-action d-flex justify-content-between align-items-center"><%# Eval("descricao") %><span class="badge badge-light badge-pill"><%# Eval("Count") %></span></asp:LinkButton>

                        </ItemTemplate>
                    </asp:Repeater>


                </div>

            </div>
            <!-- /.col-lg-3 -->

            <div class="col-lg-9" style="margin-top: 20vh;">

                <div class="row text-center">

                    <asp:Repeater ID="rptShopProducts" runat="server" DataSourceID="sqlShopProducts">
                        <ItemTemplate>

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 border-white">
                                    <a href='storeFront-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>'>
                                        <img class="img" width="200" src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Product Image"></a>



                                    <div class="card-body">
                                        <!-- card body -->
                                        <h4 class="card-title m-auto text-center">
                                            <a href='storeFront-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>' class="text-decoration-none text-dark">
                                                <h5><%# Eval("nome") %></h5>
                                            </a>
                                        </h4>
                                        <h5><%# Eval("preco") %> €</h5>

                                    </div>
                                    <!-- //card body -->
                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>


                </div>
                <!-- /.row -->
            </div>
            <!-- /.col-lg-9 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->









    <!-- SQL SOURCES -->
    <asp:SqlDataSource ID="sqlShopProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_productFiltering" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="nome" Name="Campo" Type="String" />
            <asp:Parameter DefaultValue="ASC" Name="Ordem" Type="String" />
            <asp:Parameter DefaultValue="All" Name="Categoria" Type="String" />
            <asp:Parameter DefaultValue="All" Name="Marca" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlSearchProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_searchShopProducts" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="query" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlBrandsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="select Marca.ID, Marca.descricao , Count(Produto.ID_Categoria) as 'Count'
            from Marca inner join Produto on Produto.ID_Marca = Marca.ID
            where Produto.Activo = 1 
		    AND Produto.Descontinuado = 0
            group by Marca.ID, Marca.descricao">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlCategorySource" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="select Categoria.ID, Categoria.descricao , Count(Produto.ID_Categoria) as 'Count'
            from Categoria inner join Produto on Produto.ID_Categoria = Categoria.ID
            where Produto.Activo = 1 
		    AND Produto.Descontinuado = 0
            group by Categoria.ID, Categoria.descricao">
    </asp:SqlDataSource>
     <!-- //SQL SOURCES -->

</asp:Content>
