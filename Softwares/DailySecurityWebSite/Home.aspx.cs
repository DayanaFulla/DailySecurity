using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    private object messageError;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
        }
    }


    protected void loggear_Click(object sender, EventArgs e)
    {


        String correoActual = tbEmail.Text;
        String contraseñaActual = tbContrasena.Text;

        if (String.IsNullOrWhiteSpace(correoActual) || String.IsNullOrWhiteSpace(contraseñaActual))
        {

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo del correo o contraseña no debe estar vacio')", true);
        }
        else
        {
            DailyDB.App_Code.Model.Usuario userActual = DailyDB.App_Code.BRL.UsuarioBRL.GetUsuarioByEmail(correoActual);
            if (userActual != null)
            {
                String desEncriptada = userActual.Contrasena;
                System.Diagnostics.Debug.WriteLine("Esta es la contrseña: " + desEncriptada + " - este dentro" + contraseñaActual);
                if (desEncriptada.Equals(contraseñaActual))
                {
                    bool estadoEsperaUsuario = DailyDB.App_Code.BRL.UsuarioBRL.getEstadoEsperaUsuarioByID(userActual.UsuarioID);
                    bool existeVer = DailyDB.App_Code.BRL.VerificacionBRL.ExisteVerificacion(userActual.UsuarioID);
                    DailyDB.App_Code.Model.Verificacion ver = DailyDB.App_Code.BRL.VerificacionBRL.GetVerificacionByUsuarioId(userActual.UsuarioID);

                    if (userActual.EstadoEspera == true)
                    {  // 1 para entrar true , 0 salta false
                        Session["USUARIO"] = userActual;
                        Response.Redirect("~/Desktop.aspx");
                    }
                    else
                    {//si el estado de cuenta esta false
                        if (existeVer == false)
                        {
                            Enviar(correoActual);
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error 2.0," +
                              "Revise su correo por favor!')", true);
                            Response.Redirect("~/Login/login.aspx");
                        }
                    }
                }
                else
                { // la contraseña escrita no coincide con la guardad
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Datos Incorrectos')", true);
                }
            }
            else
            { // usuario null
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Datos Incorrectos')", true);

            }
        }


    }


    protected void Enviar(String email)
    {
        DailyDB.App_Code.Model.Usuario usuario = DailyDB.App_Code.BRL.UsuarioBRL.GetUsuarioByEmail(email);

        try
        {
            System.Diagnostics.Debug.WriteLine("Entro Primero");
            int idVerificacion = DailyDB.App_Code.BRL.VerificacionBRL.InsertVerificacion(usuario.Correo);

            DailyDB.App_Code.Model.Verificacion obj = DailyDB.App_Code.BRL.VerificacionBRL.GetVerificacionById(idVerificacion);
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
        body = body + "<a style= \"align -content: center; font-family:Calibri; font-size:15px; text-decoration: none;\" href= \"http://" + Request.Url.Host + ":" + Request.Url.Port + "/VerificarWS.aspx?codigo=" + codigo + "\">   Enlace Aquí</a>";
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