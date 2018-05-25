using DailyDB.App_Code.DAL;
using DailyDB.App_Code.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DailyDB.App_Code.BRL
{
    class AlarmaBRL
    {
        private static Alarma GetAlarmaFromRow(AlarmaDS.AlarmaRow row)
        {
            return new Alarma()
            {
                AlarmaId = row.AlarmaId,
                Codigo = row.Codigo,
                Estado = row.Estado,
                Alerta = row.Alerta,
                Latitud = row.Latitud,
                Longitud = row.Longitud,
                UsuarioID = row.UsuarioID,
                Contrasena = row.Contrasena
            };
        }

        private static Alarma GetAlarmaByID(int idAlarma)
        {
            if (idAlarma <= 0 || idAlarma == null)
                throw new ArgumentException("Id de alarma es nula");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            AlarmaDS.AlarmaDataTable table = adapter.GetAlarmaById(idAlarma);
            if (table.Rows.Count == 0)
            {
                throw new ArgumentException("Vacio o tal vez no existe");
                return null;
            }

            Alarma alarma = GetAlarmaFromRow(table[0]);
            return alarma;

        }

        private static Alarma GetAlarmaByIdUsuarioById(int idUsuario,int idAlarma)
        {
            if (idAlarma <= 0 || idUsuario <= 0 || idUsuario == null || idAlarma == null)
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

        private static Alarma GetAlarmaByIdUsuario(int idUsuario)
        {
            if (idUsuario <= 0 || idUsuario == null )
                throw new ArgumentException("Id de usuario  o usuario es nula");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            AlarmaDS.AlarmaDataTable table = adapter.GetAlarmaByUsuarioId(idUsuario);
            if (table.Rows.Count == 0)
            {
                throw new ArgumentException("Vacio o tal vez no existe");
                return null;
            }

            Alarma alarma = GetAlarmaFromRow(table[0]);
            return alarma;
        }

        private static void DeleteAlarma(int idAlarma)
        {
            if (idAlarma <= 0 || idAlarma == null)
                throw new ArgumentException("Id de alarma  o usuario es nula");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            adapter.Delete(idAlarma);
        }

        private static void UpdateAlarma(Alarma alrm)
        {
            if (alrm == null)
                throw new ArgumentException("No hay Alarma");

            DAL.AlarmaDSTableAdapters.AlarmaTableAdapter adapter = new DAL.AlarmaDSTableAdapters.AlarmaTableAdapter();
            adapter.Update(alrm.AlarmaId, alrm.Estado, alrm.Alerta, alrm.Latitud, alrm.Longitud, alrm.Contrasena, alrm.UsuarioID);
        }

    }

}
