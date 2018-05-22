using System;

namespace DailyDB.App_Code.Model
{
    /// <summary>
    /// Summary description for Verificacion
    /// </summary>
    public class Verificacion
    {
        public Verificacion()
        {
        }

        public int VerificacionId { get; set; }
        public String CodigoVerificacion { get; set; }
        public DateTime HorarioInicio { get; set; }
        public DateTime HorarioFin { get; set; }
        public int UsuarioId { get; set; }
        public Boolean Estado { get; set; }

    }
}