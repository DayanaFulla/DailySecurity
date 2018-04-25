<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Registrar.aspx.cs" Inherits="Registrar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="Form" style = "width:700px;  display:block; margin-left:auto; margin-right:auto">
        
          <div class="form-group">
                <input type="text" class="form-control" id="txtNombre" runat="server" aria-describedby="Nombre" placeholder="Ingrese su nombre" />  
          </div>
          <div class="form-group">
                <input type="text" class="form-control" id="txtApellido" runat="server" aria-describedby="Apellido" placeholder="Ingrese su Apellido"/>
          </div>
            <div class="form-group">
            <input type="tel" class="form-control" id="txtTelefono" runat="server" aria-describedby="Telefono" placeholder="Ingrese su número de telefono"/>
          </div>
          <div class="form-group">
            <input type="email" class="form-control" id="txtEmail" runat="server" aria-describedby="emailHelp" placeholder="Ingrese su Correo Electrónico"/>
          </div>
          <div class="form-group">
            <input type="password" class="form-control" id="txtContrasena" runat="server"  placeholder="Ingrese su contraseña"/>
          </div>
          
        <asp:Button ID="btnGuardar" runat="server" Text="REGISTRAR" OnClick="btnGuardar_Click" CssClass="btn btn-primary" style="display:block; width:50%; margin-top:50px; 
             margin-left:auto;  margin-right:auto" />
        
    </div>

    

</asp:Content>

