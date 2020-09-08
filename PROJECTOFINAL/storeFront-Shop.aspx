<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Shop.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Shop" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!-- Page Content -->
    <div class="container">

        <div class="row">

            <div class="col-lg-3" style="margin-top: 20vh;">

                <h1 class="my-4">Shop Name</h1>
                <div class="list-group">
                    <a href="#" class="list-group-item">Category 1</a>
                    <a href="#" class="list-group-item">Category 2</a>
                    <a href="#" class="list-group-item">Category 3</a>
                </div>

            </div>
            <!-- /.col-lg-3 -->

            <div class="col-lg-9" style="margin-top: 20vh;">
                <div class="row">

                    <asp:Repeater ID="rptShopProducts" runat="server" DataSourceID="sqlShopProducts" OnItemDataBound="rptShopProducts_ItemDataBound" OnItemCommand="rptShopProducts_ItemCommand">
                        <ItemTemplate>

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 border-white">
                                    <a href="#">
                                        <img class="img-fluid card-img card-img-top" src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Product Image"></a>
                                    
                                    <div class="card-body"> 
                                        <!-- card body -->
                                        <h4 class="card-title m-auto text-center">
                                            <a href="#"><%# Eval("nome") %></a>
                                        </h4>
                                        <h5><%# Eval("preco") %> €</h5>

                                    <div class="card-footer bg-transparent">
                                         <!-- card footer -->
                                        <asp:LinkButton ID="link_addProduct" runat="server" CommandName="link_addProduct" CommandArgument='<%# Eval("Codreferencia") %>' CssClass="btn btn-block btn-outline-success"><i class="fas fa-plus-circle"></i></asp:LinkButton>
                                    </div>
                                        <!-- //card footer -->

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
    <asp:SqlDataSource ID="sqlShopProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_displayShopProducts" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSearchProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_searchShopProducts" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="query" QueryStringField="q" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
