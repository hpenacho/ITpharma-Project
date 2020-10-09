﻿<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Cart.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Cart" %>

<%@ Register Src="~/TargetedAds.ascx" TagPrefix="uc1" TagName="TargetedAds" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">




</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:UpdatePanel ID="updshoppingcart" runat="server" UpdateMode="Always">
        <ContentTemplate>

            <div class="container mt-5">
                <h2 class="h2 text-center">Your Shopping Cart</h2>

                <!-- Shopping cart table -->
                <div class="table-responsive mt-4">
                    <table class="table">
                        <thead class="thead-dark text-white text-center">
                            <tr>
                                <th scope="col" class="rounded-left text-center">
                                    <div class="px-2 text-capitalize">Product</div>
                                </th>
                                <th scope="col" class="text-center">
                                    <div class="px-2 text-capitalize">Price</div>
                                </th>
                                <th scope="col" class="text-center">
                                    <div class="px-2 text-capitalize">Qty</div>
                                </th>
                                <th scope="col" class="rounded-right text-center">
                                    <div class="px-2 text-capitalize">Remove</div>
                                </th>
                            </tr>
                        </thead>

                        <!-- FIM CABEÇALHO -->

                        <tbody>

                            <asp:Repeater ID="rptModalCart" runat="server" DataSourceID="SqlSourceCart" OnItemDataBound="rptModalCart_ItemDataBound" OnItemCommand="rptModalCart_ItemCommand">

                                <ItemTemplate>

                                    <tr>

                                        <td class="row justify-content-around" style="vertical-align: middle">

                                            <div class="col" style="max-width: 110px; height: 110px; min-width: 110px;">
                                                <img src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("ProdImage")) %>" alt="" class="align-middle" style="vertical-align: middle; height: 100%; width: 100%; object-fit: contain; overflow: hidden">
                                            </div>

                                            <div class="col ml-2 d-inline-block align-content-end align-self-center">
                                                <h5 class="mb-0"><a href="storeFront-itemPage.aspx?prod=<%# Eval("Prod_Ref") %>" class="text-dark d-inline-block"><%# Eval("ProdName") %></a></h5>
                                                <h6 class="small text-muted"><%# Eval("ProdSummary") %></h6>
                                            </div>

                                        </td>

                                        <td class="align-middle text-center">
                                            <asp:Label ID="lb_total" runat="server" CssClass="w-100" Font-Bold="true"><%# Eval("Unit Price") %> €</asp:Label>
                                            <asp:Label ID="lb_prodRef" runat="server" Visible="false" Text='<%# Eval("Prod_Ref") %>'></asp:Label>
                                        </td>

                                        <td class="align-middle text-center">

                                            <div class="justify-content-between align-middle text-center">
                                                <asp:LinkButton runat="server" ID="link_decreaseQty" CommandName="link_decreaseQty" CommandArgument='<%# Eval("Prod_Ref") %>' class="btn btn-warning btn-sm mr-1 rounded"><i class="fas fa-minus"></i></asp:LinkButton>
                                                <label id="itemQty" class="font-weight-bold border-0 text-center" style="width: 1.5em;"><%# Eval("Qty") %></label>
                                                <asp:LinkButton runat="server" ID="link_increaseQty" CommandName="link_increaseQty" CommandArgument='<%# Eval("Prod_Ref") %>' class="btn btn-warning btn-sm mr-1 rounded"><i class="fas fa-plus"></i></asp:LinkButton>
                                            </div>

                                        </td>

                                        <td class="align-middle text-center">
                                            <asp:LinkButton ID="linkDeleteCartItem" class="text-danger" CommandArgument='<%# Eval("Prod_Ref") %>' CommandName="linkDeleteCartItem" Style="cursor: pointer; background-color: transparent; border-color: transparent; font-size: 20px;" runat="server"><i class="fas fa-times-circle"></i></asp:LinkButton>
                                        </td>

                                    </tr>

                                </ItemTemplate>
                            </asp:Repeater>

                        </tbody>
                    </table>
                </div>
                <!-- FOOTER -->
                <div class="row justify-content-between mt-3">

                    <div class="col-lg-7">

                        <div class="col-lg-12 mb-2">
                            <a href="storeFront-Checkout.aspx" class="btn btn-warning w-75 rounded mb-1">Checkout</a>
                            <asp:LinkButton ID="link_clearCart" CssClass="btn btn-dark w-75 rounded mt-1" runat="server">Clear&nbspCart</asp:LinkButton>
                        </div>

                    </div>

                    <div class="col-lg-5 text-right">

                        <h5 class="bg-dark rounded py-1 text-white text-center">Summary</h5>

                        <ul class="list-unstyled mb-4">

                            <li class="d-flex justify-content-between py-1 border-bottom small"><strong class="text-dark">Tax (6%)</strong>
                                <label id="lbl_tax" class="text-black font-weight-bold" runat="server"></label>
                            </li>

                            <li class="d-flex justify-content-between py-1 border-bottom small"><strong class="text-dark">SubTotal</strong>
                                <label id="lbl_SubTotal" class="text-black" runat="server"></label>
                            </li>

                            <li class="d-flex justify-content-between py-1"><strong class="text-black">Order&nbspTotal</strong>
                                <label id="lbl_Total" class="font-weight-bold text-black" runat="server"></label>
                            </li>

                        </ul>
                    </div>

                </div>
            </div>
            <!-- //FOOTER -->
        </ContentTemplate>
    </asp:UpdatePanel>




    <!-- Sql Source -->
    <asp:SqlDataSource ID="SqlSourceCart" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnUserCartItems" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="id_cliente" Type="Int32" DefaultValue="0" />
            <asp:CookieParameter CookieName="noLogID" Name="cookies" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
