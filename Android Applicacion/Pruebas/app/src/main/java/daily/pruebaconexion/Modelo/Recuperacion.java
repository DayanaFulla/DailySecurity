package daily.pruebaconexion.Modelo;

import java.util.Date;

public class Recuperacion {
    public int RecuperacionId;
    public String Codigo;
    public Date HoraInicio;
    public Date HorarioFin;
    public int UsuarioId;
    public String Estado;

    public int getRecuperacionId() {
        return RecuperacionId;
    }

    public void setRecuperacionId(int recuperacionId) {
        RecuperacionId = recuperacionId;
    }

    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String codigo) {
        Codigo = codigo;
    }

    public Date getHoraInicio() {
        return HoraInicio;
    }

    public void setHoraInicio(Date horaInicio) {
        HoraInicio = horaInicio;
    }

    public Date getHorarioFin() {
        return HorarioFin;
    }

    public void setHorarioFin(Date horarioFin) {
        HorarioFin = horarioFin;
    }

    public int getUsuarioId() {
        return UsuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        UsuarioId = usuarioId;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String estado) {
        Estado = estado;
    }
}
