using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DailyDB.App_Code.BRL;
using DailyDB.App_Code.Model;

namespace Servicios.Controllers
{
    [RoutePrefix("api/Alarma")]
    public class AlarmaController : ApiController
    {
        [HttpGet]
        [Route("GetAlarmaByCodigo/{Codigo}")]
        public HttpResponseMessage GetAlarmaById(string Codigo)
        {
            HttpResponseMessage msg = null;
            try
            {
                Alarma alarm = AlarmaBRL.GetAlarmaByCodigo(Codigo);
                if (alarm == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, alarm);
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
                return msg;
            }
            
            return msg;
        }

        [HttpGet]
        [Route("GetAlarmaByUsuario/{UsuarioID}")]
        public HttpResponseMessage GetAlarmaByUsuario(string UsuarioID)
        {
            HttpResponseMessage msg = null;
            try
            {
                List<Alarma> alarmas = AlarmaBRL.GetAlarmaByIdUsuario(int.Parse(UsuarioID));
                if (alarmas == null || alarmas.Count <= 0)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, alarmas);
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
            }

            return msg;
        }

        [HttpPost]
        [Route("UpdateAlarma")]
        public HttpResponseMessage UpdateAlarma (
            [FromBody]Alarma alarma)
        {
            HttpResponseMessage msg = null;
            try
            {
                AlarmaBRL.UpdateAlarma(alarma);
                msg = Request.CreateResponse(HttpStatusCode.OK,"BIEN");
            }
            catch(Exception)
            {
                msg = Request.CreateResponse(HttpStatusCode.NotFound, "ERROR");
            }
            return msg;
        }

        [HttpGet]
        [Route("GetAlarmaById/{AlarmaID}")]
        public HttpResponseMessage GetAlarmaID(string AlarmaID)
        {
            HttpResponseMessage msg = null;
            try
            {
                Alarma alarma = AlarmaBRL.GetAlarmaByID(int.Parse(AlarmaID));
                if (alarma == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, alarma);
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
            }

            return msg;
        }

    }
}
