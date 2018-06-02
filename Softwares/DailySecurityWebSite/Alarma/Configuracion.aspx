<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Configuracion.aspx.cs" Inherits="Alarma_Configuracion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <google-map latitude="-17.7979877" longitude="-63.1478128" zoom="15" fit-to-markers api-key="AIzaSyD3E1D9b-Z7ekrT3tbhl_dy8DCXuIuDDRc" id="Gmap">
                         <google-map-marker id="markerG" latitude="-17.7979877" longitude="-63.1478128" draggable="true"></google-map-marker>
                    </google-map>
    </div>
    </form>
</body>
</html>
