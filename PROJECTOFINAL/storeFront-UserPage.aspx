﻿<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-UserPage.aspx.cs" Inherits="PROJECTOFINAL.storeFront_UserPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="row mt-5 mb-3">


        <div class="col-lg-10">
            <div class="card shadow shadow-sm" style="border-radius: 20px;">
                <div class="card-body">
                    <div class="row">

                        <div class="col-lg-12 text-center">
                            <!-- Controlos de navegação -->

                            <h5 class="card-title">Benvindo Utilizador</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>

                            <ul class="nav nav-pills nav-justified" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link show active" id="home-tab" data-toggle="tab" href="#change-details" role="tab" aria-controls="details" aria-selected="true">Users</a>
                                </li>
                                <li class="nav-item bg-light">
                                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#orders" role="tab" aria-controls="orders" aria-selected="false">Orders</a>
                                </li>
                                <li class="nav-item bg-light">
                                    <a class="nav-link" id="contact-tab" data-toggle="tab" href="#exams" role="tab" aria-controls="exams" aria-selected="false">Exams</a>
                                </li>
                            </ul>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-sm-12 text-center">
            <!-- Botão Aviar a receita -->
            <button type="button" class="btn btn-info btn-block mt-4"><i class="fas fa-pills"></i></button>
            <!-- Botão Aviar a receita -->
            <button type="button" class="btn btn-danger btn-block mt-4">Logout</button>
        </div>


    </div>



    <div class="tab-content" id="myTabContent">

        <div class="tab-pane fade show active" id="change-details" role="tabpanel" aria-labelledby="details-tab">
            <div class="row">

                <div class="col-lg-4 mb-4 my-4">
                    <div class="card shadow pb-4 bg-white" style="border-radius: 20px;">
                        <div class="card-body">

                            <h3 class="text-dark text-left">Alter Password</h3>

                            <div class="form-row">

                                <div class="col">
                                    <label for="lbl_oldPassword">Old Password</label>
                                    <input type="text" id="lbl_oldPassword" runat="server" class="form-control bg-light" placeholder="*******" />
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col mt-3">
                                    <label for="lbl_newPassword">New Password</label>
                                    <input type="text" id="lbl_newPassword" runat="server" class="form-control bg-light" placeholder="*******" />
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col mt-3">
                                    <label for="lbl_repeatPassword">Repeat Password</label>
                                    <input type="text" id="lbl_repeatPassword" runat="server" class="form-control bg-light" placeholder="*******" />
                                    <small id="passwordHelpBlock" class="form-text text-muted">8-20 caracteres, conter letras e numeros, um caracter especial e sem espaços
                                    </small>
                                </div>

                            </div>


                            <div class="form-row mt-4">

                                <div class="col-md-8">
                                    <asp:Label ID="lbl_erro" runat="server" class="form-text text-dark" Font-Size="small" Text=""></asp:Label>
                                </div>
                                <div class="col-md-4">
                                    <asp:Button ID="link_alterPassword" class="btn btn-sm btn-info btn-block" runat="server" Text="Change" />
                                </div>

                            </div>

                        </div>
                    </div>
                </div>


                <!-- Change Details -->

                <div class="col-lg-8 my-4">
                    <div class="card shadow bg-white pb-4" style="border-radius: 20px;">
                        <div class="card-body">
                            <h3 class="text-dark text-">User</h3>

                            <!-- Alterar detalhes -->

                            <div class="form-row">

                                <div class="col-md-6 mb-3">
                                    <label for="txt_altername">Name</label>
                                    <input type="text" id="txt_altername" runat="server" class="form-control bg-light"/>
                                </div>

                                <div class="col-md-6 mb-3">

                                    <label for="validationCustomUsername">Email</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="inputGroupPrepend">@</span>
                                        </div>
                                        <input type="text" id="txt_alteremail" runat="server" class="form-control bg-light"/>
                                    </div>

                                </div>
                            </div>

                            <div class="form-row mb-3">
                                <div class="col-md-12">
                                    <label for="txt_alteraddress">Address</label>
                                    <input type="text" id="txt_alteraddress" runat="server" class="form-control bg-light"/>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label for="txt_alterhealthnumber">Health Number</label>
                                    <input type="text" id="txt_alterhealthnumber" runat="server" class="form-control bg-light"/>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="txt_alternif">NIF</label>
                                    <input type="text" id="txt_alternif" runat="server" class="form-control bg-light"/>
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col-md-6">
                                </div>

                                <div class="col-md-6">
                                    <asp:Button ID="link_alterarDetails" class="btn btn-sm btn-info mt-5 float-right w-50" runat="server" Text="Change"/>
                                </div>
                            </div>



                        </div>
                    </div>
                </div>


            </div>
            <!-- //.Row -->


        </div>

        <div class="tab-pane fade" id="orders" role="tabpanel" aria-labelledby="orders-tab">

            <div class="card pb-4 mt-4 shadow shadow-sm bg-white pb-5" style="border-radius: 20px;">
                <div class="card-body">
                    <div class="col-lg-12">

                        <h3>Encomendas</h3>

                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">ORDER 1</li>
                            <li class="list-group-item">
                            ORDER 1/li>
                            <li class="list-group-item">ORDER 1</li>
                            <li class="list-group-item">ORDER 1</li>
                            <li class="list-group-item">ORDER 1</li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="exams" role="tabpanel" aria-labelledby="exams-tab">

            <div class="card pb-4 mt-4 shadow shadow-sm bg-white" style="border-radius: 20px;">
                <div class="card-body">

                    <h3 class="text-dark">Exames</h3>

                    <div class="row mt-1 card-deck">

                        <div class="col-sm-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Tipo: analises</h5>
                                    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="btn btn-info">Go somewhere</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Tipo: oncologico</h5>
                                    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="btn btn-info">Go somewhere</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Special title treatment</h5>
                                    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="btn btn-info">Go somewhere</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Special title treatment</h5>
                                    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="btn btn-info">Go somewhere</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Special title treatment</h5>
                                    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="btn btn-info">Go somewhere</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Special title treatment</h5>
                                    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="btn btn-info">Go somewhere</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Special title treatment</h5>
                                    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="btn btn-info">Go somewhere</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>

    </div>


    <script type="text/javascript">

        //Para evitar ir de encontro aos detalhes do utilizador
        document.getElementById("navbar-pharma").classList.remove('sticky-top');

    </script>



</asp:Content>
