<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-AdvertsClient.aspx.cs" Inherits="PROJECTOFINAL.backOffice_AdvertsClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card mb-4 border-bottom-0">
            <div class="card-header">
                <i class="far fa-eye mr-1"></i>
                        
            <button type="button" class="btn btn-warning mr-3 shadow shadow-sm" data-toggle="modal" data-target="#modal-insert-ClientCentricAd">Add Advertisement <i class="fas fa-plus"></i></button>
                             
            </div>
            
          <div class="container-xl">

                        <asp:Repeater ID="rpt_SeasonalAdvertsBackoffice" runat="server" DataSourceID="SqlSourceSeasonAds" OnItemCommand="rpt_SeasonalAdvertsBackoffice_ItemCommand" OnItemDataBound="rpt_SeasonalAdvertsBackoffice_ItemDataBound">
                                <ItemTemplate>

                                    <div class="hvrbox">
                                    <div class="card bg-dark text-white mt-4 mb-4">
                                      <img class="card-img hvrbox-layer_bottom" src="<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>" alt="Card image">
                                      <div class="hvrbox-layer_top">
                                          <div class="hvrbox-text">
                                        <h5>Ad Category: <%# Eval("Descricao") %></h5>
                                        <p> Expiration Date: <%# Eval("DataExpiracao") %></p>
                                           </div>
                                        <asp:LinkButton ID="link_updateAdvert" class="btn btn-sm" CommandName="link_updateAdvert" CommandArgument='<%# Eval("ID") %>' runat="server" CausesValidation="false"><i class="fas fa-pen " style="color: white;"></i></asp:LinkButton>
                                        <asp:LinkButton ID="link_deleteAdvert" class="btn btn-sm" CommandName="link_deleteAdvert" CommandArgument='<%# Eval("ID") %>' runat="server"><i class="fas fa-trash" style="color: white;"></i></asp:LinkButton>
                                                
                                        </div>
                                        </div>
                                        </div>
                                
                                </ItemTemplate>
                            </asp:Repeater>
       
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
    <!-- /Insert ads Modal -->

    <!-- MODAL SQLSOURCES AND REPEATER SOURCES -->    
      <asp:SqlDataSource ID="SqlSource_seasonalTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT [ID], [Descricao] FROM [Pub_Sazonal]"></asp:SqlDataSource>
     </div>

    <!-- SQLSOURCES AND REPEATER SOURCES -->  

    <asp:SqlDataSource ID="SqlSourceSeasonAds" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_listSeasonalAds" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>
