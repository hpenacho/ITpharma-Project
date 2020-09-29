<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Shop.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Shop" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>


        body {
            font-family: "Open Sans", sans-serif;
        }

        h2 {
            color: #000;
            font-size: 26px;
            font-weight: 300;
            text-align: center;
            text-transform: uppercase;
            position: relative;
            margin: 30px 0 80px;
        }

            h2 b {
                color: #ffc000;
            }

            h2::after {
                content: "";
                width: 100px;
                position: absolute;
                margin: 0 auto;
                height: 4px;
                background: rgba(0, 0, 0, 0.2);
                left: 0;
                right: 0;
                bottom: -20px;
            }

        .carousel {
            margin: 10px auto;
            padding: 0 50px;
        }

            .carousel .carousel-item {
                min-height: 330px;
                text-align: center;
                overflow: hidden;
            }

                .carousel .carousel-item .img-box {
                    height: 160px;
                    width: 100%;
                    position: relative;
                }

                .carousel .carousel-item img {
                    max-width: 100%;
                    max-height: 100%;
                    display: inline-block;
                    position: absolute;
                    bottom: 0;
                    margin: 0 auto;
                    left: 0;
                    right: 0;
                }

                .carousel .carousel-item h4 {
                    font-size: 18px;
                    margin: 10px 0;
                }

                .carousel .carousel-item .btn {
                    color: #333;
                    border-radius: 0;
                    font-size: 11px;
                    text-transform: uppercase;
                    font-weight: bold;
                    background: none;
                    border: 1px solid #ccc;
                    padding: 5px 10px;
                    margin-top: 5px;
                    line-height: 16px;
                }

                    .carousel .carousel-item .btn:hover, .carousel .carousel-item .btn:focus {
                        color: #fff;
                        background: #000;
                        border-color: #000;
                        box-shadow: none;
                    }

                    .carousel .carousel-item .btn i {
                        font-size: 14px;
                        font-weight: bold;
                        margin-left: 5px;
                    }

            .carousel .thumb-wrapper {
                text-align: center;
            }

            .carousel .thumb-content {
                padding: 15px;
            }

        .carousel-control-prev, .carousel-control-next {
            height: 100px;
            width: 40px;
            background: none;
            margin: auto 0;
            background: rgba(0, 0, 0, 0.2);
        }

            .carousel-control-prev i, .carousel-control-next i {
                font-size: 30px;
                position: absolute;
                top: 50%;
                display: inline-block;
                margin: -16px 0 0 0;
                z-index: 5;
                left: 0;
                right: 0;
                color: rgba(0, 0, 0, 0.8);
                text-shadow: none;
                font-weight: bold;
            }

            .carousel-control-prev i {
                margin-left: -3px;
            }

            .carousel-control-next i {
                margin-right: -3px;
            }

        .carousel .item-price {
            font-size: 13px;
            padding: 2px 0;
        }

            .carousel .item-price strike {
                color: #999;
                margin-right: 5px;
            }

            .carousel .item-price span {
                color: #86bd57;
                font-size: 110%;
            }

        .carousel .carousel-indicators {
            bottom: -50px;
        }

        .carousel-indicators li, .carousel-indicators li.active {
            width: 10px;
            height: 10px;
            margin: 4px;
            border-radius: 50%;
            border-color: transparent;
            border: none;
        }

        .carousel-indicators li {
            background: rgba(0, 0, 0, 0.2);
        }

            .carousel-indicators li.active {
                background: rgba(0, 0, 0, 0.6);
            }

        .star-rating li {
            padding: 0;
        }

        .star-rating i {
            font-size: 14px;
            color: #ffc000;
        }

        @media only screen and (max-width: 961px) {
            #targetAds {
                display: none;
            }
        }


    </style>

   
  


