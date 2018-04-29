using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
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
            messageError.Text = "";
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
            if  (userActual!=null)
             {
                String desEncriptada = UsuarioBRL.DesEncriptarPassword(userActual.Contrasena);
                if (desEncriptada.Equals(contraseñaActual))
                {
                        int usuarioActualID = userActual.UsuarioID;
                        Model.Verificacion objActual = VerificacionBRL.GetVerificacionByUsuarioId(usuarioActualID);

                    if (objActual != null)
                    {
                        objActual = verify(correoActual);
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Es necesario que verifique su correo')", true);
                        Boolean IsVerified = objActual.Estado;

                            if (objActual.Estado)
                            {
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('aun no ha verificado su cuenta, por favor revise su correo!')", true);
                                actualizarVerificacion(correoActual);
                            }
                            else
                            {
                                Response.Redirect("../Home.aspx");
                            }
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No existe Verificacion  "+objActual.UsuarioId+"')", true);
                    }
                }
                else
                    {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Datos Incorrectos')", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Datos Incorrectos')", true);
            }
        }


    }

    private void actualizarVerificacion(string correoActual)
    {
       
    }

    private void mostrarError()
    {
        messageError.Text = "El correo no esta registrado";
        messageError.Visible = true;
    }


    protected Model.Verificacion verify(String email)
    {
        Usuario usuario = UsuarioBRL.GetUsuarioByEmail(email);
        Model.Verificacion obj=null;
        try
        {
            System.Diagnostics.Debug.WriteLine("Entro Primero");
            int idVerificacion = VerificacionBRL.InsertVerificacion(usuario.Correo);

            obj = VerificacionBRL.GetVerificacionById(idVerificacion);
            //UsuarioBRL.UpdateUsuarioPassword(usuario.UsuarioID, obj.Codigo);

            EnviarEmail(email, obj.CodigoVerificacion, usuario.UsuarioID, idVerificacion);

        }
        catch (Exception)
        {

        }
        return obj;
    }




    public void EnviarEmail(string email, string codigo, int UsuarioId, int idVerificacion)
    {
        string correo = ConfigurationManager.AppSettings["correoElectronico"].ToString();
        string password = ConfigurationManager.AppSettings["contraseñaCorreo"].ToString();

        System.Diagnostics.Debug.WriteLine("Correo From: " + correo);
        System.Diagnostics.Debug.WriteLine("Correo From: " + password);
        System.Diagnostics.Debug.WriteLine("cleinte to: " + email);
        System.Diagnostics.Debug.WriteLine("codigo to: " + codigo);


        string body = "<html>";
        body = body + "<head>";
        body = body + "<title></title>";
        body = body + "</head>";
        body = body + "<body>";
        body = body + "<div class=\"text -center\" style=\"margin-right: auto; margin-left:auto; width: 700px; padding:50px; border: 3px solid #9D00AE; background-color: white; margin-top: 50px;\">";
        body = body + "<h3 style = \"text -align: center; font-family:Calibri; font-size:15px; margin-top: 0px;margin-bottom: 5px;\" > <strong> El link de verificacion se encuentra aquí </strong></h3>";
        body = body + "<h6 style = \"margin -left:5px;margin-right:5px; font-family:Calibri; font-size:15px; margin-top: 0px;margin-bottom: 5px;\" > Gracias por registrarse, enseguida estara el link para que pueda verificar su registro</h6>";
        body = body + "<div style = \"text -align: center; margin-bottom: 5px;\" >";
        body = body + "<a style= \"align -content: center; font-family:Calibri; font-size:15px; text-decoration: none;\" href= \"http://localhost:" + puerto + "/VerificarWS.aspx?codigo=" + codigo + "\">   Enlace Aquí</a>";
        body = body + "</div>";
        body = body + "</div>";
        body = body + "</body>";
        body = body + "</html>";

        try
        {
            MailMessage mail = new MailMessage();
            SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

            mail.From = new MailAddress(correo, "Daily Security");
            mail.To.Add(email);
            mail.Subject = "Verificación de Registro";
            mail.IsBodyHtml = true;
            mail.Body = body;
            SmtpServer.Port = 587;
            SmtpServer.Credentials = new System.Net.NetworkCredential(correo, password);
            SmtpServer.EnableSsl = true;
            SmtpServer.Send(mail);
            System.Diagnostics.Debug.WriteLine("Mensaje enviado");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Mensaje error: " + ex.ToString());
        }

    }


}