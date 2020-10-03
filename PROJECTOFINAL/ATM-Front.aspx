<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-Front.aspx.cs" Inherits="PROJECTOFINAL.ATM_Front" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style>

        :root {

            /* para alterar a cor principal é só alterar aqui*/

            --main-bg-color: #74C72B;
        }


        .vl {
            border-left: 1px solid var(--main-bg-color);
            height: 70px;
            opacity: 0.3;
        }

        .vl2 {
            border-left: 1px solid var(--main-bg-color);
            height: 20px;
            opacity: 0.3;
        }


        .atmcolorheader{
            background-color: var(--main-bg-color)  !important; 
        }

        .atmcolor{
            background-color: var(--main-bg-color) ;
            
        }

        .atmcolor:hover{

            background-color: #8CC857;
            transition: 0.3s;
        }


    </style>

</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <div class="container mt-3">
            <div class="row bg-success rounded atmcolorheader">

                <div class="col-lg-6 text-left my-2">
                    <i class="fas fa-heartbeat text-white" style="font-size: 3em;"></i>
                    <label runat="server" class="h3 text-center text-white" id="lbl_chosenATM_title">ATM Carcavelos </label>
                </div>

                <div class="col-lg-6 text-right my-2">
                    <label runat="server" class="h3">Customer Support</label><br />
                    <label runat="server" class="h5 text-white">+351 560 560</label>
                </div>

            </div>
        </div>

        <div class="row mt-3 mb-3">

            <div class="col-lg-5 text-center mt-4">
                <a href="ATM-OrderPick.aspx" class="text-decoration-none text-dark"><i class="fas fa-qrcode" style="font-size: 15em;"></i></a>
                <h2 class="text-dark">Pickup</h2>
            </div>

            <div class="col-lg-2">
                <div class="vl mt-4 ml-4"></div><br />
                <h3 class="ml-2 text-dark">OR</h3><br />
                <div class="vl mt-2 ml-4"></div>
            </div>

            <div class="col-lg-5">
                <div class="col-lg-12 mb-4">
                    <a href="ATM-Shop.aspx" class="btn btn-block py-lg-1 border-0 atmcolor">
                        <i class="fas fa-shopping-bag my-2" style="font-size: 3em;"></i>
                        <h6 class="font-weight-bold text-light">SHOP</h6>
                    </a>
                </div>
                <div class="col-lg-12 mb-4">
                    <a href="#" class="btn btn-block py-lg-1 border-0 atmcolor">
                        <i class="fas fa-prescription-bottle-alt my-2" style="font-size: 3em;"></i>
                        <h6 class="font-weight-bold text-light">FILL PRESCRIPTION</h6>
                    </a>
                </div>
                <div class="col-lg-12 mb-4">
                    <a href="#" class="btn btn-block py-lg-1 border-0 atmcolor">
                        <i class="fas fa-notes-medical my-2" style="font-size: 3em;"></i>
                        <h6 class="font-weight-bold text-light">ANALYSIS</h6>
                    </a>
                </div>
            </div>

        </div>
    </div>



</asp:Content>
