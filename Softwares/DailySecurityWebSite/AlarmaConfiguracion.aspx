<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AlarmaConfiguracion.aspx.cs" Inherits="Alarma" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="padding:2px; background-color:#9C27B0; border-radius:40px; margin-bottom:10px;">
        <h3 style="color:white; text-align:center">Alarmas</h3>
    </div>
    <asp:HyperLink runat="server" NavigateUrl="~/Formularios/FormularioAlarma.aspx">Nueva Alarma</asp:HyperLink>
    <div class="row">
        <div class="table" runat="server">
            <asp:GridView ID="GridAlarma" runat="server" OnRowCommand="GridAlarma_RowCommand" CssClass="table" GridLines="None" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Editar">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditarAlarmaButton" runat="server" CommandName="EditarAlarma" CommandArgument='<%# Eval("AlarmaId") %>'>
                                <i class="glyphicon-pencil"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar">
                        <ItemTemplate>
                            <asp:LinkButton ID="EliminarAlarmaButton" runat="server" CommandName="EliminarAlarma" CommandArgument='<%# Eval("AlarmaId") %>'>
                                <i class="glyphicon glyphicon-leaf"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Codigo" HeaderText="Código" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Contrasena" HeaderText="Contraseña" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

