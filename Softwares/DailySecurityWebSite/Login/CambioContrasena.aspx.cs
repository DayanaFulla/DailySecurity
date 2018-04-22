using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login_CambioContraseña : System.Web.UI.Page
{
    string IdRecuperacion = "";
    string IdUsuario = "";
    string Codigo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Codigo = Convert.ToString(Request.QueryString["Codigo"]);
        IdUsuario = Convert.ToString(Request.QueryString["IdUser"]);
        IdRecuperacion = Convert.ToString(Request.QueryString["IdRecu"]);

        if (string.IsNullOrEmpty(Codigo) || string.IsNullOrEmpty(IdUsuario) || string.IsNullOrEmpty(IdRecuperacion)) { 
            Response.Write("<script language=javascript>alert('No hay datos para Proceso');window.location.href = \"http://localhost:4667/Home.aspx\";</script>");
            return;
        }

        int idUser = Int32.Parse(IdUsuario);
        Usuario user = UsuarioBRL.GetUsuarioById(idUser);

        if (user == null)
        {
            MsgError.Text = "No existe el Usuario";
            MsgError.Visible = true;
            Response.Write("<script language=javascript>alert('No existe el Usuario');window.location.href = \"http://localhost:4667/Login/Login.aspx\";</script>");
        }
        int idRecup = Int32.Parse(IdRecuperacion);
        Recuperacion recup = RecuperacionBRL.GetRecuperacionById(idRecup);

        int comparacion = DateTime.Compare(recup.HorarioFin, DateTime.Now);

        if (recup == null)
        {
            Response.Write("<script language=javascript>alert('El Codigo a expirado');window.location.href = \"http://localhost:4667/Login/SignUp.aspx\";</script>");
        }
        if (!recup.Estado.Equals("P") || comparacion <= 0)
        {
            RecuperacionBRL.DeleteRecuperacion(idRecup);
            Response.Write("<script language=javascript>alert('Expiro su Codigo'); window.location.href = \"http://localhost:4667/Login/Login.aspx\";</script>");
        }

    }

    protected void CambiarContraseña(object sender, EventArgs e)
    {
        int idUser = Int32.Parse(IdUsuario);
        int idRecup = Int32.Parse(IdRecuperacion);
        String NewPasswo = TxtNewPassword.Text;
        String SamePasswo = TxtSamePassword.Text;

        if (NewPasswo.Equals(SamePasswo)){
            System.Diagnostics.Debug.WriteLine("Entro a Cambiar");
            UsuarioBRL.UpdateUsuarioPassword(idUser, NewPasswo);
            RecuperacionBRL.DeleteRecuperacion(idRecup);
            Server.Transfer("SignUp.aspx", true);
        }
        else{
            btnConfirmar.Attributes["onclick"] = "alert('Los campos deben ser los mismos'); return false ;";
        }
    }
}