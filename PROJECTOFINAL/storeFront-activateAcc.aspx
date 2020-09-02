<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-activateAcc.aspx.cs" Inherits="PROJECTOFINAL.storeFront_activateAcc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <meta http-equiv="refresh" content="5; url=https://localhost:44391/storeFront-index.aspx" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="jumbotron text-center mt-5 bg-light shadow shadow-sm" style="border-radius:20px;">  
            <div class="container">
        <h1 class ="h3 mb-3 font-weight-normal">Account Activation Status</h1>       		
            
            <div class="row justify-content-center">  <asp:Label ID="lbl_message" runat="server"></asp:Label> </div>  
            
        </div>
            </div>

</asp:Content>
