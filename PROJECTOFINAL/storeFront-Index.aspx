<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Index.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <!-- Bootstrap core CSS -->
    <link href="StoreFront/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="StoreFront/css/modern-business.css" rel="stylesheet">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <header>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-12">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" style="border-radius:20px;" role="listbox">
            <div class="carousel-item active">
              <img class="d-block img-fluid" id="imgSlotSeasonal" runat="server" src="Resources/images/summerAd.png" alt="First slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" id="imgSlotGender" runat="server" src="Resources/images/winterAd1.png" alt="Second slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" id="imgSlotAge" runat="server" src="Resources/images/fallAd1.png" alt="Third slide">
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

    <!-- Page Content -->
    <div class="container my-5">

        <h1 class="my-4">Welcome to Modern Business</h1>

        <!-- Marketing Icons Section -->
        <div class="row my-5">
            <div class="col-lg-4 mb-4">
                <div class="card h-100">
                    <h4 class="card-header">Card Title</h4>
                    <div class="card-body">
                        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
                    </div>
                    <div class="card-footer">
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="card h-100">
                    <h4 class="card-header">Card Title</h4>
                    <div class="card-body">
                        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis ipsam eos, nam perspiciatis natus commodi similique totam consectetur praesentium molestiae atque exercitationem ut consequuntur, sed eveniet, magni nostrum sint fuga.</p>
                    </div>
                    <div class="card-footer">
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="card h-100">
                    <h4 class="card-header">Card Title</h4>
                    <div class="card-body">
                        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
                    </div>
                    <div class="card-footer">
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->


   




    </div>
    <!-- /.container -->


    <!-- Bootstrap core JavaScript -->
    <script src="StoreFront/vendor/jquery/jquery.min.js"></script>
    <script src="StoreFront/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


</asp:Content>
