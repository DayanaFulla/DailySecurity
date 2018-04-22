using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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