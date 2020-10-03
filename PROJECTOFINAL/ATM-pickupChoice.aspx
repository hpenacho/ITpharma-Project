<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-pickupChoice.aspx.cs" Inherits="PROJECTOFINAL.ATM_pickupChoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
    
    <div class="row text-center justify-content-center mt-4 mb-4">
        <div class="col-lg-8"> 

            <p class="text-muted text-center"> Para efeitos de demonstração de funcionalidade, escolha uma das pickups abaixo, a aplicação carregará a respectiva ATM.</p>

        </div>       
    </div>
        <div class="row justify-content-center mb-4">

            <div class="col-lg-4">

                <asp:DropDownList ID="ddl_ATMchoice" CssClass="form-control" runat="server" DataSourceID="SQLsourceATMs" DataTextField="Descricao" DataValueField="ID"></asp:DropDownList>

                <asp:SqlDataSource ID="SQLsourceATMs" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT [Descricao], [ID] FROM [Pickup]"></asp:SqlDataSource>

            </div>
    
        </div>


        <!-- Button trigger modal -->
    <div class="text-center mb-4">
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop">
        Launch Chosen ATM
    </button>
        </div>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Confirm the chosen ATM</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you wish to load the selected ATM?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtn_loadChosenATM" CssClass="btn btn-primary" Text="Yes" runat="server" OnClick="lbtn_loadChosenATM_Click">Confirm</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>


</asp:Content>


