using DailyDB.App_Code.DAL;
using DailyDB.App_Code.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DailyDB.App_Code.BRL
{
    public class AlarmaBRL
    {
        private static Alarma GetAlarmaFromRow(AlarmaDS.AlarmaRow row)
        {
            Alarma alarma = new Alarma();
            alarma.AlarmaId = row.AlarmaId;
            alarma.Codigo = row.Codigo;
            alarma.Estado = row.Estado;
            if (alarma.Estado == 1)
            {
                alarma.Alerta = row.Alerta;
                alarma.Latitud = row.Latitud;
                alarma.Longitud = row.Longitud;
                alarma.UsuarioID = row.UsuarioId;
                alarma.Contrasena = row.Contrasena;
                alarma.Nombre = row.Nombre;
                return alarma;
            }
            return alarma;
        }

        public static Alarma GetAlarmaByID(int idAlarma)
        {
            if (idAlarma <= 0)
                throw new ArgumentException("Id de alarma es nula");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            AlarmaDS.AlarmaDataTable table = adapter.GetAlarmaById(idAlarma);
            if (table.Rows.Count == 0)
            {
                throw new ArgumentException("Vacio o tal vez no existe");
            }

            Alarma alarma = GetAlarmaFromRow(table[0]);
            return alarma;
        }

        public static Alarma GetAlarmaByIdUsuarioById(int idUsuario,int idAlarma)
        {
            if (idAlarma <= 0 || idUsuario <= 0 )
                throw new ArgumentException("Id de alarma  o usuario es nula");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            AlarmaDS.AlarmaDataTable table = adapter.GetAlarmaByAlarmaIdByUsuarioId(idUsuario,idAlarma);
            if (table.Rows.Count == 0)
            {
                throw new ArgumentException("Vacio o tal vez no existe");
                return null;
            }

            Alarma alarma = GetAlarmaFromRow(table[0]);
            return alarma;

        }

        public static List<Alarma> GetAlarmaByIdUsuario(int idUsuario)
        {
            if (idUsuario <= 0 )
                throw new ArgumentException("Id de usuario  o usuario es nula");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            AlarmaDS.AlarmaDataTable table = adapter.GetAlarmaByUsuarioId(idUsuario);

            List<Alarma> alarmas = new List<Alarma>();
            foreach (AlarmaDS.AlarmaRow row in table)
            {
                Alarma alarma = GetAlarmaFromRow(row);
                alarmas.Add(alarma);
            }
            return alarmas;
        }

        public static void DeleteAlarma(int idAlarma)
        {
            if (idAlarma <= 0)
                throw new ArgumentException("Id de alarma  o usuario es nula");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            adapter.Delete(idAlarma);
        }

        public static void UpdateAlarma(Alarma alrm)
        {
            if (alrm == null)
                throw new ArgumentException("No hay Alarma");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            adapter.Update(alrm.AlarmaId, alrm.Estado, alrm.Alerta, alrm.Latitud, alrm.Longitud, alrm.Contrasena, alrm.Nombre, alrm.UsuarioID);
        }

        public static Alarma GetAlarmaByCodigo(String codigo)
        {
            if (String.IsNullOrEmpty(codigo))
                throw new ArgumentException("Codigo Vacio");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            AlarmaDS.AlarmaDataTable table = adapter.GetAlarmaByCodigo(codigo);
            if (table.Rows.Count == 0)
            {
                throw new ArgumentException("Vacio o tal vez no existe");
            }

            Alarma alarma = GetAlarmaFromRow(table[0]);
            return alarma;
        }

    }

}
