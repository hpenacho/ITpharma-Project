﻿<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-UserPage.aspx.cs" Inherits="PROJECTOFINAL.storeFront_UserPage" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="BackOffice/BackOffice-Template/dist/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <script type="text/javascript">

        $(document).ready(function () {
            $('#dataTable').DataTable({
                "order": []
            });
        });

    </script>



</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- MAIN CONTAINER --> 
    <div class="container">
        <div class="row mt-5">

            <div class="col-lg-4">
                <h1 class="mt-2"><i class="fas fa-user"></i>&nbspUser Page</h1>
            </div>

            <div class="col-lg-8 mt-3 text-lg-right">
                <!-- Botão Logout -->
                <asp:LinkButton ID="link_logout" runat="server" class="btn btn-danger shadow shadow-sm" OnClick="link_logout_Click"><i class="fas fa-power-off"></i>&nbsp&nbspLogout</asp:LinkButton>
            </div>

        </div>
       
        <div class="row mt-1 mb-4">
            <!-- ROW -->
            <div class="col-lg-3 mt-5" style="margin-bottom: 1em;">
                <div class="card shadow shadow-sm">
                    <div class="card-body">
                        <div class="row">

                            <div class="col-lg-12 text-center mb-2">
                                <!-- Controlos de navegação -->
                                    <h5> Welcome </h5>
                                    <h5 class="card-title text-success" id="welcomeUser" style="color: #82ce34 !important" runat="server"></h5>                       
                                    <p class="text-muted"> Here you can change account info, check current and past orders, schedule exams and consume prescriptions.</p>                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-sm-12 text-center mt-5">
                <div class="card shadow shadow-sm py-lg-3">
                    <div class="card-body mt-4">
                        <div class=" card-deck">
                            <div class="card pb-2">
                                <div class="card-body">
                                    <h5 class="card-title">Schedule BloodWork</h5>
                                    <button type="button" class="btn-lg btn-dark mx-auto btn-block w-75 border-0" data-toggle="modal" data-target="#bloodwork-modal">
                                        <i class="fas fa-file-medical" style="color:#82ce34 !important"></i>&nbsp&nbspCheck
                                    </button>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Fill Prescription</h5>
                                    <button type="button" class="btn-lg btn-dark mx-auto btn-block w-75 border-0" data-toggle="modal" data-target="#prescriptionModal">
                                        <i class="fas fa-pills" style="color:#82ce34 !important"></i>&nbsp&nbspPrescriptions
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- ./ROW-->


           <!-- SETTINGS -->
           <div class="row mt-4 mb-5">
                <!-- Change password -->
                <div class="col-lg-4 mt-4">
                    <div class="card shadow pb-4 bg-white">
                        <div class="card-body mb-2">

                            <h3 class="text-dark text-left"><i class="fas fa-unlock-alt" style="color: #82ce34 !important"></i>&nbspAlter Password</h3>

                            <div class="form-row mt-3">

                                <div class="col">
                                    <label for="txt_oldPassword"">Old Password</label>
                                    <input type="password" id="txt_oldPassword" class="form-control bg-light text-center" runat="server" placeholder="***********" />
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col mt-3">
                                    <label for="txt_newPassword">New Password</label>
                                    <input type="password" ID="txt_newPassword" class="form-control bg-light text-center" runat="server" placeholder="***********" title="Password must have at least 7 characters and at least: 1 lowercase, 1 Uppercase, 1 number." pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" />
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="col mt-3">
                                    <label for="txt_repeatPassword">Repeat Password</label>
                                    <input type="password" id="txt_repeatPassword" class="form-control bg-light text-center" runat="server" placeholder="***********" title="Password must have at least 7 characters and at least: 1 lowercase, 1 Uppercase, 1 number." pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" />
                                    <small id="passwordHelpBlock" class="form-text text-muted">Password must have at least 7 characters and at least: 1 lowercase, 1 Uppercase, 1 number.
                                    </small>
                                </div>

                            </div>


                            <div class="form-row mt-4">

                                <div class="col-md-8">
                                    <asp:Label ID="lbl_errorPassword" runat="server" class="form-text text-dark" Font-Size="small" Text=""></asp:Label>
                                </div>

                                <div class="col-md-4">
                                    <asp:Button ID="btn_alterPassword" class="btn btn-sm btn-dark btn-block" runat="server" Text="Change" OnClick="btn_alterPassword_Click" />
                                </div>

                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-8 my-4">
                    <div class="card shadow bg-white pb-4">
                        <div class="card-body">
                            <h3 class="text-dark text-center"><i class="fas fa-user-edit" style="color: #82ce34 !important"></i>&nbspChange User Data </h3>

                            <div class="form-row mt-3">

                                <div class="col-md-6 mb-3">
                                    <label for="txt_altername">Name</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        </div>
                                    <input type="text" id="txt_altername" enableviewstate="true" runat="server" class="form-control bg-light" pattern="^[a-zA-Z_]+( [a-zA-Z_]+)*$" title="First and Last Name without special characters"/>
                                       </div>
                                    </div>

                                <div class="col-md-6 mb-3">

                                    <label for="validationCustomUsername">Email</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="inputGroupPrepend"><i class="fas fa-at"></i></span>
                                        </div>
                                        <input type="text" id="txt_alteremail" enableviewstate="true" runat="server" class="form-control bg-light"/>
                                    </div>

                                </div>
                            </div>

                            <div class="form-row mb-3">
                                <div class="col-md-8">
                                    <label for="txt_alteraddress">Address</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-house-user"></i></span>  
                                        </div>
                                    <input type="text" ID="txt_alterAddress" enableviewstate="true" runat="server"  class="form-control bg-light"/>
                                    </div>
                                        </div>
                                <div class="col-md-4">
                                    <label for="txt_zipCode">Zip-Code</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-map-marked-alt"></i></span>
                                        </div>
                                    <input type="text" id="txt_zipCode" enableviewstate="true" runat="server" class="form-control bg-light"/>
                                    </div>
                                    </div>
                            </div>

                            <div class="form-row">

                                <div class="col-md-6 mb-3">
                                    <label for="txt_alterhealthnumber">Health Number</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-file-medical"></i></span>
                                        </div>
                                    <asp:TextBox ID="txt_alterhealthnumber" enableviewstate="true" runat="server" class="form-control bg-light" ReadOnly="true" title="Please insert your 9 digit HealthNumber" pattern="^\d{9}$"></asp:TextBox>
                                    </div>
                                    </div>

                                <div class="col-md-6 mb-3">
                                    <label for="txt_alternif">NIF</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-wallet"></i></span>
                                        </div>
                                    <input type="text" id="txt_alternif" enableviewstate="true" runat="server" class="form-control bg-light" title="Please insert your 9 digit NIF" pattern="^\d{9}$"/>
                                    </div>
                                    </div>
                            </div>

                            <div class="form-row">
                                
                                <div class="col-md-4 mb-3 align-self-center">
                                    <label for="txt_alterBirth">Date Of Birth</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-birthday-cake"></i></span>
                                        </div>
                                    <input type="text" id="txt_alterBirth" enableviewstate="true" runat="server" class="form-control bg-light" readonly/>
                                    </div>
                                        <input type="date" class="form-control form-control-user bg-light" runat="server" id="txt_alterBirth2" disabled visible="false" placeholder="Date of Birth" value="2000-01-01">
                                </div>


                                <div class="col-sm-4 text-center align-self-center">
                                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                        <label class="btn btn-light">
                                            <input type="radio" name="radioGender" enableviewstate="true" id="gender_male" autocomplete="off" runat="server">
                                            <i class="fas fa-mars text-primary"></i> Male
                                        </label>
                                        <label class="btn btn-light">
                                            <input type="radio" name="radioGender" enableviewstate="true" id="gender_female" autocomplete="off" runat="server">
                                            <i class="fas fa-venus text-danger"></i> Female
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4 align-self-center">
                                    <center>  <asp:Button ID="btn_alterDetails" class="btn btn-dark mt-2" runat="server" Text="Change" OnClick="btn_alterarDetails_Click"/> </center>
                                </div>

                            </div>

                            <div class="form-row">

                                <div class="col-md-6">
                                    <asp:Label ID="lbl_changeDetailsError" runat="server" class="form-text text-dark" Font-Size="small"></asp:Label>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
             </div>
           <!-- //SETTINGS -->

           <!-- ORDERS -->
           <div class="card pb-4 mt-4 shadow shadow-sm bg-white pb-5 mb-3">
                <div class="card-body">
                    <div class="col-lg-12">

                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                            <asp:LinkButton ID="link_activeOrders" CssClass="btn text-white" style="background-color: #82ce34 !important" OnClick="link_activeOrders_Click" runat="server">Active</asp:LinkButton>
                            <asp:LinkButton ID="link_pastOrders" CssClass="btn btn-light" OnClick="link_pastOrders_Click" runat="server">Past</asp:LinkButton>
                        </div>


                        <h3 class="text-center my-2 bg-dark py-1 text-white col-12"><asp:Label ID="lbl_orderTypes" runat="server" Text="Active Orders"></asp:Label></h3>

                      
                        <!-- ORDER ELEMENT select DataCompra, MoradaEntrega, Sum(Qtd), sum(Total), Descricao, PDF  -->
                            <div class="table-responsive">
                                    <table class="table table-borderless text-center" id="dataTable" width="100%" cellspacing="0">

                                        <thead>
                                            <tr>
                                                <th scope="col">Date</th>
                                                <th scope="col">Address</th>
                                                <th scope="col">Qty</th>
                                                <th scope="col">Total</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">Invoice</th>
                                            </tr>
                                        </thead>

                                        <tbody class="text-center text-md-center">

                                             <asp:Repeater ID="rpt_orders" runat="server" DataSourceID="sqlOrderSource">
                                                <ItemTemplate>

                                            <tr>
                                                <td style="vertical-align:middle"><%# DateTime.Parse(Eval("DataCompra").ToString()).ToString("MMMM , dd  yyyy") %></td>
                                                <td style="vertical-align:middle"><%# Eval("MoradaEntrega") %></td>
                                                <td style="vertical-align:middle"><%# Eval("Qty") %></td>
                                                <td style="vertical-align:middle"><%# Eval("Total") %> €</td>
                                                <td style="vertical-align:middle"><span class="rounded-pill bg-dark text-white p-2 pl-2 pr-2"><%# Eval("Descricao") %></span></td>
                                                <td>
                                                    <a class="btn btn-outline-dark" style="vertical-align:middle" href="storeFront-UserOrders.aspx?order=<%# Eval("ENC_REF") %>">Details</a>
                                                </td>
                                            </tr>

                                               </ItemTemplate>
                                            </asp:Repeater>
                                        
                                        </tbody>
                                    </table>
                                </div>
                                    <!-- ORDER ELEMENT -->
                    </div>
                </div>
            </div>
           <!-- //ORDERS -->

    </div>
    <!-- END MAIN CONTAINER -->           









    <!-- MODALS -->

    <!-- Modal Schedule BloodWork -->
            <div class="modal fade bd-example-modal-lg" id="bloodwork-modal" tabindex="-1" role="dialog" aria-labelledby="bloodWorkLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                            <h5 class=" modal-title col-12 text-center">Schedule - Check Exams 
                                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </h5>
                        </div>

                         <!-- MODAL BODY -->
                            <div class="modal-body">

                                <asp:UpdatePanel runat="server" ID="udp_bloodwork" UpdateMode="Conditional">
                                    <ContentTemplate>

                                        <div class="container-fluid">

                                            <h4 class="mb-3 mt-2">Schedule or Check your Exams</h4>
                                            <div class="form-group mb-4">
                                                <div class="form-row">
                                                    <div class="col-lg-4">
                                                        <input type="text" id="txt_bloodHealthNumber" runat="server" class="form-control bg-light" placeholder="Health Number"/>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <input type="date" id="txt_bloodSchedule" enableviewstate="true" runat="server" class="form-control bg-light" />
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <asp:DropDownList ID="ddl_bloodPartners" runat="server" CssClass="form-control bg-light" DataSourceID="sqlPartnerships" DataValueField="ID" DataTextField="Parceria"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <label id="lblExameWarning" class="text-center text-warning" runat="server"></label>
                                            </div>

                                            <div class="collapse my-4" id="collapseExams">

                                                <asp:Repeater ID="rpt_exams" runat="server" DataSourceID="sqlExams" OnItemCommand="rpt_exams_ItemCommand">
                                                    <ItemTemplate>
 
                                                            
                                                                <div class="card mt-2">
                                                                    <div class="card-body text-center">

                                                                        <h4 class="card-title"><%# Eval("parceria") %></h4>
                                                                        <h6 class="text-muted">STATUS</h6>
                                                                        <h6 class="card-text badge-dark rounded-pill mx-auto py-1 w-25"><%# Eval("Descricao") %></h6>
                                                                        <h6 class="small text-muted">Scheduled: <%# Eval("DataPedido", "{0:dd/M/yyyy}") %></h6>

                                                                        <asp:Panel ID="panelExamButtons" runat="server" Visible='<%# (int)Eval("ID_Estado") == 9 %>'>
                                                                            <asp:LinkButton ID="link_examRedirect" class="btn btn-warning shadow shadow-sm" Target="_blank" href='<%# "/Resources/exams/" + Eval("PDFcaminho") %>' runat="server">Check Results</asp:LinkButton>
                                                                            <asp:LinkButton ID="link_examEmail" CommandName="link_examEmail" CommandArgument='<%# "Resources/exams/" + Eval("PDFcaminho") %>' class="btn btn-info shadow shadow-sm" runat="server">Send Email</asp:LinkButton>
                                                                        </asp:Panel>

                                                                    </div>
                                                                </div>
                                                           

                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                    
                                            </div>

                                            <div class="form-row text-center my-5 d-flex justify-content-center">

                                                <div class="col-lg-12">
                                                    <asp:Button ID="btn_scheduleBlood" CssClass="btn btn-dark shadow shadow-sm" runat="server" Text="Schedule" OnClick="btn_scheduleBlood_Click" />
                                                    <a class="btn btn-warning shadow shadow-sm" data-toggle="collapse" href="#collapseExams" role="button" aria-expanded="false" aria-controls="collapseExams">Check Exams</a>
                                                </div>

                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        <!-- //MODAL BODY -->

                          

                    </div>
                </div>
            </div>
    <!-- //Modal Schedule Bloodwork -->




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
    <!-- //modal verify Prescription -->


    <!-- SQL SOURCES -->
    <asp:SqlDataSource ID="sqlOrderSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnUserPersonalOrders" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="ID" Type="Int32" />
            <asp:Parameter DefaultValue="Active" Name="estado" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlExams" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnExams" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ClientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="sqlPartnerships" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT * FROM [ExamesParceria]"></asp:SqlDataSource>

    <!-- SCRIPTS -->
    <script src="BackOffice/BackOffice-Template/dist/js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
    <script src="BackOffice//BackOffice-Template/dist/assets/demo/chart-area-demo.js"></script>
    <script src="BackOffice//BackOffice-Template/dist/assets/demo/chart-bar-demo.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
    <script src="BackOffice//BackOffice-Template/dist/assets/demo/datatables-demo.js"></script>
    <!-- /SCRIPTS -->

</asp:Content>
