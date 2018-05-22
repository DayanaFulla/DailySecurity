<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CodigoRecuperacion.aspx.cs" Inherits="Login_CodigoRecuperacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
    <link href="../assets/fonts/fuentes.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="text-center" style="margin-right: auto; margin-left:auto; width: 400px;border: 3px solid #9D00AE;font-size: 10px;; background-color: white; box-shadow: 0px 0px 69px -4px rgba(169,173,185,1); height: auto; margin-top: 80px; margin-bottom:auto;">
            <div id="DivVerificacion" runat="server">
                <h1>Verificacion</h1>
                <h4>Ingrese el codigo que se le envio al correo:</h4>
                <div class="form-group" style="margin-right: auto; margin-left:auto; width:300px;">
                    <label for="TxtCodigo" style="margin-right: auto; margin-left:auto;">Codigo</label>
                    <asp:TextBox runat="server" ID="TxtCodigo" class="form-control" style="text-align:center; margin-right: auto; margin-left:auto;"></asp:TextBox>
                    <span class="text-primary">El codigo de 8 caracteres que se le envio</span>
                    <asp:Label ID="MsgError" runat="server" ForeColor="Red" Visible="false" style="margin-bottom: 10px"></asp:Label>
                </div>
                <asp:Button ID="btnVerificar" runat="server" Text="Verificar" class="btn btn-primary" style="margin-right: auto; margin-left:auto;" OnClick="VerificarExistencia" />
            </div>
            
            <div id="DivCambio" runat="server">
                <h1>Cambiar contraseña</h1>
                <h4>Ingrese su nueva Contraseña:</h4>
                <div class="form-group" style="margin-right: auto; margin-left:auto; width:300px;">
                    <label for="TxtNewPassword" style="margin-right: auto; margin-left:auto;">Contraseña</label>
                    <asp:TextBox TextMode="Password" runat="server" ID="TxtNewPassword" class="form-control" style="text-align:center; margin-right: auto; margin-left:auto;"></asp:TextBox>
                    <span class="text-primary">Nueva constraseña aquí.</span>
                </div>
                <div class="form-group" style="margin-right: auto; margin-left:auto; width:300px;">
                    <label for="TxtSamePassword" style="margin-right: auto; margin-left:auto;">Validar Contraseña</label>
                    <asp:TextBox TextMode="Password" runat="server" ID="TxtSamePassword" class="form-control" style="text-align:center; margin-right: auto; margin-left:auto;"></asp:TextBox>
                    <span class="text-primary">Escriba la misma contraseña</span>
                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Visible="false" style="margin-bottom: 10px"></asp:Label>
                </div>
                <asp:Button ID="btnConfirmar" runat="server" Text="Cambiar" class="btn btn-primary" style="margin-right: auto; margin-left:auto;" OnClick="CambiarContraseña" />
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
