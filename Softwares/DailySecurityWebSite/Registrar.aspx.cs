using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Registrar : System.Web.UI.Page
{
    string puerto = ConfigurationManager.AppSettings["puerto"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnGuardar_Click(object sender, EventArgs e)
    {
        //USUARIO
        string US_nombre = txtNombre.Value;
        string US_apellido = txtApellido.Value;
        string US_telefono = txtTelefono.Value;
        string US_email = txtEmail.Value;
        string US_contraseña = txtContrasena.Value;

        if (string.IsNullOrEmpty(US_nombre))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Nombre no debe estar vacío')", true);
            return;
        }

        if (string.IsNullOrEmpty(US_apellido))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Apellido no debe estar vacío')", true);            
            return;                
        }

        if (string.IsNullOrEmpty(US_telefono))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Teléfono no debe estar vacío')", true);           
            return;
        }

        if (string.IsNullOrEmpty(US_email))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Email no debe estar vacío')", true);            
            return;
        }

        if (string.IsNullOrEmpty(US_contraseña))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Contraseña no debe estar vacío')", true);            
            return;
        }

        if (US_contraseña.Length<6 )
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('La contraseña debe almacenar 6 caracteres como mínimo')", true);
            return;
        }else if (US_contraseña.Length > 50)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('La contraseña debe almacenar 50 caracteres como máximo')", true);
            return;
        }

        if (UsuarioBRL.GetUsuarioByEmail(US_email)==null)
        {
            //REGISTRANDO USUARIO

            Usuario obj = new Usuario()
            {
                Nombre = US_nombre,
                Apellido = US_apellido,
                Telefono = US_telefono,
                Correo = US_email,
                Contrasena = UsuarioBRL.EncriptarPassword(US_contraseña),
            };

            int idUsuario = UsuarioBRL.InsertarUsuario(obj);

            Enviar(US_email);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El Usuario se ha registrado Exitosamente!!!')", true);

            Response.Redirect("~/Registrar.aspx");
        }else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El correo electrónico indicado ya está registrado')", true);
            return;
        }
        
    }







    //Enviar Correo

    protected void Enviar(String email)
    {
           Usuario usuario = UsuarioBRL.GetUsuarioByEmail(email);

        try
        {
            System.Diagnostics.Debug.WriteLine("Entro Primero");
            int idVerificacion = VerificacionBRL.InsertVerificacion(usuario.Correo);

            Model.Verificacion obj = VerificacionBRL.GetVerificacionById(idVerificacion);
            //UsuarioBRL.UpdateUsuarioPassword(usuario.UsuarioID, obj.Codigo);

            EnviarEmail(email, obj.CodigoVerificacion, usuario.UsuarioID, idVerificacion);

        }
        catch (Exception)
        {

        }

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
        body = body + "<a style= \"align -content: center; font-family:Calibri; font-size:15px; text-decoration: none;\" href= \"http://localhost:"+puerto+"/VerificarWS.aspx?codigo=" + codigo + "\">   Enlace Aquí</a>";
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






    //Enviar Correo

}