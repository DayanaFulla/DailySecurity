using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net.Mail;
using System.Net;

using DailyDB.App_Code.BRL;
using DailyDB.App_Code.Model;

public partial class Login_Recuperar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            MsgError.Visible = false;
        }
    }
        

    protected void Enviar(object sender, EventArgs e)
    {
        string email = Text.Text;
        MsgError.Visible = false;
        if (string.IsNullOrWhiteSpace(email))
        {
            MsgError.Text = "Campo Vacio";
            MsgError.Visible = true;
        }else
        {
            Usuario usuario = UsuarioBRL.GetUsuarioByEmail(email);
            if(usuario == null)
            {
                MostrarError();
            }

            try
            {
                System.Diagnostics.Debug.WriteLine("Entro Primero");
                int idRecu = RecuperacionBRL.InsertRecuperacion(usuario.Correo);
                
                MsgError.Visible = true;
                Recuperacion obj = RecuperacionBRL.GetRecuperacionById(idRecu);
                //UsuarioBRL.UpdateUsuarioPassword(usuario.UsuarioID, obj.Codigo);

                EnviarEmail(email, obj.Codigo,usuario.UsuarioID,idRecu);

            }catch (Exception)
            {

            }
        }
        
    }
    private void MostrarError()
    {
        MsgError.Text = "El correo no esta registrado";
        MsgError.Visible = true;
    }

    public void EnviarEmail(string email, string codigo,int UsuarioId, int IdRec) {
        string correo = ConfigurationManager.AppSettings["correoElectronico"].ToString();
        string password = ConfigurationManager.AppSettings["contraseñaCorreo"].ToString();
        
        System.Diagnostics.Debug.WriteLine("Correo From: "+correo);
        System.Diagnostics.Debug.WriteLine("Correo From: " + password);
        System.Diagnostics.Debug.WriteLine("cleinte to: " + email);
        System.Diagnostics.Debug.WriteLine("codigo to: " + codigo);

         
        string body = "<html>";
        body = body + "<head>";
        body = body + "<title></title>";
        body = body + "</head>";
        body = body + "<body>";
        body = body + "<div class=\"text -center\" style=\"font-size:18px;margin-right: auto; margin-left:auto; width: 400px;border: 3px solid #9D00AE; background-color: white; margin-top: 50px;\">";
        body = body + "<h3 style = \"text -align: center; font-family:Calibri; font-size:15px; margin-top: 0px;margin-bottom: 5px;\" > <strong> Su nueva contraseña esta aqui: </strong></h3>";
        body = body + "<h6 style = \"margin -left:5px;margin-right:5px; font-family:Calibri; font-size:15px; margin-top: 0px;margin-bottom: 5px;\" > Gracias por solicitar su servicio de<Strong> Recuperación de Contraseña</Strong> enseguida estara el link para que pueda personalizar nuevamente su contraseña:</h6>";
        body = body + "<h6 style = \"margin -left:5px;margin-right:5px; font-family:Calibri; font-size:15px; margin-top: 0px;margin-bottom: 5px; font-size: 10px;\" > Copie este codigo en el enlace de abajo:" + codigo + "</h6>";
        body = body + "<div style = \"text -align: center; margin-bottom: 5px;\" >";
        body = body + "<a style= \"padding-left:20px;align -content: center; font-family:Calibri; font-size:15px; text-decoration: none;\" href= \"http://"+ Request.Url.Host + ":" + Request.Url.Port+"/Login/CodigoRecuperacion.aspx?IdUser=" + UsuarioId+"\">   Enlace Aquí</a>";
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
            mail.Subject = "Recuperación de Contraseña";
            mail.IsBodyHtml = true;
            mail.Body = body;
            SmtpServer.Port = 587;
            SmtpServer.Credentials = new System.Net.NetworkCredential(correo, password);
            SmtpServer.EnableSsl = true;
            SmtpServer.Send(mail);
            System.Diagnostics.Debug.WriteLine("Mensaje enviado");
            Response.Redirect("../Home.aspx");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Mensaje error: "+ex.ToString());
        }
        
    }
}