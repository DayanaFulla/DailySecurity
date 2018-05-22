using DailyDB.App_Code.DAL;
using System;
using DailyDB.App_Code.Model;
namespace DailyDB.App_Code.BRL
{
    /// <summary>
    /// Summary description for UsuarioBRL
    /// </summary>
    public class UsuarioBRL
    {
        public UsuarioBRL()
        {
        }

        public static Usuario GetUsuarioById(int Id)
        {
            if (Id <= 0)
                throw new ArgumentException("Id con valor invalido");

            DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter();
            UsuarioDS.UsuarioDataTable table = adapter.GetUsuarioById(Id);
            if (table.Rows.Count == 0)
                return null;

            Usuario obj = GetUsuarioFromRow(table[0]);

            return obj;
        }

        private static Usuario GetUsuarioFromRow(UsuarioDS.UsuarioRow row)
        {
            return new Usuario()
            {
                UsuarioID = row.UsuarioId,
                Nombre = row.Nombre,
                Apellido = row.Apellido,
                Telefono = row.Telefono,
                Correo = row.Correo,
                Contrasena = row.Contraseña,
                EstadoEspera = row.EstadoEspera,
                EstadoCuenta = row.EstadoCuenta
            };
        }

        public static Usuario GetUsuarioByEmail(string email)
        {
            if (string.IsNullOrEmpty(email))
                throw new ArgumentException("Email no es valido");

            DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter();
            UsuarioDS.UsuarioDataTable table = adapter.GetUsuarioByEmail(email);
            if (table.Rows.Count == 0)
                return null;

            Usuario obj = GetUsuarioFromRow(table[0]);

            return obj;
        }

        public static void UpdateUsuarioPassword(int Id, string contraseña)
        {
            if (Id <= 0 || string.IsNullOrEmpty(contraseña))
                throw new ArgumentException("valores no validos");

            System.Diagnostics.Debug.WriteLine("En Update estos datos: " + Id + " - " + contraseña);
            string encriptada = EncriptarClass.Encriptar(contraseña);
            DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter();
            adapter.UpdateUsuarioPassword(Id, encriptada);
        }

        public static void UpdateEstado(int UsuarioId)
        {
            if (UsuarioId <= 0)
                throw new ArgumentException("valores no validos");


            DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter();
            adapter.UpdateEstadoEsperaUsuario(UsuarioId);
        }


        public static String EncriptarPassword(string contraseña)
        {
            if (string.IsNullOrEmpty(contraseña))
                throw new ArgumentException("Valor no válido");

            string encriptada = EncriptarClass.Encriptar(contraseña);
            return encriptada;
        }

        public static String DesEncriptarPassword(string contraseña)
        {
            if (string.IsNullOrEmpty(contraseña))
                throw new ArgumentException("Valor no válido");

            string desEncriptada = EncriptarClass.Desencriptar(contraseña);
            return desEncriptada;
        }

        public static int InsertarUsuario(Usuario obj)
        {
            int? idUsuario = 0;
            if (obj == null)
            {
                throw new ArgumentException("El usuario no debe ser nulo");
            }

            DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter();
            adapter.Insert(obj.Nombre, obj.Apellido, obj.Telefono, obj.Correo, obj.Contrasena, ref idUsuario);
            if (idUsuario == 0)
            {
                throw new ArgumentException("Error al insertar un nuevo usuario");
            }

            return idUsuario.Value;
        }

        public static void DeleteUsuario(int UsuarioId)
        {
            if (UsuarioId <= 0)
                throw new ArgumentException("Valores no validos");

            DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new DailyDB.App_Code.DAL.UsuarioDSTableAdapters.UsuarioTableAdapter();
            adapter.Delete(UsuarioId);
        }

        public static bool getEstadoEsperaUsuarioByID(int userID)
        {

            if (userID <= 0)
            {
                throw new ArgumentException("Valores no validos");

            }

            Usuario user = GetUsuarioById(userID);
            return user.EstadoEspera;
        }

    }
}