</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <!-- Page Content -->
    <div class="container">


        <!-- Recommended item carousel -->

        <div class="row" id="targetAds">
            <div class="col-lg-12">
                <h2>Based on your<b>&nbspShopping Experience</b></h2>
                <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="0">
                    <!-- Carousel indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                    </ol>
                    <!-- Wrapper for carousel items -->

                    <div class="carousel-inner">

                        <div class="carousel-item active">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A0" runat="server">
                                                <img id="adImage0" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4 id="adTitle0" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice0" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A1" runat="server">
                                                <img id="adImage1" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4 id="adTitle1" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice1" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A2" runat="server">
                                                <img id="adImage2" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4 id="adTitle2" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice2" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A3" runat="server">
                                                <img id="adImage3" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4 id="adTitle3" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice3" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="carousel-item">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A4" runat="server">
                                                <img id="adImage4" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4 id="adTitle4" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice4" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A5" runat="server">
                                                <img id="adImage5" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4 id="adTitle5" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice5" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A6" runat="server">
                                                <img id="adImage6" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4 id="adTitle6" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice6" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="#" id="A7" runat="server">
                                                <img id="adImage7" runat="server" src="#" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                                <h4 id="adTitle7" runat="server"></h4>
                                            <p class="item-price"><span id="adPrice7" runat="server"></span></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Carousel controls -->
                    <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
                        <i class="fa fa-angle-left"></i>
                    </a>
                    <a class="carousel-control-next" href="#myCarousel" data-slide="next">
                        <i class="fa fa-angle-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- // recommended item carousel -->



        <div class="row">

            <div class="col-lg-3 mb-3" style="margin-top: 10vh;">

                <h6 class="my-4">Filtros</h6>

                <div class="list-group list-group-flush">

                        <div class="form-group mb-3">
                            <asp:DropDownList ID="ddl_filters" CssClass="form-control w-100 border-0 bg-light" runat="server" OnSelectedIndexChanged="ddl_filters_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="NASC">A - Z</asp:ListItem>
                                <asp:ListItem Value="NDESC">Z  - A</asp:ListItem>
                                <asp:ListItem Value="PASC">Price ASC</asp:ListItem>
                                <asp:ListItem Value="PDESC">Price DESC</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                </div>


                <h6 class="my-4">Category</h6>

                <div class="list-group list-group-flush">

                     <asp:Repeater ID="rptCategory" runat="server" DataSourceID="sqlCategorySource" OnItemCommand="rptCategory_ItemCommand">
                        <ItemTemplate>

                            <asp:LinkButton runat="server" CommandName="linkSelectCategory" CommandArgument='<%# Eval("Descricao") %>' CssClass="list-group-item list-group-item-action d-flex justify-content-between align-items-center"><%# Eval("descricao") %><span class="badge badge-light badge-pill"><%# Eval("Count") %></span></asp:LinkButton>

                        </ItemTemplate>
                    </asp:Repeater>
                 
                </div>

                <h6 class="my-4">Brand</h6>

                <div class="list-group list-group-flush">

                    <asp:Repeater ID="rptBrands" runat="server" DataSourceID="sqlBrandsSource" OnItemCommand="rptBrands_ItemCommand">
                        <ItemTemplate>

                            <asp:LinkButton runat="server" CommandName="linkSelectBrand" CommandArgument='<%# Eval("Descricao") %>' CssClass="list-group-item list-group-item-action d-flex justify-content-between align-items-center"><%# Eval("descricao") %><span class="badge badge-light badge-pill"><%# Eval("Count") %></span></asp:LinkButton>

                        </ItemTemplate>
                    </asp:Repeater>


                </div>

            </div>
            <!-- /.col-lg-3 -->
            <div class="col-lg-9" style="margin-top: 10vh;">

                <div class="row">

                    <asp:Repeater ID="rptShopProducts" runat="server" DataSourceID="sqlShopProducts">
                        <ItemTemplate>

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 border-white">                                                                        
                                       <center> <div class="text-center" style="height:215px; width:215px">
                                            <a href='storeFront-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>'>
                                        <img style='height: 100%; width: 100%; object-fit: contain' src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Product Image"></a>
                                        </div> </center>
                                    


                                    <div class="card-body">
                                        <!-- card body -->
                                        <h4 class="card-title text-center">
                                            <h5 class="text-center text-success"><%# Eval("preco") %> €</h5>
                                        </h4>
                                        <a href='storeFront-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>' class="text-decoration-none text-dark text-center">
                                                <h5><%# Eval("nome") %></h5>
                                            </a>
                                        

                                    </div>
                                    <!-- //card body -->
                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>


                </div>
                <!-- /.row -->

                <!-- PAGINATION -->
                 <asp:Panel ID="pagePanel" class="col-lg-12 text-center mb-5" runat="server"></asp:Panel>
              <!-- //PAGINATION -->

            </div>
            <!-- /.col-lg-9 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->



    <!-- SQL SOURCES -->
    <asp:SqlDataSource ID="sqlShopProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_productFiltering" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="nome" Name="Campo" Type="String" />
            <asp:Parameter DefaultValue="ASC" Name="Ordem" Type="String" />
            <asp:Parameter DefaultValue="All" Name="Categoria" Type="String" />
            <asp:Parameter DefaultValue="All" Name="Marca" Type="String" />
            <asp:Parameter DefaultValue="1" Name="Pagina" Type="Int32" />
            <asp:Parameter DefaultValue="9" Name="ItemsPagina" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlSearchProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_searchShopProducts" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="query" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlBrandsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="select Marca.ID, Marca.descricao , Count(Produto.ID_Categoria) as 'Count'
            from Marca inner join Produto on Produto.ID_Marca = Marca.ID
            where Produto.Activo = 1 
		    AND Produto.Descontinuado = 0
            group by Marca.ID, Marca.descricao">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlCategorySource" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="select Categoria.ID, Categoria.descricao , Count(Produto.ID_Categoria) as 'Count'
            from Categoria inner join Produto on Produto.ID_Categoria = Categoria.ID
            where Produto.Activo = 1 
		    AND Produto.Descontinuado = 0
            group by Categoria.ID, Categoria.descricao">
    </asp:SqlDataSource>

     <!-- //SQL SOURCES -->

</asp:Content>
