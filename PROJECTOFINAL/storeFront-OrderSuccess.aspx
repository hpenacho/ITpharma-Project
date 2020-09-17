<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-OrderSuccess.aspx.cs" Inherits="PROJECTOFINAL.storeFront_OrderSuccess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container justify-content-center mt-5">
    <header class="jumbotron my-4 justify-content-center text-center">
      <h1 class="display-3">Order(#<label id="lbl_orderNumber" runat="server"></label>) Instructions</h1>
      
        <p class="lead mt-sm-2 mb-sm-4 mt-3"> <label id="lbl_msgTypeOrder" runat="server"> Your order is being processed and will be ready for dispatch soon!  </label> <br /> You will receive an email shortly, containing your order details for future reference. <br /> You can also consult this information at any time, including the order's current status, in your personal user section. </p>
          <div class="row justify-content-center"> 
        <asp:LinkButton ID="lbtn_pdf" CssClass="btn btn-danger mt-2" runat="server" OnClick="lbtn_pdf_Click"><i class="fas fa-file-pdf"></i> Order Details (PDF) </asp:LinkButton>   
              </div>  
        <hr />
                    
            <!-- Aqui a imagem é devolvida -->
            <div class=" d-flex justify-content-center mt-4 mb-3">                
                <img id="qrCodeImage" src="#" alt="" title=""/>
            </div>

        <label id="lbl_qrInstructions" class="text-muted text-center" runat="server" visible="false"> 1) This unique QR code can be used to receive your items at the ATM specified during checkout. <br /> 
            2) For your convenience, you may save this image to your device or print it, it must then be presented at the ATM's QR Scanner. <br />
            3) If you decide not to use the QR code, you will have to submit your Order Number, Username and Password for authentication. <br />
            4) You can request a copy of your QR code in this Order's Details Page, under your Personal User Area. <br />
        </label>
        <div class="row justify-content-center">
            <asp:LinkButton ID="lbtn_emailQR" CssClass="btn btn-info" runat="server" OnClick="lbtn_emailQR_Click" Visible="false"><i class="fas fa-qrcode"></i> Email me this QR code</asp:LinkButton>
        </div>
        
    </header>
        
        </div>
    
    
    <script>
        window.onload = (event) => {
            const urlParams = new URLSearchParams(window.location.search);
            let text = urlParams.get("oID") + "_" + urlParams.get("cID") + "_" + urlParams.get("pID");
            console.log(urlParams.get("oID"));console.log(urlParams.get("cID"));console.log(urlParams.get("pID"));
            let qr = document.getElementById("qrCodeImage");

            if (!text.includes("null"))
                qr.src = "https://api.qrserver.com/v1/create-qr-code/?data=" + text
        };
    </script>
</asp:Content>
