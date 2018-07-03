<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormularioLlave.aspx.cs" Inherits="Formularios_FormularioLlave" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link type="text/css" href="../Content/bootstrap.css" rel="stylesheet" />
    <title>Nueva llave</title>
</head>
<body style="background-image:url(../assets/img/Formulario.jpg); background-size:100%;">
    <form id="form1" runat="server" style="display: flex; ">
        <div style="display: block; width: 600px; margin-top:40px; margin-left: auto; margin-right: auto; border: solid; border-width:1px; padding:30px 50px; border-color:white;">
            <h1 class="form-group" style="text-align: center;">Formulario Llave</h1>
            <div class="formularioDesicion" style="margin-bottom:10px; ">
                <h6>Tipo de llave</h6>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" Style="width: 100%; justify-content:center;">
                    <asp:ListItem ID="rbPermanente" Value="0">Permanente</asp:ListItem>
                    <asp:ListItem ID="rbTemporal" Value="1">Temporal</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            
            <div class="formularioPermanente" style="margin-bottom:10px;">
                <h6>Opciones</h6>
                <asp:CheckBoxList ID="CheckBoxList2" runat="server" RepeatDirection="Horizontal" Style="width: 100%;">
                    <asp:ListItem>Deshabilitar Dias</asp:ListItem>
                    <asp:ListItem>Deshabilitar Horario</asp:ListItem>
                </asp:CheckBoxList>
            </div>

            <div class="FormularioComun" style="margin-bottom:10px;">
                <h6>Identificador de la Llave</h6>
                <div class="nick" style="margin-bottom:10px;">
                    <asp:TextBox runat="server" ID="txtNick" placeholder="Identificador" Style="border-radius: 5px; width: 100%;"></asp:TextBox>
                </div>
               
                <h6>Horarios</h6>
                <div class="Horario" style="display: flex; margin-bottom:10px; justify-content:center;">
                    <div style="display:block; margin-right:100px;">
                        <label>Horario de Inicio</label>
                        <input type="time" runat="server" id="horaInicio" name="horaInicio" value="00:00:01" min="00:00:00" max="23:59:59" />
                    </div>
                    <div style="display:block; margin-right:100px;"">
                        <label>Horario Límite</label>
                        <input type="time" runat="server" id="horaFin" name="horaFin" value="23:59:59" min="00:00:00" max="23:59:59" />
                    </div>
                </div>

            </div>

            <div id="formularioTemp" class="formularioTemporal" style=" width:100%; display:flex;  margin-bottom:30px;">
                <div style="margin-right:60px;">
                    <h6>Fecha de Inicio</h6>
                    <input type="date" id="FechaInicioc" runat="server" class="form-control" />
                </div>
                <div style="margin-right:0px;">
                    <h6>Fecha Límite</h6>
                    <input type="date" id="FechaFinc" runat="server" />
                </div>
            </div>

            <div>
                <asp:Button runat="server" Text="InsertarLlave"  style="width:100%;" OnClick="RegistrarLlave_Click"  />
            </div>


          


        </div>
    </form>
</body>
</html>
