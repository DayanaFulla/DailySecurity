6t<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormularioAlarma.aspx.cs" Inherits="Alarma_FormularioAlarma" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro de Alarma</title>
    <link rel="icon" type="image/png" href="../../assets/img/Icono.png" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webcomponentsjs/1.0.17/webcomponents-lite.js"></script>
    <link rel="import" href="https://raw-dot-custom-elements.appspot.com/GoogleWebComponents/google-map/v2.0.2/google-map/google-map.html" />
    <link type="text/css" href="../Content/bootstrap.css" rel="stylesheet" />
    <style>
        google-map {
            height: 380px;
        }
    </style>
</head>
<body style="background-image:url(../assets/img/Formulario2.jpg); background-size:100%;">
    <form id="form1" runat="server" style=" display:flex; margin-top:20px;">
        <div class="form-group" style=" width:750px; display:block; margin-left:auto; margin-right:auto; ">
            <div style="margin-bottom:20px;">
                <h1 class="form-group" style="text-align:center; color:white;">Registro de Alarma</h1>
            </div>
            <div style="display:flex; justify-content:space-between; margin-left:auto; margin-right:auto;">
                <asp:TextBox runat="server" class="form-control" ID="fcodigoAlarma" placeholder="Código de Alarma" style="width:190px; padding:5px; border-radius:5px;"></asp:TextBox><br />
                <asp:TextBox runat="server" class="form-control" ID="fnombreAlarma" placeholder="Nombre de la Alarma" style="width:200px; padding:5px; border-radius:5px;"></asp:TextBox><br />
                <asp:TextBox runat="server" class="form-control" ID="fcontrasenaAlarma" placeholder="Contraseña de la Alarma" type="Password" style="width:210px; padding:5px; border-radius:5px;"></asp:TextBox><br />
            </div>
            <div  style="width:100%; margin-top:20px;">

                <div class="form-group" >
                    <asp:Label ID="Label7" runat="server" Text="Seleccione donde estará ubicada su Alarma en el siguiente Mapa: " Font-Bold="true"></asp:Label>
                    <br />
                    <google-map latitude="-17.7979877" longitude="-63.1478128" zoom="15" fit-to-markers api-key="AIzaSyD3E1D9b-Z7ekrT3tbhl_dy8DCXuIuDDRc" id="Gmap">
                         <google-map-marker id="markerG" latitude="-17.7979877" longitude="-63.1478128" draggable="true"></google-map-marker>
                    </google-map>

                </div>
                <br />
                <asp:Label ID="lbValidator" runat="server" Text="" ForeColor="Red"></asp:Label>
            </div>
            <asp:Button runat="server" Text="Guardar" OnClientClick="prueba()" OnClick="registrarAlarma"  class="btn btn-primary" style="width:100%; background-color:purple;" />

            <asp:HiddenField ID="longitudHidden" runat="server" />
            <asp:HiddenField ID="latitudHidden" runat="server" />
        </div>
        <script>
        function prueba() {
            var marker = document.getElementById("markerG");
            //console.log(marker.latitud);
            //alert("lat: " + marker.latitude + " - long: " + marker.longitude)            
            document.getElementById("<%=latitudHidden.ClientID%>").value = marker.latitude;
            document.getElementById("<%=longitudHidden.ClientID%>").value = marker.longitude;
        }
    </script>
    </form>

    

</body>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="~/Style/js/jquery-3.2.1.min.js"></script>
</html>
