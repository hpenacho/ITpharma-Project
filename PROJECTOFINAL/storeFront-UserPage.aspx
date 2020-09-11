<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-UserPage.aspx.cs" Inherits="PROJECTOFINAL.storeFront_UserPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style>

    </style>


</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container">
    <div class="row mt-5 mb-3">
        <div class="col-lg-10">
            <div class="card shadow shadow-sm">
                <div class="card-body">
                    <div class="row">

                        <div class="col-lg-12 text-center">
                            <!-- Controlos de navegação -->

                            <h5 class="card-title" id="welcomeUser" runat="server"></h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>

                            <ul class="nav nav-pills nav-justified" id="myTab" role="tablist">

                                <li class="nav-item bg-light">
                                    <a class="nav-link" id="user-tab" data-toggle="tab" href="#change-details" role="tab" aria-controls="details" aria-selected="true">Users</a>
                                </li>

                                <li class="nav-item bg-light">
                                    <a class="nav-link fade show active" id="order-tab" data-toggle="tab" href="#orders" role="tab" aria-controls="orders" aria-selected="false">Orders</a>
                                </li>

                                <li class="nav-item bg-light">
                                    <a class="nav-link" id="exam-tab" data-toggle="tab" href="#exams" role="tab" aria-controls="exams" aria-selected="false">Exams</a>
                                </li>

                            </ul>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-sm-12 text-center">
            <!-- Botão Aviar a receita -->
            <button type="button" class="btn btn-info btn-block mt-4" data-toggle="modal" data-target="#prescriptionModal" formnovalidate="formnovalidate"><i class="fas fa-pills"></i>Prescriptions</button>
            <!-- Botão Logout -->
            <asp:LinkButton ID="link_logout" runat="server" class="btn btn-danger btn-block mt-4" OnClick="link_logout_Click">Logout</asp:LinkButton>
        </div>


    </div>



    <div class="tab-content" id="myTabContent">

        <div class="tab-pane fade" id="change-details" role="tabpanel" aria-labelledby="details-tab">
            <div class="row">


                <!-- Change password -->
                <div class="col-lg-4 mb-4 my-4">
                    <div class="card shadow pb-4 bg-white">
                        <div class="card-body">

                            <h3 class="text-dark text-left">Alter Password</h3>

                            <div class="form-row">

                                <div class="col">
                                    <label for="txt_oldPassword"">Old Password</label>
                                    <input type="password" id="txt_oldPassword" runat="server" class="form-control bg-light" placeholder="*******" />
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col mt-3">
                                    <label for="txt_newPassword">New Password</label>
                                    <input type="password" id="txt_newPassword" runat="server" class="form-control bg-light" placeholder="*******" />
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col mt-3">
                                    <label for="txt_repeatPassword">Repeat Password</label>
                                        <input type="password" id="txt_repeatPassword" runat="server" class="form-control bg-light" placeholder="*******" />
                                        <small id="passwordHelpBlock" class="form-text text-muted">8-20 caracteres, conter letras e numeros, um caracter especial e sem espaços
                                    </small>
                                </div>

                            </div>


                            <div class="form-row mt-4">

                                <div class="col-md-8">
                                    <asp:Label ID="lbl_errorPassword" runat="server" class="form-text text-dark" Font-Size="small" Text=""></asp:Label>
                                </div>

                                <div class="col-md-4">
                                    <asp:Button ID="btn_alterPassword" class="btn btn-sm btn-info btn-block" runat="server" Text="Change" OnClick="btn_alterPassword_Click" />
                                </div>

                            </div>

                        </div>
                    </div>
                </div>


                <!-- Change Details -->

                <div class="col-lg-8 my-4">
                    <div class="card shadow bg-white pb-4">
                        <div class="card-body">
                            <h3 class="text-dark text-">User</h3>

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
                                <div class="col-md-8">
                                    <label for="txt_alteraddress">Address</label>
                                    <input type="text" id="txt_alteraddress" runat="server" class="form-control bg-light"/>
                                </div>
                                <div class="col-md-4">
                                    <label for="txt_zipCode">Zip-Code</label>
                                    <input type="text" id="txt_zipCode" runat="server" class="form-control bg-light"/>
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col-md-6 mb-3">
                                    <label for="txt_alterhealthnumber">Health Number</label>
                                    <input type="text" id="txt_alterhealthnumber" runat="server" class="form-control bg-light" readonly/>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="txt_alternif">NIF</label>
                                    <input type="text" id="txt_alternif" runat="server" class="form-control bg-light"/>
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col-md-6">
                                     <asp:Label ID="lbl_changeDetailsError" runat="server" class="form-text text-dark" Font-Size="small" Text=""></asp:Label>
                                </div>

                                <div class="col-md-6">
                                    <asp:Button ID="btn_alterDetails" class="btn btn-sm btn-info mt-5 float-right w-50" runat="server" Text="Change" OnClick="btn_alterarDetails_Click"/>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>


            </div>
            <!-- //.Row -->


        </div>

        <div class="tab-pane fade show active" id="orders" role="tabpanel" aria-labelledby="orders-tab">

            <div class="card pb-4 mt-4 shadow shadow-sm bg-white pb-5 mb-3">
                <div class="card-body">
                    <div class="col-lg-12">

                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                            <asp:LinkButton ID="link_activeOrders" CssClass="btn btn-info" OnClick="link_activeOrders_Click" runat="server">Active</asp:LinkButton>
                            <asp:LinkButton ID="link_pastOrders" CssClass="btn btn-info" OnClick="link_pastOrders_Click" runat="server">Past</asp:LinkButton>
                        </div>


                        <h3 class="text-center my-2 bg-info py-1 text-white col-12">Encomendas</h3>

                      
                        <!-- ORDER ELEMENT select DataCompra, MoradaEntrega, Sum(Qtd), sum(Total), Descricao, PDF  -->

                                    <table class="table table-borderless table-responsive-lg text-center" id="dataTable">
                                        <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Date</th>
                                                <th scope="col">Address</th>
                                                <th scope="col">Qty</th>
                                                <th scope="col">Total</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">Invoice</th>
                                            </tr>
                                        </thead>

                                        <tbody>

                                             <asp:Repeater ID="rpt_orders" runat="server" DataSourceID="sqlOrderSource">
                                                <ItemTemplate>

                                            <tr>
                                                <td style="vertical-align:middle"><%# Eval("ENC_REF") %></td>
                                                <td style="vertical-align:middle"><%# DateTime.Parse(Eval("DataCompra").ToString()).ToString("MMMM dd, yyyy") %></td>
                                                <td style="vertical-align:middle"><%# Eval("MoradaEntrega") %></td>
                                                <td style="vertical-align:middle"><%# Eval("Qty") %></td>
                                                <td style="vertical-align:middle"><%# Eval("Total") %> €</td>
                                                <td style="vertical-align:middle"><span class="rounded-pill bg-info text-white p-2 pl-2 pr-2"><%# Eval("Descricao") %></span></td>
                                                <td>
                                                    <a class="btn btn-outline-info" style="vertical-align:middle" href="storeFront-UserOrders.aspx?order=<%# Eval("ENC_REF") %>">Details</a>
                                                </td>
                                            </tr>

                                               </ItemTemplate>
                                            </asp:Repeater>
                                        
                                        </tbody>
                                    </table>

                                    <!-- ORDER ELEMENT -->

                    </div>
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="exams" role="tabpanel" aria-labelledby="exams-tab">

            <div class="card pb-4 mt-4 shadow shadow-sm bg-white">
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
            
