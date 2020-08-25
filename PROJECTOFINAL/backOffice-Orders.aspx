<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Orders.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Orders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

          #produpdate:hover{
            color: orange;
          }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="container-fluid mt-5 d-flex align-items-center">

        <div class="col-lg-12">

            <h1>Orders</h1>
            <ol class="breadcrumb bg-dark text-white mb-4 shadow shadow-sm">
                <a class="breadcrumb-item text-white" href="backOffice-Index.aspx">Dashboard</a>
                <li class="breadcrumb-item active">Orders</li>
            </ol>

            <div class="card mb-4 shadow shadow-sm">
                <div class="card-header text-center bg-dark text-white">
                    <i class="fas fa-table mr-1"></i>
                    Current Orders
                </div>
                <div class="card-body">
                    <div class="table-responsive">

                        <table class="table" id="dataTable" width="100%" cellspacing="0">

                            <thead>
                                <!-- HEADER OF THE TABLE -->
                                <tr class="text-muted text-center">
                                    <th>#</th>
                                    <th>Created</th>
                                    <th>Customer</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Updated</th>
                                    <th class="text-hide"></th>
                                    <th class="text-hide"></th>
                                </tr>
                            </thead>

                            <tbody class="text-center">

                                <asp:Repeater ID="rpt_parent_orders" runat="server" DataSourceID="sqlSourceOrderDetails" OnItemDataBound="rpt_parent_orders_ItemDataBound">
                                    <ItemTemplate>

                                        <!-- ORDERS -->

                                        <tr class="text-center">

                                            <td>
                                                <%# Eval("Ref") %>
                                            </td>
                                            
                                            <td>
                                                <%# Eval("dataCompra") %>
                                            </td>
                                            
                                            <td>
                                                <%# Eval("clientName") %>
                                            </td>
                                            
                                            <td>
                                                <%# Eval("orderTotal") %> €
                                            </td>

                                            <td>
                                                <asp:DropDownList ID="ddl_orderStatus" runat="server" class="form-control border-white btn-dark" DataSourceID="sqlSourceStatus" DataTextField="Descricao" DataValueField="ID"></asp:DropDownList>
                                            </td>
                                            
                                            <td>
                                                <%# Eval("ultimaActualizacao") %>
                                            </td>

                                            <td>
                                                <button type="button" class="btn btn-warning" data-toggle="collapse" data-target='#collapseExample<%# Eval("Ref") %>' aria-expanded="false" aria-controls='collapseExample<%# Eval("Ref") %>'><i class="fas fa-sort-down"></i></button>
                                            </td>

                                            <td>
                                                <asp:LinkButton ID="link_updateOrder" runat="server"><i id="produpdate" class="fas fa-save"></i></asp:LinkButton>
                                            </td>

                                        </tr>

                                        <!-- //ORDERS -->

                                        <!-- ORDER PRODUCT -->
                                        <tr class="collapse" id='collapseExample<%# Eval("Ref") %>'>
                                            <asp:HiddenField ID="hidden_Order_ID" Value='<%# Eval("Ref") %>' runat="server" />

                                              
                                            <td colspan="8">
                                                        
                                                        <div class="col-lg-12 d-flex justify-content-between bg-dark pt-1 pb-1 rounded text-light mb-4">
                                                                       
                                                                       <div class ="col-lg-2">
                                                                            #
                                                                       </div>
                                                                        
                                                                        <div class ="col-lg-2">
                                                                            Ref
                                                                        </div>

                                                                        <div class ="col-lg-1">
                                                                            Qty
                                                                        </div>

                                                                        <div class ="col-lg-4">
                                                                            Name
                                                                        </div>

                                                                        <div class ="col-lg-1">
                                                                            Price
                                                                        </div>

                                                                        <div class ="col-lg-2">
                                                                            Total
                                                                        </div>
                                                             </div>

                                                <asp:Repeater ID="rpt_child_orders" runat="server">
                                                    
                                                    <ItemTemplate>

                                                            <div class="col-lg-12 mt-3 mb-3 d-flex justify-content-between">

                                                                
                                                                       <div class ="col-lg-2">
                                                                            <img src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="" width="70" class="img-fluid rounded align-middle">
                                                                       </div>
                                                                        
                                                                        <div class ="col-lg-2">
                                                                             <label class="col-form-label"><%# Eval("Prod_ref") %></label>
                                                                        </div>

                                                                        <div class ="col-lg-1">
                                                                             <label class="col-form-label"><%# Eval("Qtd") %></label>
                                                                        </div>

                                                                        <div class ="col-lg-4">
                                                                              <label class="col-form-label"><%# Eval("Nome") %></label>
                                                                        </div>

                                                                        <div class ="col-lg-1">
                                                                             <label class="col-form-label"><%# Eval("Preco") %> €</label>
                                                                        </div>

                                                                        <div class ="col-lg-2">
                                                                             <label class="col-form-label"><%# Eval("Total") %> €</label>
                                                                        </div>

                                                            </div>

                                                    </ItemTemplate>
                                                </asp:Repeater>

                                            </td>
                                        </tr>
                                        <!-- //ORDER PRODUCT -->

                                    </ItemTemplate>
                                </asp:Repeater>

                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Returns the order details -->
    <asp:SqlDataSource ID="sqlSourceOrderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnBackofficeOrders" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <!-- Order Status  -->
    <asp:SqlDataSource ID="sqlSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Estado] WHERE ([Tipo] = @Tipo)">
        <SelectParameters>
            <asp:Parameter DefaultValue="false" Name="Tipo" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
