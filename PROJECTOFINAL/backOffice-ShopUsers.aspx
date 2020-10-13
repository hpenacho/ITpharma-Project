<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-ShopUsers.aspx.cs" Inherits="PROJECTOFINAL.backOffice_ShopUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style>

        th {

            text-align: center; 
            vertical-align: middle;
        }

        #prodtrash:hover{
            color: darkred;
        }

        #produpdate:hover{
            color: orange;
        }

        .table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
         background-color: #B5EE9B;
         transition: all 1s ease;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
     
    <!-- Shop User TABLE -->

    <div class="container-fluid mt-0">
        <div class="breadcrumb bg-light text-white mb-4 justify-content-around">
                                       
            <!-- Insert Shop Users | opens a modal with all the fields necessary to insert a Shop User manually -->
                <div class="row">                    
                    <div class="align-self-center">
                        <button type="button" class="btn-lg btn-warning mr-3" data-toggle="modal" data-target="#modal-insert-ShopUser">Add Shop User <i class="fas fa-plus"></i></button>    
                    </div>
               </div>
                                    
            <!-- /Insert Shop Users -->
        </div>

                <div class="row text-center justify-content-center">
                    <label id="lbl_updateError" runat="server" class="h5 text-warning"></label>
                </div> 

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table mr-1"></i>
                Shop User Table
            </div>
            <div class="card-body">
                <div class="table-responsive">

                    <table class="table table-striped table-hover" id="dataTable" width="100%" cellspacing="0">

                        <thead>
                            <!-- HEADER OF THE TABLE -->
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Account Status</th>
                                <th>First Activation</th>

                                <th class="text-hide"></th>
                                <th class="text-hide"></th>
                            </tr>
                        </thead>

                        <tbody class="text-center text-md-center">

                            <!-- SHOP USERS -->
                         
                                <asp:Repeater ID="rpt_ShopUsersBackOffice" runat="server" DataSourceID="SqlrptShopUsers" OnItemCommand="rpt_ShopUsersBackOffice_ItemCommand" OnItemDataBound="rpt_ShopUsersBackOffice_ItemDataBound">
                                <ItemTemplate>

                                    <tr class="text-center">
                                        <td class="align-middle">                                          
                                            <asp:Label ID="lbl_ID" runat="server" Text=<%# Eval("ID") %>></asp:Label>                                            
                                        </td>

                                        <td class="align-middle">
                                            <asp:TextBox ID="tb_updateName" runat="server" CssClass="text-center rounded-pill border-light bg-light" Text=<%# Eval("nome") %>></asp:TextBox>      
                                        </td>

                                        <td class="align-middle">
                                            <asp:TextBox ID="tb_updateEmail" runat="server" CssClass="text-center rounded-pill border-light bg-light" Text=<%# Eval("email") %>></asp:TextBox> 
                                        </td>

                                        <td class="align-middle">

                                            <h6 class="text-hide" style="margin-bottom: -9px;"><%# Eval("activo") %></h6>
                                            <!-- only for the filter -->
                                            <asp:CheckBox ID="check_userIsActive" Style="margin-left: -9px" runat="server" Checked='<%# Eval("activo") %>' />
                                            
                                        </td>

                                        <td class="align-middle">
                                            <h6 class="text-hide" style="margin-bottom: -9px;"><%# Eval("firstActivation") %></h6>
                                            <!-- only for the filter -->
                                            <asp:CheckBox ID="check_isFirstActivation" Style="margin-left: -9px" runat="server" Checked='<%# Eval("firstActivation") %>' />                                        
                                        </td>

                                        <td class="align-middle">
                                            <asp:LinkButton ID="link_updateShopUser" class="btn btn-sm" CommandName="link_updateShopUser" CommandArgument='<%# Eval("ID") %>' runat="server" CausesValidation="false"><i id="produpdate" class="fas fa-save"></i></asp:LinkButton>
                                        </td>

                                        <td class="align-middle">
                                            <asp:LinkButton ID="link_deleteShopUser" class="btn btn-sm" CommandName="link_deleteShopUser" CommandArgument='<%# Eval("ID") %>' runat="server"><i id="prodtrash" class="fas fa-trash"></i></asp:LinkButton>
                                        </td>
                                    </tr>

                                </ItemTemplate>


                            </asp:Repeater>

                            <!-- //SHOP USERS -->

                        </tbody>
                    </table>


                </div>
            </div>
        </div>
    </div>

    <!-- /SHOP USER TABLE -->





    <!-- insert shopUser Modal -->
    <div class="modal fade ml-3" id="modal-insert-ShopUser" tabindex="-1" role="dialog" aria-labelledby="modal-insert-ShopUser" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-label">Shop User Insertion<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </h5>
                </div>
                <div class="modal-body">
                    <!-- BEGIN MODAL BODY CONTENT -->


                    <!-- INNER UPDATE PANEL -->


                    <!-- NAVIGATION -->
                    <!-- /NAVIGATION -->

                    <div class="tab-content" id="insert-nav-tabContent">

                        <!-- CONTENT 1 DETAILS -->
                        <div class="tab-pane fade show active" id="insert-nav-details" role="tabpanel" aria-labelledby="nav-details-tab">

                            <div class="p-4">
                                <!-- WINDOW PADDING -->

                                <!-- Name -->
                                <div class="form-group row">
                                      <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_name1" placeholder="First Name" required pattern="[a-zA-Z]+" title="Only letters allowed, without special characters nor spaces.">
                                      </div>
                                      <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_name2" placeholder="Last Name" required pattern="[a-zA-Z]+" title="Only letters allowed, without special characters nor spaces.">
                                      </div>
                                    </div>
                                <!-- /Name -->

                                <!-- Email -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <input type="email" class="form-control form-control-user bg-light" runat="server" id="tb_email" placeholder=" Shop User's Email " data-toggle="tooltip" data-placement="top" title="Insert the Shop User's Email" required>
                                    </div>

                                </div>
                                <!-- /Email -->

                                <!-- NIF & Health Number -->
                                <div class="form-group row">

                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_NIF" placeholder=" NIF " data-toggle="tooltip" data-placement="top" title="Insert a 9 digit NIF" required pattern="^\d{9}$">
                                    </div>

                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_healthNumber" placeholder=" Health Number " data-toggle="tooltip" data-placement="top" title="Insert a 9 digit Health Number" pattern="^\d{9}$" required>
                                    </div>

                                </div>
                                <!-- /NIF & Health Number -->

                                <!-- Address -->
                                <div class="form-group row">
                                  <div class="col-sm-9 mb-3 mb-sm-0">
                                      <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_address" placeholder="Address" required>
                                    </div>
                                      <div class="col-sm-3">
                                      <input id="tb_zipcode" runat="server" class="form-control form-control-user bg-light" name="zipcode" pattern="[0-9\-]+" title="Please insert a valid zip code. (xxxx-yyy)" placeholder="Zip-code" required>
                                       </div>
                                  </div>
                                <!-- /Address -->

                                
                                
                                <!-- DateOfBirth & Gender -->
                                
                                <div class="form-group row justify-content-center">
                      
                                  <div class="col-sm-4 mb-3 mb-sm-0">
                                <input type="date" class="form-control form-control-user bg-light" runat="server" id="tb_dateOfBirth" placeholder="Date of Birth" value="2000-01-01">

                              </div>

                                  <div class="col-sm-4 text-center">
                                  <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                      <label class="btn btn-light active">
                                        <input type="radio" name="radioGender" id="gender_male" autocomplete="off" runat="server" checked > <h6> <i class="fas fa-mars text-primary"> </i>  Male </h6>
                                      </label>
                                      <label class="btn btn-light">
                                        <input type="radio" name="radioGender" id="gender_female" autocomplete="off" runat="server"> <h6><i class="fas fa-venus text-danger"></i>  Female </h6>
                                      </label>
                                    </div>
                                  </div>
                                  </div>

                                <!-- /Gender & DateOfBirth -->
                            <!-- WINDOW PADDING -->

                        </div>
                        <!-- // CONTENT 1 DETAILS -->


                        <div class="form-row mt-4">
                            <div class="col text-center">                                                                
                                <asp:Button ID="btn_insertShopUser" runat="server" class="btn btn-primary btn-dark w-25 mr-1" Text=" Insert " OnClick="btn_insertShopUser_Click"/>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        <div class="form-row mt-2">
                            <label id="lbl_errors" class="text-center text-warning" runat="server"></label>
                        </div>

                    </div>
                    <!-- //TAB SYSTEM ENDING -->


                    <!-- END INNER UPDATE PANEL -->


                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>
    <!-- /Insert products Modal -->

     <script type="text/javascript">

         $(document).ready(function () {
             $('[data-toggle="tooltip"]').tooltip();
         });

     </script>


    <!-- SQLSOURCES AND REPEATER SOURCES -->
    <asp:SqlDataSource ID="SqlrptShopUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT [ID], [nome], [email], [firstActivation], [activo] FROM [Cliente] where cliente.nome not like 'ATM -%'"></asp:SqlDataSource>


     </div>
</asp:Content>
