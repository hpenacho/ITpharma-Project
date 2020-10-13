<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-AdvertsSeasonal.aspx.cs" Inherits="PROJECTOFINAL.backOffice_AdvertsSeasonal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type = "text/css" href="Resources/stylesHoverBox.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="card mb-4 border-bottom-0">
            <div class="card-header justify-content-center align-content-around p-2">
              
                <div class="row ">  
                    
                        <div class="col-md-4 col-sm-6 text-center mb-1">
                            <button type="button" class="btn btn-info shadow shadow-sm" data-toggle="modal" data-target="#modal-insert-SeasonalType">Add Seasonal Type <i class="fas fa-plus"></i></button>
                        </div>
                         
                        <div class="col-md-4 col-sm-6 text-center mb-1">
                            <button type="button" class="btn btn-warning shadow shadow-sm" data-toggle="modal" data-target="#modal-insert-SeasonalAd">Add Advertisement <i class="fas fa-plus"></i></button>
                        </div>
                    
                        <div class="col-md-3 col-sm-12 text-center mb-1">
                            <asp:DropDownList ID="ddl_filterByType" CssClass="form-control text-center align-self-center justify-content-center" runat="server" DataSourceID="SqlSource_seasonalTypes" DataTextField="Descricao" DataValueField="ID" AppendDataBoundItems="true" AutoPostBack="True" OnTextChanged="ddl_filterByType_TextChanged">
                                <asp:ListItem>Show All</asp:ListItem>
                            </asp:DropDownList>  
                        </div> 
                                                    
                </div>
            </div>
            
          <div class="container-fluid mt-1">
                    <div class="row no-gutters">
                        <asp:Repeater ID="rpt_SeasonalAdvertsBackoffice" runat="server" DataSourceID="SqlSourceSeasonAds" OnItemCommand="rpt_SeasonalAdvertsBackoffice_ItemCommand" OnItemDataBound="rpt_SeasonalAdvertsBackoffice_ItemDataBound">
                                <ItemTemplate>

                               <div class="col-xl-4 col-lg-6 p-2">

                                            <div class="hvrbox">
                                                <div class="card bg-dark text-white">
                                                    <img class="card-img hvrbox-layer_bottom" src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Card image">
                                                    <div class="hvrbox-layer_top">
                                                        <div class="hvrbox-text">
                                                            <h5><b>Ad Category: <%# Eval("Descricao") %></b></h5>
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

    <div class="modal fade ml-3" id="modal-insert-SeasonalAd" tabindex="-1" role="dialog" aria-labelledby="modal-insert-SeasonalAd" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-label">Seasonal Advertisement Creation<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
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
                                        <asp:DropDownList ID="ddl_SeasonalTypes" CssClass="form-control" runat="server" DataSourceID="SqlSource_seasonalTypes" DataTextField="Descricao" DataValueField="ID">
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
                                <asp:LinkButton ID="link_insertSeasonalAd" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertSeasonlAd_Click"> Insert </asp:LinkButton>
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
    <!-- /Insert advertisements Modal -->

    <!-- Insert Seasonal TYPES -->

    <div class="modal fade ml-3" id="modal-insert-SeasonalType" tabindex="-1" role="dialog" aria-labelledby="modal-insert-SeasonalType" aria-hidden="true">
        <div class="modal-dialog modal-lg shadow-lg" role="document">
            <div class="modal-content">
                <div class="modal-header py-3 modal-title bg-dark rounded-top text-light">
                    <h5 class=" modal-title col-12 text-center" id="modal-insert-label2">Seasonal Advertisement Creation<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
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
                                        
                                        <input type="text" id="tb_typeName" runat="server" class="form-control" placeholder="Seasonal Type Name" required/>
                                        
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
                                <asp:LinkButton ID="link_insertSeasonalType" class="btn btn-primary btn-dark w-25 mr-1" runat="server" OnClick="link_insertSeasonalType_Click"> Insert </asp:LinkButton>
                                <!-- INSERTION DRIVE -->
                                <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>

                        <div class="form-row mt-2">
                            <label id="lbl_errors2" class="text-danger text-center" runat="server"></label>
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

    <!-- END of insert Seasonal Types -->

    <!-- SQLSOURCES AND REPEATER SOURCES -->  
    <asp:SqlDataSource ID="SqlSource_seasonalTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT [ID], [Descricao] FROM [Pub_Sazonal]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlSourceSeasonAds" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT Publicidade.ID, Publicidade.imagem, publicidade.ID_Pub_Sazonal, Pub_Sazonal.Descricao,Pub_Sazonal.DataStart, Pub_Sazonal.DataExpiracao from Publicidade inner join Pub_Sazonal on Publicidade.ID_Pub_Sazonal = Pub_Sazonal.id where Publicidade.Tipo = 1"></asp:SqlDataSource>

</asp:Content>
