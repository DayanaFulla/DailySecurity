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
    [RoutePrefix("api/Llave")]
    public class LlaveController : ApiController
    {
        [HttpGet]
        [Route("GetLlaveByCodigo/{Codigo}")]
        public HttpResponseMessage GetLlaveByCodigo(string Codigo)
        {
            HttpResponseMessage msg = null;
            try
            {
                Llave llave = LlaveBRL.GetLlaveByCodigo(Codigo);
                if (llave == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, llave);
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
        [Route("GetLlaveByLlaveId/{LlaveId}")]
        public HttpResponseMessage GetLlaveByLlaveId(string LlaveId)
        {
            HttpResponseMessage msg = null;
            try
            {
                Llave llave = LlaveBRL.GetLlaveByLlaveId(Int32.Parse(LlaveId));
                if (llave == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, llave);
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
        [Route("GetLlavesPropias/{UsuarioID}")]
        public HttpResponseMessage GetLlavesPropias(string UsuarioID)
        {
            HttpResponseMessage msg = null;
            try
            {
                List<Llave> llaves = LlaveBRL.GetLlavesPropias(Int32.Parse(UsuarioID));
                if (llaves == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, llaves);
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
                return msg;
            }
            return msg;
        }


        [HttpPost]
        [Route("GetLlavesPrestadas")]
        public HttpResponseMessage GetLlavesPrestadas([FromBody]Llave llave)
        {
            HttpResponseMessage msg = null;
            try
            {

                List<Llave> llaves = LlaveBRL.GetLlavesPrestadas(llave.AlarmaId, llave.UsuarioId);
                if (llaves == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, llaves);
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
                return msg;
            }
            return msg;
        }


        [HttpPost]
        [Route("GetCantidadPrestadas")]
        public HttpResponseMessage GetCantidadPrestadas([FromBody]Llave llave)
        {
            HttpResponseMessage msg = null;
            try
            {

                List<Llave> llaves = LlaveBRL.GetLlavesPrestadas(llave.AlarmaId, llave.UsuarioId);
                if (llaves == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, llaves.Count);
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
        [Route("GetLlavesObtenidas/{UsuarioID}")]
        public HttpResponseMessage GetLlavesObtenidas(string UsuarioID)
        {
            HttpResponseMessage msg = null;
            try
            {
                List<Llave> llaves = LlaveBRL.GetLlavesObtenidas(Int32.Parse(UsuarioID));
                if (llaves == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, llaves);
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
                return msg;
            }
            return msg;
        }

        [HttpPost]
        [Route("InsertLlave")]
        public HttpResponseMessage InserLlave(Llave llave)
        {
            HttpResponseMessage msg = null;
            try
            {
                
                if (llave == null/*String.IsNullOrEmpty(Codigo) | String.IsNullOrEmpty(Estado) | String.IsNullOrEmpty(Tipo) | String.IsNullOrEmpty(Nick) | String.IsNullOrEmpty(AlarmaId)*/)
                {
                    
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {

                    LlaveBRL.InsertarLlave(llave);
                    msg = Request.CreateResponse(HttpStatusCode.OK, "OK");
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
                return msg;
            }
            return msg;
        }

        [HttpPost]
        [Route("UpdateConfirmar")]
        public HttpResponseMessage UpdateConfirmar([FromBody]Llave llave)
        {
            HttpResponseMessage msg = null;
            try
            {

                if (llave == null)
                {

                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    LlaveBRL.ConfirmaRecibido(llave);
                    msg = Request.CreateResponse(HttpStatusCode.OK, "OK");
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
                return msg;
            }
            return msg;
        }

        [HttpPost]
        [Route("Update")]
        public HttpResponseMessage Update([FromBody]Llave llave)
        {
            HttpResponseMessage msg = null;
            try
            {

                if (llave == null)
                {

                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NOTFOUND");
                }
                else
                {
                    LlaveBRL.UpdateLlave(llave);
                    msg = Request.CreateResponse(HttpStatusCode.OK, "OK");
                }
            }
            catch (Exception e)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "ERROR" + e);
                return msg;
            }
            return msg;
        }
    }
}
