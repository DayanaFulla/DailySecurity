package daily.pruebaconexion.Modelo;

import java.sql.Time;
import java.util.Date;

public class Llave {
    private int LlaveId;
    private String Codigo;
    private int Estado;
    private String Tipo;
    private String Nick;
    private int AlarmaId;
    private Time HoraInicio;
    private Time HoraFin;
    private Date FechaInicio;
    private Date FechaFin;
    private String Dias;
    private int UsuarioId;
    private String Nombre;

    public Llave() {
    }

    public int getLlaveId() {
        return LlaveId;
    }

    public void setLlaveId(int llaveId) {
        LlaveId = llaveId;
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

    public String getTipo() {
        return Tipo;
    }

    public void setTipo(String tipo) {
        Tipo = tipo;
    }

    public String getNick() {
        return Nick;
    }

    public void setNick(String nick) {
        Nick = nick;
    }

    public int getAlarmaId() {
        return AlarmaId;
    }

    public void setAlarmaId(int alarmaId) {
        AlarmaId = alarmaId;
    }

    public Time getHoraInicio() {
        return HoraInicio;
    }

    public void setHoraInicio(Time horaInicio) {
        HoraInicio = horaInicio;
    }

    public Time getHoraFin() {
        return HoraFin;
    }

    public void setHoraFin(Time horaFin) {
        HoraFin = horaFin;
    }

    public Date getFechaInicio() {
        return FechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        FechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return FechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        FechaFin = fechaFin;
    }

    public String getDias() {
        return Dias;
    }

    public void setDias(String dias) {
        Dias = dias;
    }

    public int getUsuarioId() {
        return UsuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        UsuarioId = usuarioId;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public static String generadorCodigo(){
        String palabra = "";
        char[] codigo = new char[] { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'ñ', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9','=','|','+','-','|','@','Ì','´' };

        for (int i = 0; i < 12; i++)
        {
            int numero = (int) (Math.random()*63);
            palabra = palabra + codigo[numero];
        }
        return palabra;
    }
}
