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
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css'/>

</head>
<body class="text-center">
    <form runat="server" >
        <div class="container">
            <div class="row">
               <div class="rounded mx-auto d-block" style ="  margin-right: auto; margin-left:auto; width: 400px;border: 3px solid #9D00AE; background-color: white; box-shadow: 0px 0px 69px -4px rgba(169,173,185,1); height: 450px; margin-top: 50px;" >
                   <h1 class="h3 mb-3 font-weight-normal">Ingresar</h1>
                    <asp:Label ID="messageError" runat="server" ForeColor="Red" Visible="false" style="margin-bottom: 10px"></asp:Label>
        <br>
                   <div class="form-group" style ="margin:30px" >
                    <label for="exampleInput1" class="">Correo Electrónico</label>
                    <asp:TextBox TextMode="email" class="form-control" id="tbEmail" runat="server"  style ="padding:10px"/>
                    <span class="bmd-help">Correo con el que se registro</span>
                   </div>
                   <div class="form-group" style ="margin:30px">
                    <label for="contrasena" class="label-floating">Contraseña</label>
                    <asp:TextBox TextMode="Password" class="form-control" id="tbContrasena" runat="server"  style ="padding:10px"/>
                    <span class="bmd-help">Contraseña con las que se registro</span>
                   </div>
                   
                   <div>
                       <asp:HyperLink runat="server" NavigateUrl="~/Login/Recuperar.aspx">¿Olvidaste tu contraseña?</asp:HyperLink>
                   </div>
                   <asp:Button class="btn btn-primary" OnClientClick="submit" runat="server" Text="Ingresar" ID="loggear" OnClick="loggear_Click" />

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
