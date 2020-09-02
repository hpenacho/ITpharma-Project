<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Index.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">




</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- HEADER -->
            <header>
                
                 <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" role="listbox">
              <div class="carousel-item active">
                  <img class="d-block img-fluid" src="advPlaceholder.png" alt="First slide">
              </div>
              <div class="carousel-item">
                  <img class="d-block img-fluid" src="advPlaceholder.png" alt="Second slide">
              </div>
              <div class="carousel-item">
                  <img class="d-block img-fluid" src="advPlaceholder.png" alt="Third slide">
              </div>
              
          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>

            </header>
            <!-- // HEADER -->


</asp:Content>
