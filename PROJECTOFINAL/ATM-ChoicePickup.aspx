<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-ChoicePickup.aspx.cs" Inherits="PROJECTOFINAL.ATM_ChoicePickup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <style>

        body {
            font-family: 'Varela Round', sans-serif;
        }

        .modal-confirm {
            color: #636363;
            width: 325px;
            font-size: 14px;
        }

            .modal-confirm .modal-content {
                padding: 20px;
                border-radius: 5px;
                border: none;
            }

            .modal-confirm .modal-header {
                border-bottom: none;
                position: relative;
            }

            .modal-confirm h4 {
                text-align: center;
                font-size: 26px;
                margin: 30px 0 -15px;
            }

            .modal-confirm .form-control, .modal-confirm .btn {
                min-height: 40px;
                border-radius: 3px;
            }

            .modal-confirm .close {
                position: absolute;
                top: -5px;
                right: -5px;
            }

            .modal-confirm .modal-footer {
                border: none;
                text-align: center;
                border-radius: 5px;
                font-size: 13px;
            }

            .modal-confirm .icon-box {
                color: #fff;
                position: absolute;
                margin: 0 auto;
                left: 0;
                right: 0;
                top: -70px;
                width: 95px;
                height: 95px;
                border-radius: 50%;
                z-index: 9;
                background: #82ce34;
                padding: 15px;
                text-align: center;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
            }

                .modal-confirm .icon-box i {
                    font-size: 58px;
                    position: relative;
                    top: 3px;
                }

            .modal-confirm.modal-dialog {
                margin-top: 80px;
            }

            .modal-confirm .btn {
                color: #fff;
                border-radius: 4px;
                background: #82ce34;
                text-decoration: none;
                transition: all 0.4s;
                line-height: normal;
                border: none;
            }

                .modal-confirm .btn:hover, .modal-confirm .btn:focus {
                    background: #6fb32b;
                    outline: none;
                }

        .trigger-btn {
            display: inline-block;
            margin: 100px auto;
        }

    </style>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <div class="row text-center justify-content-center my-4">
        <div class="col-lg-8 mt-4"> 

            <p class="text-muted text-center"> Para efeitos de demonstração de funcionalidade, escolha uma das pickups abaixo, a aplicação carregará a respectiva ATM.</p>

        </div>       
    </div>
        <div class="row justify-content-center mb-4">

            <div class="col-lg-4 mt-4">

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


    <!-- CUSTOM MODAL -->

    <div id="staticBackdrop" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="material-icons">&#xE876;</i>
                    </div>
                    <h4 class="modal-title w-100">Confirme a sua escolha</h4>
                </div>
                <div class="modal-body">
                    <p class="text-center"> Ao clicar em confirmar, será redirecionado para o Landing Page do ATM escolhido. </p>
                </div>
                <div class="modal-footer border-0">
                    <asp:LinkButton ID="lbtn_loadChosenATM" CssClass="btn btn-primary btn-block" runat="server" OnClick="lbtn_loadChosenATM_Click">Confirmar</asp:LinkButton>
                    <button class="btn btn-danger btn-block" style="background-color: #dc3545 !important;" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>





</asp:Content>
