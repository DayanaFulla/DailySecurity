using DailyDB.App_Code.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UsuarioVista : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        Usuario usuario = (Usuario)Session["USUARIO"];
        if (usuario==null)
        {
            Response.Redirect("Home.aspx");
        }else
        {
            NombreCompleto.Text = usuario.Nombre + " " + usuario.Apellido;
            Correo.Text = usuario.Correo;
            Telefono.Text = usuario.Telefono;

        }
    }
}