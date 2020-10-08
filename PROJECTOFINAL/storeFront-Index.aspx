<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Index.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <!-- Bootstrap core CSS -->
    <link href="StoreFront/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="StoreFront/css/modern-business.css" rel="stylesheet">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <header>
        <div class="container mt-5 pl-5 pr-5">
            <div class="row justify-content-center">
                <div class="col-lg-12" style="max-height:500px; max-width: 889px;">
         <div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" style="border-radius:20px;" role="listbox">                        
            <div class="carousel-item active">
              <img class="d-block img-fluid" id="imgSlotAge" runat="server" src="#" alt="First Slide">
            </div>
              <div class="carousel-item">
              <img class="d-block img-fluid" id="imgSlotGender" runat="server" src="#" alt="Second Slide">
            </div>
              <div class="carousel-item">
              <img class="d-block img-fluid" id="imgSlotSeasonal" runat="server" src="#" alt="Third Slide">
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
            </div>
            </div>
            </div>
    </header>




    <!-- PROMO -->
   
    <div class="container mt-3 shadow-sm text-center">
        <!-- Image Header -->
        <img class="img-fluid rounded mb-4 align-self-center" style="width: 60em; height: auto;" src="Resources/images/pharmaBannerII.png" alt="">
    </div>

  <!-- Page Content -->
  <div class="container mt-4">

    <!-- Portfolio Section -->
    <div class="row">

      <div class="col-lg-4 col-sm-6 portfolio-item">
        <div class="card h-100 border-light text-center">
          <a href="#"><img class="card-img-top" src="#" alt=""></a>
          <div class="card-body">
            <h4 class="card-title">
              <a href="#" class="card-text text-dark">Placeholder 1</a>
            </h4>
            <p class="card-text small text-dark">Lorem Ipsum Lorem Ipsum</p>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-sm-6 portfolio-item">
        <div class="card h-100 border-light text-center">
          <a href="#"><img class="card-img-top" src="#" alt=""></a>
          <div class="card-body">
            <h4 class="card-title">
              <a href="#" class="card-text text-dark">Placeholder 2</a>
            </h4>
            <p class="card-text small text-dark">Lorem Ipsum Lorem Ipsum</p>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-sm-6 portfolio-item">
        <div class="card h-100 border-light text-center">
          <a href="#"><img class="card-img-top" src="#" alt=""></a>
          <div class="card-body">
            <h4 class="card-title">
              <a href="#" class="card-text text-dark">Placeholder 3</a>
            </h4>
            <p class="card-text small text-dark">Lorem Ipsum Lorem Ipsum</p>
          </div>
        </div>
      </div>

    </div>
    <!-- /.row -->

    <hr>

  </div>


    <!-- Bootstrap core JavaScript -->
    <script src="StoreFront/vendor/jquery/jquery.min.js"></script>
    <script src="StoreFront/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


</asp:Content>
