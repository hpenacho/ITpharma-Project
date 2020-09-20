<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Stock.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Stock" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


 <style>

     #stockupdate:hover {
         color: orange;
     }

     a.active.nav-item.nav-link {
         background-color: orange !important;
         color: white !important;
     }

     a.nav-item.nav-link {
         color: #333 !important;
     }

     #home-tab.active {
         background-color: orange !important;
         color: white !important;
     }

     #home-tab {
         background-color: whitesmoke !important;
         color: #333 !important;
     }

     #profile-tab.active {
         background-color: orange !important;
         color: white !important;
     }

     #profile-tab {
         background-color: whitesmoke !important;
         color: #333 !important;
     }



 </style> 


    <script type="text/javascript">

        $(document).ready(function () {
            $('table.stock').DataTable();
        });

        $(document).ready(function () {
            $('table.restock').DataTable({
                scrollY: 500,
                searching: false
            });
        });

    </script>

  
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">


        <div class="container-fluid">

            <div class="row mb-3">
                <div class="col-lg-12 text-center">
                    <h1 class="mb-2">Manage Stock</h1>
                </div>
            </div>
        </div>

         <!-- RESTOCK BUTTON -->
        <div class="row my-3 text-center">
            <div class="container">
                 <button id="btn_NeedsRestock" runat="server" type="button" class="btn btn-dark" data-toggle="modal" data-target="#restock-products">RESTOCK ALL</button>
            </div>
        </div>
        <!-- //RESTOCK BUTTON -->


    <!-- tab controls -->
        <div class="col-lg-12 col-md-12 col-sm-12 mb-4">
            <!-- /Insert Products -->
            <ul class="nav nav-pills" id="myTab" role="tablist">

                <li class="nav-item w-50 text-center shadow shadow-sm">
                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#stock" role="tab" aria-controls="products" aria-selected="true">
                        <h5>Stock</h5>
                    </a>
                </li>

                <li class="nav-item w-50 text-center shadow shadow-sm">
                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#pickup" role="tab" aria-controls="archived" aria-selected="false">
                        <h5>Pickup</h5>
                    </a>
                </li>

            </ul>
        </div>
     <!-- //tab controls -->



    <!-- tab content -->
    <div class="tab-content" id="myTabContent">
                
        <!-- STORE STOCK TABLE -->
        <div class="tab-pane fade show active" id="stock" role="tabpanel" aria-labelledby="store-tab">
                   <div class="container-fluid">

                        <h4>Stock Store Warehouse</h4>

                            <div class="table-responsive">

                                <table class="table stock table-hover table-light rounded shadow shadow-sm" id="" width="100%" cellspacing="0">

                                    <thead class="text-center text-white thead-dark align-middle">
                                        <!-- HEADER OF THE TABLE -->
                                        <tr>
                                            <th>Cod</th>
                                            <th>Name</th>
                                            <th>Cur. Qty</th>
                                            <th>Min. Qty</th>
                                            <th>Max. Qty</th>
                                            <th>Status</th>
                                            <th class="text-hide"></th>
                                        </tr>
                                    </thead>

                                    <tbody class="text-center text-md-center">

                                        <!-- PRODUCTS -->

                                        <asp:Repeater ID="rpt_infoStock" runat="server" DataSourceID="sqlStock" OnItemDataBound="rpt_infoStock_ItemDataBound" OnItemCommand="rpt_infoStock_ItemCommand">
                                            <ItemTemplate>

                                                <tr class="text-center align-middle">

                                                    <td class="align-middle">
                                                        <%# Eval("Codreferencia") %>
                                                    </td>

                                                    <td class="align-middle">
                                                        <%# Eval("nome") %>
                                                    </td>

                                                    <td class="align-middle">
                                                        <label class="text-hide" style="display: none"><%# Eval("Qtd") %></label>
                                                        <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_qty" runat="server" min="0" value='<%# Eval("Qtd") %>' />
                                                    </td>

                                                    <td class="align-middle">
                                                        <label class="text-hide" style="display: none"><%# Eval("QtdMin") %></label>
                                                        <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_qtymin" runat="server" min="0" value='<%# Eval("QtdMin") %>' />
                                                    </td>

                                                    <td class="align-middle">
                                                        <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_qtymax" runat="server" min="1" value='<%# Eval("QtdMax") %>' />
                                                        <label class="text-hide" style="display: none"><%# Eval("QtdMax") %></label>
                                                    </td>

                                                    <td class="align-middle">
                                                        <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
                                                    </td>

                                                    <td class="align-middle">
                                                        <asp:LinkButton CssClass="btn bg-transparent" CommandName="link_updateStock" CommandArgument='<%# Eval("Codreferencia") %>' ID="link_updateStock" runat="server"><i id="stockupdate" class="fas fa-save"></i></asp:LinkButton>
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
        <!-- //ACTIVE PRODUCT TABLE -->
          
        <!-- PICKUP STOCK TABLE -->
        <div class="tab-pane fade show" id="pickup" role="tabpanel" aria-labelledby="pickup-tab">
                    
                 <div class="container-fluid">

                     <!-- selection of pickup atm -->
                     <div class="col-lg-12 d-flex justify-content-center">
                        <asp:DropDownList ID="ddl_pickupstock" class="form-control mb-4 text-center w-25 shadow shadow-sm bg-light border-0" runat="server" DataSourceID="sqlPickupChooser" DataTextField="Descricao" DataValueField="ID" OnSelectedIndexChanged="ddl_pickupstock_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                     </div>
                     <!-- //selection of pickup atm -->

                        <h4>Stock Pickups Warehouse</h4>

                            <div class="table-responsive">

                                <table class="table stock table-hover table-light rounded shadow shadow-sm" id="">

                                    <thead class="text-center thead-dark align-middle shadow shadow-sm">
                                        <!-- HEADER OF THE TABLE -->
                                        <tr>
                                            <th>Cod</th>
                                            <th>Name</th>
                                            <th>Cur. Qty</th>
                                            <th>Min. Qty</th>
                                            <th>Max. Qty</th>
                                            <th>Status</th>
                                            <th class="text-hide"></th>
                                        </tr>
                                    </thead>

                                    <tbody class="text-center text-md-center">

                                        <!-- PRODUCTS -->

                                        <asp:Repeater ID="rpt_pickupStock" runat="server" DataSourceID="sqlPickupStock" OnItemDataBound="rpt_pickupStock_ItemDataBound" OnItemCommand="rpt_pickupStock_ItemCommand">
                                            <ItemTemplate>

                                                <tr class="text-center align-middle">

                                                    <td class="align-middle">
                                                        <%# Eval("Codreferencia") %>
                                                    </td>

                                                    <td class="align-middle">
                                                        <%# Eval("nome") %>
                                                    </td>

                                                    <td class="align-middle">
                                                        <label class="text-hide" style="display: none"><%# Eval("Qtd") %></label>
                                                        <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_PickupQty" runat="server" value='<%# Eval("Qtd") %>' />
                                                    </td>

                                                    <td class="align-middle">
                                                        <label class="text-hide" style="display: none"><%# Eval("QtdMin") %></label>
                                                        <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_PickupQtymin" runat="server" value='<%# Eval("QtdMin") %>' />
                                                    </td>

                                                    <td class="align-middle">
                                                        <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_PickupQtymax" runat="server" value='<%# Eval("QtdMax") %>' />
                                                        <label class="text-hide" style="display: none"><%# Eval("QtdMax") %></label>
                                                    </td>

                                                    <td class="align-middle">
                                                        <asp:Label ID="lbl_PickupStatus" runat="server" Text=""></asp:Label>
                                                    </td>

                                                    <td class="align-middle">
                                                        <asp:LinkButton CssClass="btn bg-transparent" CommandName="link_updatePickupStock" CommandArgument='<%# Eval("Codreferencia") %>' ID="link_updatePickupStock" runat="server"><i id="stockupdate" class="fas fa-save"></i></asp:LinkButton>
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
        <!-- //PICKUP STOCK TABLE -->

        </div>
    <!-- //tab content -->

    </div>



    <!-- RESTOCK MODAL -->
    <asp:UpdatePanel ID="upd_restock" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="modal fade my-5 mb-5" id="restock-products" tabindex="-1" role="dialog" aria-labelledby="restock-products" aria-hidden="true">
                <div class="modal-dialog modal-xl shadow-lg" role="document">
                    <div class="modal-content" style="margin-bottom: 10em;">
                        <div class="modal-header py-2 modal-title bg-dark rounded-top text-light">
                            <h5 class="modal-title col-12 text-center" id="modal-insert-brand-label">Restock
                         <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                             <span aria-hidden="true">&times;</span>
                         </button>
                            </h5>
                        </div>
                        <!-- BEGIN MODAL BODY CONTENT -->

                        <div class="modal-body">

                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>


                                    <table class="table table-borderless restock">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>Restock</th>
                                                <th >Warehouse</th>
                                                <th>Product Ref</th>
                                                <th>Product Name</th>
                                                <th>Qtd</th>
                                            </tr>
                                        </thead>
                                        <tbody>


                                            <!-- item in need of restocking both in warehouse and pickup -->

                                            <asp:Repeater ID="rpt_itemNeedsRestock" runat="server" DataSourceID="sqlNeedsRestock">
                                                <ItemTemplate>


                                                    <tr>

                                                        <th>
                                                            <div class="btn-group-toggle" data-toggle="buttons">
                                                                <label class="btn btn-primary">
                                                                    <asp:CheckBox ID="ck_needsRestock" runat="server" autocomplete="off"/>
                                                                    Restock
                                                                </label>
                                                            </div>
                                                        </th>

                                                        <td>
                                                            <asp:Label ID="lbl_warehouse" runat="server" Text='<%# Eval("Warehouse") %>'></asp:Label>
                                                        </td>

                                                        <td>
                                                            <asp:Label ID="lbl_ProductRef" runat="server" Text='<%# Eval("ProductRef") %>'></asp:Label>
                                                        </td>

                                                        <td>
                                                            <%# Eval("ProductName") %>
                                                        </td>

                                                        <td>
                                                            <%# Eval("Qtd") %>
                                                        </td>

                                                    </tr>


                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </tbody>
                                    </table>


                                    <!-- //item in need of restocking both in warehouse and pickup -->

                                </ContentTemplate>
                            </asp:UpdatePanel>


                        </div>
                        <!-- END MODAL BODY CONTENT -->
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- /INSERT BRANDS Modal -->


    <!-- //RESTOCK MODAL -->





    <!-- SQL SOURCES -->
    <asp:SqlDataSource ID="sqlStock" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_infoStock" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPickupChooser" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Pickup]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPickupStock" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnPickupStock" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_pickupstock" DefaultValue="1" Name="PickupID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlNeedsRestock" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_ItemsNeedingRestock" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>
