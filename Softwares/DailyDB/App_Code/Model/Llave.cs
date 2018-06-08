using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DailyDB.App_Code.Model
{
    public class Llave
    {
        public int LlaveId { get; set; }
        public string Codigo { get; set; }
        public int Estado { get; set; }
        public string Tipo { get; set; }
        public string Nick { get; set; }
        public int AlarmaId { get; set; }
        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFin { get; set; }
        public string Dias { get; set; }
        public int UsuarioId { get; set; }
        public string Nombre { get; set; }
    }
}
