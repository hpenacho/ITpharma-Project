<%@ Page Title="" Language="C#" MasterPageFile="~/ATM-MasterPage.Master" AutoEventWireup="true" CodeBehind="ATM-ItemPage.aspx.cs" Inherits="PROJECTOFINAL.ATM_ItemPage" %>
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

    <div class="container mt-3">
       
    </div>



    <div class="container">

        <div class="row">
            <div class="col-lg-12 text-center">
                <h3 id="txt_itemTitle" runat="server" class="my-3 text-dark"></h3>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-lg-12 d-flex justify-content-center">
                <div style="max-width: 300px; height: auto">
                    <img class="align-self-center" style='height: auto; width: 100%; object-fit: contain; overflow: hidden' src="#" runat="server" id="productImg" />
                </div>
            </div>
        </div>

        <div class="row text-center">
            <div class="col-lg-12 mt-5 text-center">

                
                <h6 id="txt_itemSummary" runat="server" class="my-3 "></h6>

                <h5 class="my-3 text-dark">Details</h5>
                <h6 class="text-dark small badge badge-warning" id="control_productCategory" runat="server"></h6>
                <h6 class="text-dark small badge badge-warning" id="control_productBrand" runat="server"></h6>
                <br />
                <br />

                <div class="row mt-1 d-flex justify-content-center">
                    <h4 class="text-dark ml-3" style="font-size: 30px">Price - </h4>
                    <h4 class="text-dark ml-3" style="font-size: 30px" id="control_itemPrice" runat="server"></h4>
                </div>

                <div class="row mt-3 ml-3 d-flex justify-content-center">
                    <button type="button" class="btn btn-warning mr-2 btn-sm p-2" onclick="removeAmount()" formnovalidate="formnovalidate"><i class="fas fa-minus"></i></button>
                    <asp:TextBox ID="cartAmount" pattern="[0-9]+" title="Only numbers" Text="1" CssClass="form-control text-center bg-white p-2" runat="server" Style="width: 3.5em"></asp:TextBox>
                    <button type="button" class="btn btn-warning mr-2 btn-sm ml-2 p-2" onclick="addAmount()" formnovalidate="formnovalidate"><i class="fas fa-plus"></i></button>
                </div>

                <div class="row mt-3">
                    <div class="col-lg-12 text-center">
                         <asp:LinkButton ID="link_addToCart" Width="400px" class="btn btn-warning ml-4 p-3 shadow-sm" runat="server" ToolTip="Adds this item to your cart with the selected ammount (if stock is available)."><i class="fas fa-cart-plus"></i>&nbspBUY</asp:LinkButton>
                    </div>
                </div>

                <div class="row mt-1">
                    <div class="col-lg-12 text-center">
                        <button type="button" style="width: 400px;" class="btn btn-secondary ml-4 p-3 shadow-sm" data-toggle="modal" data-target="#exampleModalLong">
                            <i class="fas fa-scroll"></i>&nbspDESCRIPTION
                        </button>
                    </div>
                </div>

                <div class="row mt-1">
                    <div class="col-lg-12 text-center">
                        <a href="ATM-Shop.aspx" style="width: 400px;" class="btn btn-dark ml-4 p-3 shadow-sm">BACK</a>
                    </div>
                </div>

            </div>
        </div>
    

    <div class="row mt-5">

      
      </div>
    </div>



    <!-- Modal -->
    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5>Description</h5>
                </div>
                <div class="modal-body">

                    <asp:Literal ID="control_description" runat="server"></asp:Literal>

                </div>
                <div class="modal-footer text-center">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">OKAY</button>
                </div>
            </div>
        </div>
    </div>




</asp:Content>
