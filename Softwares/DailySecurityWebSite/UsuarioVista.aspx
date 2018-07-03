<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UsuarioVista.aspx.cs" Inherits="UsuarioVista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Usuario</h1>
    <h3 class="titulos">Nombre Completo</h3>
    <asp:Label runat="server" ID="NombreCompleto"></asp:Label><br />
    <h3 class="titulos">Correo</h3>
    <asp:Label runat="server" ID="Correo"></asp:Label><br />
    <h3 class="titulos">Telefono</h3>
    <asp:Label runat="server" ID="Telefono"></asp:Label><br />
    <style>
        .titulos{
            color:#9C27B0;
        }
    </style>
</asp:Content>

