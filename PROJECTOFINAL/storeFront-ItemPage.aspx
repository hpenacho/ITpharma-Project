<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-ItemPage.aspx.cs" Inherits="PROJECTOFINAL.storeFront_ItemPage" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

     
    <script type="text/javascript">

        let amount = $("input[id$='cartAmount']").val();


        function removeAmount() {

            if (amount > 1) {
                amount = +$("input[id$='cartAmount']").val();
                amount--;
                $("input[id$='cartAmount']").val(amount);
            }
        }

        function addAmount() {

            amount = +$("input[id$='cartAmount']").val();
            amount++;
            $("input[id$='cartAmount']").val(amount);

        }

    </script>

   
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
      <!-- Page Content -->
  <div class="container  mt-5">

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-3 mb-3 text-center">Product Details</h1>

    <!-- Portfolio Item Row -->
    <div class="row">

      <div class="col-lg-8 col-md-12 col-sm-12 align-self-center">

          <div class="text-center" style="max-width:500px; height:600px">
          <img style='height: 100%; width: 100%; object-fit: contain; overflow:hidden' src="#" runat="server" id="productImg"/>
          </div> 
      </div>
       
      <div class="col-lg-4 mt-5">
        <h3 id="txt_itemTitle" runat="server" class="my-3 text-dark"></h3>
        <small> <label id="lbl_codRef" runat="server" class="text-muted"></label> </small>
        <h6 id="txt_itemSummary" runat="server" class="my-3 "></h6>
          
      

          <h5 class="my-3 text-dark">Details</h5>

           <h6 class="text-dark small badge badge-warning" id="control_productCategory" runat="server"></h6>
           <h6 class="text-dark small badge badge-warning" id="control_productBrand" runat="server"></h6>
          <br />
          <br />



             <div class="row mt-1">
            <h4 class="text-dark ml-3" style="font-size: 30px">Price - </h4><h4 class="text-dark ml-3" style="font-size: 30px" id="control_itemPrice" runat="server"></h4>
          </div>



        <div class="row mt-3 ml-3">
         
           <div class="row">
               <button type="button" class="btn btn-warning mr-2 btn-sm" onclick="removeAmount()" formnovalidate="formnovalidate"><i class="fas fa-minus"></i></button>
               <asp:TextBox id= "cartAmount" pattern="[0-9]+" title="Only numbers" CssClass="form-control text-center bg-white" runat="server" style="width: 3.5em"></asp:TextBox> 
               <button type="button" class="btn btn-warning mr-2 btn-sm ml-2" onclick="addAmount()" formnovalidate="formnovalidate"><i class="fas fa-plus"></i></button>
               <asp:LinkButton ID="link_addToCart" class="btn btn-warning" runat="server" OnClick="link_addToCart_Click1" ToolTip="Adds this item to your cart with the selected amount (if stock is available)." data-toggle="tooltip" data-placement="right"><i class="fas fa-cart-plus"></i> Add</asp:LinkButton>
          </div>
        </div>


              <ul class="list-group mt-4">

            <!-- AVAILABILITY REPEATER -->
                  <asp:Repeater ID="rpt_availability" runat="server" DataSourceID="sqlAvailability" OnItemDataBound="rpt_availability_ItemDataBound">
                      <ItemTemplate>

                          <li class="list-group-item d-flex justify-content-between">

                              <div class="col-lg-7 justify-content-lg-start">
                                  <%# Eval("DistributionPoint") %>
                              </div>

                              <div class="col-lg-5 justify-content-lg-start">
                                  <asp:Label ID="lblStock" runat="server" CssClass="badge badge-pill badge-dark" Text='<%# Eval("StockStatus") %>'></asp:Label>
                              </div>

                          </li>
                      </ItemTemplate>
                  </asp:Repeater>
             <!-- AVAILABILITY REPEATER -->

              </ul>

          <h5 class="mt-5 mb-4 text-dark small badge badge-warning">Tags</h5>

          <div class="text-start" >
              <asp:Panel ID="panel_prescribed" runat="server"><i class="fas fa-prescription-bottle-alt" style="font-size: 25px"></i><span class="small text-muted">&nbsp Prescription&nbspneeded</span></asp:Panel>
              <asp:Panel ID="panel_overcounter" runat="server"><i class="fas fa-mortar-pestle" style="font-size: 25px"></i><span class="small text-muted">&nbsp Over-the-counter</span></asp:Panel>
              <asp:Panel ID="panel_genericDrug" runat="server"><i class="fas fa-hand-holding-medical mt-1" style="font-size: 25px"></i><span class="small text-muted">&nbsp Generic</span></asp:Panel>
          </div>


          <h5 class="mt-5 mb-3 text-dark">Alternatives</h5>

          <div class="col-md-4 mt-2 text-center">

              <asp:Repeater ID="rpt_Generics" runat="server" DataSourceID="sqlGenericItems">
                  <ItemTemplate>

                      <a href="storeFront-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>">
                          <img class="img-fluid" src='<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>' alt="">
                      </a>

                  </ItemTemplate>
              </asp:Repeater>

          </div>

        </div>
    </div>
    <!-- /.row -->

      <div class="row">

          <div class="card border-0">
              <div class="card-header bg-transparent">
                  <h5>Description</h5>
              </div>
              <div class="card-body">
                  <asp:Literal id="control_description" runat="server"></asp:Literal>
              </div>
          </div>
      </div>

    <!-- Related Projects Row -->
    <h3 class="my-4">Related Items</h3>

    <div class="row">

        <asp:Repeater ID="rpt_produtoRelacionado" runat="server" DataSourceID="sqlRelatedItems">
            <ItemTemplate>

                 <div class="col-md-3 col-sm-6 mb-4 text-center">
                  
                   <center>  <div class="text-center" style="height:200px; width:200px">
                    <a href="storeFront-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>">
                        <img style='height: 100%; width: 100%; object-fit: contain' src='<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>' alt="">
                   </a> </div> </center>
                 &nbsp;&nbsp;&nbsp;&nbsp;<h5 class="my-3 text-dark"><%# Eval("nome") %></h5>
                  <h6 class="my-3 text-dark"><%# Eval("preco") %>€</h6>
                </div>

            </ItemTemplate>
        </asp:Repeater>

    </div>
    <!-- /.row -->
  </div>
  <!-- /.container -->


    <!-- SQL SOURCE -->
    <asp:SqlDataSource ID="sqlRelatedItems" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnRelatedItemPage" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Reference" QueryStringField="ref" Type="String" />
        </SelectParameters>
      </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlGenericItems" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_returnRelatedGenericItem" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Reference" QueryStringField="ref" Type="String" />
        </SelectParameters>
      </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlAvailability" runat="server" ConnectionString="<%$ ConnectionStrings:ITpharmaConnectionString %>" SelectCommand="usp_itemPageAvailability" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="reference" QueryStringField="ref" Type="String" />
        </SelectParameters>
      </asp:SqlDataSource>

     
 

</asp:Content>
