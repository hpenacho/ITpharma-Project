<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-OrderRegularAuth.aspx.cs" Inherits="PROJECTOFINAL.ATM_OrderRegularAuth" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


                    <h2 class="text-center my-4"> Please submit the fields below to authenticate your order</h2>

                 
                    <div class="row justify-content-center">
                              <div class="col-md-11 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-hashtag"></i> </span>
                                </div>    
                                <input type="text" id="tb_OrderNumber" runat="server" class="form-control bg-light" placeholder="Order Reference Number" />
                                      </div>
                                <small class="text-muted"> You can obtain this number from your Order Details Page, or from the Order email sent to you after checkout. </small>
                              </div>
                                   </div>

                    <div class="row justify-content-center">
                              <div class="col-md-11 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-at"></i> </span>
                                </div>    
                                <input type="text" id="tb_clientEmail" runat="server" class="form-control bg-light" placeholder="Email" />
                                      </div>
                                <small class="text-muted"> Insert the email associated with your account. </small>
                              </div>
                                   </div>

                    <div class="row justify-content-center">
                              <div class="col-md-11 mb-2">
                                  <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"> <i class="fas fa-lock"></i> </span>
                                </div>    
                                <input type="password" id="tb_password" runat="server" class="form-control bg-light" placeholder="Password" />
                                      </div>
                                <small class="text-muted"> Verify order authenticity by submitting your password. </small>
                              </div>
                                   </div>

                    <div class="row justify-content-center">
                        <label class="text-danger font-weight-bold" runat="server" id="lbl_message"></label>
                        </div>

                 <div class="text-center my-4">
                    <asp:LinkButton ID="lbtn_regularAuth" CssClass="btn btn-primary" Text="Yes" runat="server" OnClick="lbtn_regularAuth_Click">Confirm</asp:LinkButton>
                </div>
               
</asp:Content>
