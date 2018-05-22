<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ingresar</title>

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
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css' />
    <style>
        @import url('https://fonts.googleapis.com/css?family=Asul|Baloo+Bhaina|Cantora+One|Corben|Gabriela|Gurajada|Imprima|Katibeh|Sansita');
    </style>
    <link href="../assets/fonts/fuentes.css" rel="stylesheet" />
    <link href="../assets/css/extra.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#myModal").modal('show');
        });
    </script>
</head>
<body class="text-center body-daily">

    <form runat="server">
        <div class="container">
            <div class="row">
                <div class="rounded mx-auto d-block fondito">
                    <h1 class="h3 mb-3" id="titulo-daily1">INICIAR SESIÓN</h1>
                    <asp:Label ID="messageError" runat="server" ForeColor="Red" Visible="false" Style="margin-bottom: 10px"></asp:Label>
                    <div class="form-group" style="margin: 30px">
                        <label for="exampleInput1" id="lb-daily2">Correo Electrónico</label>
                        <asp:TextBox TextMode="email" class="form-control" ID="tbEmail" runat="server" Style="text-align: center; margin-right: auto; margin-left: auto;" />
                        <span class="bmd-help">Correo con el que se registro</span>
                    </div>
                    <div class="form-group" style="margin: 30px">
                        <label for="contrasena" id="lb-daily1">Contraseña</label>
                        <asp:TextBox TextMode="Password" class="form-control" ID="tbContrasena" runat="server" Style="text-align: center; margin-right: auto; margin-left: auto;" />
                        <span class="bmd-help">Contraseña con las que se registro</span>
                    </div>
                    <div>
                        <asp:HyperLink runat="server" CssClass="url-daily" NavigateUrl="~/Login/Recuperar.aspx">¿Olvidaste tu contraseña?</asp:HyperLink>
                        ó
                        <asp:HyperLink runat="server" CssClass="url-daily" NavigateUrl="~/Registrar.aspx">Registrate</asp:HyperLink>
                    </div>
                    <asp:Button class="btn btn-daily" OnClientClick="submit" runat="server" Text="Ingresar" ID="loggear" OnClick="loggear_Click" data-toggle="modal" data-target="#exampleModal"/>

                </div>
            </div>
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
