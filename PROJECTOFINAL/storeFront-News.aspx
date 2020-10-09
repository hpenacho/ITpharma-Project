<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-News.aspx.cs" Inherits="PROJECTOFINAL.storeFront_News" %>

<%@ Register Src="~/News/newsUserControl.ascx" TagPrefix="uc1" TagName="newsUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" href="News/news.css">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <uc1:newsUserControl runat="server" id="newsUserControl" />

</asp:Content>
