<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Checkout.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        .container {
        max-width: 960px;
                   }

        .lh-condensed { line-height: 1.25; }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- -->

    <div class="container mt-3">
  <div class="py-5 text-center">
    <img class="d-block mx-auto mb-2" src="../Resources/images/PHARMALOGO.png" alt="" width="85" height="85">
    <h2>Checkout Page</h2>
    <p class="lead"> Please fill out the details requested below to conclude your purchase!</p>
  </div>

  <div class="row">
    <div class="col-md-4 order-md-2 mb-4">
      <h4 class="d-flex justify-content-between align-items-center mb-3">
        <span class="text-muted">Cart</span>
        <span class="badge badge-secondary badge-pill"> <span id="lbl_totQty" runat="server"></span> </span>
      </h4>
      <ul class="list-group mb-3">


       <asp:Repeater ID="rpt_compactCart" runat="server" DataSourceID="SqlSmallCartDetails" OnItemDataBound="rpt_compactCart_ItemDataBound">

           <ItemTemplate>

        <li class="list-group-item d-flex justify-content-between lh-condensed">
          <div>
            <h6 class="my-0"> <span id="lbl_title" runat="server">  <%# Eval("ProdName") %> </span></h6>
            <small class="text-muted" style="display: block; width: 170px;">
 
                
            <span id="itemPrice" runat="server"> <%# Eval("Unit Price") %> </span> € per Unit
                <br>
            <span id="lbl_itemQty" runat="server"> <%# Eval("Qty") %> </span> unit(s)
        </small>
              
          </div>
            <div class=" d-flex align-items-center">
          <b><span class="text-success"> <span id="itemTotalPrice" runat="server"> <%# Eval("itemTotalPrice") %> </span> € </b>       
              </div>
                        
        </li>
            
           </ItemTemplate>

       </asp:Repeater>
          


          <asp:SqlDataSource ID="SqlSmallCartDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnUserCartItems" SelectCommandType="StoredProcedure">
              <SelectParameters>
                  <asp:Parameter Name="id_cliente" Type="Int32" />
                  <asp:CookieParameter CookieName="noLogID" Name="cookies" Type="String" />
              </SelectParameters>
          </asp:SqlDataSource>
          


        <li class="list-group-item bg-light">   
            <div class="row justify-content-around">
            <p class="text-muted"><b>Sub-Total: </b><label class="form-label" id="lbl_SubTotal" runat="server"> [subTotal]</label> </p>
             <p class="text-muted"><b>Tax(6%): </b><label class="form-label" id="lbl_Tax" runat="server"> [tax]</label> </p>
                </div>
            <div class="row justify-content-center">
            <b>Total: <label class="col-form-label text-primary" id="lbl_finalTotal" runat="server"> [total]</label> € </b>
                </div>
        </li>
      </ul>
    

    </div>
    <div class="col-md-8 order-md-1">
      <h4 class="mb-3">Billing Information</h4>
      <div class="needs-validation" novalidate>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="firstName">Receiver's Name</label>
            <input type="text" class="form-control" id="firstName" runat="server" placeholder="First Name" pattern="^[a-zA-Z_\-]+$" title="Only letters without spaces allowed." value="" required>

          </div>
          <div class="col-md-6 mb-3">
            <label for="lastName">Last Name</label>
            <input type="text" class="form-control" id="lastName" runat="server" pattern="^[a-zA-Z_\-]+$" title="Only letters without spaces allowed." placeholder="Last Name" value="" required>

          </div>
        </div>

        <div class="mb-3">
          <label for="userName">Client</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"> <i class="fas fa-user"></i> </span>
            </div>            
              <asp:TextBox ID="userName" class="form-control" runat="server" required="true" ReadOnly="True"></asp:TextBox>
            
          </div>
        </div>

        <div class="mb-3">
          <label for="email">Email <span class="text-muted"></span></label>
            <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"> <i class="fas fa-envelope"></i> </span>
            </div>    
            <asp:TextBox ID="email" class="form-control" runat="server" placeholder="you@example.com"  ReadOnly="True"></asp:TextBox>
          
        </div>
         

            <input id="inpHide" type="hidden" runat="server" value="ClientAddress" /> <!-- holds type of order, pickup or home address -->           
            
            <ul class="nav nav-tabs justify-content-center mt-5" role="tablist">
                
                <li class="nav-item"><a data-toggle="tab" class="btn btn-light nav-link active" onclick="selectedAddress()" href="#tabAddress">Address</a></li>
                <li class="nav-item"><a data-toggle="tab" class="btn btn-light" onclick="selectedPickup()" href="#tabPickup">ATM Pickup</a></li>
                                
            </ul>




            <div class="tab-content">
                <div id="tabAddress" class="tab-pane in active">
                            <div class="form-group row mt-2 mb-2">
            <div class="col-md-9">
          <label for="address">Address</label>
            <input type="text" class="form-control" id="address" name="address" runat="server" placeholder="Address" required>
                </div>
            
                <div class="col-md-3 mb-2">
            <label for="zip">Zip-Code</label>
            <input type="text" name="zip" class="form-control text-center" id="zip" runat="server" placeholder="Zip-Code" pattern="^[0-9\-]*$" title="Only numbers allowed." required>        
            </div>
        </div>
                    
                    <div class="row justify-content-center">
          <div class="col-md-5 mb-3">
            <label for="LocationZone">Location</label>
            <select class="custom-select d-block w-100" id="LocationZone" required>
              <option selected">Portugal Continental</option>
                <option>Açores</option>
                <option>Madeira</option>
            </select>
          </div>
                      
        </div>

                </div>

                <div id="tabPickup" class="tab-pane fade">                   
                    <p class="text-muted mt-2 text-center">Please choose your prefered pickup point</p>
                    <div class="row justify-content-center"> 
                    <div class="col-md-4 mb-3">                        
          <asp:DropDownList ID="ddl_pickUp" CssClass="btn btn-light dropdown-toggle" runat="server" DataSourceID="SqlSourcePickups" DataTextField="Descricao" DataValueField="ID"></asp:DropDownList>
              <asp:SqlDataSource ID="SqlSourcePickups" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="SELECT [ID], [Descricao] FROM [Pickup]"></asp:SqlDataSource>
                     </div>
                        </div>
                    <div class="row justify-content-center"> 
                          <p class="bg-light rounded pl-1 pr-1 font-italic"> You must conclude this order at the chosen pickup by: <label class="col-form-label text-success" id="lbl_expiryPickup" runat="server"> [date]</label> </p>  
                            </div>
                        <p class="text-muted text-center"> Expired Orders will be canceled and reverted.</p>
                        </div>
                </div>
            </div> 
                
        <hr class="mb-4">

        <h4 class="mb-3 text-center">Payment Details</h4>
                 
          <div class=" form-group row mt-2 mb-3">
                    <div class="col-sm-12 text-center">
                      <div class="btn-group btn-group-toggle" data-toggle="buttons">
                        
                          <label class="btn btn-light active">
                            <input type="radio" name="radioPaymentCard" id="CreditCard" autocomplete="off" runat="server" checked > <h6> <i class="far fa-credit-card text-success"></i>  Credit Card </h6>
                          </label>
                                                      
                          <label class="btn btn-light">
                            <input type="radio" name="radioPaymentCard" id="DebitCard" autocomplete="off" runat="server"> <h6> <i class="fas fa-credit-card text-primary"></i>  Debit Card </h6>
                          </label>
                                                                                    
                        </div>
                        </div>
          </div>
                      
              
        <div class="row">
          <div class="col-md-6 mb-3">
            <input type="text" class="form-control" id="ccName" runat="server" placeholder="Name on Card" required>
            <small class="text-muted"> Your name as written on your card.</small>

          </div>
          <div class="col-md-6 mb-3">
            <input type="text" class="form-control" id="ccNumber" runat="server" placeholder="Card Number" pattern="^[0-9]*$" title="Only numbers allowed." required>

          </div>
        </div>
        <div class="row">
          <div class="col-md-4 mb-3">
            <label for="ccExpiration">Expiration Date</label>
              <input type="date" class="form-control form-control-user bg-light" runat="server" id="ccExpiration" value="2021-01-01">

          </div>
          <div class="col-md-3 mb-3">
            <label for="cc_Cvv">CVV</label>
            <input type="text" class="form-control" id="cc_Cvv" runat="server" placeholder="CVV" pattern="[0-9]{3}" title="CVV is composed of 3 digits" required>

          </div>
        </div>
        <hr class="mb-4">   
          <asp:Button ID="btn_finalizePurchase" class="btn btn-primary btn-lg btn-block mb-5"  runat="server" Text="Purchase" OnClick="btn_finalizePurchase_Click"/>
      </div>
        
            
    </div>
  </div>
        
  
</div>
    
    <script>
        function selectedAddress() {
            var hiddenControl = '<%= inpHide.ClientID %>';
            document.getElementById(hiddenControl).value = "ClientAddress";
        }

        function selectedPickup() {
            var hiddenControl = '<%= inpHide.ClientID %>';
            document.getElementById(hiddenControl).value = "Pickup";
        }

    </script>

    <script>



    </script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
      <script>window.jQuery || document.write('<script src="StoreFront/vendor/jquery/jquery.slim.min.js"><\/script>')</script><script src="StoreFront/vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <script src="StoreFront/js/form-validation.js"></script>

    <!-- -->    
</asp:Content>
