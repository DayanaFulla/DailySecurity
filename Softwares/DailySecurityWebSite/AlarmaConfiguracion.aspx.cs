using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DailyDB.App_Code.BRL;
using DailyDB.App_Code.Model;
using System.Web.UI.WebControls;

public partial class Alarma : System.Web.UI.Page
{
    int user = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario usuario = (Usuario)Session["USUARIO"];
        user = usuario.UsuarioID;
        if (AlarmaBRL.GetAlarmaByIdUsuario(user) != null)
        { 
            List<DailyDB.App_Code.Model.Alarma> alarmas = AlarmaBRL.GetAlarmaByIdUsuario(user);
            GridAlarma.DataSource = alarmas;
            GridAlarma.DataBind();

        }
        
    }

    protected void GridAlarma_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int alarmaId2 = 0;
        try
        {
            alarmaId2 = Convert.ToInt32(e.CommandArgument);
        }
        catch(Exception ex)
        {

        }
        if (alarmaId2 <= 0)
        {
            return;
        }
        if (e.CommandName=="EditarAlarma")
        {
            Response.Redirect("Formularios/FormularioAlarma.aspx?Id="+ alarmaId2.ToString());
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Editar')", true);
        }
        if (e.CommandName == "EliminarAlarma")
        {
            DailyDB.App_Code.Model.Alarma alarma2 = AlarmaBRL.GetAlarmaByID(alarmaId2);
            alarma2.UsuarioID = 0;
            alarma2.Latitud = "";
            alarma2.Longitud = "";
            alarma2.Nombre = "";
            alarma2.Contrasena = "";
            alarma2.Alerta = 0;
            AlarmaBRL.UpdateAlarma(alarma2);
            Response.Redirect("AlarmaConfiguracion.aspx");
        }
    }
}