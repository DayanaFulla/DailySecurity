<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Recuperar.aspx.cs" Inherits="Login_Recuperar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recuperación</title>
    <style type="text/css">
        .validators{
            margin-bottom: 10px;
            color: red;
        }
    </style>
    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png" />
    <link rel="icon" type="image/png" href="../assets/img/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <!-- Bootstrap core CSS     -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
    <!--  Material Dashboard CSS    -->
    <link href="../assets/css/material-dashboard.css?v=1.2.0" rel="stylesheet" />
    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="../assets/css/demo.css" rel="stylesheet" />
    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css'/>

    <style>
        @import url('https://fonts.googleapis.com/css?family=Asul|Baloo+Bhaina|Cantora+One|Corben|Gabriela|Gurajada|Imprima|Katibeh|Sansita');
    </style>
    <link href="../assets/fonts/fuentes.css" rel="stylesheet" />
    <link href="../assets/css/extra.css" rel="stylesheet" />
</head>
<body class="body-daily">
    <form id="form1" runat="server">
    <div class="text-center fondito">
        <h1 class="text-center" id="titulo-daily3">BIENVENIDO</h1>
        <h4 class="h4-daily">Esta es su guía para recuperar su contraseña:</h4>
        <div class="form-group" style="margin-right: auto; margin-left:auto; width:300px;">
            <label for="Text" id="lb-daily3" style="margin-right: auto; margin-left:auto;">Correo</label>
            <asp:TextBox TextMode="Email" runat="server" ID="Text" class="form-control" style="text-align:center; margin-right: auto; margin-left:auto;"></asp:TextBox>
            <span class="bmd-help">Debe ingresar el correo con el cual se registro</span>
        </div>
        <div style="margin-right: auto; margin-left:auto; width:200px;">
            <p class="text-muted"><i class="material-icons" style="color:#9D00AE;">info_outline</i>Dentro de un momento recibira su nueva contraseña en su correo.</p>
        </div>
        <asp:Label ID="MsgError" runat="server" ForeColor="Red" Visible="false" style="margin-bottom: 10px"></asp:Label>
        <br>
        <asp:Button runat="server" Text="Enviar" class="btn btn-daily" style="margin-right: auto; margin-left:auto;" OnClick="Enviar"/>
    </div>
    </form>


    <!--   Core JS Files   -->
    <script src="../assets/js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../assets/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../assets/js/material.min.js" type="text/javascript"></script>
    <!--  Charts Plugin -->
    <script src="../assets/js/chartist.min.js"></script>
    <!--  Dynamic Elements plugin -->
    <script src="../assets/js/arrive.min.js"></script>
    <!--  PerfectScrollbar Library -->
    <script src="../assets/js/perfect-scrollbar.jquery.min.js"></script>
    <!--  Notifications Plugin    -->
    <script src="../assets/js/bootstrap-notify.js"></script>
    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
    <!-- Material Dashboard javascript methods -->
    <script src="../assets/js/material-dashboard.js?v=1.2.0"></script>
    <!-- Material Dashboard DEMO methods, don't include it in your project! -->
    <script src="../assets/js/demo.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            // Javascript method's body can be found in assets/js/demos.js
            demo.initDashboardPageCharts();

        });
    </script>
</body>
</html>
