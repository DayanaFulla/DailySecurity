using System;

public partial class Verificacion : System.Web.UI.Page
{
    String codigo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        codigo = Convert.ToString(Request.QueryString["codigo"]);
        System.Diagnostics.Debug.WriteLine("Entro Primero: " + codigo);
        
        if (string.IsNullOrEmpty(codigo))
        {
            Response.Write("<script language=javascript>alert('Sin Usuario');window.location.href = \"~/Login/Login.aspx\";</script>");
            return;
        }
        VerificarExistencia(codigo);
  }

    protected void VerificarExistencia(String codigo)
    {
        DailyDB.App_Code.Model.Verificacion ver = DailyDB.App_Code.BRL.VerificacionBRL.GetVerificacionByCodigo(codigo);
        if (ver == null)
        {
            System.Diagnostics.Debug.WriteLine("Esto" + codigo);
            Response.Write("<script language=javascript>alert('Codigo invalido o No existe');window.location.href = \"~/Login/Login.aspx\";</script>");
        }
        int comparacion = DateTime.Compare(ver.HorarioFin, DateTime.Now);

        if (ver.Estado == true || comparacion <= 0)
        {

            DailyDB.App_Code.BRL.VerificacionBRL.UpdateVerificacion(ver.UsuarioId, ver.VerificacionId, false);
            DailyDB.App_Code.BRL.UsuarioBRL.UpdateEstado(ver.UsuarioId);
            return;
        }
        else
        {
            Response.Write("<script language=javascript>alert('Codigo invalido, Vuelva a solicitar el servicio'); window.location.href = \"~/Login/Login.aspx\";</script>");

        }
     
    }

    protected void Redireccionar_click(object sender, EventArgs e)
    {
        Response.Redirect("/Login/Login.aspx");
    }


    }