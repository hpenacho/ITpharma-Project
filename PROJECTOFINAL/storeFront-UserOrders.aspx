<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-UserOrders.aspx.cs" Inherits="PROJECTOFINAL.storeFront_UserOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid" style="margin-top: 4em">
        <div class="card shadow shadow-sm mt-3 mb-3" style="border-radius: 15px;">
            <div class="card-header text-center" style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
               <div class="row">
                <div class="col-md-3">
                    <b>Order Reference #</b><asp:Label ID="lbl_EncRef" runat="server" Text="[missing]"></asp:Label>
                </div>
                <div class="col-md-3">
                 <b>Date: </b> <asp:Label ID="lbl_orderDate" runat="server" Text="[missing]"></asp:Label>
                </div>
                   <div class="col-md-3">
                     <strong>Status: </strong><asp:Label ID="lbl_orderStatus" runat="server" Text="[missing]"></asp:Label>
                   </div>
                   <div class="col-md-3">
                       <asp:LinkButton ID="lbtn_pdf" CssClass="btn btn-danger" runat="server" OnClick="lbtn_pdf_Click"><i class="fas fa-file-pdf"></i> <label id="pdfText" runat="server" style="cursor:pointer;">Order PDF</label> </asp:LinkButton>                                           
                       <asp:LinkButton ID="lbtn_qr" CssClass="btn btn-primary" runat="server" style="cursor:pointer;" Visible="false" OnClick="lbtn_qr_Click"><i class="fas fa-qrcode"></i> View QR Code</> </asp:LinkButton> 
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
                            <strong> <asp:Label ID="lbl_customerName" runat="server" Text="[missing]"></asp:Label> </strong>
                        </div>
                        <div> <asp:Label ID="lbl_address" runat="server" Text="[missing]"></asp:Label> </div>
                        <div><asp:Label ID="lbl_zip" runat="server" Text="[missing]"></asp:Label></div>
                        <div>Email: <asp:Label ID="lbl_email" runat="server" Text="[missing]"></asp:Label></div>
                        <div>NIF: <asp:Label ID="lbl_nif" runat="server" Text="Not provided."></asp:Label></div>
                    </div>
                </div>
                <div class="table-responsive-sm">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th class="center">#</th>
                                <th>Name</th>
                                <th class="right">Unit Cost</th>
                                <th class="center">Qty</th>
                                <th class="right">Total</th>
                            </tr>
                        </thead>
                        <tbody>

                            <asp:Repeater ID="rpt_orderItems" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="rpt_orderItems_ItemDataBound">
                                <ItemTemplate>
                            <tr>
                                <td class="center">
                                    <label class="col-form-label"><%# Eval("Prod_ref") %></label>
                                </td>
                                <td class="left">
                                    <label class="col-form-label"><%# Eval("ProdName") %></label>
                                </td>
                                <td class="right">
                                    <label class="col-form-label"><%# Eval("Unit Price") %> €</label>
                                </td>
                                <td class="center">
                                    <label class="col-form-label"><%# Eval("Qty") %></label>
                                </td>
                                <td class="right">
                                    <label class="col-form-label"><%# Eval("itemTotalPrice") %> €</label>
                                </td>
                            </tr>
                            
                                </ItemTemplate>
                            </asp:Repeater>
                                                                                                                                                                                                                                                                                                                                   
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnStoreFrontUserOrderDetails" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter Name="ID_cliente" Type="Int32" />
                                    <asp:QueryStringParameter Name="Enc_reference" QueryStringField="order" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            
                                                                                                                                                                                                                                                                                                                                   
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
                                    <td class="right"><asp:Label ID="lbl_subTotal" runat="server" Text="[missing]"></asp:Label></td>
                                </tr>                              
                                <tr>
                                    <td class="left">
                                        <strong>IVA (6%)</strong>
                                    </td>
                                    <td class="right"> <asp:Label ID="lbl_tax" runat="server" Text="[missing]"></asp:Label> </td>
                                </tr>
                                <tr>
                                    <td class="left">
                                        <strong>Total(€)</strong>
                                    </td>
                                    <td class="right">
                                        <strong> <asp:Label ID="lbl_Total" runat="server" Text="[missing]"></asp:Label> </strong>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
