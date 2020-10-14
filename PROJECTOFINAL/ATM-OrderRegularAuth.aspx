<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-OrderRegularAuth.aspx.cs" Inherits="PROJECTOFINAL.ATM_OrderRegularAuth" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


                    <h2 class="text-center my-5"> Please submit the fields below to authenticate your order</h2>

                 
                    <div class="row justify-content-center text-center mb-2 mt-3">
                              <div class="col-md-5 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-hashtag"></i> </span>
                                </div>    
                                <input type="text" id="tb_OrderNumber" runat="server" class="form-control bg-light" placeholder="Order Reference Number" pattern="^[0-9]*$" title="The Ref# consists only of numbers." required/>
                                      </div>
                                
                              </div>
                        </div>
                        <div class="row justify-content-center">
                        <span class="text-muted h6"> You can obtain this number from your Order Details Page, or from the Order email sent to you after checkout. </span>
                               </div>    

                    <div class="row justify-content-center text-center mb-2">
                              <div class="col-md-5 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-at"></i> </span>
                                </div>    
                                <input type="email" id="tb_clientEmail" runat="server" class="form-control bg-light" placeholder="Email" required/>
                                      </div>
                                </div>
                              </div>
                        <div class="row justify-content-center">
                        <p class="text-muted h6"> Insert the email associated with your account. </p> </div>
                                   

                    <div class="row justify-content-center text-center mb-2">
                              <div class="col-md-5 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-lock"></i> </span>
                                </div>    
                                <input type="password" id="tb_password" runat="server" class="form-control bg-light" placeholder="Password" required/>
                                      </div>
                                <span class="text-muted h6"> Verify order authenticity by submitting your password. </span>
                              </div>
                                   </div>

                    <div class="row justify-content-center">
                        <label class="text-danger font-weight-bold" runat="server" id="lbl_message"></label>
                        </div>

                 <div class="text-center my-4">                   
                     <asp:Button ID="btn_regularAuth" CssClass="btn btn-primary" runat="server" Text="Confirm" OnClick="btn_regularAuth_Click" />                     
                 </div>
               
</asp:Content>
