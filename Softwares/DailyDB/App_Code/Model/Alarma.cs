using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DailyDB.App_Code.Model
{
    class Alarma
    {
        public int AlarmaId { get; set; }
        public string Codigo { get; set; }
        public string Estado { get; set; }
        public string Alerta { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public int UsuarioID { get; set; }
        public string Contrasena { get; set; }
    }
}
