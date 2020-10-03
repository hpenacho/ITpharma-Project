<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-Shop.aspx.cs" Inherits="PROJECTOFINAL.ATM_Shop" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   

    <style>

        .keyboardbutton{
            padding: 1em;
            font-size: 20px;
            margin: auto;
        }


    </style>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-3">
        <div class="row">
            <div class="col-lg-12 text-center">
                 <a href="ATM-Front.aspx" class="btn btn-dark shadow shadow-sm" style="font-size:larger; width: 17.5em;"><i class="fas fa-arrow-left"></i>&nbspBack</a>
                 <a href="ATM-Front.aspx" class="btn btn-success shadow shadow-sm" data-toggle="modal" data-target="#exampleModalCenter" style="font-size:larger; width: 7.5em;"><i class="fas fa-search"></i>&nbspSearch </a>
            </div>
        </div>
    </div>

    <div class="col-lg-12 mt-4 justify-content-around">
        <div class="row">
            <asp:Repeater ID="rptShopProducts" runat="server" DataSourceID="sqlcat">
                <ItemTemplate>

                    <div class="col-lg-4 col-md-6 mb-4">
                         <a href='ATM-Category.aspx?ref=<%# Eval("ID") %>' class="text-decoration-none">
                        <div class="card h-100 border-light shadow shadow-sm rounded category-card border-0 mt-2">
                            <center> 
                                <div class="text-center" style="height:150px; width:150px">
                                    <img style='height: 100%; width: 100%; object-fit: contain' src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Categoria">
                                 </div> 
                            </center>
                            <div class="card-body">
                                <!-- card body -->
                                <h4 class="card-title text-center">
                                    <h5 class="text-center text-dark"><%# Eval("descricao") %></h5>
                                </h4>
                            </div>
                            <!-- //card body -->
                        </div>
                        </a>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
   


    <!-- SQL SOURCES -->
    <asp:SqlDataSource ID="sqlcat" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_atmcategories" SelectCommandType="StoredProcedure"></asp:SqlDataSource>


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
                            </div>
                        </div>

                          <div class="row mt-2 mb-2">
                            <div class="col-lg-12">
                                <button type="button" id="space" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton"><i class="fas fa-inbox"></i></button>
                                <button type="button" id="Z" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">Z</button>
                                <button type="button" id="X" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">X</button>
                                <button type="button" id="C" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">C</button>
                                <button type="button" id="V" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">V</button>
                                <button type="button" id="B" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">B</button>
                                <button type="button" id="N" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">N</button>
                                <button type="button" id="M" onclick="keyboardWrite(this)" class="btn btn-sm btn-success keyboardbutton">M</button>
                                <button type="button" id="delete" onclick="keyboardDelete()" class="btn btn-sm btn-success keyboardbutton"><i class="fas fa-backspace"></i></button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>



     <script type="text/javascript">

         let searchfield = document.getElementById('searchfield');

         function keyboardWrite(element) {
             searchfield.value += element.id == "space" ? " " : element.id;
         }

         function keyboardDelete() {
             searchfield.value = searchfield.value.substring(0, searchfield.value.length - 1);
         }

     </script>



</asp:Content>
