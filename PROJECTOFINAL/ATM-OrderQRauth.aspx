<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ATM-OrderQRauth.aspx.cs" Inherits="PROJECTOFINAL.ATM_OrderPickup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <title> ATM - </title>

    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

  <script src="https://kit.fontawesome.com/7d8b56b46a.js"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

</head>
<body class="bg-light">
    
     <h2 class="text-center p-0"> IT-Pharma ATM </h2>
        <div class="text-center my-1" > 
            <img src="Resources/images/PHARMALOGO.png" style="width:100px"/>
        </div>

        <div class="container">

            <div class="border rounded">
                  
                    <h1 class="text-center font-weight-bold mt-5"> Please submit your QR code at the ATM's scanner </h1>

                <div>
                    <div class="row justify-content-center my-1">

                        <label style="font-size:150px;"> <i class="fas fa-qrcode text-success"></i> <i class="fas fa-upload text-info"></i> </label>

                        </div>
                </div>
                  

                    <form id="form1" runat="server">
                            <div class="text-center">
                                <label id="lbl_messageQR" class="text-danger" runat="server"></label>
                            </div>

                        
                        <div class="row justify-content-center mb-3">

                            <div class="col-md-1">
                                 <input type="text" id="tb_decrypterInput" runat="server" class="form-control bg-light border-0" placeholder="." />
                            </div>

                            <div class="col-md-3 text-center">
                                <asp:LinkButton ID="lbtn_QRauth" class="btn btn-light" runat="server" OnClick="lbtn_QRauth_Click"><i class="fas fa-key" style="font-size:40px;"></i></asp:LinkButton>
                            </div>
                            <div class="col-md-1"></div>
                       </div>

                    </form>
                    <!-- -->
                     <hr />         
                    <form enctype="multipart/form-data" action="https://api.qrserver.com/v1/read-qr-code/" method="POST" id="qrForm"> <!-- tem de ser https por causa de insecure connections -->
                        <input type="hidden" name="MAX_FILE_SIZE" value="1048576" />

                           <div class="row justify-content-center">
                               <div class="col-md-3">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="inputGroupFileAddon01"><i class="fas fa-qrcode"></i></span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" name="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01" />
                                        <label class="custom-file-label" for="inputGroupFile01">QR Upload</label>
                                    </div>
                                </div>
                            </div>
                           
                                <div class="col-md-3 mb-3">
                                    <input type="submit" class="btn btn-primary" value="Read QR code" />                                    
                               </div>
                               </div>

                    </form>

                    
                    <script>
                    /*
                        document.forms['qrForm'].addEventListener('submit', (event) => {
                            event.preventDefault();
                            // TODO do something here to show user that form is being submitted
                            fetch(event.target.action, {
                                method: 'POST',
                                body: new URLSearchParams(new FormData(event.target)) // event.target is the form
                            }).then((resp) => {
                                return resp.json(); // or resp.text() or whatever the server sends
                            }).then((body) => {
                                // TODO handle body
                                let qrString = document.getElementById("qrString");
                                qrString.innerText = resp.json().symbol[0].data;
                            }).catch((error) => {
                                // TODO handle error
                            });
                        });
                        */

                    </script>
                    <!-- -->
                </div>
                
  </div>
       



        <!-- Bootstrap core JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
