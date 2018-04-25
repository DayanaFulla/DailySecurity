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
            Response.Write("<script language=javascript>alert('Sin Usuario');window.location.href = \"http://localhost:"+puerto+"/Home.aspx\";</script>");
            return;
        }

        

    }

    protected void VerificarExistencia(object sender, EventArgs e)
    {

        Model.Verificacion ver = VerificacionBRL.GetVerificacionByCodigo(codigo);

        if (ver == null)
        {
            System.Diagnostics.Debug.WriteLine("Esto" + codigo);
            Response.Write("<script language=javascript>alert('No existe');window.location.href = \"http://localhost:" + puerto + "/Home.aspx\";</script>");
            return;
        }
        int comparacion = DateTime.Compare(ver.HorarioFin, DateTime.Now);

        if (!ver.Estado == false || comparacion <= 0)
        {

            VerificacionBRL.DeleteVerificacion(ver.UsuarioId, ver.VerificacionId);
            UsuarioBRL.DeleteUsuario(ver.UsuarioId);
            Response.Write("<script language=javascript>alert('Vuelva a solicitar el servicio'); window.location.href = \"http://localhost:" + puerto + "/VerificarWS.aspx\";</script>");
            return;
        }
        
        VerificacionBRL.DeleteVerificacion(ver.UsuarioId, ver.VerificacionId);
        UsuarioBRL.UpdateEstado(ver.UsuarioId);
        //Response.Write("<script language=javascript>alert('Bienvenido');window.location.href = \"http://localhost:" + puerto + "/Home.aspx\";</script>");
    }

    protected void Redireccionar_click(object sender, EventArgs e)
    {
        Response.Write("<script language=javascript>alert('Bienvenido');window.location.href = \"http://localhost:" + puerto + "/Home.aspx\";</script>");
    }


    }