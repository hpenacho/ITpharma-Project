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
            $('table.restock').DataTable({
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
        <div class="row my-5 text-center">
            <div class="container">
                 <button type="button" class="btn btn-dark shadow shadow-sm"  data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"><i class="fas fa-layer-group"></i>&nbsp&nbspRESTOCK ALL</button>
            </div>
        </div>
        <!-- //RESTOCK BUTTON -->


        <div class="container">
            <div class="collapse my-4" id="collapseExample">
                <div class="card card-body">
                    <table class="table table-hover table-borderless restock">
                        <thead class="text-center">
                            <tr>
                                <th>Restock</th>
                                <th>Warehouse</th>
                                <th>Product Ref</th>
                                <th>Product Name</th>
                                <th>Qtd</th>
                                <th>Qtd Min</th>
                            </tr>
                        </thead>
                        <tbody>

                            <asp:Repeater ID="rpt_itemNeedsRestock" runat="server" DataSourceID="sqlNeedsRestock">
                                <ItemTemplate>

                                    <tr class="text-center" style="vertical-align: middle">
                                        <th style="vertical-align: middle">
                                            <div class="btn-group-toggle" data-toggle="buttons">
                                                <label class="btn btn-warning">
                                                    <asp:CheckBox ID="ck_needsRestock" runat="server" autocomplete="off" />
                                                    Restock
                                                </label>
                                            </div>
                                        </th>

                                        <td style="vertical-align: middle">
                                            <asp:Label ID="lbl_warehouse" runat="server" Text='<%# Eval("Warehouse") %>'></asp:Label>
                                        </td>

                                        <td style="vertical-align: middle">
                                            <asp:Label ID="lbl_ProductRef" runat="server" Text='<%# Eval("ProductRef") %>'></asp:Label>
                                        </td>

                                        <td style="vertical-align: middle">
                                            <%# Eval("ProductName") %>
                                        </td>

                                        <td style="vertical-align: middle">
                                            <%# Eval("Qtd") %>
                                        </td>

                                        <td style="vertical-align: middle">
                                            <%# Eval("QtdMin") %>
                                        </td>

                                    </tr>

                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>

                    <div class="col-lg-12 text-center my-4">
                        <asp:LinkButton ID="linkRestockAll" CssClass="btn btn-dark" runat="server" OnClick="linkRestockAll_Click">Restock All</asp:LinkButton>
                        <asp:LinkButton ID="linkRestockSelected" CssClass="btn btn-warning" runat="server" OnClick="linkRestockSelected_Click">Restock Selected</asp:LinkButton>
                    </div>

                </div>
            </div>
        </div>




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
