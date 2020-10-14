<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="backOffice-Login.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Login" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <title>Administrator Login - ITpharma</title>
    <link rel="icon" href="Resources/images/PHARMALOGO.png" type="image/png">

    <!-- Bootstrap core CSS -->    
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
         
      
    <!-- Custom styles for this template -->
    <link href="../BackOffice/BackOffice-Logins/floating-labels.css" rel="stylesheet">

  </head>
<body>
    <form class="form-signin" runat="server">

        <div class="text-center mb-4">
            <img class="mb-4" src="Resources/images/PHARMALOGO.png" alt="" width="100" height="100">
            <h1 class="h3 mb-3 font-weight-normal">Administrator Login - ITpharma</h1>
            <p>Please insert your login credentials below. </p>
        </div>

        <div class="form-label-group">
            <input type="text" id="inputUserName" runat="server" class="form-control" placeholder="Administrator Name" required autofocus>
            <label for="inputUserName">Administrator Name</label>
        </div>

        <div class="form-label-group">
            <input type="password" id="inputPassword" runat="server" class="form-control" placeholder="Password" required>
            <label for="inputPassword">Password</label>
        </div>

        <asp:Button ID="btn_login" runat="server" class="btn btn-lg btn-primary btn-block" Text="Sign in" OnClick="btn_login_Click" />

        <div class="form-label-group">
            <asp:Label ID="lbl_errorMessage" runat="server" class="text-center" Text=" " ForeColor="Red"></asp:Label>
        </div>

        <p class="mt-5 mb-3 text-muted text-center">&copy; 2017-2020</p>

    </form>
</body>
</html>
