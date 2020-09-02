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
 
     <label id="lbl_updateError" runat="server"></label>

    <!-- Shop User TABLE -->

    <div class="container-fluid">
        <h1>Shop Users</h1>
        <ol class="breadcrumb bg-dark text-white mb-4">
                                
            <a class="breadcrumb-item text-white" href="backOffice-Index.aspx">Dashboard</a>
            <li class="breadcrumb-item active">Shop Users</li>
       
            <!-- Insert Shop Users | opens a modal with all the fields necessary to insert a Shop User manually -->
                <div>
                    <button type="button" class="btn btn-warning mr-3" data-toggle="modal" data-target="#modal-insert-ShopUser">Add Shop User <i class="fas fa-plus"></i></button>    
                </div>
            
            
            <!-- /Insert Shop Users -->
        </ol>

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
                                            <asp:TextBox ID="tb_updateName" runat="server" BorderStyle="None" Text=<%# Eval("nome") %>></asp:TextBox>      
                                        </td>

                                        <td class="align-middle">
                                            <asp:TextBox ID="tb_updateEmail" runat="server" BorderStyle="None" Text=<%# Eval("email") %>></asp:TextBox> 
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
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <input type="text" class="form-control" runat="server" id="tb_name" placeholder="Client Name" data-toggle="tooltip" data-placement="Top" title="Insert the Shop User's full name." required>
                                    </div>

                                </div>
                                <!-- /Name -->

                                <!-- Email -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <label for="tb_email">Email</label>
                                        <input type="text" class="form-control" runat="server" id="tb_email" placeholder=" Shop User's Email " data-toggle="tooltip" data-placement="top" title="Insert the Shop User's Email" required>
                                    </div>

                                </div>
                                <!-- /Email -->

                                <!-- Address -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <label for="tb_address">Address</label>
                                        <input type="text" class="form-control" runat="server" id="tb_address" placeholder=" Full Address " data-toggle="tooltip" data-placement="top" title="Insert the Full Address" required>
                                    </div>

                                </div>
                                <!-- /Address -->

                                <!-- NIF & Health Number -->
                                <div class="form-row mt-2 d-flex justify-content-between"">

                                    <div class="form-group col-md-5">
                                        <label for="tb_NIF">NIF</label>
                                        <input type="text" class="form-control" runat="server" id="tb_NIF" placeholder=" NIF " data-toggle="tooltip" data-placement="top" title="Insert NIF" required>
                                    </div>

                                    <div class="form-group col-md-5">
                                        <label for="tb_healthNumber">Health Number</label>
                                        <input type="text" class="form-control" runat="server" id="tb_healthNumber" placeholder=" Health Number " data-toggle="tooltip" data-placement="top" title="Insert Health Number" required>
                                    </div>

                                </div>
                                <!-- /NIF & Health Number -->
                                
                                <!-- Gender & DateOfBirth -->
                                <div class="form-row mt-2 d-flex justify-content-between">
               
                                    <!-- Gender -->
                                   
                                    <div class="col-md-5">
                                         
                                      <div class="custom-control custom-radio custom-control-inline">
                                          <asp:RadioButton ID="rbtn_male" runat="server" Checked="True" GroupName="gender" class="custom-control custom-radio custom-control-inline" Text="Male"/>                                   
                                      </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <asp:RadioButton ID="rbtn_female" runat="server" GroupName="gender" Text="Female"/>       
                                       </div> 
                               
                                        </div>
                                    <!-- /Gender -->

                                    <!-- DateOfBirth -->
                                    <div class="col-md-5"> 
                                       <div class="input-group">
                                           <div class="input-group-append">
                                             <span class="input-group-text" id="inputGroupPrepend3"><i class="fas fa-euro-sign"></i></span>
                                           </div>
                                             <input type="date" class="form-control" runat="server" id="tb_dateofbirth" aria-describedby="inputGroupPrepend3" value="2000-01-01" required>
                                       </div>
                                    </div> 
                                    <!-- /DateOfBirth -->
                                   
                               </div>
                                <!-- /Gender & DateOfBirth -->
                            <!-- WINDOW PADDING -->

                        </div>
                        <!-- // CONTENT 1 DETAILS -->


                        <div class="form-row mt-4">
                            <div class="col text-center">                                
                                <asp:LinkButton ID="link_insertShopUser" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertShopUser_Click"> Insert </asp:LinkButton>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        <div class="form-row mt-2">
                            <label id="lbl_errors" runat="server"></label>
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
    <asp:SqlDataSource ID="SqlrptShopUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT [ID], [nome], [email], [firstActivation], [activo] FROM [Cliente]"></asp:SqlDataSource>


     </div>
</asp:Content>
