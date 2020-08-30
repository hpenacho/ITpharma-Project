<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Analytics.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Analytics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.card-box {
    position: relative;
    color: #fff;
    padding: 20px 10px 40px;
    margin: 20px 0px;
}
.card-box:hover {
    text-decoration: none;
    color: #f1f1f1;
}
.card-box:hover .icon {
    font-size: 86px;
    transition: 1.5s;
    -webkit-transition: 1s;
}
.card-box .inner {
    padding: 5px 10px 0 10px;
}
.card-box h3 {
    font-size: 27px;
    font-weight: bold;
    margin: 0 0 8px 0;
    white-space: nowrap;
    padding: 0;
    text-align: left;
}
.card-box p {
    font-size: 15px;
}
.card-box .icon {
    position: absolute;
    transition: 1s;
    top: 0;
    bottom: 5px;
    right: 5px;
    z-index: 0;
    font-size: 72px;
    color: rgba(0, 0, 0, 0.15);
}
.card-box .card-box-footer {
    position: absolute;
    left: 0px;
    bottom: 0px;
    text-align: center;
    padding: 3px 0;
    color: rgba(255, 255, 255, 0.8);
    background: rgba(0, 0, 0, 0.1);
    width: 100%;
    text-decoration: none;
}
.card-box:hover .card-box-footer {
    background: rgba(0, 0, 0, 0.3);
}
.bg-blue {
    background-color: #00c0ef !important;
}
.bg-green {
    background-color: #00a65a !important;
}
.bg-orange {
    background-color: #f39c12 !important;
}
.bg-red {
    background-color: #d9534f !important;
}
</style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">
        
          <div class="mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-blue">
                    <div class="inner">
                        <h3><asp:Label ID="lbl_stats0" runat="server" Text="totalOrders#"></asp:Label></h3>
                        <p> Total Orders </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-shopping-cart" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseOrders" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseOrders">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseOrders">
                        <div class="card card-footer">
                            <p> Orders this month: <asp:Label ID="lbl_stats1" runat="server" Text="ordersMonth#"></asp:Label></p>
                            <p> Orders today: <asp:Label ID="lbl_stats2" runat="server" Text="ordersDay#"></asp:Label></p>                            
                          </div>
                        </div>   
                <!-- -->
                </div>
            </div>

            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-green">
                    <div class="inner">
                        <h3> €<asp:Label ID="lbl_stats3" runat="server" Text="Total money"></asp:Label> </h3>
                        <p> Total Profit </p>
                    </div>
                    <div class="icon">
                        <i class="far fa-money-bill-alt" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseProfit" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseProfit">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseProfit">
                        <div class="card card-footer">
                            <p> Profit this month: €<asp:Label ID="lbl_stats4" runat="server" Text="moneyMonth"></asp:Label></p>
                            <p> Profit today: €<asp:Label ID="lbl_stats5" runat="server" Text="moneyDay"></asp:Label></p>                            
                          </div>
                        </div>  
                </div>
            </div>
            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-orange">
                    <div class="inner">
                        <h3><asp:Label ID="lbl_stats6" runat="server" Text="totalProds#"></asp:Label> </h3>
                        <p> Total Unique Products </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-box-open" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseProducts" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseProducts">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseProducts">
                        <div class="card card-footer text-center">
                            <p> Active: <asp:Label ID="lbl_stats7" runat="server" Text="activeProds#"></asp:Label> &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp Inactive: <asp:Label ID="lbl_stats8" runat="server" Text="inactiveProds#"></asp:Label> </p>
                            <p> Archived: <asp:Label ID="lbl_stats9" runat="server" Text="archivedProds#"></asp:Label></p>
                          </div>
                        </div>  
                </div>
            </div>
            <!-- -->
            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-info">
                    <div class="inner">
                        <h3> <asp:Label ID="lbl_stats10" runat="server" Text="totalItems#"></asp:Label> </h3>
                        <p> Total Item Qty </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-boxes" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseQty" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseQty">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseQty">
                        <div class="card card-footer">
                            <p> Warehouse: <asp:Label ID="lbl_stats11" runat="server" Text="warehouseItems#"></asp:Label></p>
                            <p> Pickups: <asp:Label ID="lbl_stats12" runat="server" Text="atmItems#"></asp:Label></p>                            
                          </div>
                        </div>   
                <!-- -->
                </div>
            </div>
            <!-- -->
            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-red">
                    <div class="inner">
                        <h3> <asp:Label ID="lbl_stats13" runat="server" Text="totalShoppers#"></asp:Label> </h3>
                        <p> Total Shoppers </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-users"></i>
                    </div>
                    <a href="#collapseShoppers" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseShoppers">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseShoppers">
                        <div class="card card-footer">                            
                            <p> Active: <asp:Label ID="lbl_stats14" runat="server" Text="activeShoppers#"></asp:Label></p>
                            <p> Inactive: <asp:Label ID="lbl_stats15" runat="server" Text="inactiveShoppers#"></asp:Label></p>
                          </div>
                        </div>  
                </div>
            </div>

            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-secondary">
                    <div class="inner">
                        <h3> <asp:Label ID="lbl_stats16" runat="server" Text="totalExams#"></asp:Label> </h3>
                        <p> Total Exams Outsourced </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-notes-medical"></i>
                    </div>
                    <a href="#collapseExams" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseExams">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseExams">
                        <div class="card card-footer">
                            <p> Exams this month: <asp:Label ID="lbl_stats17" runat="server" Text="examsMonth#"></asp:Label></p>
                            <p> Exams today: <asp:Label ID="lbl_stats18" runat="server" Text="examsDay#"></asp:Label></p>                            
                          </div>
                        </div>   
                <!-- -->
                </div>
            </div>

        </div>
    </div>
        <!-- end of top row stat cards -->

        <div class="row mt-4 justify-content-around">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area mr-1"></i>
                                        Area Chart Example
                                    </div>
                                    <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            
                         <div class="col-xl-6">
                               <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                DataTable Example
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Position</th>
                                                <th>Office</th>
                                                <th>Age</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Tiger Nixon</td>
                                                <td>System Architect</td>
                                                <td>Edinburgh</td>
                                                <td>61</td>
                                            </tr>
                                            <tr>
                                                <td>Garrett Winters</td>
                                                <td>Accountant</td>
                                                <td>Tokyo</td>
                                                <td>63</td>
                                            </tr>
                                            <tr>
                                                <td>Ashton Cox</td>
                                                <td>Junior Technical Author</td>
                                                <td>San Francisco</td>
                                                <td>66</td>
                                            </tr>                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                             </div>

                        </div>

    <!-- charts END here-->
        
            <div class="row d-flex justify-content-around">
                

                    <div class="col-lg-4">

                        <div class="card">
                            <div class="card-header"><i class="fas fa-fire-alt"></i> Most Popular Product</div>
                            <div class="card-body">
                                <div class="row justify-content-around">
                                 <asp:Image ID="img_popProd" CssClass="card-img" runat="server" Width="60" />
                                    <p class="card-text">Ref: <asp:Label ID="lbl_PopProdRef" runat="server" Text="[PopProdRef]"></asp:Label> </p>
                                    <p class="card-text">Name: <asp:Label ID="lbl_PopProdName" runat="server" Text="[PopProdName]"></asp:Label> </p>
                                    
                                    </div>
                            </div>
                        </div>

                    </div>

                    <div class="col-lg-5">

                        <div class="card">
                            <div class="card-header"><i class="fas fa-star"></i> Bestseller</div>
                            <div class="card-body">
                         <div class="row justify-content-around">
                             <asp:Image ID="img_bsProd" CssClass="card-img" runat="server" width="60" />
                                <p class="card-text">Ref: <asp:Label ID="lbl_bsRef" runat="server" Text="[bsRef]"></asp:Label> </p>
                                    <p class="card-text">Name: <asp:Label ID="lbl_bsName" runat="server" Text="[bsName]"></asp:Label> </p>
                                      <p class="card-text">Sold: <asp:Label ID="lbl_bsQty" runat="server" Text="[bsQty]"></asp:Label> </p>                                    
                                    </div>

                            </div>
                        </div>

                    </div>

                    <div class="col-lg-3">

                        <div class="card">
                            <div class="card-header"><i class="fas fa-user-check"></i> Newest Shopper</div>
                            <div class="card-body">
                                <div class="row justify-content-around">
                                <p class="card-text">Name: <asp:Label ID="lbl_newShopperName" runat="server" Text="[shopper Name]"></asp:Label></p>
                                <p class="card-text">Age: <asp:Label ID="lbl_newShopperAge" runat="server" Text="[shopper Age]"></asp:Label></p>
                                    </div>
                            </div>
                        </div>

                    </div>


                </div>


            


        </div>

        

     <!-- end of main container -->

    <!-- SQL Sources -->

    </asp:Content>
