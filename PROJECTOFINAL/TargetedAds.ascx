<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TargetedAds.ascx.cs" Inherits="PROJECTOFINAL.TargetedAds" %>


<!-- item ads -->
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

                        <asp:Repeater ID="rptCarouselOne" runat="server" DataSourceID="sqlTargetedAds">
                            <ItemTemplate>

                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="storeFront-itemPage.aspx?ref=<%# Eval("Codreferencia") %>">
                                                <img id="adImage0" src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4><%# Eval("Nome") %></h4>
                                            <p class="item-price"><span id="adPrice0" runat="server"><%# Eval("preco") %> €</span></p>
                                        </div>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                </div>

                <div class="carousel-item">
                    <div class="row">

                        <asp:Repeater ID="rptCarouselTwo" runat="server" DataSourceID="sqlTargetedAds2">
                            <ItemTemplate>

                                <div class="col-sm-3">
                                    <div class="thumb-wrapper">
                                        <div class="img-box">
                                            <a href="storeFront-itemPage.aspx?ref=<%# Eval("Codreferencia") %>">
                                                <img id="adImage4" src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" class="img-fluid" alt="">
                                            </a>
                                        </div>
                                        <div class="thumb-content">
                                            <h4><%# Eval("Nome") %></h4>
                                            <p class="item-price"><span id="adPrice4" runat="server"><%# Eval("preco") %> €</span></p>
                                        </div>
                                    </div>
                                </div>


                            </ItemTemplate>
                        </asp:Repeater>

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
<!-- //item ads-->

<asp:SqlDataSource ID="sqlTargetedAds" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_PersonalizedAds" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ClienteID" Type="Int32" />
        <asp:Parameter Name="Cookie" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlTargetedAds2" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_PersonalizedAds2" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ClienteID" Type="Int32" />
        <asp:Parameter Name="Cookie" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
