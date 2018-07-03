using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DailyDB.App_Code.BRL;
using DailyDB.App_Code.Model;

public partial class Formularios_FormularioLlave : System.Web.UI.Page
{
    int id;
    protected void Page_Load(object sender, EventArgs e)
    {
        String strId = Request.Params["Id"];
        id = 0;
        try
        {
            id = Convert.ToInt32(strId);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Hubo un error en el Actualizar')", true);
            return;
        }
        if (id <= 0)
        {
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Hubo un error en el Actualizar')", true);
            return;
        }
        
        
        
    }


    protected void RegistrarLlave_Click(object sender, EventArgs e)
    {
        Usuario usuario = (Usuario)Session["USUARIO"];
        int user=0;
        if (usuario == null)
        {
            Response.Redirect("../LlaveConfiguracion.aspx");
        }
        else
        {
            user = usuario.UsuarioID;
        }


        bool permanente = RadioButtonList1.Items[0].Selected;
        bool temporal = RadioButtonList1.Items[1].Selected;
        string nick1 = txtNick.Text;
        string fechaInicio = FechaInicioc.Value;
        string fechaFin = FechaFinc.Value;

        if (permanente==false && temporal==false)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Debe seleccionar alguna opción de tipo de llave')", true);
            return;
        }
        if (string.IsNullOrEmpty(nick1))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Debe ingresar el Nick')", true);
            return;
        }
        if (string.IsNullOrEmpty(fechaInicio))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Debe ingresar el Nick')", true);
            return;
        }


        String cod = Guid.NewGuid().ToString().Substring(0, 10);
        List<Alarma> alarma = AlarmaBRL.GetAlarmaByIdUsuario(user);


        //Horario Inicio
        TimeSpan ts = TimeSpan.Parse(horaInicio.Value);
        
        //Horario Fin
        TimeSpan ts2 = TimeSpan.Parse(horaFin.Value);

        Llave llave = new Llave();

        if (permanente)
        {
            llave.Tipo = "P";
            llave.AlarmaId = alarma[0].AlarmaId;
            llave.Codigo = cod;
            llave.Nick = nick1;
            llave.FechaInicio = DateTime.Parse(fechaInicio);
            llave.FechaFin = DateTime.Parse(fechaFin);
            llave.HoraInicio = ts;
            llave.HoraFin = ts2;
            llave.ActHora = 1;
            llave.Estado = 1;
        }

        if (temporal)
        {
            llave.Tipo = "T";
            llave.Nombre = "Temporal";
            llave.AlarmaId = alarma[0].AlarmaId;
            llave.Codigo = cod;
            llave.Nick = nick1;
            llave.FechaInicio = DateTime.Parse(fechaInicio);
            llave.FechaFin = DateTime.Parse(fechaFin);
            llave.HoraInicio = ts;
            llave.HoraFin = ts2;
            llave.ActHora = 1;
            llave.ActDias = 1;
            llave.Estado = 1;
        }

        if (id == 0)
        {
            LlaveBRL.InsertarLlave(llave);
            Response.Redirect("~/LlaveConfiguracion.aspx");
        }else
        {
            llave.LlaveId = id;
            LlaveBRL.UpdateLlave(llave);
            Response.Redirect("~/LlaveConfiguracion.aspx");
        }


    }
}