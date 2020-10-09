<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-Front.aspx.cs" Inherits="PROJECTOFINAL.ATM_Front" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

    <style>

        :root {

            /* para alterar a cor principal é só alterar aqui*/

            --main-bg-color: #82ce34;
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


        .keyboardbutton{

            padding: 1em;
            font-size: 20px;
            margin: auto;
            background-color: var(--main-bg-color)  !important; 
            border: none !important;
        }

    </style>

</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <div class="container mt-3">
            <div class="row bg-success rounded atmcolorheader">

                <div class="col-lg-6 text-left my-2">
                    <i class="fas fa-heartbeat text-white" style="font-size: 3em;"></i>
                    <label runat="server" class="h3 text-center text-white" id="lbl_chosenATM_title"></label>
                </div>

                <div class="col-lg-6 text-right my-2">
                    <label runat="server" class="h3">Customer Support</label><br />
                    <label runat="server" class="h5 text-white">+351 560 560</label>
                </div>

            </div>
        </div>

        <div class="row mt-3 mb-3">

            <div class="col-lg-5 text-center mt-4">
                <a href="ATM-OrderQRauth.aspx" class="text-decoration-none text-dark"><i class="fas fa-qrcode" style="font-size: 15em;"></i></a>
                <h2 class="text-dark">FAST&nbspPICKUP</h2>
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
                    <a href="ATM-OrderRegularAuth.aspx" class="btn btn-block py-lg-1 border-0 atmcolor">
                        <i class="fas fa-prescription-bottle-alt my-2" style="font-size: 3em;"></i>
                        <h6 class="font-weight-bold text-light">PICKUP</h6>
                    </a>
                </div>
                <div class="col-lg-12 mb-4">
                    <a href="#" class="btn btn-block py-lg-1 border-0 atmcolor" data-toggle="modal" data-target="#exampleModalCenter">
                        <i class="fas fa-search" style="font-size: 3em;"></i>
                        <h6 class="font-weight-bold text-light">SEARCH</h6>
                    </a>
                </div>
            </div>

        </div>
    </div>


       <!-- MODAL SEARCH -->

    <!-- Modal -->
    <div class="modal fade bd-example-modal-lg" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="container text-center">

                        <div class="row mt-2">
                            <div class="col-lg-12">
                                <input type="text" id="searchfield" style="height:50px;" class="form-control" runat="server"/>
                            </div>
                        </div>


                          <div class="row mt-3 mb-2">
                            <div class="col-lg-12">
                                <button type="button" id="1" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">1</button>
                                <button type="button" id="2" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">2</button>
                                <button type="button" id="3" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">3</button>
                                <button type="button" id="4" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">4</button>
                                <button type="button" id="5" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">5</button>
                                <button type="button" id="6" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">6</button>
                                <button type="button" id="7" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">7</button>
                                <button type="button" id="8" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">8</button>
                                <button type="button" id="9" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">9</button>
                                <button type="button" id="0" onclick="keyboardWrite(this)"  class="btn btn-sm btn-success keyboardbutton">0</button>
                            </div>
                        </div>

                        <div class="row mt-3 mb-2">
                            <div class="col-lg-12">
                                <button type="button" id="Q" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">Q</button>
                                <button type="button" id="W" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">W</button>
                                <button type="button" id="E" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">E</button>
                                <button type="button" id="R" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">R</button>
                                <button type="button" id="T" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">T</button>
                                <button type="button" id="Y" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">Y</button>
                                <button type="button" id="U" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">U</button>
                                <button type="button" id="I" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">I</button>
                                <button type="button" id="O" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">O</button>
                                <button type="button" id="P" onclick="keyboardWrite(this)"  class="btn btn-sm btn-success keyboardbutton">P</button>
                            </div>
                        </div>

                          <div class="row mt-2 mb-2">
                            <div class="col-lg-12">
                                <button type="button" id="A" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">A</button>
                                <button type="button" id="S" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">S</button>
                                <button type="button" id="D" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">D</button>
                                <button type="button" id="F" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">F</button>
                                <button type="button" id="G" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">G</button>
                                <button type="button" id="H" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">H</button>
                                <button type="button" id="J" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">J</button>
                                <button type="button" id="K" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">K</button>
                                <button type="button" id="L" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">L</button>
                                <button type="button" id="Ç" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">Ç</button>
                                <button type="button" id="." onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">.</button>
                            </div>
                        </div>

                          <div class="row mt-2 mb-2">
                            <div class="col-lg-12">
                                <button type="button" id="space" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton"><i class="fas fa-inbox"></i></button>
                                <button type="button" id="@" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">@</button>
                                <button type="button" id="Z" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">Z</button>
                                <button type="button" id="X" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">X</button>
                                <button type="button" id="C" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">C</button>
                                <button type="button" id="V" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">V</button>
                                <button type="button" id="B" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">B</button>
                                <button type="button" id="N" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">N</button>
                                <button type="button" id="M" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">M</button>
                                <button type="button" id="delete" onclick="keyboardDelete()" class="btn btn-sm btn-success keyboardbutton"><i class="fas fa-backspace"></i></button>
                                <asp:LinkButton runat="server" ID="searchbutton" CssClass="btn btn-sm btn-success keyboardbutton" OnClick="searchbutton_Click"><i class="fas fa-search"></i></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">

        let searchfield = document.getElementById("<%= searchfield.ClientID %>");

        function keyboardWrite(element) {
            searchfield.value += element.id == "space" ? " " : element.id;
        }

        function keyboardDelete() {
            searchfield.value = searchfield.value.substring(0, searchfield.value.length - 1);
        }

    </script>


</asp:Content>
