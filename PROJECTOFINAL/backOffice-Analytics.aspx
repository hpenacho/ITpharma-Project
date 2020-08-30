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
.card-box:hover .icon i {
    font-size: 100px !important;
    transition: 1s !important;
    -webkit-transition: 1s !important;
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
    top: auto;
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
                        <h3><asp:Label ID="lbl_totalOrders" runat="server" Text="totalOrders#"></asp:Label></h3>
                        <p> Total Orders </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-shopping-cart" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseOrders" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseOrders">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseOrders">
                        <div class="card card-footer">
                            <p> Orders this month: <asp:Label ID="lbl_ordersMonth" runat="server" Text="ordersMonth#"></asp:Label></p>
                            <p> Orders today: <asp:Label ID="lbl_ordersDay" runat="server" Text="ordersDay#"></asp:Label></p>                            
                          </div>
                        </div>   
                <!-- -->
                </div>
            </div>

            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-green">
                    <div class="inner">
                        <h3> €<asp:Label ID="lbl_totalProfit" runat="server" Text="money"></asp:Label> </h3>
                        <p> Total Profit </p>
                    </div>
                    <div class="icon">
                        <i class="far fa-money-bill-alt" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseProfit" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseProfit">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseProfit">
                        <div class="card card-footer">
                            <p> Profit this month: €<asp:Label ID="lbl_profitMonth" runat="server" Text="money"></asp:Label></p>
                            <p> Profit today: €<asp:Label ID="lbl_profitDay" runat="server" Text="money"></asp:Label></p>                            
                          </div>
                        </div>  
                </div>
            </div>
            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-orange">
                    <div class="inner">
                        <h3><asp:Label ID="lbl_totalProds" runat="server" Text="totalProds#"></asp:Label> </h3>
                        <p> Total Unique Products </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-box-open" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseProducts" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseProducts">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseProducts">
                        <div class="card card-footer">
                            <p> Active: <asp:Label ID="lbl_prodsActive" runat="server" Text="activeProds#"></asp:Label></p>
                            <p> Inactive: <asp:Label ID="lbl_prodsInactive" runat="server" Text="inactiveProds#"></asp:Label></p>
                            <p> Archived: <asp:Label ID="lbl_archived" runat="server" Text="archivedProds#"></asp:Label></p>
                          </div>
                        </div>  
                </div>
            </div>
            <!-- -->
            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-info">
                    <div class="inner">
                        <h3> <asp:Label ID="lbl_itemQty" runat="server" Text="totalItems#"></asp:Label> </h3>
                        <p> Total Item Qty </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-boxes" aria-hidden="true"></i>
                    </div>
                    <a href="#collapseQty" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseQty">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseQty">
                        <div class="card card-footer">
                            <p> Warehouse: <asp:Label ID="lbl_warehouseItemQty" runat="server" Text="warehouseItems#"></asp:Label></p>
                            <p> Pickups: <asp:Label ID="lbl_pickupQty" runat="server" Text="atmItems#"></asp:Label></p>                            
                          </div>
                        </div>   
                <!-- -->
                </div>
            </div>
            <!-- -->
            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-red">
                    <div class="inner">
                        <h3> <asp:Label ID="lbl_totalShoppers" runat="server" Text="totalShoppers#"></asp:Label> </h3>
                        <p> Total Shoppers </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-users"></i>
                    </div>
                    <a href="#collapseShoppers" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseShoppers">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseShoppers">
                        <div class="card card-footer">                            
                            <p> Active: <asp:Label ID="lbl_activeShoppers" runat="server" Text="activeShoppers#"></asp:Label></p>
                            <p> Inactive: <asp:Label ID="lbl_inactiveShoppers" runat="server" Text="inactiveShoppers#"></asp:Label></p>
                            <p> New Users today: <asp:Label ID="lbl_newShoppers" runat="server" Text="newShoppers#"></asp:Label></p>
                          </div>
                        </div>  
                </div>
            </div>

            <div class="col-lg-2 col-sm-6">
                <div class="card-box rounded bg-secondary">
                    <div class="inner">
                        <h3> <asp:Label ID="lbl_totalExams" runat="server" Text="totalExams#"></asp:Label> </h3>
                        <p> Total Exams Outsourced </p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-notes-medical"></i>
                    </div>
                    <a href="#collapseExams" class="card-box-footer" data-toggle="collapse" aria-expanded="false" aria-controls="collapseExams">View More <i class="fa fa-arrow-circle-right"></i></a>
                     <div class="collapse" id="collapseExams">
                        <div class="card card-footer">
                            <p> Exams this month: <asp:Label ID="lbl_examsMonth" runat="server" Text="examsMonth#"></asp:Label></p>
                            <p> Exams today: <asp:Label ID="lbl_examsDay" runat="server" Text="examsDay#"></asp:Label></p>                            
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

                                
        


        </div> <!-- end of main container -->

    <!-- SQL Sources -->

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    </asp:Content>
