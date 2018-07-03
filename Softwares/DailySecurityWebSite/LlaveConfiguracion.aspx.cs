using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DailyDB.App_Code.BRL;
using DailyDB.App_Code.Model;

public partial class LlaveConfiguracion : System.Web.UI.Page
{
    int user = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario usuario = (Usuario)Session["USUARIO"];
        user = usuario.UsuarioID;
        List<DailyDB.App_Code.Model.Alarma> alarmas = AlarmaBRL.GetAlarmaByIdUsuario(user);

        List<DailyDB.App_Code.Model.Llave> llave = LlaveBRL.GetLlavesPorAlarma(alarmas[0].AlarmaId);
        GridLlavesObtenidas.DataSource = llave;
        GridLlavesObtenidas.DataBind();



    }

    protected void GridLlavesObtenidas_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int llaveid = 0;
        try
        {
            llaveid = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {

        }
        if (llaveid <= 0)
        {
            return;
        }
        if (e.CommandName== "EditarLlave")
        {
            Response.Redirect("Formularios/FormularioLlave.aspx?Id=" + llaveid.ToString());
        }
        else if (e.CommandName == "EliminarLlave")
        {
            LlaveBRL.DeleteLlave(llaveid);
        }

    }
}