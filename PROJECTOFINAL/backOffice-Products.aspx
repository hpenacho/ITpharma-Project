<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Products.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Products" ValidateRequest="false" EnableViewState="true" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style>

         a.active.nav-item.nav-link{background-color: orange !important;color:whitesmoke !important;}
         a.nav-item.nav-link{color: #333 !important;}

         #home-tab.active{background-color: orange !important;color:white !important;}
         #home-tab{background-color: whitesmoke !important;color: #333 !important;}

         #profile-tab.active{background-color: orange !important;color:white !important;}
         #profile-tab{background-color: whitesmoke !important;color: #333 !important;}

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

    <!-- TESTE -->

    <script type="text/javascript">

        $(document).ready(function () {

            $('[data-toggle="tooltip"]').tooltip();
            $('table.products').DataTable();


            if (document.getElementById("<%= check_updateGeneric.ClientID %>").checked) {
                document.getElementById("genericUpdateParentsDiv").style.display = "";
            } else {
                document.getElementById("genericUpdateParentsDiv").style.display = "none";
            }


        });

        function openModal() {
            $('#modal-update-product').modal('show');
        }

        function showHideUpdateGenParents(){

            let genUpdateDiv = document.getElementById("genericUpdateParentsDiv");

            genUpdateDiv.style.display = document.getElementById("<%= check_updateGeneric.ClientID %>").checked ? "none" : "";

        }

        function showHideGenParents() {

            let genDiv = document.getElementById("genericParentsDiv");

            if (genDiv.style.display === "none") {
                genDiv.style.display = "";

            } else {
                genDiv.style.display = "none";
            }
        }

    </script>

    <!-- TESTE -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap core JavaScript -->  
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <script src="ckeditor/ckeditor.js"></script>
    <!-- CK EDITOR SCRIPT -->


    <div class="container-fluid">
    

        <div class="col-lg-12 col-md-12 col-sm-12 mb-2 mt-3 text-center">
            <h1 class="mb-2">Manage Products</h1>
        </div>

        <div class="form-row text-center col-lg-12 mt-5 mb-3">

            <div class="col-12 col-sm-12 col-md-4 align-middle mb-2">
                <button type="button" class="btn btn-block btn-dark shadow shadow-sm mr-3" data-toggle="modal" data-target="#modal-insert-brand">Manage Brands <i class="fas fa-plus"></i></button>
            </div>

            <div class="col-12 col-sm-12 col-md-4 align-middle mb-2">
                <button type="button" class="btn btn-block btn-dark shadow shadow-sm mr-3" data-toggle="modal" data-target="#modal-insert-category">Manage Categories <i class="fas fa-plus"></i></button>
            </div>

            <div class="col-12 col-sm-12 col-md-4 align-middle mb-2">
                <button type="button" class="btn btn-block btn-warning shadow shadow-sm" data-toggle="modal" data-target="#modal-insert-product">Add Product <i class="fas fa-plus"></i></button>
            </div>

        </div>


        <div class="col-lg-12 col-md-12 col-sm-12 mb-4 mt-3">
   
            <ul class="nav nav-pills" id="myTab" role="tablist">

                <li class="nav-item w-50 text-center shadow shadow-sm">
                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#products" role="tab" aria-controls="products" aria-selected="true">
                        <h5>Products</h5>
                    </a>
                </li>

                <li class="nav-item w-50 text-center  shadow shadow-sm">
                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#archived" role="tab" aria-controls="archived" aria-selected="false">
                        <h5>Archived</h5>
                    </a>
                </li>

            </ul>
        </div>




    <div class="tab-content" id="myTabContent">
       <!-- ACTIVE PRODUCT TABLE -->

        <div class="tab-pane fade show active" id="products" role="tabpanel" aria-labelledby="home-tab">

            <div class="container-fluid">
                <div class="card mb-4 shadow shadow-sm">
                    <div class="card-header text-center bg-dark text-white">
                        <i class="fas fa-table mr-1"></i>
                        Active Products
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">

                            <table class="table products table-striped table-hover" width="100%" cellspacing="0">

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
                                                    <div style="height:83px; width:83px">
                                                    <img style='height: 100%; width: 100%; object-fit: contain' src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" class="img-fluid rounded align-middle">
                                                    </div>
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
                                                    <asp:CheckBox ID="check_productIsActive" Enabled="false" Style="margin-left: -9px;" runat="server" Checked='<%# Eval("Activo") %>' />
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

        </div>
        <!-- /ACTIVE PRODUCT TABLE -->

        <!-- ARCHIVED PRODUCT TABLE -->
        <div class="tab-pane fade show" id="archived" role="tabpanel" aria-labelledby="archive-tab">

            <div class="container-fluid">
                <div class="card mb-4 shadow shadow-sm">
                    <div class="card-header text-center bg-dark text-white">
                        <i class="fas fa-table mr-1"></i>
                         Archived Products
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">

                            <table class="table products table-striped table-hover" id="" width="100%" cellspacing="0">

                                <thead>
                                    <!-- HEADER OF THE TABLE -->
                                    <tr>
                                        <th>Cod</th>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>Price</th>
                                        <th>Qty</th>
                                    </tr>
                                </thead>

                                <tbody class="text-center text-md-center">

                                    <!-- PRODUCTS -->

                                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SQLrptArchived">

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

            </div>
        <!-- //ARCHIVED PRODUCT TABLE -->
        </div>
    </div>
    <!-- //END CONTAINER-FLUID -->



    <!-- INSERT PRODUCTS MODAL -->
    <asp:UpdatePanel ID="updinsertProduct" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
        <ContentTemplate>
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
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>

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
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text"><i class="fas fa-box"></i></span>
                                                            </div>
                                                            <input type="text" class="form-control" runat="server" id="tb_name" placeholder="Product Name" data-toggle="tooltip" data-placement="Top" title="Insert the Product name to be displayed" required>
                                                        </div>
                                                    </div>

                                                </div>
                                                <!-- /Name -->

                                                <!-- Reference and Image -->
                                                <div class="form-row">

                                                    <div class="form-group col-md-6 mt-1">
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                                            </div>
                                                            <input type="text" class="form-control" runat="server" id="tb_reference" placeholder="Reference Number" data-toggle="tooltip" data-placement="top" title="Insert the reference code supplied by the manufacturer" required>
                                                        </div>
                                                    </div>

                                                    <div class="input-group col-md-6 mt-1">
                                                        <div class="custom-file">
                                                            <ajaxToolkit:AsyncFileUpload ID="fl_insertProductImage" OnUploadedComplete="fl_insertProductImage_UploadedComplete" class="custom-file-input" aria-describedby="fl_insertProductImage" runat="server" accept=".png,.jpg,.jpeg" />
                                                            <label id="custom-file-label" class="custom-file-label" for="fl_insertProductImage">Choose File </label>
                                                        </div>
                                                        <div class="input-group-append">
                                                        </div>
                                                    </div>

                                                </div>
                                                <!-- /Reference and Image -->


                                                <!-- Description -->

                                                <div class="form-row mt-1">

                                                    <div class="col-lg-12">
                                                        <label for="tb_description">
                                                            <p class="text-muted"><i class="fas fa-edit"></i>Item Description </p>
                                                        </label>
                                                        <CKEditor:CKEditorControl ID="ckeditorInsertProduct" runat="server"></CKEditor:CKEditorControl>
                                                    </div>

                                                </div>

                                                <!-- Resumo -->


                                                <div class="form-row mt-4 d-flex justify-content-between">
                                                    <div class="col-lg-6 mb-2">
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text"><i class="fas fa-pen"></i></span>
                                                            </div>
                                                            <input class="form-control" runat="server" type="text" id="tb_summary" placeholder="Summary" data-toggle="tooltip" data-placement="Top" title="Insert the summary, a shortened product description." required />
                                                        </div>
                                                    </div>
                                                    <div class="input-group mb-3 col-sm-12 col-md-5 col-lg-5">
                                                        <div class="input-group-prepend">
                                                            <label class="input-group-text" for="ddl_category">Category</label>
                                                        </div>
                                                        <asp:DropDownList ID="ddl_category" class="form-control" runat="server" DataSourceID="SQLcategory" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                                    </div>

                                                </div>
                                                <!-- /Resumo -->
                                                <!-- Price || Brand-->
                                                <div class="form-row mt-1 d-flex justify-content-between">

                                                    <div class="col-md-6 mb-2">
                                                        <div class="input-group">
                                                            <div class="input-group-append">
                                                                <span class="input-group-text text-center">&nbsp;<i class="fas fa-euro-sign"></i></span>
                                                            </div>
                                                            <input type="number" class="form-control" runat="server" id="tb_price" aria-describedby="inputGroupPrepend4" value="10.00" min="0.00" max="99999.00" step="0.01" placeholder="Price" title="Only numbers allowed" required>
                                                        </div>
                                                    </div>
                                                    <div class="input-group mb-3 col-md-5 col-sm-12">
                                                        <div class="input-group-prepend">
                                                            <label class="input-group-text" for="ddl_brand">Brand&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                        </div>
                                                        <asp:DropDownList ID="ddl_brand" class="form-control" runat="server" DataSourceID="SQLbrand" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <!-- /Price-->
                                                <!-- Generic || Prescription || Generic-Product -->
                                                <div class="form-row mt-2 mb-2 d-flex justify-content-between">

                                                    <div class="btn-group-toggle col-md-6 d-flex justify-content-around mb-3" data-toggle="buttons">


                                                        <label class="btn btn-outline-dark rounded-right">
                                                            <input type="checkbox" name="active" id="check_active" runat="server" autocomplete="off">
                                                            Active
                                                        </label>



                                                        <label class="btn btn-outline-warning rounded-left">
                                                            <input type="checkbox" name="prescription" id="check_prescription" runat="server" autocomplete="off">
                                                            Prescription
                                                        </label>


                                                        <label class="btn btn-outline-warning rounded-left" onclick="showHideGenParents()">
                                                            <input type="checkbox" name="generic" id="check_generic" runat="server" autocomplete="off">
                                                            Generic
                                                        </label>

                                                    </div>

                                                    <div class="input-group mb-3 col-md-5 col-sm-12" id="genericParentsDiv" style="display: none;">
                                                        <div class="input-group-prepend">
                                                            <label class="input-group-text" for="ddl_genericParent">Parent&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                        </div>
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

                                        <div class="form-row mt-2">
                                            <div class="col text-center">
                                                <asp:LinkButton ID="link_insertProduct" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertProduct_Click">Insert</asp:LinkButton>
                                                <!-- INSERTION DRIVE -->
                                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                                            </div>
                                        </div>

                                        <div class="form-row mt-2 justify-content-center">
                                            <label id="lbl_errors" class="text-danger" runat="server"></label>
                                        </div>
                                    </div>
                                    <!-- //TAB SYSTEM ENDING -->
                                    <!-- END INNER UPDATE PANEL -->
                                </ContentTemplate>


                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="link_insertProduct" />
                                </Triggers>


                            </asp:UpdatePanel>
                        </div>
                        <!-- END MODAL BODY CONTENT -->
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- //INSERT PRODUCTS MODAL -->




   <!-- UPDATE PRODUCTS MODAL -->
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
                            <asp:UpdatePanel ID="updUpdateProduct" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                <ContentTemplate>

                                    <div class="p-4">
                                        <!-- WINDOW PADDING -->

                                        <!-- Name -->
                                        <div class="form-row">

                                            <div class="form-group col-md-12">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fas fa-box"></i></span>
                                                    </div>
                                                    <input type="text" class="form-control" runat="server" id="tb_updateName" placeholder="Product Name" data-toggle="tooltip" data-placement="Top" title="Insert the Product name to be displayed" required>
                                                </div>
                                            </div>

                                        </div>
                                        <!-- /Name -->

                                        <!-- Reference and Image -->
                                        <div class="form-row">

                                            <div class="form-group col-md-6 mt-1">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                                    </div>
                                                    <input type="text" class="form-control" runat="server" id="tb_updateReference" placeholder="Reference Number" data-toggle="tooltip" data-placement="top" title="Insert the reference code supplied by the manufacturer" required>
                                                </div>
                                            </div>

                                            <div class="input-group col-md-6 mt-1">
                                                <div class="custom-file">
                                                    <ajaxToolkit:AsyncFileUpload ID="fl_updateProductImage" OnUploadedComplete="fl_updateProductImage_UploadedComplete" class="custom-file-input" aria-describedby="fl_updateProductImage" runat="server" accept=".png,.jpg,.jpeg" />
                                                    <label id="custom-file-label2" class="custom-file-label" for="fl_updateProductImage">Choose File</label>
                                                </div>
                                                <div class="input-group-append">
                                                </div>
                                            </div>

                                        </div>
                                        <!-- /Reference and Image -->


                                        <!-- Description -->

                                        <div class="form-row mt-1">

                                            <div class="col-lg-12">
                                                <label for="tb_description">
                                                    <p class="text-muted"><i class="fas fa-edit"></i>Item Description </p>
                                                </label>
                                                <CKEditor:CKEditorControl ID="ckeditorUpdateProduct" runat="server"></CKEditor:CKEditorControl>
                                            </div>

                                        </div>

                                        <!-- Resumo -->


                                        <div class="form-row mt-4 d-flex justify-content-between">
                                            <div class="col-lg-6 mb-2">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fas fa-pen"></i></span>
                                                    </div>
                                                    <input class="form-control" runat="server" type="text" id="tb_updateSummary" placeholder="Summary" data-toggle="tooltip" data-placement="Top" title="Insert the summary, a shortened product description." required />
                                                </div>
                                            </div>
                                            <div class="input-group mb-3 col-sm-12 col-md-5 col-lg-5">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text" for="ddl_category">Category</label>
                                                </div>
                                                <asp:DropDownList ID="ddl_updateCategory" EnableViewState="true" class="form-control" runat="server" DataSourceID="SQLcategory" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                            </div>

                                        </div>
                                        <!-- /Resumo -->
                                        <!-- Price || Brand-->
                                        <div class="form-row mt-1 d-flex justify-content-between">

                                            <div class="col-md-6 mb-2">
                                                <div class="input-group">
                                                    <div class="input-group-append">
                                                        <span class="input-group-text text-center">&nbsp;<i class="fas fa-euro-sign"></i></span>
                                                    </div>
                                                    <input type="number" class="form-control" runat="server" id="tb_updatePrice" aria-describedby="inputGroupPrepend4" min="0.00" max="99999.00" step="0.01" placeholder="Price" title="Only numbers allowed" required>
                                                </div>
                                            </div>
                                            <div class="input-group mb-3 col-md-5 col-sm-12">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text" for="ddl_brand">Brand&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                </div>
                                                <asp:DropDownList ID="ddl_updateBrand" EnableViewState="true" class="form-control" runat="server" DataSourceID="SQLbrand" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <!-- /Price-->

                                        <!-- Generic || Prescription || Generic-Product -->
                                        <div class="form-row mt-2 mb-2 d-flex justify-content-between">

                                            <div class="btn-group-toggle col-md-6 d-flex justify-content-around mb-3" data-toggle="buttons">

                                                <label class="btn btn-outline-dark rounded-right">
                                                    <input type="checkbox" name="active" id="check_updateActive" runat="server" autocomplete="off">
                                                    Active   
                                                </label>

                                                <label class="btn btn-outline-warning rounded-left">
                                                    <input type="checkbox" name="prescription" id="check_updatePrescription" runat="server" autocomplete="off">
                                                    Prescription
                                                </label>

                                                <label class="btn btn-outline-warning rounded-left" onclick="showHideUpdateGenParents()">
                                                    <input type="checkbox" name="generic" id="check_updateGeneric" runat="server" autocomplete="off">
                                                    Generic
                                                </label>

                                            </div>

                                            <div class="input-group mb-3 col-md-5 col-sm-12" id="genericUpdateParentsDiv">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text" for="ddl_updateGenericParent">Parent&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                </div>
                                                <asp:DropDownList ID="ddl_updateGenericParent" EnableViewState="true" class="form-control" runat="server" DataSourceID="SQLgenericParent" DataTextField="nome" DataValueField="Codreferencia"></asp:DropDownList>
                                            </div>

                                        </div>

                                        <!-- //Brand || Prescription || Generic-Product-->

                                    </div>
                                    <!-- WINDOW PADDING -->

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

                                </ContentTemplate>

                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="link_updateProductDetails" />
                                </Triggers>

                            </asp:UpdatePanel>
                        </div>
                        <!-- END MODAL BODY CONTENT -->
                    </div>
                </div>
            </div>
   <!-- //UPDATE PRODUCTS MODAL -->



    <!-- INSERT\UPDATE BRANDS Modal -->
    <!--TESTADO ESTÁ A FUNCIONAR COMO DEVE SER -->
    <asp:UpdatePanel ID="udtpBrands" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>

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

                <div class="modal-body">
                    
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>

                    <div class="form-row col-md-12 d-flex form-inline">

                        <input type="text" class="form-control w-75" runat="server" id="tb_insertBrand" placeholder="Brand">
                        <asp:LinkButton ID="link_insertBrand" runat="server" CommandArgument="usp_insertBrand" CommandName="brand" class="btn btn-warning ml-3 shadow shadow-sm" Style="padding-left: 1.5em; padding-right: 1.5em;" OnClick="link_insertCategoryBrand">Insert</asp:LinkButton>

                    </div>

                    <div class="form-group">

                        <div class="form-row col-md-12 mt-4 d-flex form-inline">

                            <asp:DropDownList ID="ddl_allBrands" class="form-control w-75" runat="server" DataSourceID="SQLbrand" DataTextField="descricao" DataValueField="ID" AutoPostBack="True"></asp:DropDownList>

                            <button class="btn btn-dark ml-3 shadow shadow-sm" type="button" data-toggle="collapse" data-target="#collapseBrandUpdate" aria-expanded="false" aria-controls="collapseExample">
                                <i class="fas fa-pen"></i>
                            </button>

                            <asp:LinkButton ID="link_deleteBrand" runat="server" class=" ml-2 btn btn-danger shadow shadow-sm" OnClick="link_deleteBrand_Click">
                                 <i class="fas fa-trash"></i>
                            </asp:LinkButton>


                        </div>

                        <div class="collapse" id="collapseBrandUpdate">

                            <div class="form-row col-md-12 mt-4">
                                <input type="text" class="form-control w-75" runat="server" id="tb_updateBrand" placeholder="Update brand">
                                <asp:LinkButton ID="link_updateBrand" class="btn btn-dark ml-3" Style="padding-left: 1.2em; padding-right: 1.2em;" runat="server" OnClick="link_updateBrand_Click">Update</asp:LinkButton>
                           </div>

                        </div>

                    </div>

                    <label class="mt-2 text-center col-12" id="lbl_BrandMessage" runat="server"></label>

                           </ContentTemplate>
                        </asp:UpdatePanel>

                </div> <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- /INSERT BRANDS Modal -->


    <!-- INSERT CATEGORIES Modal -->
    <!--TESTADO ESTÁ A FUNCIONAR COMO DEVE SER -->
    <asp:UpdatePanel ID="udptCategory" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
   
            <!-- INSERT\UPDATE CATEGORIES Modal -->
    <div class="modal fade ml-3 mt-5" id="modal-insert-category" tabindex="-1" role="dialog" aria-labelledby="modal-update-product" aria-hidden="true">
        <div class="modal-dialog modal-md shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-2 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-category-label">Categories
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    </h5>
                </div>
                <!-- BEGIN MODAL BODY CONTENT -->
                <div class=" modal-body">

                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>


                    <div class="form-row col-md-12 d-flex form-inline">
                        <input type="text" class="form-control w-75" runat="server" id="tb_insertCategory" placeholder="Category">
                        <asp:LinkButton ID="link_insertCategory" CommandArgument="usp_insertCategory" CommandName="category" class="btn btn-warning ml-3 shadow shadow-sm" Style="padding-left: 1.5em; padding-right: 1.5em;" runat="server" OnClick="link_insertCategoryBrand">Insert</asp:LinkButton>

                    </div>

                    <div class="form-group">

                        <div class="form-row col-md-12 mt-4 d-flex form-inline">

                            <asp:DropDownList ID="ddl_allCategories" class="form-control w-75" runat="server" DataSourceID="SQLcategory" DataTextField="descricao" DataValueField="ID"></asp:DropDownList>

                            <button class="btn btn-dark ml-3 shadow shadow-sm" type="button" data-toggle="collapse" data-target="#collapseCategoryUpdate" aria-expanded="false" aria-controls="collapseExample">
                                <i class="fas fa-pen"></i>
                            </button>

                            <asp:LinkButton ID="link_deleteCategory" class=" ml-2 btn btn-danger shadow shadow-sm" runat="server" OnClick="link_deleteCategory_Click">
                                <i class="fas fa-trash"></i>
                            </asp:LinkButton>


                        </div>

                        <div class="collapse" id="collapseCategoryUpdate">

                            <div class="form-row col-md-12 mt-4">

                                <input type="text" class="form-control w-75" runat="server" id="tb_updateCategory" placeholder="Update category">
                                <asp:LinkButton ID="link_updateCategory" class="btn btn-dark ml-3" Style="padding-left: 1.2em; padding-right: 1.2em;" runat="server" OnClick="link_updateCategory_Click">Update</asp:LinkButton>

                            </div>

                        </div>


                    </div>

                    <label class="mt-2 text-center col-12" id="lbl_CategoryMessage" runat="server"></label>


                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- //INSERT CATEGORIES Modal -->



    <!-- TESTE -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap core JavaScript -->  
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    <!-- SQLSOURCES AND REPEATER SOURCES -->
    <asp:SqlDataSource ID="SQLcategory" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Categoria] ORDER BY descricao ASC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLbrand" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Marca] ORDER BY descricao ASC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLgenericParent" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * from produto where ref_generico IS NULL and produto.Descontinuado != 1 ORDER BY Produto.nome"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLrptProdutos" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_listBackofficeProducts" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLrptArchived" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_listArchivedBackofficeProducts" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>


