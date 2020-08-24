<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backoffice-encomendas.aspx.cs" Inherits="PROJECTOFINAL.backoffice_encomendas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    



      
        

        <div class="container-fluid mt-5 d-flex align-items-center">

       <div class="col-lg-10">

         <div class="col-lg-12 mt-5 mb-4 d-flex d-flex justify-content-end">

            <button type="button" class="btn btn-dark mr-3 shadow shadow-sm"><i class="fas fa-caret-square-left"></i></button>
        
        </div>


        <h1>Orders</h1>
        <ol class="breadcrumb bg-dark text-white mb-4 shadow shadow-sm">
            <a class="breadcrumb-item text-white" href="backOffice-Index.aspx">Dashboard</a>
            <li class="breadcrumb-item active">Orders</li>
        </ol>

        <div class="card mb-4 shadow shadow-sm">
            <div class="card-header text-center bg-dark text-white">
                <i class="fas fa-table mr-1"></i>
                Current Orders
            </div>
            <div class="card-body">
                <div class="table-responsive">

                    <table class="table table-striped table-hover" id="dataTable" width="100%" cellspacing="0">

                        <thead>
                            <!-- HEADER OF THE TABLE -->
                            <tr class="text-muted text-center">
                                <th>#</th>
                                <th>Created</th>
                                <th>Customer</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Updated</th>
                            </tr>
                        </thead>

                        <tbody class="text-center text-md-center">

                            <!-- ORDERS -->
                              <tr class="text-center">
                                <td>#</td>
                                <td>Created</td>
                                <td>Customer</td>
                                <td>Total</td>
                                <td>Status</td>
                                <td>Updated</td>
                            </tr>

                            <!-- //ORDERS -->

                        </tbody>
                    </table>


                </div>
            </div>
        </div>
    </div>


          <div class="col-lg-2 bg-dark d-flex" style="min-height:100%;">

              MINI ESTATÍSTICA

          </div>




        </div>









</asp:Content>