</div>
    <!-- END CONTAINER -->

    <!-- modal verify Prescription -->

    <asp:UpdatePanel ID="prescriptionUpdate" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>


    <div class="modal fade ml-3" id="prescriptionModal" tabindex="-1" role="dialog" aria-labelledby="prescriptionModal" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-label"> Order Prescription-Only Meds  <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </h5>
                </div>

                 <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                <div class="modal-body">
                    <!-- BEGIN MODAL BODY CONTENT -->

                   

                    <div class="tab-content" id="insert-nav-tabContent">

                        <!-- CONTENT 1 DETAILS -->
                        <div class="tab-pane fade show active" id="insert-nav-details" role="tabpanel" aria-labelledby="nav-details-tab">

                            <div class="p-4">
                                <!-- WINDOW PADDING -->
                                
                            <!-- WINDOW PADDING -->

                                   <div class="row justify-content-center">
                              <div class="col-md-7 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-file-medical"></i> </span>
                                </div>    
                                <input type="text" id="prescriptionNumber" runat="server" class="form-control bg-light" placeholder="Prescription Reference Number" />
                                      </div>
                                <small class="text-muted"> Consult the prescription supplied by your Doctor to find this number. </small>
                              </div>
                                   </div>
           
                                <div class="row justify-content-center text-center mt-4">
                              <div class="col-md-7 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-hospital-user"></i> </span>
                                </div>  
                                <input type="text" id="healthNumber" runat="server" class="form-control bg-light" placeholder="Health Number" />
                                      </div>
                                <small class="text-muted"> Please insert your Health Number. </small>
                              </div>
                                    </div>


                                <div class="form-row mt-2 justify-content-center text-center">
                            <label id="lbl_message" class="text-warning" runat="server"></label>
                        </div>

                        </div>
                        <!-- // CONTENT 1 DETAILS -->


                            <hr />
                        <div class="form-row mt-2">
                            <div class="col text-center">                                
                                <asp:LinkButton ID="link_validatePrescription" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_validatePrescription_Click"> Validate & Checkout </asp:LinkButton>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        

                    </div>
                </div>
            </div> <!-- END MODAL BODY CONTENT --> 
                </ContentTemplate>
                    </asp:UpdatePanel>
        </div>
    </div>
 </div>

        </ContentTemplate>
    </asp:UpdatePanel>



    <!-- SQL SOURCES -->
    <asp:SqlDataSource ID="sqlOrderSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnUserPersonalOrders" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="ID" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="estado" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



</asp:Content>
