<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Contacts.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Contacts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="row justify-content-center  mt-5">
        <div class="col-lg-7">
                                                             
                                <div class="text-center align-middle mb-4">
                             <iframe src="https://www.google.com/maps/d/embed?mid=1pd2yxKy1XfgzgootzzgzU2qJKYlEq-R3" frameborder="0" width=90% height="640"></iframe>
                                </div>
            </div>

        <div class="col-lg-3 py-5">
        <h2>About ITpharma</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sed voluptate nihil eum consectetur similique? Consectetur, quod, incidunt, harum nisi dolores delectus reprehenderit voluptatem perferendis dicta dolorem non blanditiis ex fugiat.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Saepe, magni, aperiam vitae illum voluptatum aut sequi impedit non velit ab ea pariatur sint quidem corporis eveniet. Odit, temporibus reprehenderit dolorum!</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Et, consequuntur, modi mollitia corporis ipsa voluptate corrupti eum ratione ex ea praesentium quibusdam? Aut, in eum facere corrupti necessitatibus perspiciatis quis?</p>
        </div>
        
    </div>

    <hr />
    <h2 class="text-center mt-3 mb-3">Our Team</h2>

    <div class="row justify-content-center align text-center mt-5">
      <div class="col-lg-3 mb-4">
        <div class="card h-100 text-center border-0">
        <center>  <div class="card-img-top " style="max-width:160px; height:160px;"> <img style='height: 100%; width: 100%; object-fit: contain; border-radius:30px' src="Resources/images/founder_H.JPG"/> </div> </center>
          <div class="card-body">
            <h4 class="card-title">Hugo Penacho</h4>
            <h6 class="card-subtitle mb-2 text-muted">Lead Programmer, DBA, Q&A Lead</h6>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus aut mollitia eum ipsum fugiat odio officiis odit.</p>
          </div>
          <div class="card-footer">
            <a href="#">hpenacho89@gmail.com</a>
          </div>
        </div>
      </div>
      <div class="col-lg-3 mb-4">
        <div class="card h-100 text-center border-0">
           <center> <div class="card-img-top" style="max-width:160px; height:160px;"> <img style='height: 100%; width: 100%; object-fit: contain; border-radius:30px' src="Resources/images/founder_F.JPG"/> </div> </center>
          <div class="card-body">
            <h4 class="card-title">Filipe Cancelinha</h4>
            <h6 class="card-subtitle mb-2 text-muted">Lead Programmer, DBA, Q&A Lead</h6>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus aut mollitia eum ipsum fugiat odio officiis odit.</p>
          </div>
          <div class="card-footer">
            <a href="#">fmcancelinha@gmail.com</a>
          </div>
        </div>
      </div>
    </div>
</asp:Content>
