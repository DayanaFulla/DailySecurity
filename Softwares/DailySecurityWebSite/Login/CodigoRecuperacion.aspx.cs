using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DailyDB.App_Code.BRL;
using DailyDB.App_Code.Model;

public partial class Login_CodigoRecuperacion : System.Web.UI.Page
{
    string idUser = "";
    string puerto = ConfigurationManager.AppSettings["puerto"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        idUser = Convert.ToString(Request.QueryString["IdUser"]);
        DivCambio.Visible = false;
        if (string.IsNullOrEmpty(idUser))
        {
            Response.Write("<script language=javascript>alert('Sin Usuario');window.location.href = \"http://localhost:" + puerto + "/Home.aspx\";</script>");
            return;
        }


    }
    protected void VerificarExistencia(object sender, EventArgs e)
    {
        int UserID = Int32.Parse(idUser);
        Usuario user = UsuarioBRL.GetUsuarioById(UserID);
        string codigo = TxtCodigo.Text;
        System.Diagnostics.Debug.WriteLine("Esto es lo que envio en codigo: " + codigo);
        Recuperacion recup = RecuperacionBRL.GetRecupByIdUserAndCodigo(UserID, codigo);

        if (recup == null)
        {
            System.Diagnostics.Debug.WriteLine("Esto" + codigo);
            Response.Write("<script language=javascript>alert('No existe');window.location.href = \"http://localhost:" + puerto + "/Home.aspx\";</script>");
            return;
        }
        int comparacion = DateTime.Compare(recup.HorarioFin, DateTime.Now);

        if (!recup.Estado.Equals("P") || comparacion <= 0)
        {
            RecuperacionBRL.DeleteRecuperacion(recup.ResuperacionId);
            Response.Write("<script language=javascript>alert('Vuelva a solicitar el servicio'); window.location.href = \"http://localhost:" + puerto + "/Login/Recuperar.aspx\";</script>");
            return;
        }
        RecuperacionBRL.DeleteRecuperacion(recup.ResuperacionId);
        DivVerificacion.Visible = false;
        DivCambio.Visible = true;
        //Response.Redirect("~/Home.aspx");
    }

    protected void CambiarContraseña(object sender, EventArgs e)
    {
        int UserID = Int32.Parse(idUser);
        String NewPasswo = TxtNewPassword.Text;
        String SamePasswo = TxtSamePassword.Text;

        if (NewPasswo.Equals(SamePasswo))
        {   
            UsuarioBRL.UpdateUsuarioPassword(UserID, NewPasswo);
            btnConfirmar.Attributes["onclick"] = "alert('Cambio Exitoso'); window.location.href = \"~/Login.aspx\";";
        }
        else
        {
            btnConfirmar.Attributes["onclick"] = "alert('Los campos deben ser los mismos'); return false ;";
        }
        Response.Redirect("~/Home.aspx");
    }
}