<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-UserOrders.aspx.cs" Inherits="PROJECTOFINAL.storeFront_UserOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
        <div class="card shadow shadow-sm mt-3 mb-3" style="border-radius: 15px;">
            <div class="card-header text-center" style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
               <div class="row">
                <div class="col-md-4">
                    <b>Order Reference #</b><asp:Label ID="lbl_EncRef" runat="server" Text="4743"></asp:Label>
                </div>
                <div class="col-md-4">
                 <b>Date: </b> <asp:Label ID="lbl_orderDate" runat="server" Text="01-01-2020"></asp:Label>
                </div>
                   <div class="col-md-4">
                     <strong>Status: </strong><asp:Label ID="lbl_orderStatus" runat="server" Text="Delivered"></asp:Label>
                   </div>
                   </div>
            </div>
            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-sm-6">
                        <h6 class="mb-3">From:</h6>
                        <div>
                            <strong>ITpharma</strong>
                        </div>
                        <div>71-101 Money Street, PT</div>
                        <div>2774-449</div>
                        <div>Email: ITpharmaProject@outlook.com</div>
                        <div>Phone: +351 2160789332</div>
                    </div>
                    <div class="col-sm-6">
                        <h6 class="mb-3">To:</h6>
                        <div>
                            <strong> <asp:Label ID="lbl_customerName" runat="server" Text="Hugo Penacho"></asp:Label> </strong>
                        </div>
                        <div> <asp:Label ID="lbl_address" runat="server" Text="Rua do Fim de Linha 123"></asp:Label> </div>
                        <div><asp:Label ID="lbl_zip" runat="server" Text="2345-765"></asp:Label></div>
                        <div>Email: <asp:Label ID="lbl_email" runat="server" Text="example@gmail.com"></asp:Label></div>
                        <div>NIF: <asp:Label ID="lbl_nif" runat="server" Text="Not provided."></asp:Label></div>
                    </div>
                </div>
                <div class="table-responsive-sm">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th class="center">#</th>
                                <th>Item</th>
                                <th>Description</th>
                                <th class="right">Unit Cost</th>
                                <th class="center">Qty</th>
                                <th class="right">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="center">1</td>
                                <td class="left strong">Origin License</td>
                                <td class="left">Extended License</td>
                                <td class="right">$999,00</td>
                                <td class="center">1</td>
                                <td class="right">$999,00</td>
                            </tr>
                            <tr>
                                <td class="center">2</td>
                                <td class="left">Custom Services</td>
                                <td class="left">Instalation and Customization (cost per hour)</td>
                                <td class="right">$150,00</td>
                                <td class="center">20</td>
                                <td class="right">$3.000,00</td>
                            </tr>
                            <tr>
                                <td class="center">3</td>
                                <td class="left">Hosting</td>
                                <td class="left">1 year subcription</td>
                                <td class="right">$499,00</td>
                                <td class="center">1</td>
                                <td class="right">$499,00</td>
                            </tr>
                            <tr>
                                <td class="center">4</td>
                                <td class="left">Platinum Support</td>
                                <td class="left">1 year subcription 24/7</td>
                                <td class="right">$3.999,00</td>
                                <td class="center">1</td>
                                <td class="right">$3.999,00</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-5">
                    </div>
                    <div class="col-lg-4 col-sm-5 ml-auto">
                        <table class="table table-clear">
                            <tbody>
                                <tr>
                                    <td class="left">
                                        <strong>Subtotal</strong>
                                    </td>
                                    <td class="right"><asp:Label ID="lbl_subTotal" runat="server" Text="83.66"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="left">
                                        <strong>Discount (20%)</strong>
                                    </td>
                                    <td class="right"> Placeholder entry </td>
                                </tr>
                                <tr>
                                    <td class="left">
                                        <strong>IVA (6%)</strong>
                                    </td>
                                    <td class="right"> <asp:Label ID="lbl_tax" runat="server" Text="5.34"></asp:Label> </td>
                                </tr>
                                <tr>
                                    <td class="left">
                                        <strong>Total(€)</strong>
                                    </td>
                                    <td class="right">
                                        <strong> <asp:Label ID="lbl_Total" runat="server" Text="89"></asp:Label> </strong>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    

</asp:Content>
