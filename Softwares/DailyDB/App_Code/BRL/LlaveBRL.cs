using DailyDB.App_Code.DAL;
using DailyDB.App_Code.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DailyDB.App_Code.BRL
{
    public class LlaveBRL
    {
        private static Llave GetLlaveFromRow(LlaveDS.LlaveRow row)
        {
            Llave llave = new Llave();
            llave.LlaveId = row.LlaveId;
            llave.Codigo = row.Codigo;
            llave.Estado = row.Estado;
            llave.Nick = row.IsNickNull() ? "" : row.Nick;
            llave.AlarmaId = row.AlarmaId;
            llave.Tipo = row.Tipo == null ? "T" : row.Tipo;
            llave.ActHora = row.IsActHoraNull() ? 0 : row.ActHora;
            llave.ActDias = row.IsActDiasNull() ? 0 : row.ActDias;
            // Estado: 0 = desactivado ; 1 = activado ; 2 = cancelado ;
            // Tipo: T = temporal ; P = permanente ;
            if (llave.Tipo.Equals("P") )
            {
                if (llave.ActHora == 1)
                {
                    llave.HoraInicio = row.IsHoraInicioNull() ? TimeSpan.MinValue : row.HoraInicio;
                    llave.HoraFin = row.IsHoraFinNull() ? TimeSpan.MaxValue : row.HoraFin;

                }
                if (llave.ActDias == 1)
                {
                    llave.Dias = row.IsDiasNull() ? "" : row.Dias;
                }
            }
            if (llave.Tipo.Equals("T") )
            {
                if (llave.ActHora == 1)
                {
                    llave.HoraInicio = row.IsHoraInicioNull() ? TimeSpan.MinValue : row.HoraInicio;
                    llave.HoraFin = row.IsHoraFinNull() ? TimeSpan.MaxValue : row.HoraFin;

                }
                if (llave.ActDias == 1)
                {
                    llave.Dias = row.IsDiasNull() ? "" : row.Dias;
                }
                llave.FechaInicio = row.IsFechaInicioNull() ? DateTime.MinValue : row.FechaInicio;
                llave.FechaFin = row.IsFechaFinNull() ? DateTime.MinValue : row.FechaFin;
                
            }

            if(llave.Estado == 1 || llave.Estado == 2)
            {
                llave.Nombre = row.IsNombreNull() ? "" : row.Nombre;
                llave.UsuarioId = row.IsUsuarioIdNull() ? 0 : row.UsuarioId;
            }
            return llave;
        }
        public static void InsertarLlave(Llave llave)
        {
            int? llaveId = 0;
            if (llave == null)
                throw new ArgumentException("Llave Vacia");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            if (llave.Tipo.Equals("T"))
                adapter.InsertLlaveTemporal(llave.Codigo, llave.Estado, llave.Tipo, llave.Nick, llave.HoraInicio, llave.HoraFin, llave.FechaInicio, llave.FechaFin, llave.AlarmaId, llave.Dias, llave.ActHora, llave.ActDias, ref llaveId);
            else
                adapter.Insert(llave.Codigo, llave.Estado, llave.Tipo, llave.Nick, llave.AlarmaId, llave.HoraInicio, llave.HoraFin, llave.Dias, llave.ActHora, llave.ActDias, ref llaveId);
        }

        public static List<Llave> GetLlavesPropias(int UsuarioID)
        {

            if (UsuarioID <= 0)
                throw new ArgumentException("Valores no validos llaves propias");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            LlaveDS.LlaveDataTable table = adapter.GetLlavesPropietario(UsuarioID);

            List<Llave> llaves = new List<Llave>();
            foreach (LlaveDS.LlaveRow row in table)
            {
                Llave llave = GetLlaveFromRow(row);
                llaves.Add(llave);
            }
            return llaves;
        }

        public static List<Llave> GetLlavesPrestadas(int AlarmaId, int UsuarioID)
        {
            if (UsuarioID <= 0 || AlarmaId <= 0)
                throw new ArgumentException("Valores no validos llaves prestadas");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            LlaveDS.LlaveDataTable table = adapter.GetLlavesPrestadas(AlarmaId, UsuarioID);

            List<Llave> llaves = new List<Llave>();
            foreach (LlaveDS.LlaveRow row in table)
            {
                Llave llave = GetLlaveFromRow(row);
                llaves.Add(llave);
            }
            return llaves;
        }

        public static List<Llave> GetLlavesPorAlarma(int AlarmaId)
        {
            if (AlarmaId <= 0)
                throw new ArgumentException("Valores no validos llaves prestadas");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            LlaveDS.LlaveDataTable table = adapter.GetLlavesPorAlarma(AlarmaId);

            List<Llave> llaves = new List<Llave>();
            foreach (LlaveDS.LlaveRow row in table)
            {
                Llave llave = GetLlaveFromRow(row);
                llaves.Add(llave);
            }
            return llaves;
        }


        public static List<Llave> GetLlavesObtenidas(int UsuarioID)
        {
            if (UsuarioID <= 0)
                throw new ArgumentException("Valores no validos llaves obtenidas");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            LlaveDS.LlaveDataTable table = adapter.GetLlavesObtenidas(UsuarioID);

            List<Llave> llaves = new List<Llave>();
            foreach (LlaveDS.LlaveRow row in table)
            {
                Llave llave = GetLlaveFromRow(row);
                llaves.Add(llave);
            }
            return llaves;
        }

        public static Llave GetLlaveByCodigo(string Codigo)
        {
            if (string.IsNullOrEmpty(Codigo))
                throw new ArgumentException("Valores no validos Llave por Codigo");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            LlaveDS.LlaveDataTable table = adapter.GetLlaveByCodigo(Codigo);
            if (table.Rows.Count == 0)
                return null;

            Llave llave = GetLlaveFromRow(table[0]);
            return llave;
        }

        public static Llave GetLlaveByLlaveId(int LlaveId)
        {
            if (LlaveId <= 0)
                throw new ArgumentException("Valores no validos Llave por llaveId");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            LlaveDS.LlaveDataTable table = adapter.GetLlaveByLlaveId(LlaveId);
            if (table.Rows.Count == 0)
                return null;

            Llave llave = GetLlaveFromRow(table[0]);
            return llave;
        }

        public static bool ConfirmaRecibido(Llave llave)
        {
            if (llave == null)
                throw new ArgumentException("Valores no validos confirmado Recibido");

            bool existe = false;
            List<Llave> llaves = GetLlavesObtenidas(llave.UsuarioId);
            Alarma alarma = AlarmaBRL.GetAlarmaByID(llave.AlarmaId);
            if (llave.UsuarioId == alarma.UsuarioID)
            {
                existe = true;
            }
            else
            {
                foreach (var key in llaves)
                {
                    if (llave.AlarmaId == key.AlarmaId)
                    {
                        existe = true;
                    }
                }
            }
                      

            if (!existe)
            {
                DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
                adapter.UpdateConfirmarRecibido(llave.UsuarioId, llave.Nombre, llave.Codigo);
                return true;
            }
            else
            {
                return false;
            }
            
        }

        public static void UpdateLlave(Llave llave)
        {
            if (llave == null)
                throw new ArgumentException("Valores no validos confirmado Recibido");
            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            adapter.Update(llave.Nick, llave.Estado, llave.Tipo, llave.HoraInicio, llave.HoraFin, llave.FechaInicio, llave.FechaFin, llave.Dias, llave.Nombre, llave.ActHora, llave.ActDias, llave.LlaveId);
        }

        public static void DeleteLlave(int idLlave)
        {
            if (idLlave <= 0)
                throw new ArgumentException("Id de la llave es nula");

            DAL.LlaveDSTableAdapters.LlaveTableAdapter adapter = new DAL.LlaveDSTableAdapters.LlaveTableAdapter();
            adapter.Delete(idLlave);
        }
    }
}
