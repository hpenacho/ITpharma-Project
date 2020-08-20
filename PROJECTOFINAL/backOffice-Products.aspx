<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Products.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Products" ValidateRequest="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script>

       function openModal() { $('#modal-update-product').modal('show'); }

    </script>



    <style>

         a.active.nav-item.nav-link{background-color: orange !important;}
         a.active.nav-item.nav-link{color:white !important;}
         a.nav-item.nav-link{color: #333 !important;}


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

        .table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
         background-color: #B5EE9B;
         transition: all 1s ease;
        }

    </style>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <script src="ckeditor/ckeditor.js"></script>
    <!-- CK EDITOR SCRIPT -->


    <!-- Insert Products | opens a modal with all the fields necessary to insert a product -->

 

   
        <div class="col-lg-12 mt-5 mb-4 d-flex d-flex justify-content-end">

            <button type="button" class="btn btn-dark mr-3" data-toggle="modal" data-target="#modal-insert-brand">Add Brand <i class="fas fa-plus"></i></button>
            <button type="button" class="btn btn-dark mr-3" data-toggle="modal" data-target="#modal-insert-category">Add Category <i class="fas fa-plus"></i></button>
            <button type="button" class="btn btn-warning mr-3" data-toggle="modal" data-target="#modal-insert-product">Add Product <i class="fas fa-plus"></i></button>
        
        </div>



    <!-- /Insert Products -->



    <!-- PRODUCT TABLE -->

    <div class="container-fluid">
        <h1>Products</h1>
        <ol class="breadcrumb bg-dark text-white mb-4">
            <a class="breadcrumb-item text-white" href="backOffice-Index.aspx">Dashboard</a>
            <li class="breadcrumb-item active">Products</li>
        </ol>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table mr-1"></i>
                Product Table
            </div>
            <div class="card-body">
                <div class="table-responsive">

                    <table class="table table-striped table-hover" id="dataTable" width="100%" cellspacing="0">

                        <thead>
                            <!-- HEADER OF THE TABLE -->
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

                            <asp:Repeater ID="rpt_produtosBackoffice" runat="server" DataSourceID="SQLrptProdutos" OnItemCommand="rpt_produtosBackoffice_ItemCommand" OnItemDataBound="rpt_produtosBackoffice_ItemDataBound">

                                <ItemTemplate>

                                    <tr class="text-center">
                                        <td class="align-middle">
                                            <%# Eval("Codreferencia") %>
                                        </td>

                                        <td class="align-middle">
                                            <img src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="" width="70" class="img-fluid rounded align-middle">
                                        </td>

                                        <td class="align-middle">
                                            <%# Eval("nome") %>
                                        </td>

                                        <td class="align-middle">
                                            <%# Eval("preco") %> €
                                        </td>

                                        <td class="align-middle">
                                            <%# Eval("Qtd") %>
                                        </td>

                                        <td class="align-middle">
                                            <h6 class="text-hide" style="margin-bottom: -9px;"><%# Eval("activo") %></h6>
                                            <!-- only for the filter -->
                                            <asp:CheckBox ID="check_productIsActive" Style="margin-left: -9px" runat="server" Checked='<%# Eval("Activo") %>' />
                                        </td>

                                        <td class="align-middle">
                                            <asp:LinkButton ID="link_updateProduct" class="btn btn-sm" CommandName="link_updateProduct" CommandArgument='<%# Eval("Codreferencia") %>' runat="server" CausesValidation="false"><i id="produpdate" class="fas fa-pen"></i></asp:LinkButton>
                                        </td>

                                        <td class="align-middle">
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
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-label">Product Insertion
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </h5>
                </div>
                <div class="modal-body">
                    <!-- BEGIN MODAL BODY CONTENT -->


                    <!-- INNER UPDATE PANEL -->


                    <!-- NAVIGATION -->

                    <div class="nav nav nav-pills nav-justified" id="insert-nav-tab" role="tablist">
                        <a class="nav-item nav-link active" style="margin-left: 2em;" id="insert-nav-home-tab" data-toggle="tab" href="#insert-nav-details" role="tab" aria-controls="nav-home" aria-selected="true">Details</a>
                        <a class="nav-item nav-link" style="margin-right: 2em;" id="insert-nav-profile-tab" data-toggle="tab" href="#insert-nav-stock" role="tab" aria-controls="nav-profile" aria-selected="false">Stock</a>
                    </div>

                    <!-- /NAVIGATION -->

                    <div class="tab-content" id="insert-nav-tabContent">

                        <!-- CONTENT 1 DETAILS -->
                        <div class="tab-pane fade show active" id="insert-nav-details" role="tabpanel" aria-labelledby="nav-details-tab">

                            <div class="p-4">
                                <!-- WINDOW PADDING -->

                                <!-- Name -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <input type="text" class="form-control" runat="server" id="tb_name" placeholder="Product Name" data-toggle="tooltip" data-placement="Top" title="Insert the Product name to be displayed" required>
                                    </div>

                                </div>
                                <!-- /Name -->

                                <!-- Reference and Image -->
                                <div class="form-row">

                                    <div class="form-group col-md-6">
                                        <label for="tb_reference">Reference</label>
                                        <input type="text" class="form-control" runat="server" id="tb_reference" placeholder="Reference #" data-toggle="tooltip" data-placement="top" title="Insert the reference code supplied by the manufacturer" required>
                                    </div>

                                    <div class="form-group col-md-6" style="margin-top: 2em">
                                        <asp:FileUpload ID="fl_insertProductImage" runat="server" />
                                    </div>

                                </div>
                                <!-- /Reference and Image -->


                                <!-- Description -->

                                <div class="form-row mt-1">

                                    <div class="col-lg-12">
                                        <label for="tb_description">
                                            <p class="text-muted">Item Description </p>
                                        </label>
                                        <textarea class="form-control" id="tb_description" runat="server" rows="3" required></textarea>
                                        <script type="text/javascript">

                                            CKEDITOR.replace('<%=tb_description.ClientID%>', { customConfig: 'custom/menu.js' });

                                        </script>
                                    </div>

                                </div>

                                <!-- Resumo -->

                                <div class="form-row mt-4 d-flex justify-content-between">

                                    <div class="col-lg-6">
                                        <input class="form-control" runat="server" type="text" id="tb_summary" placeholder="Summary" data-toggle="tooltip" data-placement="Top" title="Insert the summary, a shortened product description." required />
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
                                        <div class="input-group">
                                            <div class="input-group-append">
                                                <span class="input-group-text" id="inputGroupPrepend3"><i class="fas fa-euro-sign"></i></span>
                                            </div>
                                            <input type="number" class="form-control" runat="server" id="tb_price" aria-describedby="inputGroupPrepend3" min="0.00" max="99999.00" step="0.01" placeholder="Price" title="Only numbers allowed" required>
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
                        <div class="tab-pane fade" id="insert-nav-stock" role="tabpanel" aria-labelledby="nav-stock-tab">

                            <!-- STOCK -->

                            <div class="form-row mt-4 d-flex justify-content-between">

                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="0" class="form-control" runat="server" min="0.00" id="tb_qty" aria-describedby="inputGroupPrepend3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Qty</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="0" class="form-control" runat="server" min="0.00" id="tb_minQty" aria-describedby="inputGroupPrepend3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Min Qty</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="1" class="form-control" runat="server" min="0.00" id="tb_maxQty" aria-describedby="inputGroupPrepend3">
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
                                <asp:LinkButton ID="link_insertProduct" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertProduct_Click">Insert</asp:LinkButton>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        <div class="form-row mt-2">
                            <label id="lbl_errors" runat="server"></label>
                        </div>

                    </div>
                    <!-- //TAB SYSTEM ENDING -->


                    <!-- END INNER UPDATE PANEL -->


                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>
    <!-- /Insert products Modal -->


    <!-- UPDATE products Modal -->
    <div class="modal fade ml-3" id="modal-update-product" tabindex="-1" role="dialog" aria-labelledby="modal-update-product" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-update-label">Product Update
                                                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                    </h5>
                </div>
                <div class="modal-body">
                    <!-- BEGIN MODAL BODY CONTENT -->


                    <!-- INNER UPDATE PANEL -->



                    <!-- NAVIGATION -->

                    <div class="nav nav nav-pills nav-justified" id="nav-tab" role="tablist">
                        <a class="nav-item nav-link active" style="margin-left: 2em;" id="nav-home-tab" data-toggle="tab" href="#nav-details" role="tab" aria-controls="nav-home" aria-selected="true">Details</a>
                        <a class="nav-item nav-link" style="margin-right: 2em;" id="nav-profile-tab" data-toggle="tab" href="#nav-stock" role="tab" aria-controls="nav-profile" aria-selected="false">Stock</a>
                    </div>

                    <!-- /NAVIGATION -->

                    <div class="tab-content" id="nav-tabContent">

                        <!-- CONTENT 1 DETAILS -->
                        <div class="tab-pane fade show active" id="nav-details" role="tabpanel" aria-labelledby="nav-details-tab">

                            <div class="p-4">
                                <!-- WINDOW PADDING -->

                                <!-- Name -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <label for="tb_updateName">Name</label>
                                        <input type="text" class="form-control" runat="server" id="tb_updateName" placeholder="Title" required>
                                    </div>

                                </div>
                                <!-- /Name -->

                                <!-- Reference and Image -->
                                <div class="form-row">

                                    <div class="form-group col-md-6">
                                        <label for="tb_updateReference">Reference</label>
                                        <input type="text" class="form-control" runat="server" id="tb_updateReference" placeholder="Reference" readonly required>
                                    </div>

                                    <div class="form-group col-md-6" style="margin-top: 2em">
                                        <asp:FileUpload ID="fl_updateProductImage" runat="server" />
                                    </div>

                                </div>
                                <!-- /Reference and Image -->


                                <!-- Description -->

                                <div class="form-row mt-1">

                                    <div class="col-lg-12">
                                        <label for="tb_description">Description</label>
                                        <textarea class="form-control" id="tb_updateDescription" runat="server" rows="3" required></textarea>
                                        <script type="text/javascript">

                                            CKEDITOR.replace('<%=tb_updateDescription.ClientID%>', { customConfig: 'custom/menu.js' });

                                        </script>
                                    </div>
                                </div>

                                <!-- Resumo -->

                                <div class="form-row mt-4 d-flex justify-content-between">

                                    <div class="col-lg-6">
                                        <label for="tb_updateSummary">Summary</label>
                                        <input class="form-control" runat="server" type="text" id="tb_updateSummary" required />
                                    </div>

                                    <div class="col-md-5">
                                        <label for="ddl_updateCategory">Category</label>
                                        <asp:DropDownList ID="ddl_updateCategory" class="form-control" runat="server" DataSourceID="SQLcategory" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                    </div>

                                </div>

                                <!-- /Resumo -->

                                <!-- Price-->
                                <div class="form-row mt-1 d-flex justify-content-between">

                                    <div class="col-md-6">
                                        <label for="tb_updatePrice">Price</label>
                                        <div class="input-group">
                                            <div class="input-group-append">
                                                <span class="input-group-text" id="inputGroupPrepend3">€</span>
                                            </div>
                                            <input type="number" class="form-control" runat="server" id="tb_updatePrice" aria-describedby="inputGroupPrepend3" required>
                                        </div>
                                    </div>

                                    <div class="col-md-5">
                                        <label for="ddl_updateBrand">Brand</label>
                                        <asp:DropDownList ID="ddl_updateBrand" class="form-control" runat="server" DataSourceID="SQLbrand" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                    </div>



                                </div>
                                <!-- /Price-->


                                <!-- Generic || Prescription || Generic-Product -->
                                <div class="form-row mt-2 mb-2 d-flex justify-content-between">

                                    <div class="btn-group-toggle col-md-6 d-flex justify-content-between" style="margin-top: 30px;" data-toggle="buttons">

                                        <label class="btn btn-outline-warning" style="padding-left: 1em; padding-right: 1em;">
                                            <input type="checkbox" name="prescription" id="check_updatePrescription" runat="server" autocomplete="off">
                                            Prescription
                                        </label>

                                        <label class="btn btn-outline-warning" style="padding-left: 2em; padding-right: 2em;">
                                            <input type="checkbox" name="generic" id="check_updateGeneric" runat="server" autocomplete="off">
                                            Generic
                                        </label>

                                        <label class="btn btn-outline-dark" style="padding-left: 2em; padding-right: 2em;">
                                            <input type="checkbox" name="active" class="pr-2 pl-2" id="check_updateActive" runat="server" autocomplete="off">
                                            Active
                                        </label>
                                       
                                    </div>
                                   
                                    <div class="col-md-5" id="genericUpdateDiv">
                                        <label for="ddl_updateGenericParent">Parent Product</label>
                                        <asp:DropDownList ID="ddl_updateGenericParent" class="form-control" runat="server" DataSourceID="SQLgenericParent" DataTextField="nome" DataValueField="Codreferencia"></asp:DropDownList>
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
                                        <input type="number" value="0" class="form-control" runat="server" id="tb_updateCurQty" aria-describedby="inputGroupPrepend3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Cur Qty</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="0" class="form-control" runat="server" id="tb_updateMinQty" aria-describedby="inputGroupPrepend3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Min Qty</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="number" value="1" class="form-control" runat="server" id="tb_updateMaxQty" aria-describedby="inputGroupPrepend3">
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
                                <asp:LinkButton ID="link_updateProductDetails" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_updateProductDetails_Click">Update</asp:LinkButton>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        <div class="form-row mt-2">
                            <div class="col text-center">
                                <label id="lbl_updateErrors" runat="server"></label>
                            </div>
                        </div>

                    </div>
                    <!-- //TAB SYSTEM ENDING -->



                    <!-- END INNER UPDATE PANEL -->
                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>
    <!-- /UPDATE products Modal -->

    <!-- INSERT BRANDS Modal -->
    <div class="modal fade ml-3 mt-5" id="modal-insert-brand" tabindex="-1" role="dialog" aria-labelledby="modal-update-product" aria-hidden="true">
        <div class="modal-dialog modal-md shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-2 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-brand-label">Brands
                         <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                               <span aria-hidden="true">&times;</span>
                          </button>
                    </h5>
                </div>
                <!-- BEGIN MODAL BODY CONTENT -->
                <div class=" modal-body">


                                    <div class="form-group col-md-12 d-flex form-inline">
                                            <input type="text" class="form-control w-75" runat="server" id="tb_insertBrand" placeholder="Brand">
                                            <asp:LinkButton ID="link_insertBrand" CommandArgument="usp_insertBrand" CommandName="brand" class="btn btn-warning ml-3" style="padding-left: 1em; padding-right: 1em;" runat="server" OnClick="link_insertCategoryBrand">Insert</asp:LinkButton>
                                            <label class="mt-2" id="lbl_insertBrandError" runat="server"></label>
                                    </div>

                                     

                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>
    <!-- /INSERT BRANDS Modal -->





       <!-- INSERT CATEGORIES Modal -->
    <div class="modal fade ml-3 mt-5" id="modal-insert-category" tabindex="-1" role="dialog" aria-labelledby="modal-update-product" aria-hidden="true">
        <div class="modal-dialog modal-md shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-2 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-category-label">Categories<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                               <span aria-hidden="true">&times;</span>
                          </button>
                    </h5>
                </div>
                <!-- BEGIN MODAL BODY CONTENT -->
                <div class=" modal-body">


                                    <div class="form-group col-md-12 d-flex form-inline">
                                            <input type="text" class="form-control w-75" runat="server" id="tb_insertCategory" placeholder="Category">
                                            <asp:LinkButton ID="link_insertCategory" CommandArgument="usp_insertCategory" CommandName="category" class="btn btn-warning ml-3" style="padding-left: 1em; padding-right: 1em;" runat="server" OnClick="link_insertCategoryBrand">Insert</asp:LinkButton>
                                            <label class="mt-2"  id="lbl_insertCategoryError" runat="server"></label>
                                    </div>
                                    
                                     

                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>
    <!-- /INSERT CATEGORIES Modal -->




     <script type="text/javascript">

         $(document).ready(function () {
             $('[data-toggle="tooltip"]').tooltip();
         });

     </script>


    <!-- SQLSOURCES AND REPEATER SOURCES -->
    <asp:SqlDataSource ID="SQLcategory" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Categoria]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLbrand" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Marca]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLgenericParent" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * from produto where ref_generico IS NULL and produto.Descontinuado != 1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLrptProdutos" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_listBackofficeProducts" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>


