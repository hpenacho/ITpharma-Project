<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="backOffice-Login.aspx.cs" Inherits="PROJECTOFINAL.backOffice_Login" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <title>Administrator Login - ITpharma</title>

    <!-- Bootstrap core CSS -->    
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
         
      <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    <!-- Custom styles for this template -->
    <link href="../BackOffice/BackOffice-Logins/floating-labels.css" rel="stylesheet">

  </head>
  <body>
    <form class="form-signin" runat="server">
  <div class="text-center mb-4">
    <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
    <h1 class="h3 mb-3 font-weight-normal">Floating labels</h1>
    <p> Administrator Login </p>
  </div>

  <div class="form-label-group">
    <input type="text" id="inputUserName" class="form-control" placeholder="Administrator Name" required autofocus>
    <label for="inputUserName">Administrator Name</label>
  </div>

  <div class="form-label-group">
    <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
    <label for="inputPassword">Password</label>
  </div>

  <div class="checkbox mb-3">
    <label>
      <input type="checkbox" value="remember-me"> Remember me
    </label>
  </div>
  <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        <asp:Button ID="btn_login" runat="server" class="btn btn-lg btn-primary btn-block" Text="Sign in" />
  <p class="mt-5 mb-3 text-muted text-center">&copy; 2017-2020</p>
    
</form>
</body>
</html>
