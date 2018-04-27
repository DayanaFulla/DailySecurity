using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login_Default : System.Web.UI.Page
{
    string puerto = ConfigurationManager.AppSettings["puerto"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            messageError.Visible = false;
        }
    }

    protected void loggear_Click(object sender, EventArgs e)
    {
        String correoActual = tbEmail.Text;
        String contraseñaActual = tbContrasena.Text;

        if (String.IsNullOrWhiteSpace(correoActual)) {
            messageError.Text = "Campo Vacio";
            messageError.Visible = true;

        }
        else
        {
            Usuario userActual = UsuarioBRL.GetUsuarioByEmail(correoActual);

            if (!userActual.Equals(null))
            {
                if (userActual.Contrasena.Equals(contraseñaActual))
                {
                    Response.Redirect("../Home.aspx");
                } else
                {
                    messageError.Text ="Error al digitar los datos";
                }
            }
            else
            {
                messageError.Text = "No existe el registro";
                Response.Redirect("../../Login.aspx");

            }
        }


    }

    private void mostrarError()
    {
        messageError.Text = "El correo no esta registrado";
        messageError.Visible = true;
    }

}