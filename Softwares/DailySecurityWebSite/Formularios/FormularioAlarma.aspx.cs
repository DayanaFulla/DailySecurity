using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DailyDB.App_Code.BRL;
using DailyDB.App_Code.Model;

public partial class Alarma_FormularioAlarma : System.Web.UI.Page
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
        if (id<=0)
        {
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Hubo un error en el Actualizar')", true);
            return;
        }
    }

    

    protected void registrarAlarma(object sender, EventArgs e)
    {
        String codigoAlarma = fcodigoAlarma.Text.Trim();
        String nombreAlarma = fnombreAlarma.Text.Trim();
        String contrasenaAlarma = fcontrasenaAlarma.Text.Trim();
        Usuario user = (Usuario)Session["USUARIO"];
        int usuario = user.UsuarioID;
        
        if (string.IsNullOrEmpty(codigoAlarma))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo del código de Alarma no debe quedar vacío')", true);
            return;
        }

        if (string.IsNullOrEmpty(nombreAlarma))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo del nombre de la Alarma no puede quedar vacío')", true);
            return;
        }

        if (string.IsNullOrEmpty(contrasenaAlarma))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo de la contraseña de la Alarma no puede quedar vacío')", true);
            return;
        }
       

        string AL_latitud = latitudHidden.Value;
        string AL_longitud = longitudHidden.Value;

        if (string.IsNullOrEmpty(AL_latitud) || string.IsNullOrEmpty(AL_longitud))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error de Red, Asegurese de que el equipo tenga Conexión a INTERNET')", true);
            return;
        }


        
        if (id==0)
        {
            Alarma alarma = AlarmaBRL.GetAlarmaByCodigo(codigoAlarma);

            if (alarma != null && alarma.UsuarioID == -1)
            {
                alarma.Alerta = 0;
                alarma.UsuarioID = usuario;
                alarma.Nombre = nombreAlarma;
                alarma.Contrasena = contrasenaAlarma;
                alarma.Latitud = AL_latitud;
                alarma.Longitud = AL_longitud;
                AlarmaBRL.UpdateAlarma(alarma);
                Llave llave = new Llave();
                llave.Codigo=contrasenaAlarma;
                llave.Estado = 1;
                llave.Tipo = "P";
                llave.Nick = "Propietario";
                llave.AlarmaId = alarma.AlarmaId;
                LlaveBRL.InsertarLlave(llave);
                Response.Redirect("~/AlarmaConfiguracion.aspx");
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El código de la alarma no es válido')", true);
                Response.Redirect("~/AlarmaConfiguracion.aspx");
            }

        }else
        {
            Alarma alarma2 = AlarmaBRL.GetAlarmaByID(id);
            if (alarma2 != null && alarma2.UsuarioID == usuario)
            {
                alarma2.Alerta = 0;
                alarma2.UsuarioID = usuario;
                alarma2.Nombre = nombreAlarma;
                alarma2.Contrasena = contrasenaAlarma;
                alarma2.Latitud = AL_latitud;
                alarma2.Longitud = AL_longitud;
                AlarmaBRL.UpdateAlarma(alarma2);
                Response.Redirect("~/AlarmaConfiguracion.aspx");
            }
        }

    


        
        

    }

}