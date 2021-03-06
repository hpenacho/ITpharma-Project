﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-Search.aspx.cs" Inherits="PROJECTOFINAL.ATM_Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container mt-3">
        <div class="row">
            <div class="col-lg-12 text-center">
                 <a href="ATM-Front.aspx" class="btn btn-dark shadow shadow-sm" style="font-size:larger; width: 17.5em;">Back</a>
            </div>
        </div>
    </div>

      <div class="col-lg-12 mt-4 justify-content-around">
        <div class="row">
            <asp:Repeater ID="rptShopProducts" runat="server" DataSourceID="sqlSearchSource">
                <ItemTemplate>

                    <div class="col-lg-4 col-md-6 mb-4">
                         <a href='ATM-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>' class="text-decoration-none">
                        <div class="card h-100 border-light shadow shadow-sm rounded category-card border-0 mt-2">
                            <center> 
                                <div class="text-center" style="height:150px; width:150px">
                                    <img style='height: 100%; width: 100%; object-fit: contain' src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Categoria">
                                 </div> 
                            </center>
                            <div class="card-body">
                                <!-- card body -->
                                <h4 class="card-title text-center">
                                    <h5 class="text-center text-dark"><%# Eval("nome") %></h5>
                                </h4>
                            </div>
                            <!-- //card body -->
                        </div>
                        </a>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
   


    <!-- SQL SOURCES -->
    <asp:SqlDataSource ID="sqlSearchSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_searchATMShopProducts" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="null" Name="query" SessionField="search" Type="String" />
            <asp:Parameter Name="PickupID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
