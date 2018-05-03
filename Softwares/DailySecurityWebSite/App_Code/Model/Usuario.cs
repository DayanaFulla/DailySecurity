using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Usuario
/// </summary>
public class Usuario
{
    public Usuario()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    public int UsuarioID { get; set; }
    public string Nombre { get; set; }
    public string Apellido { get; set; }
    public string Telefono { get; set; }
    public string Correo { get; set; }
    public string Contrasena { get; set; }
    public bool EstadoEspera { get; set; }
    public bool EstadoCuenta { get; set; }
}