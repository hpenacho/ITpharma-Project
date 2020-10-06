<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-Purchase.aspx.cs" Inherits="PROJECTOFINAL.ATM_Purchase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager> 

   <asp:UpdatePanel ID="updshoppingcart" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
     <ContentTemplate>
                        

                        <div class="container">
                            <div class="mt-4">


                                <!-- Shopping cart table -->
                                <div class="table-responsive rounded">
                                    <table class="table">
                                        <thead class="text-dark text-center" style="background-color: #82ce34;">
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

                                            <asp:Repeater ID="rptATMCart" runat="server" DataSourceID="SqlSourceCart" OnItemCommand="rptATMCart_ItemCommand" OnItemDataBound="rptATMCart_ItemDataBound">
                                               
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
                                                            <asp:Label ID="lb_total" runat="server" CssClass="w-100" Font-Bold="true"><%# Eval("Unit Price") %>€</asp:Label>
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
                            </div>
                            <!-- MODLA BODY -->

                            <!-- ATM FOOTER -->
                            <div class="container">

                                <div class="row justify-content-around">

                                    <div class="col-lg-7 text-left">

                                        <div class="col-lg-12 mb-2">
                                            <button type="button" class="btn btn-warning w-75 rounded rounded-pill" data-toggle="modal" data-target="#exampleModalCenter"> Pay </button>
                                        </div>

                                    </div>

                                    <div class="col-lg-5 text-right">

                                        <h5 class="rounded py-1 text-dark text-center" style="background-color: #82ce34;">Summary</h5>

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
                            <!-- //ATM FOOTER -->
                        </div>
                      <!-- ASYNC STUFF -->
                    </ContentTemplate>
                </asp:UpdatePanel> 

            <!-- Button trigger modal -->


<!-- Payment Modal -->
    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle"><i class="fas fa-hand-holding-usd"></i>Payment Method</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">


                    <div class="col-md-12 text-center mb-4">
                        <div class="btn-group btn-group-toggle" data-toggle="buttons" style="width: 500px; height: 200px;">
                            <label class="btn btn-light active">
                                <input type="radio" name="radioPayMethod" autocomplete="off" checked>
                                <p style="font-size: 80px"><i class="far fa-credit-card text-warning"></i></p>
                                <span style="font-size: 30px">Card</span>
                            </label>
                            <label class="btn btn-light">
                                <input type="radio" name="radioPayMethod" autocomplete="off">
                                <p style="font-size: 80px"><i class="far fa-money-bill-alt text-info"></i></p>
                                <span style="font-size: 30px">Cash </span>
                            </label>
                        </div>
                    </div>

                    <div class="row text-center justify-content-center">
                        <div class="col-md-6">
                            <input type="text" placeholder="NIF (optional)" class="form-control form-control-user bg-light" pattern="^\d{9}$" title="Insert your 9 Digit NIF (optional)" id="tb_NIF" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer text-center">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtn_finalizeOrder" CssClass="btn btn-success" runat="server" OnClick="lbtn_finalizeOrder_Click"> Confirm Payment </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- Sql Source -->
        <asp:SqlDataSource ID="SqlSourceCart" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnUserCartItems" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="id_cliente" Type="Int32" DefaultValue="0" />
                <asp:Parameter DefaultValue="NULL" Name="cookies" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>


</asp:Content>
