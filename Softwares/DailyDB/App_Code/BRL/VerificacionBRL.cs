﻿using DailyDB.App_Code.DAL;
using DailyDB.App_Code.Model;
using System;
namespace DailyDB.App_Code.BRL
{
    /// <summary>
    /// Summary description for VerificacionBRL
    /// </summary>
    public class VerificacionBRL
    {
        public VerificacionBRL()
        {
        }

        public static int InsertarVerificacion(Verificacion obj)
        {
            int? VerificacionId = 0;
            if (obj == null)
            {
                throw new ArgumentException("El usuario no debe ser nulo");
            }


            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            adapter.Insert(obj.CodigoVerificacion, obj.HorarioInicio, obj.HorarioFin, obj.UsuarioId, obj.Estado, ref VerificacionId);
            if (VerificacionId == 0)
            {
                throw new ArgumentException("Error al insertar un nuevo usuario");
            }

            return VerificacionId.Value;
        }

        public static Verificacion GetVerificacionByUsuarioId(int UsuarioId)
        {
            if (UsuarioId <= 0)
                throw new ArgumentException("Id con valor invalido");

            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            VerificacionDS.VERIFICACIONDataTable table = adapter.GetVerificacionByUsuarioId(UsuarioId);
            if (table.Rows.Count == 0)
                return null;

            Verificacion obj = GetVerificacionForRow(table[0]);

            return obj;
        }

        private static Verificacion GetVerificacionForRow(VerificacionDS.VERIFICACIONRow row)
        {
            return new Verificacion()
            {
                VerificacionId = row.VerificacionId,
                CodigoVerificacion = row.codigoVerificacion,
                HorarioInicio = row.HorarioInicio,
                HorarioFin = row.HorarioFin,
                UsuarioId = row.UsuarioId,
                Estado = row.Estado
            };
        }



        public static void UpdateVerificacion(int UsuarioId, int VerificacionId, Boolean estado)
        {
            if (UsuarioId <= 0 || VerificacionId <= 0)
                throw new ArgumentException("valores no validos");

            System.Diagnostics.Debug.WriteLine("En Update estos datos: " + UsuarioId + " - " + VerificacionId + " - " + estado);
            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            adapter.UpdateVerificacion(UsuarioId, VerificacionId, false);
        }

        public static void DeleteVerificacion(int UsuarioId, int VerificacionId)
        {
            if (UsuarioId <= 0 || VerificacionId <= 0)
                throw new ArgumentException("Valores no validos");

            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            adapter.Delete(UsuarioId, VerificacionId);
        }

        public static int InsertVerificacion(string email)
        {
            if (string.IsNullOrEmpty(email))
                throw new ArgumentException("valores no validos");

            DateTime HorarioInicio = DateTime.Now;
            Usuario usuario = UsuarioBRL.GetUsuarioByEmail(email);
            String codigo = GetCodigo();
            DateTime HorarioFin = HorarioInicio.AddHours(3);
            int? VerificacionId = null;


            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            adapter.Insert(codigo, HorarioInicio, HorarioFin, usuario.UsuarioID, true, ref VerificacionId);

            if (VerificacionId == null || VerificacionId.Value <= 0)
                throw new Exception("La llave primaria no se generó correctamente");

            return VerificacionId.Value;
        }

        public static Verificacion GetVerificacionById(int idVerificacion)
        {
            if (idVerificacion <= 0)
                throw new ArgumentException("Id con valor invalido");

            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            VerificacionDS.VERIFICACIONDataTable table = adapter.GetVerificacionById(idVerificacion);
            if (table.Rows.Count == 0)
                return null;

            Verificacion obj = GetVerificacionForRow(table[0]);

            return obj;
        }

        public static Verificacion GetVerificacionByVerificacionIdAndCodigo(int idVerificacion, String codigo)
        {
            if (idVerificacion <= 0)
                throw new ArgumentException("Id con valor invalido");

            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            VerificacionDS.VERIFICACIONDataTable table = adapter.GetVerificacionByUsuarioIdAndCodigo(idVerificacion, codigo);
            if (table.Rows.Count == 0)
                return null;

            Verificacion obj = GetVerificacionForRow(table[0]);

            return obj;
        }

        public static Verificacion GetVerificacionByCodigo(String codigo)
        {
            if (codigo == null)
                throw new ArgumentException("Id con valor invalido");

            DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter adapter = new DailyDB.App_Code.DAL.VerificacionDSTableAdapters.VERIFICACIONTableAdapter();
            VerificacionDS.VERIFICACIONDataTable table = adapter.GetVerificacionByCodigo(codigo);
            if (table.Rows.Count == 0)
                return null;

            Verificacion obj = GetVerificacionForRow(table[0]);

            return obj;
        }

        public static bool GetEstadoVerificacionByVerfificacionID(int verificacionId)
        {
            Verificacion obj = GetVerificacionById(verificacionId);
            return obj.Estado;
        }

        public static bool ExisteVerificacion(int usuarioID)
        {
            Verificacion verificacion = GetVerificacionByUsuarioId(usuarioID);
            if (verificacion != null)
                return true;
            return false;
        }

        private static String GetCodigo()
        {
            String palabra = "";
            char[] codigo = new char[] { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'ñ', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
            Random rnd = new Random();
            for (int i = 0; i < 8; i++)
            {
                palabra = palabra + codigo[rnd.Next(0, 53)];
            }
            return palabra;
        }





    }
}