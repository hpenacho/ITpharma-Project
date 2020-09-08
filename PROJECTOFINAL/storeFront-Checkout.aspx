<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-Checkout.aspx.cs" Inherits="PROJECTOFINAL.storeFront_Checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- -->

    <div class="container">
  <div class="py-5 text-center">
    <img class="d-block mx-auto mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
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
            <h6 class="my-0"> <span id="lbl_title">  <%# Eval("ProdName") %> </span></h6>
            <small class="text-muted" style="display: block; width: 150px;">
        <span> 
            <span id="item price"> <%# Eval("Unit Price") %> € per Unit</span>
            <p id="lbl_itemQty"> <%# Eval("Qty") %></p> unit(s)
        </span></small>
              
          </div>
          <b><span class="text-success" style="text-align:right;"> <span id="itemTotalPrice"> <%# Eval("itemTotalPrice") %> </span> € </b>       
              
                        
        </li>
            
           </ItemTemplate>

       </asp:Repeater>
          


          <asp:SqlDataSource ID="SqlSmallCartDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnUserCartItems" SelectCommandType="StoredProcedure">
              <SelectParameters>
                  <asp:Parameter Name="id_cliente" Type="Int32" />
                  <asp:CookieParameter CookieName="noLogID" Name="cookies" Type="String" />
              </SelectParameters>
          </asp:SqlDataSource>
          


        <li class="list-group-item d-flex justify-content-between bg-light">
          <span>Total (€)</span>
            <p class="text-muted">Sub-Total: <label class="col-form-label" id="lbl_SubTotal" runat="server"> [subTotal]</label> </p>
                      <p class="text-muted">Tax(6%): <label class="col-form-label" id="lbl_Tax" runat="server"> [tax]</label> </p>
                      <b>Total: <label class="col-form-label" id="lbl_finalTotal" runat="server"> [total]</label>  </b>
        </li>
      </ul>
     
        <form class="card p-2" >
        <div class="input-group">
          
        </div>
      </form>

    </div>
    <div class="col-md-8 order-md-1">
      <h4 class="mb-3">Billing address</h4>
      <div class="needs-validation" novalidate>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="firstName">Primeiro Nome</label>
            <input type="text" class="form-control" id="firstName" runat="server" placeholder="" value="" required>
            <div class="invalid-feedback">
              Please insert the package receiver's first name.
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="lastName">Apelido</label>
            <input type="text" class="form-control" id="lastName" runat="server" placeholder="" value="" required>
            <div class="invalid-feedback">
              Please insert the package receiver's last name.
            </div>
          </div>
        </div>

        <div class="mb-3">
          <label for="username">Username</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">@</span>
            </div>            
              <asp:TextBox ID="tb_userName" class="form-control" runat="server" required="true" ReadOnly="True"></asp:TextBox>
            <div class="invalid-feedback" style="width: 100%;">
              Your username is required.
            </div>
          </div>
        </div>

        <div class="mb-3">
          <label for="email">Email <span class="text-muted"></span></label>
            <asp:TextBox ID="tb_email" class="form-control" runat="server" placeholder="you@example.com" ReadOnly="True"></asp:TextBox>
          <div class="invalid-feedback">
            Please enter a valid email address for shipping updates.
          </div>
        </div>

        <div class="mb-3">
          <label for="address">Address</label>
          <asp:TextBox ID="tb_morada" class="form-control" runat="server" placeholder="Address"></asp:TextBox>
          <div class="invalid-feedback">
            Confirme que inseriu a sua morada.
          </div>
        </div>

        <div class="mb-3">
          <label for="address2"> Address 2 <span class="text-muted">(Optional)</span></label>
          <input type="text" class="form-control" id="address2" runat="server" placeholder="Additional Address Information (optional)">
        </div>

        <div class="row">
          <div class="col-md-5 mb-3">
            <label for="country">Location</label>
            <select class="custom-select d-block w-100" id="LocationZone" runat="server" required>
              <option value="">Choose...</option>
              <option selected>Portugal Continental</option>
                <option>Açores</option>
                <option>Madeira</option>
            </select>
          </div>
          
          <div class="col-md-3 mb-3">
            <label for="zip">Zip-Code</label>
            <input type="text" class="form-control" id="zip" runat="server" placeholder="" required>
            <div class="invalid-feedback">
              Insert the Zip-Code.
            </div>
          </div>
        </div>
        <hr class="mb-4">
        <div class="custom-control custom-checkbox">
          <input type="checkbox" class="custom-control-input" id="save-info">
          <label class="custom-control-label" for="save-info"> Save this information for next time.</label>
        </div>
        <hr class="mb-4">

        <h4 class="mb-3">Detalhes de pagamento</h4>
                 
      <!--  <asp:RadioButtonList ID="rbtnl_paymentType" runat="server" Font-Italic="True" Font-Size="Medium" Height="0px">
                <asp:ListItem Selected="True" Value="Credit Card"> Credit Card </asp:ListItem>             
            <asp:ListItem Value="Debit Card"> Debit Card </asp:ListItem>               
            <asp:ListItem Value="PayPal"> PayPal </asp:ListItem>
                  </asp:RadioButtonList> -->

          <div class="row">
                      <div class="btn-group btn-group-toggle" data-toggle="buttons">
                          <div class="col-md-2">
                          <label class="btn btn-light active">
                            <input type="radio" name="radioPaymentCard" id="CreditCard" autocomplete="off" runat="server" checked > <h6> <i class="fas fa-mars text-primary"> </i>  Credit Card </h6>
                          </label>
                              </div>
                          <div class="col-md-2">
                          <label class="btn btn-light">
                            <input type="radio" name="radioPaymentCard" id="DebitCard" autocomplete="off" runat="server"> <h6><i class="fas fa-venus text-danger"></i>  Debit Card </h6>
                          </label>
                              </div>
                          <div class="col-md-2">
                          <label class="btn btn-light">
                            <input type="radio" name="radioPaymentCard" id="PayPal" autocomplete="off" runat="server"> <h6><i class="fas fa-venus text-danger"></i>  Paypal </h6>
                          </label>
                              </div>
                        </div>
          </div>
                      
              
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="cc-name">Name on Card</label>
            <input type="text" class="form-control" id="ccName" runat="server" placeholder="Name as written on your card" required>
            <small class="text-muted"> Name as written on your card.</small>
            <div class="invalid-feedback">
              This is a mandatory field.
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="cc-number">Card Number</label>
            <input type="text" class="form-control" id="ccNumber" runat="server" placeholder="Card Number" required>
            <div class="invalid-feedback">
              Card number necessary for payment.
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-3 mb-3">
            <label for="cc-expiration">Prazo</label>
              <input type="date" class="form-control form-control-user bg-light" runat="server" id="ccExpiration" value="2000-01-01">
            <div class="invalid-feedback">
              Expiration date required.
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <label for="cc-cvv">CVV</label>
            <input type="text" class="form-control" id="ccCvv" runat="server" placeholder="CVV" pattern="[0-9]{3}" title="CVV is composed of 3 digits" required>
            <div class="invalid-feedback">
              CVV number needed, this is typically at the back of your card.
            </div>
          </div>
        </div>
        <hr class="mb-4">   
          <asp:Button ID="btn_finalizePurchase" class="btn btn-primary btn-lg btn-block mb-5"  runat="server" Text="Purchase" OnClick="btn_finalizePurchase_Click"/>
      </div>
        
            
    </div>
  </div>
        
  
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
      <script>window.jQuery || document.write('<script src="../vendor/jquery/jquery.slim.min.js"><\/script>')</script><script src="../vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <script src="form-validation.js"></script>


    <!-- -->
</asp:Content>
