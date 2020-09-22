﻿<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Orders.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Orders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <script type="text/javascript">

        $(document).ready(function () {
            $('table.orders').DataTable();
        });

    </script>

    <style>

        table{
            text-align:center;
            vertical-align: middle;
        }

    </style>


    <!-- TESTE -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap core JavaScript -->  
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="container-fluid mt-5">

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
                        <table class="table orders table-hover" id="">
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

                                <asp:Repeater ID="rpt_orders" runat="server" DataSourceID="sqlSourceOrderDetails" OnItemCommand="rpt_parent_orders_ItemCommand">
                                    <ItemTemplate>

                                        <!-- ORDERS -->

                                        <tr class="text-center align-middle">

                                            <td style="vertical-align: middle">
                                                <%# Eval("Ref") %>
                                            </td>

                                            <td style="vertical-align: middle">
                                                <%#  DateTime.Parse(Eval("dataCompra").ToString()).ToString("MMMM dd, yyyy") %>
                                            </td>

                                            <td style="vertical-align: middle">
                                                <%# Eval("clientName") %>
                                            </td>

                                            <td style="vertical-align: middle">
                                                <%# Eval("orderTotal") %> €
                                            </td>

                                            <td style="vertical-align: middle">
                                                <asp:DropDownList ID="ddl_orderStatus" runat="server" class="form-control border-white btn-dark" DataSourceID="sqlSourceStatus" DataTextField="Descricao" DataValueField="ID"></asp:DropDownList>
                                            </td>

                                            <td style="vertical-align: middle">
                                                <%#  DateTime.Parse(Eval("ultimaActualizacao").ToString()).ToString("MMMM dd, yyyy H:mm") %>h
                                            </td>

                                            <td style="vertical-align: middle">
                                                <asp:LinkButton ID="link_orderDetails" CommandName="link_orderDetails" CommandArgument='<%# Eval("Ref") %>' CssClass="btn btn-warning" runat="server"><i class="fas fa-info"></i></asp:LinkButton>
                                            </td>

                                            <td style="vertical-align: middle">
                                                <asp:LinkButton ID="link_updateOrder" CommandArgument='<%# Eval("Ref") %>' CommandName="link_updateOrder" CssClass="btn btn-warning" runat="server"><i id="produpdate" class="fas fa-save"></i></asp:LinkButton>
                                            </td>

                                        </tr>

                                        <!-- //ORDERS -->
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
     </div>


    <!-- ORDER MODAL -->
    <div class="modal fade ml-2" id="order-contents" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-dark text-light text-center">
                    <h5 class="modal-title">Order Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="table-responsive">
                    <table class="table table-borderless" width="100">

                        <tbody>
                            <asp:Repeater ID="rpt_orderDetails" runat="server" DataSourceID="sqlSourceOrders">
                                <ItemTemplate>
                                    <tr>
                                        <td style="vertical-align: middle;">
                                            <img src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="" width="80" class="img-fluid rounded align-middle">
                                        </td>

                                        <td style="vertical-align: middle;">
                                            <%# Eval("nome") %>
                                        </td>

                                        <td style="vertical-align: middle;">
                                            <%# Eval("Qtd") %>
                                        </td>

                                        <td style="vertical-align: middle;">
                                            <%# Eval("PriceAtTime") %> €
                                        </td>

                                        <td style="vertical-align: middle;">
                                            <%# Eval("Total") %> €
                                        </td>

                                    </tr>

                                </ItemTemplate>
                            </asp:Repeater>

                        </tbody>

                    </table>
                </div>

                </div>
            </div>

        </div>
    </div>
    <!-- //ORDER MODAL -->




    <!-- Returns the orders -->
    <asp:SqlDataSource ID="sqlSourceOrders" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnBackofficeOrderDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="EncRef" Type="Int32" />
        </SelectParameters>
     </asp:SqlDataSource>

    <!-- Returns order's details -->
    <asp:SqlDataSource ID="sqlSourceOrderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnBackofficeOrders" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <!-- Order Status  -->
    <asp:SqlDataSource ID="sqlSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [Estado] WHERE ([Tipo] = @Tipo)">
        <SelectParameters>
            <asp:Parameter DefaultValue="false" Name="Tipo" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
