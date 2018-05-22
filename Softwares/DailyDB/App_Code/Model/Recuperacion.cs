using System;
namespace DailyDB.App_Code.Model
{
    /// <summary>
    /// Summary description for Recuperacion
    /// </summary>
    public class Recuperacion
    {
        public Recuperacion()
        {

        }
        public int ResuperacionId { get; set; }
        public string Codigo { get; set; }
        public DateTime HoraInicio { get; set; }
        public DateTime HorarioFin { get; set; }
        public int UsuarioId { get; set; }
        public string Estado { get; set; }
    }
}