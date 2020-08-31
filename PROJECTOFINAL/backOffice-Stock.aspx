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


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="container-fluid mt-3">
        <h1>Secção Stock</h1>
        <ol class="breadcrumb bg-dark text-white mb-4 shadow shadow-sm">
            <a class="breadcrumb-item text-white" href="backOffice-Index.aspx">Dashboard</a>
            <li class="breadcrumb-item active">Stock</li>
        </ol>

        <div class="row">

            <div class="col-lg-12 col-md-12 col-sm-12 mb-4">
               
                <ul class="nav nav-pills" id="myTab" role="tablist">

                    <li class="nav-item mb-2 w-50 text-center">
                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#store" role="tab" aria-controls="products" aria-selected="true">
                            <h5>Store</h5>
                        </a>
                    </li>

                    <li class="nav-item w-50 text-center">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#pickup" role="tab" aria-controls="archived" aria-selected="false">
                            <h5>Pickup</h5>
                        </a>
                    </li>

                </ul>
            </div>

            <div class="tab-content col-lg-10 d-inline-block ml-0" id="v-pills-tabContent">

                <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">

                    <h4>Stock Armazém Loja</h4>

                    <div class="mb-4">
                        <div class="table-responsive" id="editabletable">

                            <table class="table table-hover table-light table-striped rounded shadow shadow-sm" id="dataTable">

                                <thead class="text-center thead-dark align-middle">
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
                                                    <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_qty" runat="server" value='<%# Eval("Qtd") %>' />
                                                </td>

                                                <td class="align-middle">
                                                    <label class="text-hide" style="display: none"><%# Eval("QtdMin") %></label>
                                                    <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_qtymin" runat="server" value='<%# Eval("QtdMin") %>' />
                                                </td>

                                                <td class="align-middle">
                                                    <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" id="txt_qtymax" runat="server" value='<%# Eval("QtdMax") %>' />
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
                <!--  END CONTENT 1-->




                <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">Conteudo 2</div>
                <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">Conteudo 3</div>
                <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">Conteudo 4</div>


            </div>
        </div>
    </div>


    <asp:SqlDataSource ID="sqlStock" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_infoStock" SelectCommandType="StoredProcedure"></asp:SqlDataSource>


</asp:Content>
