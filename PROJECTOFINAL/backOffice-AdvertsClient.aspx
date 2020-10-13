<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-AdvertsClient.aspx.cs" Inherits="PROJECTOFINAL.backOffice_AdvertsClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type = "text/css" href="Resources/stylesHoverBox.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card mb-4 border-bottom-0">

        <div class="card-header justify-content-center align-content-around p-2">

            <div class="row ">

                <div class="col-md-4 col-sm-6 text-center mb-1">
                    <button type="button" class="btn btn-info mr-3 shadow shadow-sm" data-toggle="modal" data-target="#modal-insert-ClientCentricType">Add Client-Centric Type <i class="fas fa-plus"></i></button>
                </div>

                <div class="col-md-4 col-sm-6 text-center mb-1">
                    <button type="button" class="btn btn-warning mr-3 shadow shadow-sm" data-toggle="modal" data-target="#modal-insert-ClientCentricAd">Add Advertisement <i class="fas fa-plus"></i></button>
                </div>

                <div class="col-md-3 col-sm-12 text-center mb-1">
                    <asp:DropDownList ID="ddl_filterByType" CssClass="form-control text-center align-self-center justify-content-center" runat="server" DataSourceID="SqlDataSourceClientTypes" DataTextField="Descricao" DataValueField="ID" AppendDataBoundItems="true" AutoPostBack="True" OnTextChanged="ddl_filterByType_TextChanged">
                        <asp:ListItem>Show All</asp:ListItem>
                    </asp:DropDownList>
                </div>

            </div>
        </div>





        <div class="container-fluid mt-1">
                    <div class="row no-gutters">

                        <asp:Repeater ID="rpt_ClientAdvertsBackoffice" runat="server" DataSourceID="SqlSourceClientAds" OnItemCommand="rpt_ClientAdvertsBackoffice_ItemCommand" OnItemDataBound="rpt_ClientAdvertsBackoffice_ItemDataBound">
                                <ItemTemplate>
                                    <div class="col-xl-4 col-lg-6 p-2">
                                        <div class="hvrbox">
                                            <div class="card bg-dark text-white mt-4 mb-4">
                                                <img class="card-img hvrbox-layer_bottom" src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Card image">
                                                <div class="hvrbox-layer_top">
                                                    <div class="hvrbox-text">
                                                        <h5>Ad Category: <%# Eval("Descricao") %></h5>
                                                        <p class="mt-3"><i>Start Date: <%# DateTime.Parse(Eval("DataStart").ToString()).ToString("dd-MM-yyyy") %> </i></p>
                                                        <p><i>Expiration Date: <%# DateTime.Parse(Eval("DataExpiracao").ToString()).ToString("dd-MM-yyyy") %> </i></p>
                                                    </div>                                                    
                                                    <asp:LinkButton ID="link_deleteAdvert" class="btn btn-sm" CommandName="link_deleteAdvert" CommandArgument='<%# Eval("ID") %>' runat="server"><i class="fas fa-trash" style="color: white;"></i></asp:LinkButton>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
       
                       </div>
       
              </div>

