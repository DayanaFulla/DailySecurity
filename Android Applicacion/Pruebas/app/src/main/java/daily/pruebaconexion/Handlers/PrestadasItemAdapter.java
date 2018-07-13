package daily.pruebaconexion.Handlers;

import android.content.Context;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.TextView;

import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.R;

public class PrestadasItemAdapter extends LinearLayout {

    private TextView txt_nombres, txt_fechas, txt_horas, txt_dias, txt_habilitado;

    public PrestadasItemAdapter(Context context, Llave llave) {
        super(context);
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if(inflater != null){
            inflater.inflate(R.layout.item_llave_prestada, this);
        }

        txt_nombres = findViewById(R.id.txtLlaveNombre2);
        txt_fechas = findViewById(R.id.txtFechas);
        txt_dias = findViewById(R.id.txtDias);
        txt_horas = findViewById(R.id.txtHoras);
        txt_habilitado = findViewById(R.id.txtHabilitado);

        txt_nombres.setText(llave.getNombre()+"");
        txt_habilitado.setText(llave.getEstado() == 1? "HABILITADO" : "DESHABILITADO");
        if (llave.getActHora() == 0){
            txt_horas.setText("S/H");
        }else{
            txt_horas.setText(llave.getHoraInicio()+"-"+llave.getHoraFin());
        }

        if (llave.getTipo().equals("T")){
            txt_fechas.setText(llave.getFechaInicio()+":"+llave.getFechaFin());
        }else{
            txt_fechas.setText("S/F");
        }

        if(llave.getActDias() == 1){
            txt_dias.setText("D:"+llave.getDias());
        }else{
            txt_dias.setText("S/D");
        }

    }
}
