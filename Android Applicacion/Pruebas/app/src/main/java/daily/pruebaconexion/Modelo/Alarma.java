package daily.pruebaconexion.Modelo;

public class Alarma {
    private int AlarmaId;
    private String Codigo;
    private int Estado;
    private int Alerta;
    private String Latitud;
    private String Longitud;
    private int UsuarioID;
    private String Contrasena;
    private String Nombre;

    public Alarma() {
    }

    public int getAlarmaId() {
        return AlarmaId;
    }

    public void setAlarmaId(int alarmaId) {
        AlarmaId = alarmaId;
    }

    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String codigo) {
        Codigo = codigo;
    }

    public int getEstado() {
        return Estado;
    }

    public void setEstado(int estado) {
        Estado = estado;
    }

    public int getAlerta() {
        return Alerta;
    }

    public void setAlerta(int alerta) {
        Alerta = alerta;
    }

    public String getLatitud() {
        return Latitud;
    }

    public void setLatitud(String latitud) {
        Latitud = latitud;
    }

    public String getLongitud() {
        return Longitud;
    }

    public void setLongitud(String longitud) {
        Longitud = longitud;
    }

    public int getUsuarioID() {
        return UsuarioID;
    }

    public void setUsuarioID(int usuarioID) {
        UsuarioID = usuarioID;
    }

    public String getContrasena() {
        return Contrasena;
    }

    public void setContrasena(String contrasena) {
        Contrasena = contrasena;
    }

    public String getNombre() { return Nombre; }

    public void setNombre(String nombre) { Nombre = nombre; }
}
