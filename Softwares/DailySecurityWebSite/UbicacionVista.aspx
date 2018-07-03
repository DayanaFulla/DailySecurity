<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UbicacionVista.aspx.cs" Inherits="UbicacionVista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <link rel="import" href="https://raw-dot-custom-elements.appspot.com/GoogleWebComponents/google-map/v2.0.2/google-map/google-map.html" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        google-map {
            height: 380px;
        }
    </style>
    <div style="width: 100%; margin-top: 20px;">

        <div class="form-group">
            <asp:Label ID="Label7" runat="server" Text="Seleccione donde estará ubicada su Alarma en el siguiente Mapa: " Font-Bold="true"></asp:Label>
            <br />
            <google-map latitude="-17.7979877" longitude="-63.1478128" zoom="15" fit-to-markers api-key="AIzaSyD3E1D9b-Z7ekrT3tbhl_dy8DCXuIuDDRc" id="Gmap">
            <google-map-marker id="markerG" latitude="-17.7979877" longitude="-63.1478128" draggable="true"></google-map-marker>
            </google-map>

        </div>
        <br />
        <asp:Label ID="lbValidator" runat="server" Text="" ForeColor="Red"></asp:Label>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webcomponentsjs/1.0.17/webcomponents-lite.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="~/Style/js/jquery-3.2.1.min.js"></script>
</asp:Content>

