using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DailyDB.App_Code.Model;
using DailyDB.App_Code.BRL;

namespace Servicios.Controllers
{
    [RoutePrefix("api/Usuario")]
    public class UsuarioController : ApiController
    {
        [HttpGet]
        [Route("GetUsuarios")]
        public HttpResponseMessage GetUsuarios()
        {
            HttpResponseMessage msg = null;
            try
            {
                List<Usuario> users = UsuarioBRL.getUsuarios();
                if (users == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "0");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, users);
                }
            }
            catch (Exception en)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "0" + en);
                return msg;
            }
            return msg;
        }
        
        [HttpGet]
        [Route("GetUsuario/{usuarioid}")]
        public HttpResponseMessage GetUsuario(string usuarioid)
        {
            HttpResponseMessage msg = null;
            try
            {
                Usuario usr = UsuarioBRL.GetUsuarioById(Int32.Parse(usuarioid));

                if (usr == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Problemas por este lado");
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.OK, usr);
                }
            }
            catch (Exception en)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, " problema aqui" + en);
                return msg;
            }
            return msg;
        }

        [HttpPost]
        [Route("Login")]
        public HttpResponseMessage Login([FromBody]Usuario usuario)
        {
            HttpResponseMessage msg = null;
            Usuario usr = UsuarioBRL.GetUsuarioByEmail(usuario.Correo);
            System.Diagnostics.Debug.WriteLine("Esta cont usuario" + usuario.Correo);
            System.Diagnostics.Debug.WriteLine("Esta cont usr" + usr.Correo);
            if (usr == null)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "NULL");
            }
            if(usr.Contrasena == usuario.Contrasena)
            {
                if (usr.EstadoEspera)
                {
                    msg = Request.CreateResponse<string>(HttpStatusCode.OK, usr.UsuarioID.ToString());
                }
                else
                {
                    msg = Request.CreateResponse<string>(HttpStatusCode.OK, "VERIFICACION");
                }

            }
            else
            {
                msg = Request.CreateResponse(HttpStatusCode.OK, "NOTFOUND");
            }
            
            return msg;
        }
    }
}
