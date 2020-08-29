<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Stock.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Stock" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


 <style>

     #stockupdate:hover{
         color: orange;
     }

 </style> 


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <div class="container-fluid mt-5">
        <h1>Stock</h1>
        <ol class="breadcrumb bg-dark text-white mb-4 shadow shadow-sm">
            <a class="breadcrumb-item text-white" href="backOffice-Index.aspx">Dashboard</a>
            <li class="breadcrumb-item active">Stock</li>
        </ol>

        <div class="mb-4">
            <div class="">
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
                                            <Label class="text-hide" style="display:none"><%# Eval("Qtd") %></Label>
                                            <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" ID="txt_qty" runat="server" value='<%# Eval("Qtd") %>'/>
                                        </td>

                                        <td class="align-middle">
                                             <Label class="text-hide" style="display:none"><%# Eval("QtdMin") %></Label>
                                             <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" ID="txt_qtymin" runat="server" value='<%# Eval("QtdMin") %>'/>
                                        </td>

                                         <td class="align-middle">
                                              <input type="number" style="max-width: 7em" class="text-center border-0 bg-transparent" ID="txt_qtymax" runat="server" value='<%# Eval("QtdMax") %>'/>
                                              <Label class="text-hide" style="display:none"><%# Eval("QtdMax") %></Label>
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
    </div>




    <asp:SqlDataSource ID="sqlStock" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_infoStock" SelectCommandType="StoredProcedure"></asp:SqlDataSource>


</asp:Content>
