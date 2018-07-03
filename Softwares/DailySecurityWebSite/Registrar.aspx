<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Registrar.aspx.cs" Inherits="Registrar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DailySecurity</title>

    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png" />
    <link rel="icon" type="image/png" href="../assets/img/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <!-- Bootstrap core CSS     -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
    <!--  Material Dashboard CSS    -->
    <link href="assets/css/material-dashboard.css?v=1.2.0" rel="stylesheet" />
    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="assets/css/demo.css" rel="stylesheet" />
    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css' />
    <style>
        @import url('https://fonts.googleapis.com/css?family=Asul|Baloo+Bhaina|Cantora+One|Corben|Gabriela|Gurajada|Imprima|Katibeh|Sansita');
    </style>
    <link href="assets/fonts/fuentes.css" rel="stylesheet" />
    <link href="assets/css/extra.css" rel="stylesheet" />

</head>
<body class="body-daily" style="display: block; background-image: url(assets/img/intro-bg.jpg); background-size: 100%; background-attachment: fixed;">

    <form runat="server" style="display: block; width: 700px; margin-top: 50px; margin-left: auto; margin-right: auto;">
        <div style="width: 700px; display:block; border:solid; border-color:white; border-width:1px; ">
            <h1 style="text-align:center; font-family:Quantify; color:white;">Registrar</h1>
            <div style="display: flex;" >
                <div class="Form" style="width: 350px;  display: block; margin-left:100px;">
                    <div class="form-group">
                        <label for="txtNombre" id="lb-daily8">Nombre(s):</label><br />
                        <asp:TextBox type="text" CssClass="form-control input-daily"  ID="txtNombre" runat="server" aria-describedby="Nombre" /><br />
                        <span class="bmd-help">Ingrese su nombre completo</span>
                    </div>
                    <div class="form-group">
                        <label for="txtApellido" id="lb-daily9">Apellido(s):</label>
                        <asp:TextBox type="text" CssClass="form-control input-daily" ID="txtApellido" runat="server" aria-describedby="Apellido" />
                        <span class="bmd-help">Ingrese su(s) apellido(s)</span>
                    </div>
                    <div class="form-group">
                        <label for="txtTelefono" id="lb-daily10">Telefono:</label>
                        <asp:TextBox type="tel" CssClass="form-control input-daily" ID="txtTelefono" runat="server" aria-describedby="Telefono" />
                        <span class="bmd-help">Número de Teléfono</span>
                    </div>

                </div>

                <div style="width: 350px; display: block; margin-left: auto; margin-right: auto; ">
                    <div class="form-group">
                        <label for="txtEmail" id="lb-daily11">Correo Electrónico:</label>
                        <asp:TextBox type="email" CssClass="form-control input-daily" ID="txtEmail" runat="server" aria-describedby="emailHelp" />
                        <span class="bmd-help">Ingresar correo electrónico</span>
                    </div>
                    <div class="form-group">
                        <label for="txtContrasena" id="lb-daily12">Contraseña</label>
                        <asp:TextBox type="password" CssClass="form-control input-daily" ID="txtContrasena" runat="server" />
                        <span class="bmd-help">Contraseña secreta </span>
                    </div>
                </div>
            </div>
            <asp:Button ID="btnGuardar" runat="server" Text="REGISTRAR" OnClick="btnGuardar_Click" style="display:block; width:70%; margin-left:auto; margin-right:auto;" CssClass="btn btn-daily" />
        </div>
        
    </form>
</body>

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
</html>


