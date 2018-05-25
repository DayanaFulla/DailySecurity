package daily.pruebaconexion.Modelo;

import java.util.Date;

public class Verificacion {
    public int VerificacionId;
    public String CodigoVerificacion;
    public Date HorarioInicio;
    public Date HorarioFin;
    public int UsuarioId;
    public boolean Estado;


    public int getVerificacionId() {
        return VerificacionId;
    }

    public void setVerificacionId(int verificacionId) {
        VerificacionId = verificacionId;
    }

    public String getCodigoVerificacion() {
        return CodigoVerificacion;
    }

    public void setCodigoVerificacion(String codigoVerificacion) {
        CodigoVerificacion = codigoVerificacion;
    }

    public Date getHorarioInicio() {
        return HorarioInicio;
    }

    public void setHorarioInicio(Date horarioInicio) {
        HorarioInicio = horarioInicio;
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

    public boolean isEstado() {
        return Estado;
    }

    public void setEstado(boolean estado) {
        Estado = estado;
    }
}
