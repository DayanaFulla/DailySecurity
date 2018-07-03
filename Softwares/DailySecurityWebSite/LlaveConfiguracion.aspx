<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LlaveConfiguracion.aspx.cs" Inherits="LlaveConfiguracion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="padding:2px; background-color:purple; border-radius:40px; margin-bottom:10px;">
        <h1 style="color:white; text-align:center">Llaves</h1>
    </div>

    <asp:HyperLink runat="server" NavigateUrl="~/Formularios/FormularioLlave.aspx">Nueva Llave</asp:HyperLink>
    
    <div class="row">
        <div class="table" runat="server">
            <asp:GridView ID="GridLlavesObtenidas" runat="server" OnRowCommand="GridLlavesObtenidas_RowCommand" CssClass="table" GridLines="None" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Editar">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditarLlaveButton" runat="server" CommandName="EditarLlave" CommandArgument='<%# Eval("LlaveId") %>'>
                                <i class="glyphicon-pencil"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar">
                        <ItemTemplate>
                            <asp:LinkButton ID="EliminarLlaveButton" runat="server" CommandName="EliminarLlave" CommandArgument='<%# Eval("LlaveId") %>'>
                                <i class="glyphicon glyphicon-leaf"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Codigo" HeaderText="Código" />
                    <asp:BoundField DataField="HoraInicio" HeaderText="Hora de Inicio" />
                    <asp:BoundField DataField="HoraFin" HeaderText="Hora Límite" />
                    <asp:BoundField DataField="FechaInicio" HeaderText="Fecha Inicio" />
                    <asp:BoundField DataField="FechaFin" HeaderText="Fecha Límite" />
                    <asp:BoundField DataField="Nick" HeaderText="Nick" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

