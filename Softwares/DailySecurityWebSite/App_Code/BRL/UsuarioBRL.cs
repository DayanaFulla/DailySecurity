using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UsuarioBRL
/// </summary>
public class UsuarioBRL
{
    public UsuarioBRL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static Usuario GetUsuarioById(int Id)
    {
        if (Id <= 0)
            throw new ArgumentException("Id con valor invalido");

        UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new UsuarioDSTableAdapters.UsuarioTableAdapter();
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
            Contrasena = row.Contraseña
        };
    }

    public static Usuario GetUsuarioByEmail(string email)
    {
        if (string.IsNullOrEmpty(email))
            throw new ArgumentException("Email no es valido");

        UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new UsuarioDSTableAdapters.UsuarioTableAdapter();
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

        System.Diagnostics.Debug.WriteLine("En Update estos datos: "+Id +" - "+contraseña);
        string encriptada = EncriptarClass.Encriptar(contraseña);
        UsuarioDSTableAdapters.UsuarioTableAdapter adapter = new UsuarioDSTableAdapters.UsuarioTableAdapter();
        adapter.UpdateUsuarioPassword(Id, encriptada);
    }
        
}