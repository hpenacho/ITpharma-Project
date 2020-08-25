<%@ Page Title="" Language="C#" MasterPageFile="~/backOfficeMasterPage.Master" AutoEventWireup="true" CodeBehind="backOffice-AdvertsClient.aspx.cs" Inherits="PROJECTOFINAL.backOffice_AdvertsClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card mb-4">
            <div class="card-header">
                <i class="far fa-eye mr-1"></i>
                <button type="button" class="btn btn-dark mr-3 shadow shadow-sm" > Filter Seasonal Ads <i class="fas fa-plus"></i></button>
            <button type="button" class="btn btn-dark mr-3 shadow shadow-sm" > Filter Client-Centric Ads <i class="fas fa-plus"></i></button>
            <button type="button" class="btn btn-warning mr-3 shadow shadow-sm" data-toggle="modal" data-target="#modal-insert-product">Add Product <i class="fas fa-plus"></i></button>
            </div>
            
          <div class="container-xl ">
        <div class="card bg-dark text-white mt-3 mb-3">
          <img class="card-img" src="placeholderAD.png" alt="Card image">
          <div class="card-img-overlay">
            <h5 class="card-title">Ad name</h5>
            <p class="card-text">This is a wider card with supporting text</p>
          </div>
        </div>

              <div class="card bg-dark text-white mt-3 mb-3">
          <img class="card-img" src="placeholderAD.png" alt="Card image">
          <div class="card-img-overlay">
            <h5 class="card-title">Card title</h5>
            <p class="card-text"></p>
            <p class="card-text">Last updated 3 mins ago</p>
          </div>
        </div>

              <div class="card bg-dark text-white mt-3 mb-3">
          <img class="card-img" src="placeholderAD.png" alt="Card image">
          <div class="card-img-overlay">
            <h5 class="card-title">Card title</h5>
            <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>           
          </div>
        </div>

              <div class="card bg-dark text-white mt-3 mb-3">
          <img class="card-img" src="placeholderAD.png" alt="Card image">
          <div class="card-img-overlay">
            <h5 class="card-title">Card title</h5>
            <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            <p class="card-text">Last updated 3 mins ago</p>
          </div>
        </div>
              </div>
        
</div>

</asp:Content>