</div>

    <!-- modal insert seasonal advertisements -->

    <div class="modal fade ml-3" id="modal-insert-ClientCentricAd" tabindex="-1" role="dialog" aria-labelledby="modal-insert-ClientCentricAd" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-label">Client-Centric Advertisement Creation<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </h5>
                </div>
                <div class="modal-body">
                    <!-- BEGIN MODAL BODY CONTENT -->


                    <!-- INNER UPDATE PANEL -->


                    <!-- NAVIGATION -->
                    <!-- /NAVIGATION -->

                    <div class="tab-content" id="insert-nav-tabContent">

                        <!-- CONTENT 1 DETAILS -->
                        <div class="tab-pane fade show active" id="insert-nav-details" role="tabpanel" aria-labelledby="nav-details-tab">

                            <div class="p-4">
                                <!-- WINDOW PADDING -->

                                <!-- Name -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">                                        
                                        <asp:DropDownList ID="ddl_ClientTypes" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceClientTypes" DataTextField="Descricao" DataValueField="ID">
                                        </asp:DropDownList>
                                        
                                        
                                    </div>

                                </div>
                                <!-- /Name -->

                                <!-- image Upload -->
                                <div class="form-row">

                                    <div class="input-group col-md-6 mt-1">
                                        <div class="custom-file">
                                            <asp:FileUpload ID="fl_insertAdvertisementImage" class="custom-file-input" runat="server" />
                                            <label id="custom-file-label" class="custom-file-label" for="inputGroupFile04">Choose file</label>
                                        </div>
                                            <div class="input-group-append">
                                        </div>
                                    </div>

                                </div>
                                <!-- /Email -->
                               

                            <!-- WINDOW PADDING -->

                        </div>
                        <!-- // CONTENT 1 DETAILS -->


                        <div class="form-row mt-4">
                            <div class="col text-center">                                
                                <asp:LinkButton ID="link_insertClientAd" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertClientAd_Click"> Insert </asp:LinkButton>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        <div class="form-row mt-2">
                            <label id="lbl_errors" runat="server"></label>
                        </div>

                    </div>
                    <!-- //TAB SYSTEM ENDING -->


                    <!-- END INNER UPDATE PANEL -->


                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>
        </div>
    <!-- /Insert ads Modal -->
        

     <!-- Insert Client-Centric TYPES -->

    <div class="modal fade ml-3" id="modal-insert-ClientCentricType" tabindex="-1" role="dialog" aria-labelledby="modal-insert-ClientCentricType" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-label2">Client Advertisement Creation<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </h5>
                </div>
                <div class="modal-body">
                    <!-- BEGIN MODAL BODY CONTENT -->


                    <!-- INNER UPDATE PANEL -->


                    <!-- NAVIGATION -->
                    <!-- /NAVIGATION -->

                    <div class="tab-content" id="insert-nav-tabContent2">

                        <!-- CONTENT 1 DETAILS -->
                        <div class="tab-pane fade show active" id="insert-nav-details2" role="tabpanel" aria-labelledby="nav-details-tab">

                            <div class="p-4">
                                <!-- WINDOW PADDING -->

                                <!-- Name -->
                                <div class="form-row">

                                    <div class="form-group col-md-12">                                        
                                        
                                        <input type="text" id="tb_typeName" runat="server" class="form-control" placeholder="Client-Centric Type Name" required/>
                                        
                                    </div>

                                </div>
                                <!-- /Name -->

                                <!-- date Selection -->
                                <div class="form-group">
                                <div class="form-row">
                                    
                                    <div class="input-group col-md-6 mt-1">
                                        <div class="col-md-12">
                                        <label for="dateStart "> Date Start </label></div>
                                        <input type="date" id="dateStart" runat="server" class="form-control" value="2020-01-01" required/>

                                            <div class="input-group-append">
                                        </div>
                                    </div>

                                    <div class="input-group col-md-6 mt-1">
                                        <div class="col-md-12">
                                        <label for="dateExpire"> Date Expire </label> </div>
                                        <input type="date" id="dateExpire" runat="server" class="form-control" value="2020-12-31" required/>

                                            <div class="input-group-append">
                                        </div>
                                    </div>
                                    </div>
                                </div>
                                
                               

                            <!-- WINDOW PADDING -->

                        </div>
                        <!-- // CONTENT 1 DETAILS -->


                        <div class="form-row mt-4">
                            <div class="col text-center">                                
                                <asp:LinkButton ID="link_insertClientCentricType" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertClientCentricType_Click"> Insert </asp:LinkButton>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        <div class="form-row mt-2">
                            <label id="lbl_errors2" runat="server" class="text-danger text-center"></label>
                        </div>

                    </div>
                    <!-- //TAB SYSTEM ENDING -->


                    <!-- END INNER UPDATE PANEL -->


                </div>
                <!-- END MODAL BODY CONTENT -->
            </div>
        </div>
    </div>
      
     </div>

    <!-- END of insert Client-Centric Types -->



    <!-- SQLSOURCES AND REPEATER SOURCES -->  
    <asp:SqlDataSource ID="SqlDataSourceClientTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT [Descricao], [ID] FROM [Pub_Cliente]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlSourceClientAds" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT Publicidade.ID, Publicidade.imagem, publicidade.ID_Pub_Cliente, Pub_Cliente.Descricao, Pub_Cliente.DataStart, Pub_Cliente.DataExpiracao from Publicidade inner join Pub_Cliente on Publicidade.ID_Pub_Cliente = Pub_Cliente.ID where Publicidade.Tipo = 0"></asp:SqlDataSource>
    </asp:Content>
