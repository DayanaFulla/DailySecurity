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
        [Route("GetAlarmaById/{idAlarma}")]
        public HttpResponseMessage GetAlarmaById(string idAlarma)
        {
            HttpResponseMessage msg = null;
            try
            {
                Alarma alarm = AlarmaBRL.GetAlarmaByID(int.Parse(idAlarma));
                if (alarm == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "No existe");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, alarm);
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Un roblema para obtener alarma de Id" + e);
                return msg;
            }
            
            return msg;
        }

    }
}
