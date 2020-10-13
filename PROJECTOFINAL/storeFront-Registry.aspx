<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Registry.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Registry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   <style>
       .bg-register-image {
    background: url(Resources/images/register-nurse.jpg);
    background-position: center;
    background-size: cover
}
       .container{
           padding-left: 1.5rem;
           padding-right: 1.5rem;           
       }

   </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <div class="container">
    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-lg-block bg-register-image">
          </div>

          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Create an Account</h1>
              </div>
              <div class="user">
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_name1" pattern="[a-zA-Z]+" title="Only letters allowed, without special characters nor spaces." placeholder="First Name" required>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_name2" pattern="[a-zA-Z]+" title="Only letters allowed, without special characters nor spaces." placeholder="Last Name" required>
                  </div>
                </div>
                <div class="form-group">
                  <input type="email" class="form-control form-control-user bg-light" runat="server" id="tb_email" placeholder="Email Address" required>
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="password" class="form-control form-control-user bg-light" runat="server" id="tb_password" placeholder="Password" title="Password must have at least 7 characters and at least: 1 lowercase, 1 Uppercase, 1 number." pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user bg-light" id="tb_confirmPw" placeholder="Confirm Password" title="Password must have at least 7 characters and at least: 1 lowercase, 1 Uppercase, 1 number." pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                  </div>
                </div>

                  <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_nif" placeholder="NIF" title="Please insert your 9 digit NIF" pattern="^\d{9}$" required>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_healthNumber" placeholder="Health Number" title="Please insert your 9 digit health number" pattern="^\d{9}$" required>
                  </div>
                </div>

                  <div class="form-group row">
                  <div class="col-sm-9 mb-3 mb-sm-0">
                      <input type="text" class="form-control form-control-user bg-light" runat="server" id="tb_address" placeholder="Address" required>
                    </div>
                      <div class="col-sm-3">
                      <input id="tb_zipcode" runat="server" class="form-control form-control-user bg-light" name="zipcode" title="Please insert a valid zip code. (xxxx-yyy)" pattern="[0-9\-]+" placeholder="Zip-code" required>
                       </div>
                  </div>
                  

                  <div class="form-group row">
                      
                      <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="date" class="form-control form-control-user bg-light" runat="server" id="tb_dateOfBirth" placeholder="Date of Birth" value="2000-01-01">

                  </div>

                      <div class="col-sm-6 text-center">
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

                  <hr> 
                <asp:Button ID="btn_register" CssClass="btn btn-info input-group btn-user btn-block" runat="server" Text="Register Account" OnClick="btn_register_Click" />
                                
              </div>
                           

                <div class="text-center">
                    <asp:Label ID="lbl_message" runat="server" Font-Italic="False" ForeColor="#CC0000"></asp:Label>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
        </div>

</asp:Content>
