<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Index.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- HEADER -->
    <header>

        <div id="carouselExampleIndicators" class="carousel slide my-5" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner" role="listbox">
                <div class="carousel-item active">
                    <img class="d-block img-fluid" style="border-radius:20px;" src="advPlaceholder.png" alt="First slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block img-fluid" style="border-radius:20px;" src="advPlaceholder.png" alt="Second slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block img-fluid" style="border-radius:20px;" src="advPlaceholder.png" alt="Third slide">
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


    <div class="row">

        <div class="col-lg-3">

            <h1 class="my-4">Catalog</h1>
            <div class="list-group">
                <a href="#" class="list-group-item">Category 1</a>
                <a href="#" class="list-group-item">Category 2</a>
                <a href="#" class="list-group-item">Category 3</a>
            </div>

        </div>
        <!-- /.col-lg-3 -->

        <div class="col-lg-9">

            <div class="row mt-5">

 
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100">
                            <a href="#">
                                <img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                            <div class="card-body">
                                <h4 class="card-title">
                                    <a href="#">Item One</a>
                                </h4>
                                <h6>$24.99</h6>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100">
                            <a href="#">
                                <img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                            <div class="card-body">
                                <h4 class="card-title">
                                    <a href="#">Item Two</a>
                                </h4>
                                <h6>$24.99</h6>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100">
                            <a href="#">
                                <img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                            <div class="card-body">
                                <h4 class="card-title">
                                    <a href="#">Item Three</a>
                                </h4>
                                <h6>$24.99</h6>
                            </div>
                        </div>
                    </div>

                  <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100">
                            <a href="#">
                                <img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                            <div class="card-body">
                                <h4 class="card-title">
                                    <a href="#">Item Three</a>
                                </h4>
                                <h6>$24.99</h6>
                            </div>
                        </div>
                    </div>

                  <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100">
                            <a href="#">
                                <img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                            <div class="card-body">
                                <h4 class="card-title">
                                    <a href="#">Item Three</a>
                                </h4>
                                <h6>$24.99</h6>
                            </div>
                        </div>
                    </div>

                  <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100">
                            <a href="#">
                                <img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                            <div class="card-body">
                                <h4 class="card-title">
                                    <a href="#">Item Three</a>
                                </h4>
                                <h6>$24.99</h6>
                            </div>
                        </div>
                    </div>

         

            </div>
            <!-- /.row -->

        </div>
        <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->












</asp:Content>
