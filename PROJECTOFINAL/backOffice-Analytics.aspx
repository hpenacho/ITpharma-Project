<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-Analytics.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Analytics" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
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
        
          <div>
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
                        <div class="card card-footer text-center font-italic">
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
                        <div class="card card-footer text-center font-italic">
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
                        <div class="card card-footer text-center font-italic">
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
                        <div class="card card-footer text-center font-italic">
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
                        <div class="card card-footer text-center font-italic">                            
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
                        <div class="card card-footer text-center font-italic">
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
                                <div class="card mb-4 " style="padding-bottom: 0.72em;">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area mr-1"></i>
                                        Charts: Order Information
                                    </div>
                                    <div class="card-body">

                                        <div class="row justify-content-around">
                                        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" ImageType="Jpeg">
                                            <Series>
                                                <asp:Series Name="Series1" ChartType="Pie" XValueMember="gender" YValueMembers="Qty Orders" YValuesPerPoint="6"></asp:Series>
                                            </Series>
                                            <ChartAreas>
                                                <asp:ChartArea Name="ChartArea1">
                                                    <Area3DStyle IsRightAngleAxes="False" Perspective="45" />
                                                </asp:ChartArea>
                                            </ChartAreas>
                                            <BorderSkin BackColor="Transparent" BackImageWrapMode="TileFlipX" />
                                        </asp:Chart>

                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="select count(EncomendaHistorico.ENC_REF) as 'Qty Orders' , case when cliente.sexo = 'M' then 'Male' when cliente.sexo = 'F' then 'Female' else 'Other' end as 'Gender' from Cliente inner join EncomendaHistorico on Cliente.ID = EncomendaHistorico.ID_Cliente group by cliente.sexo"></asp:SqlDataSource>
                                        <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource2">
                                            <Series>
                                                <asp:Series BackGradientStyle="TopBottom" BorderDashStyle="NotSet" Color="Silver" Name="Series1" Palette="BrightPastel" XValueMember="Order Status" YValueMembers="Qty Orders">
                                                </asp:Series>
                                            </Series>
                                            <ChartAreas>
                                                <asp:ChartArea BackColor="Transparent" Name="ChartArea1">
                                                    <AxisY>
                                                        <MajorGrid Enabled="False" />
                                                    </AxisY>
                                                    <AxisX>
                                                        <MajorGrid Enabled="False" />
                                                    </AxisX>
                                                    <AxisX2>
                                                        <MajorGrid Enabled="False" />
                                                    </AxisX2>
                                                </asp:ChartArea>
                                            </ChartAreas>
                                        </asp:Chart>
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="select count(encomendaHistorico.ID_Estado) as 'Qty Orders' ,estado.Descricao as 'Order Status'
                                        from EncomendaHistorico inner join estado on EncomendaHistorico.ID_Estado = estado.ID
                                        group by estado.Descricao"></asp:SqlDataSource>
                                            </div>
                                    </div>
                                </div>
                            </div>
                            
                         <div class="col-xl-6">

                             <ul class="nav nav-tabs" id="myTab" role="tablist">
                                 <li class="nav-item">
                                     <a class="nav-link active" id="TopBuyers-tab" data-toggle="tab" href="#TopBuyers" role="tab" aria-controls="TopBuyers" aria-selected="true"><i class="fas fa-table mr-1"></i> Top-Buyers</a>
                                 </li>
                                 <li class="nav-item">
                                     <a class="nav-link" id="ATMlocalSales-tab" data-toggle="tab" href="#ATMlocalSales" role="tab" aria-controls="ATMlocalSales" aria-selected="false"><i class="fas fa-cash-register"></i> ATM - Local Sales</a>
                                 </li>
                                 <li class="nav-item">
                                     <a class="nav-link" id="ATMonlineSales-tab" data-toggle="tab" href="#ATMonlineSales" role="tab" aria-controls="ATMonlineSales" aria-selected="false"><i class="fas fa-globe"></i> ATM - Online Sales</a>
                                 </li>
                             </ul>
                             <div class="tab-content" id="myTabContent">
                                 <!-- Start of TopBuyers TabPane below -->
                                 <div class="tab-pane fade show active" id="TopBuyers" role="tabpanel" aria-labelledby="TopBuyers-tab">

                                     <div class="card mb-4">
            
            <div class="card-body" style="height: 358px">
                
                <div class="table-responsive">

                    <table class="table table-striped table-hover" width="100%" cellspacing="0">

                        <thead class="text-center text-md-center">
                            <!-- HEADER OF THE TABLE -->
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Age</th>
                                <th>Orders</th>
                            </tr>
                        </thead>

                        <tbody class="text-center text-md-center">
                         
                                <asp:Repeater ID="rpt_topBuyers" runat="server" DataSourceID="SqlSourceTopBuyers">
                                <ItemTemplate>

                                    <tr class="text-center">
                                        <td class="align-middle">                                          
                                            <asp:Label ID="lbl_ID" runat="server" Text=<%# Eval("ID") %>></asp:Label>                                            
                                        </td>

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_name" runat="server" Text=<%# Eval("nome") %>></asp:Label>
                                        </td>

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_age" runat="server" Text=<%# Eval("Age").ToString() != "" ? Eval("Age") : "Unknown" %>></asp:Label>
                                        </td>

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_orders" runat="server" Text=<%# Eval("Orders") %>></asp:Label>
                                        </td>
                                    </tr>

                                </ItemTemplate>

                            </asp:Repeater>
                                                  
                                <asp:SqlDataSource ID="SqlSourceTopBuyers" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="Select top 5 Cliente.id, Cliente.nome, DATEDIFF(year,Cliente.datanascimento,GETDATE()) - iif(datepart(dayofyear,datanascimento) &gt;datepart (dayofyear , getdate()),1,0) as 'Age', count(EncomendaHistorico.Enc_ref) as 'Orders'
                                 From Cliente inner join EncomendaHistorico on Cliente.id = EncomendaHistorico.id_cliente
                                    where Cliente.nome NOT like 'ATM -%'
                                    group by Cliente.id, Cliente.nome, datanascimento
                                    Order by 'Orders' DESC"> </asp:SqlDataSource>
                                       
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

                                 </div> <!-- End of TopBuyers TabPane -->


                                 <!-- Start of ATMlocalSales tabPane below -->
                                 <div class="tab-pane fade" id="ATMlocalSales" role="tabpanel" aria-labelledby="ATMlocalSales-tab">

                                     <div class="card mb-4">
           
            <div class="card-body" style="height: 358px">
                
                <div class="table-responsive">

                    <table class="table table-striped table-hover" width="100%" cellspacing="0">

                        <thead class="text-center text-md-center">
                            <!-- HEADER OF THE TABLE -->
                            <tr>
                                <th>Pickup ID</th>
                                <th>Designation</th>
                                <th>Local Orders</th>
                            </tr>
                        </thead>

                        <tbody class="text-center text-md-center">
                         
                                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlSourceATMstats">
                                <ItemTemplate>

                                    <tr class="text-center">

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_idPickupLoc" runat="server" Text=<%# Eval("Pickup ID") %>></asp:Label>
                                        </td>

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_name" runat="server" Text=<%# Eval("Designation") %>></asp:Label>
                                        </td>

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_orders" runat="server" Text=<%# Eval("Orders") %>></asp:Label>
                                        </td>
                                    </tr>

                                </ItemTemplate>

                            </asp:Repeater>
                                                  
                                <asp:SqlDataSource ID="SqlSourceATMstats" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="Select EncomendaHistorico.ID_Pickup as 'Pickup ID', Cliente.nome as 'Designation', count(EncomendaHistorico.Enc_ref) as 'Orders'
                                 From Cliente inner join EncomendaHistorico on Cliente.id = EncomendaHistorico.id_cliente
                                    where Cliente.nome like 'ATM -%'
                                    group by Cliente.id, Cliente.nome, datanascimento, ID_Pickup "> </asp:SqlDataSource>
                                       
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

                                 </div>
                                 <!-- End of atm LOCAL sales stats -->

                                 <!-- Start of atm ONLINE sales stats below -->

                                 <div class="tab-pane fade" id="ATMonlineSales" role="tabpanel" aria-labelledby="ATMonlineSales-tab">

                                     <div class="card mb-4">
           
            <div class="card-body" style="height: 358px">
                
                <div class="table-responsive">

                    <table class="table table-striped table-hover" width="100%" cellspacing="0">

                        <thead class="text-center text-md-center">
                            <!-- HEADER OF THE TABLE -->
                            <tr>
                                <th>Pickup ID</th>
                                <th>Designation</th>
                                <th>Online Orders</th>
                            </tr>
                        </thead>

                        <tbody class="text-center text-md-center">
                         
                                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlSourceATMonlineStats">
                                <ItemTemplate>

                                    <tr class="text-center">

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_PickupIDonl" runat="server" Text=<%# Eval("Pickup ID") %>></asp:Label>
                                        </td>

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_name" runat="server" Text=<%# Eval("Designation") %>></asp:Label>
                                        </td>

                                        <td class="align-middle">
                                            <asp:Label ID="lbl_orders" runat="server" Text=<%# Eval("OnlineOrders") %>></asp:Label>
                                        </td>
                                    </tr>

                                </ItemTemplate>

                            </asp:Repeater>
                                                  
                                <asp:SqlDataSource ID="SqlSourceATMonlineStats" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="Select EncomendaHistorico.ID_Pickup as 'Pickup ID',Pickup.Descricao as 'Designation', count(EncomendaHistorico.Enc_ref) as 'OnlineOrders'
                                From Cliente inner join EncomendaHistorico on Cliente.id = EncomendaHistorico.id_cliente
                                inner join Pickup on EncomendaHistorico.ID_Pickup = Pickup.ID
                                where MoradaEntrega like 'ATM -%'
                                group by EncomendaHistorico.ID_Pickup, Pickup.Descricao
                                order by EncomendaHistorico.ID_Pickup"> </asp:SqlDataSource>
                                       
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

                                 </div>


                                 <!-- End of atm ONLINE sales -->
                                <!-- nav tab ends on div below -->
                             </div>

                             

                             
                             
                             </div>

                        </div>

    <!-- charts END here-->
        
            <div class="row d-flex justify-content-around">
                

                    <div class="col-xl-4 col-lg-12 mb-3">

                        <div class="card border-danger">
                            <div class="card-header bg-danger text-white font-weight-bold font-italic"><i class="fas fa-fire-alt"></i> Most Popular Product</div>
                            <div class="card-body">
                                <div class="row justify-content-around align-items-center">
                                    <div class="card-image" style="max-width:60px; height:60px;"> <img style='height: 100%; width: 100%; object-fit: contain; overflow:hidden' runat="server" id="img_popProd" src="#"/> </div>
                                    <span class="card-text">Ref: <asp:Label ID="lbl_PopProdRef" runat="server" Text="[PopProdRef]"></asp:Label> </span>
                                    <span class="card-text">Name: <asp:Label ID="lbl_PopProdName" runat="server" Text="[PopProdName]"></asp:Label> </span>
                                    
                                    </div>
                            </div>
                        </div>

                    </div>

                    <div class="col-xl-5 col-lg-12 mb-3">

                        <div class="card border-warning">
                            <div class="card-header bg-warning text-white font-weight-bold font-italic"><i class="fas fa-star"></i> Bestseller</div>
                            <div class="card-body">
                         <div class="row justify-content-around align-items-center">
                             <div class="card-image" style="max-width:60px; height:60px;"> <img style='height: 100%; width: 100%; object-fit: contain; overflow:hidden' runat="server" id="img_bsProd" src="#"/> </div>
                                <span class="card-text">Ref: <asp:Label ID="lbl_bsRef" runat="server" Text="[bsRef]"></asp:Label> </span>
                                    <span class="card-text">Name: <asp:Label ID="lbl_bsName" runat="server" Text="[bsName]"></asp:Label> </span>
                                      <span class="card-text">Sold: <asp:Label ID="lbl_bsQty" runat="server" Text="[bsQty]"></asp:Label> </span>                                    
                                    </div>

                            </div>
                        </div>

                    </div>

                    <div class="col-xl-3 col-lg-12 mb-1">

                        <div class="card border-success">
                            <div class="card-header text-white bg-success font-weight-bold font-italic"><i class="fas fa-user-check"></i> Newest Shopper</div>
                            <div class="card-body">
                                <div class="row justify-content-around align-items-center">
                                 <div class="card-image" style="max-width:60px; height:60px;"> <img style='height: 80%; width: 80%; object-fit: contain; overflow:hidden' src="#" runat="server" id="userGenderSymbol"/> </div>
                                <span class="card-text"><asp:Label ID="lbl_newShopperName" runat="server" Text="[shopper Name]"></asp:Label></span>
                                <span class="card-text">Age: <asp:Label ID="lbl_newShopperAge" runat="server" Text="[shopper Age]"></asp:Label></span>
                                    </div>
                            </div>
                        </div>

                    </div>


                </div>


            


        </div>

        

     <!-- end of main container -->

    <!-- SQL Sources -->

    </asp:Content>
