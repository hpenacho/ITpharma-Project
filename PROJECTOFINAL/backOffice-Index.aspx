<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Index.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Index" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>


<asp:Content ID="Content2" class="btn btn-primary" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!-- CONTENT  -->
                                  
                            <ol class="breadcrumb mb-4 ml-4 mr-4 mt-4 text-center justify-content-center align-content-center">
                                <li class="breadcrumb-item active"><i class="fas fa-map-marked-alt"></i> &nbsp Active ITpharma Pickup Locations</li>
                            </ol>
                                                               
                                <div class="text-center align-middle">
                             <iframe src="https://www.google.com/maps/d/embed?mid=1pd2yxKy1XfgzgootzzgzU2qJKYlEq-R3" frameborder="0" width=75% height="640"></iframe>
                                </div>
                                                      
    <!-- / CONTENT -->

</asp:Content>
