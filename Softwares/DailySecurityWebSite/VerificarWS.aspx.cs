using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Verificacion : System.Web.UI.Page
{
    String codigo = "";
    string puerto = ConfigurationManager.AppSettings["puerto"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        codigo = Convert.ToString(Request.QueryString["codigo"]);
        System.Diagnostics.Debug.WriteLine("Entro Primero: " + codigo);
        
        if (string.IsNullOrEmpty(codigo))
        {
            Response.Write("<script language=javascript>alert('Sin Usuario');window.location.href = \"http://localhost:"+puerto+"/Login/Login.aspx\";</script>");
            return;
        }
        VerificarExistencia(codigo);
  }

    protected void VerificarExistencia(String codigo)
    {
        Model.Verificacion ver = VerificacionBRL.GetVerificacionByCodigo(codigo);
        if (ver == null)
        {
            System.Diagnostics.Debug.WriteLine("Esto" + codigo);
            Response.Write("<script language=javascript>alert('Codigo invalido o No existe');window.location.href = \"http://localhost:" + puerto + "/Login/Login.aspx\";</script>");
        }
        int comparacion = DateTime.Compare(ver.HorarioFin, DateTime.Now);

        if (ver.Estado == true || comparacion <= 0)
        {

            VerificacionBRL.UpdateVerificacion(ver.UsuarioId, ver.VerificacionId, false);
            UsuarioBRL.UpdateEstado(ver.UsuarioId);
            return;
        }
        else
        {
            Response.Write("<script language=javascript>alert('Codigo invalido, Vuelva a solicitar el servicio'); window.location.href = \"http://localhost:" + puerto + "/Login/Login.aspx\";</script>");

        }
     
    }

    protected void Redireccionar_click(object sender, EventArgs e)
    {
        Response.Redirect("/Login/Login.aspx");
    }


    }