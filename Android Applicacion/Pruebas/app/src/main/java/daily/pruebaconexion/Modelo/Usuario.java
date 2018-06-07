package daily.pruebaconexion.Modelo;

public class Usuario {

    private static final Usuario instancia = new Usuario();
    public int UsuarioID ;
    public String Nombre ;
    public String Apellido ;
    public String Telefono ;
    public String Correo ;
    public String Contrasena ;
    public boolean EstadoEspera ;
    public boolean EstadoCuenta ;

    public static Usuario getInstance(){
        return instancia;
    }

    public int getUsuarioID() {
        return UsuarioID;
    }

    public void setUsuarioID(int usuarioID) {
        UsuarioID = usuarioID;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public String getApellido() {
        return Apellido;
    }

    public void setApellido(String apellido) {
        Apellido = apellido;
    }

    public String getTelefono() {
        return Telefono;
    }

    public void setTelefono(String telefono) {
        Telefono = telefono;
    }

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String correo) {
        Correo = correo;
    }

    public String getContrasena() {
        return Contrasena;
    }

    public void setContrasena(String contrasena) {
        Contrasena = contrasena;
    }

    public boolean isEstadoEspera() {
        return EstadoEspera;
    }

    public void setEstadoEspera(boolean estadoEspera) {
        EstadoEspera = estadoEspera;
    }

    public boolean isEstadoCuenta() {
        return EstadoCuenta;
    }

    public void setEstadoCuenta(boolean estadoCuenta) {
        EstadoCuenta = estadoCuenta;
    }
}
