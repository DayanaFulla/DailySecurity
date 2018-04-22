using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RecuperacionBRL
/// </summary>
public class RecuperacionBRL
{
    public RecuperacionBRL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static int InsertRecuperacion(string email)
    {
        if (string.IsNullOrEmpty(email))
            throw new ArgumentException("valores no validos");

        DateTime fechaAct = DateTime.Now;
        Usuario usuario = UsuarioBRL.GetUsuarioByEmail(email);
        String codigo = GetCodigo();
        DateTime fechaExp = fechaAct.AddHours(12);
        int? RecuperacionId = null;
        
        RecuperacionDSTableAdapters.RecuperacionTableAdapter adapter = new RecuperacionDSTableAdapters.RecuperacionTableAdapter();
        adapter.Insert(codigo,fechaAct,fechaExp,usuario.UsuarioID, ref RecuperacionId);

        if (RecuperacionId == null || RecuperacionId.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");

        return RecuperacionId.Value;
    }

    public static void DeleteRecuperacion(int RecupId)
    {
        if (RecupId <= 0)
            throw new ArgumentException("Id con valor invalido");

        RecuperacionDSTableAdapters.RecuperacionTableAdapter adapter = new RecuperacionDSTableAdapters.RecuperacionTableAdapter();
        adapter.Delete(RecupId);
    }

    public static Recuperacion GetRecuperacionByUsuarioById(int UsuarioID)
    {
        if (UsuarioID <= 0)
            throw new ArgumentException("Id con valor invalido");

        RecuperacionDSTableAdapters.RecuperacionTableAdapter adapter = new RecuperacionDSTableAdapters.RecuperacionTableAdapter();
        RecuperacionDS.RecuperacionDataTable table = adapter.GetRecuperacionByUsuarioId(UsuarioID);
        if (table.Rows.Count == 0)
            return null;

        Recuperacion obj = GetRecuperacionFromRow(table[0]);

        return obj;
    }

    public static Recuperacion GetRecuperacionById(int IdRecuperacion)
    {
        if (IdRecuperacion <= 0)
            throw new ArgumentException("Id con valor invalido");

        RecuperacionDSTableAdapters.RecuperacionTableAdapter adapter = new RecuperacionDSTableAdapters.RecuperacionTableAdapter();
        RecuperacionDS.RecuperacionDataTable table = adapter.GetRecuperacionById(IdRecuperacion);
        if (table.Rows.Count == 0)
            return null;

        Recuperacion obj = GetRecuperacionFromRow(table[0]);

        return obj;
    }

    private static Recuperacion GetRecuperacionFromRow(RecuperacionDS.RecuperacionRow row)
    {
        return new Recuperacion()
        {
            ResuperacionId = row.RecuperacionId,
            Codigo = row.Codigo,
            HoraInicio = row.HorarioInicio,
            HorarioFin = row.HorarioFin,
            UsuarioId = row.UsuarioId,
            Estado = row.Estado
        };
    }

    private static String GetCodigo()
    {
        String palabra = "";
        char[] codigo = new char[] { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'ñ', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
        Random rnd = new Random();
        for (int i = 0; i < 8; i++)
        {
            palabra = palabra+codigo[rnd.Next(0, 53)];
        }
        return palabra;
    }

}