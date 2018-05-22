<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png" />
    <link rel="icon" type="image/png" href="assets/img/Icono.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <link href="ExtraCSS/css/bootstrap.min.css" rel="stylesheet" />
    <script src="assets/js/jquery-3.2.1.min.js"></script>
    <link href="assets/fonts/fuentes.css" rel="stylesheet" />
    <link href="assets/css/extra.css" rel="stylesheet" />
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css'/>

    <title>Home</title>

</head>
<body>
    <nav class="navbar navbar-expand-lg" id="navegador" style="background-color:#5d1669;">
      <a class="navbar-brand" href="javascript: void(0);"><img src="assets/img/web_hi_res_512.png" /><h1>DailySecurity</h1></a>
      <button style="color:white;" class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"><i class="material-icons">dehaze</i></span>
      </button>

      <div class="navbar-collapse collapse" id="navbarsExample04" style="">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
              <asp:HyperLink  NavigateUrl="javascript: void(0);" CssClass="nav-link urlRedirect" runat="server">
                    <h6><i class="material-icons">supervised_user_circle</i>Nosotros</h6>
                </asp:HyperLink>
          </li>
          <li class="nav-item">
            <asp:HyperLink NavigateUrl="~/Login/Login.aspx" CssClass="nav-link urlRedirect" runat="server">
                    <h6><i class="material-icons">person</i>Inicio Sesión</h6>
                </asp:HyperLink>
          </li>
          <li class="nav-item">
            <asp:HyperLink NavigateUrl="javascript: void(0);" CssClass="nav-link urlRedirect" runat="server">
                    <h6><i class="material-icons">help</i>Ayuda</h6>
                </asp:HyperLink>
          </li>
        </ul>
      </div>
    </nav>
    <img src="assets/img/ciberseguridad2.jpg" style="position:absolute;width:100%;"/>
</body>
<script src="ExtraCSS/js/bootstrap.min.js"></script>
<script src="ExtraCSS/js/popper.min.json"></script>

</html>
