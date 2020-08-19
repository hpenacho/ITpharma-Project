<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Products.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Products" ValidateRequest="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style>

         a.active.nav-item.nav-link{background-color: orange !important;}
         a.active.nav-item.nav-link{color:white !important;}
         a.nav-item.nav-link{color: #333 !important;}

        td {

            text-align: center; 
            vertical-align: middle;
        }

        th {

            text-align: center; 
            vertical-align: middle;
        }

        #prodtrash:hover{
            color: darkred;
        }

        #produpdate:hover{
            color: orange;
        }

    </style>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <script src="ckeditor/ckeditor.js"></script>
    <!-- CK EDITOR SCRIPT -->


    <!-- Insert Products | opens a modal with all the fields necessary to insert a product -->

    <div class="container col-lg-12 mt-5">
        <div class="form-group">
            <button type="button" class="btn btn-warning float-lg-right" data-toggle="modal" data-target="#modal-insert-product">Add Product <i class="fas fa-plus"></i></button>
        </div>
    </div>

    <!-- /Insert Products -->



    <!-- PRODUCT TABLE -->

    <div class="container-fluid">
        <h1 class="mt-4">Products</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item">Dashboard</li>
            <li class="breadcrumb-item active">Products</li>
        </ol>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table mr-1"></i>
                Product Table
            </div>
            <div class="card-body">
                <div class="table-responsive">

                    <table class="table" id="dataTable" width="100%" cellspacing="0">

                        <thead> <!-- HEADER OF THE TABLE -->
                            <tr>
                                <th>Cod</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Qty</th>
                                <th>Active</th>
                                <th class="text-hide"></th>
                                <th class="text-hide"></th>
                            </tr>
                        </thead>

                        <tbody class="text-center text-md-center"> 

                            <!-- PRODUCTS -->

                            <asp:Repeater ID="rpt_produtosBackoffice" runat="server" DataSourceID="SQLrptProdutos">

                                <ItemTemplate>

                             <tr>
                                <td style="text-align: center; vertical-align: middle;">
                                    <%# Eval("Codreferencia") %>
                                </td>

                                <td style="text-align: center; vertical-align: middle;">
                                    <img src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="" width="70" class="img-fluid rounded align-middle">
                                </td>

                                <td style="text-align: center; vertical-align: middle;">
                                    <%# Eval("nome") %>
                                </td>

                                <td style="text-align: center; vertical-align: middle;">
                                    <%# Eval("preco") %> €
                                </td>

                                <td style="text-align: center; vertical-align: middle;">
                                    <%# Eval("Qtd") %>
                                </td>

                                <td style="text-align: center; vertical-align: middle;">
                                    <h6 class="text-hide" style="margin-bottom: -9px;"><%# Eval("activo") %></h6> <!-- only for the filter -->  
                                    <input class="form-check-input" style="margin-left: -9px" type="checkbox" id="check-product-active" checked='<%# Eval("Activo") %>'>
                                </td>

                                <td style="text-align: center; vertical-align: middle;">
                                    <asp:LinkButton ID="link_updateProduct" class="btn btn-sm" CommandName="link_updateProduct" CommandArgument='<%# Eval("Codreferencia") %>' runat="server" CausesValidation="false"><i id="produpdate" class="fas fa-pen"></i></asp:LinkButton>
                                </td>

                                <td style="text-align: center; vertical-align: middle;">
                                    <asp:LinkButton ID="link_deleteProduct" class="btn btn-sm" CommandName="link_deleteProduct" CommandArgument='<%# Eval("Codreferencia") %>' runat="server"><i id="prodtrash" class="fas fa-trash"></i></asp:LinkButton>
                                </td>
                            </tr>

                                </ItemTemplate>

                           
                            </asp:Repeater>

                             <!-- //PRODUCTS -->
                         
                        </tbody>
                    </table>


                </div>
            </div>
        </div>
    </div>

    <!-- /PRODUCT TABLE -->





    <!-- insert products Modal -->

    <div class="modal fade ml-3" id="modal-insert-product" tabindex="-1" role="dialog" aria-labelledby="modal-insert-product" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-update-label">Product Insertion<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                        </button>
                    </h5>
                </div>
                <div class="modal-body">   <!-- BEGIN MODAL BODY CONTENT -->

                    <!-- NAVIGATION -->

                    <div class="nav nav nav-pills nav-justified" id="nav-tab" role="tablist">
                        <a class="nav-item nav-link active" style="margin-left: 2em;" id="nav-home-tab" data-toggle="tab" href="#nav-details" role="tab" aria-controls="nav-home" aria-selected="true">Details</a>
                        <a class="nav-item nav-link" style="margin-right: 2em;" id="nav-profile-tab" data-toggle="tab" href="#nav-stock" role="tab" aria-controls="nav-profile" aria-selected="false">Stock</a>
                    </div>

                    <!-- /NAVIGATION -->

                    <div class="tab-content" id="nav-tabContent">

                        <!-- CONTENT 1 DETAILS -->
                        <div class="tab-pane fade show active" id="nav-details" role="tabpanel" aria-labelledby="nav-details-tab">

                            <div class="p-4"> <!-- WINDOW PADDING -->

                                <!-- Name -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <label for="tb_name">Name</label>
                                        <input type="text" class="form-control" runat="server" id="tb_name" placeholder="Title" required>
                                    </div>

                                </div>
                                <!-- /Name -->

                                <!-- Reference and Image -->
                                <div class="form-row">

                                    <div class="form-group col-md-6">
                                        <label for="tb_reference">Reference</label>
                                        <input type="text" class="form-control" runat="server" id="tb_reference" placeholder="Reference" required>
                                    </div>

                                    <div class="form-group col-md-6" style="margin-top: 2em">
                                        <asp:FileUpload ID="fl_insertProductImage" class="form-control-file" runat="server" />
                                    </div>
                                </div>
                                <!-- /Reference and Image -->


                                <!-- Description -->

                                <div class="form-row mt-1">

                                    <div class="col-lg-12">
                                        <label for="tb_description">Description</label>
                                        <textarea class="form-control" id="tb_description" runat="server" rows="3" required></textarea>
                                        <script type="text/javascript">

                                            CKEDITOR.replace('<%=tb_description.ClientID%>', { customConfig: 'custom/menu.js' });

                                        </script>
                                    </div>

                                </div>

                                <!-- Resumo -->

                                <div class="form-row mt-4 d-flex justify-content-between">

                                    <div class="col-lg-6">
                                        <label for="tb_summary">Summary</label>
                                        <input class="form-control" runat="server" type="text" id="tb_summary" required />
                                    </div>

                                    <div class="col-md-5">
                                        <label for="ddl_category">Category</label>
                                        <asp:DropDownList ID="ddl_category" class="form-control" runat="server" DataSourceID="SQLcategory" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                    </div>

                                </div>

                                <!-- /Resumo -->

                                <!-- Price-->
                                <div class="form-row mt-1 d-flex justify-content-between">

                                    <div class="col-md-6">
                                        <label for="tb_price">Price</label>
                                        <div class="input-group">
                                            <div class="input-group-append">
                                                <span class="input-group-text" id="inputGroupPrepend3">€</span>
                                            </div>
                                            <input type="number" class="form-control" runat="server" id="tb_price" aria-describedby="inputGroupPrepend3" required>
                                        </div>
                                    </div>

                                    <div class="col-md-5">
                                        <label for="ddl_brand">Brand</label>
                                        <asp:DropDownList ID="ddl_brand" class="form-control" runat="server" DataSourceID="SQLbrand" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                    </div>



                                </div>
                                <!-- /Price-->


                                <!-- Generic || Prescription || Generic-Product -->
                                <div class="form-row mt-2 mb-2 d-flex justify-content-between">

                                    <div class="btn-group-toggle col-md-6 d-flex justify-content-between" style="margin-top: 30px;" data-toggle="buttons">

                                        <label class="btn btn-outline-warning" style="padding-left: 1em; padding-right: 1em;">
                                            <input type="checkbox" name="prescription" id="check_prescription" runat="server" autocomplete="off">
                                            Prescription
                                        </label>

                                        <label class="btn btn-outline-warning" style="padding-left: 2em; padding-right: 2em;">
                                            <input type="checkbox" name="generic" id="check_generic" runat="server" autocomplete="off">
                                            Generic
                                        </label>

                                        <label class="btn btn-outline-dark" style="padding-left: 2em; padding-right: 2em;">
                                            <input type="checkbox" name="active" class="pr-2 pl-2" id="check_active" runat="server" autocomplete="off">
                                            Active
                                        </label>

                                    </div>

                                    <div class="col-md-5" id="parent-product">
                                        <label for="ddl_genericParent">Parent Product</label>
                                        <asp:DropDownList ID="ddl_genericParent" class="form-control" runat="server" DataSourceID="SQLgenericParent" DataTextField="nome" DataValueField="Codreferencia"></asp:DropDownList>
                                    </div>

                                </div>

                                <!-- //Brand || Prescription || Generic-Product-->



                            </div>
                            <!-- WINDOW PADDING -->

                        </div>
                        <!-- // CONTENT 1 DETAILS -->


                        <!-- CONTENT 2 DETAILS -->
                        <div class="tab-pane fade" id="nav-stock" role="tabpanel" aria-labelledby="nav-stock-tab">

                            <!-- STOCK -->

                            <div class="form-row mt-4 d-flex justify-content-between">

                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="0" class="form-control" runat="server" id="tb_qty" aria-describedby="inputGroupPrepend3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Cur Qty</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="0" class="form-control" runat="server" id="tb_minQty" aria-describedby="inputGroupPrepend3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Min Qty</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="1" class="form-control" runat="server" id="tb_maxQty" aria-describedby="inputGroupPrepend3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Max Qty</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- //STOCK-->

                        </div>
                        <!-- // CONTENT 2 DETAILS -->

                        <div class="form-row mt-4">
                            <div class="col text-center">
                                <asp:LinkButton ID="link_insertProduct" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertProduct_Click">Insert</asp:LinkButton> <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                    </div>
                    <!-- //TAB SYSTEM ENDING -->



                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>

    <!-- /Insert products Modal -->


    <!-- SQLSOURCES AND REPEATER SOURCES -->
    <asp:SqlDataSource ID="SQLcategory" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Categoria]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLbrand" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Marca]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLgenericParent" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * from produto where ref_generico IS NOT NULL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLrptProdutos" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_listBackofficeProducts" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>


