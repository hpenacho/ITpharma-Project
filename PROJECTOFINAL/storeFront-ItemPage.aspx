<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-ItemPage.aspx.cs" Inherits="PROJECTOFINAL.storeFront_ItemPage" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

   
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
      <!-- Page Content -->
  <div class="container  mt-5">

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3">Detalhe do Produto</h1>

    <!-- Portfolio Item Row -->
    <div class="row">

      <div class="col-lg-8 col-md-12 col-sm-12">
          <asp:Image lass="img-fluid" Width="600" id="mainImage" runat="server" />
      </div>

      <div class="col-md-4 mt-5">
        <h3 id="txt_itemTitle" runat="server" class="my-3 text-dark"></h3>
        
        <h6 id="txt_itemSummary" runat="server" class="my-3 "></h6>
          
      

          <h5 class="my-3 text-dark">Details</h5>

           <h6 class="text-dark small badge badge-warning" id="control_productCategory" runat="server"></h6>
           <h6 class="text-dark small badge badge-warning" id="control_productBrand" runat="server"></h6>
          <br />
          <br />
          

           <div class="row">
            <h4 class="text-dark ml-3" style="font-size: 30px" id="control_itemPrice" runat="server"></h4>
          </div>

        <div class="row mt-3 ml-3">
         
           <div class="row">
               <button type="button" class="btn btn-warning mr-2 btn-sm" onclick="addAmount()"><i class="fas fa-minus"></i></button>
               <asp:TextBox id= "cartAmount" CssClass="form-control text-center bg-white" runat="server" style="width: 3.2em"></asp:TextBox>
               <button type="button" class="btn btn-warning mr-2 btn-sm ml-2" onclick="removeAmount()"><i class="fas fa-plus"></i></button>
             <asp:LinkButton ID="link_addToCart" class="btn btn-warning" style="width: 5em" runat="server" OnClick="link_addToCart_Click1"><i class="fas fa-cart-plus"></i> Add</asp:LinkButton>
          </div>
        </div>

          <h5 class="mt-3 mb-4 text-dark small badge badge-warning">Tags</h5>
          <div class="text-start" >
              <i class="fas fa-prescription-bottle-alt mr-3" style="font-size: 25px"></i><span class="small text-muted">(prescribed)</span>
              <i class="fas fa-mortar-pestle" style="font-size: 25px"></i><span class="small text-muted">(over-the-counter)</span>
          </div>

        <h5 class="mt-5 text-dark">Alternatives</h5>

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
    <h3 class="my-4">Produtos Relacionados</h3>

    <div class="row">

        <asp:Repeater ID="rpt_produtoRelacionado" runat="server" DataSourceID="sqlRelatedItems">
            <ItemTemplate>

                 <div class="col-md-3 col-sm-6 mb-4 text-center">
                  
                    <a href="storeFront-ItemPage.aspx?ref=<%# Eval("Codreferencia") %>">
                        <img class="img-fluid" width="250" src='<%# "data:image;base64," + Convert.ToBase64String((byte[])Eval("imagem")) %>' alt="">
                   </a>
                 &nbsp;&nbsp;<h5 class="my-3 text-dark"><%# Eval("nome") %></h5>
                  <h6 class="my-3 text-dark"><%# Eval("preco") %>€</h6>
                </div>

            </ItemTemplate>
        </asp:Repeater>

    </div>
    <!-- /.row -->
  </div>
  <!-- /.container -->



    <script>

        let amount = 1;

        function addAmount() {

            if (amount > 1) {
                amount = +$("input[id$='cartAmount']").val();
                amount--;
                $("input[id$='cartAmount']").val(amount);
            }
        }

        function removeAmount() {

            amount = +$("input[id$='cartAmount']").val();
            amount++;
            $("input[id$='cartAmount']").val(amount);
        }

    </script>





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



     
 

</asp:Content>
