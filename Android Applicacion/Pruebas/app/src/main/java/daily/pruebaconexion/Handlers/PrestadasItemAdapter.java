package daily.pruebaconexion.Handlers;

import android.content.Context;
import android.os.Build;
import android.support.annotation.RequiresApi;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.WrapperListAdapter;

import java.text.SimpleDateFormat;

import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.R;

public class PrestadasItemAdapter extends LinearLayout {

    private TextView txt_nombres, txt_fechas, txt_horas, txt_dias, txt_habilitado;
    private LinearLayout layoutHoras, layoutDias, layoutFechas, layoutHabilitado;

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
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
        txt_habilitado.setTextAlignment(TEXT_ALIGNMENT_CENTER);

        if (llave.getActHora() == 1){
            txt_horas.setText(llave.getHoraInicio()+"-"+llave.getHoraFin());
            txt_horas.setTextAlignment(TEXT_ALIGNMENT_CENTER);

        }else{
            txt_horas.setText("--");

        }

        if (llave.getTipo().equals("T")){
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            txt_fechas.setText(formatter.format(llave.getFechaInicio())+" al "+formatter.format(llave.getFechaFin()));
            txt_fechas.setTextAlignment(TEXT_ALIGNMENT_CENTER);

        }else{
            txt_fechas.setText("--");
        }

        if(llave.getActDias() == 1){
            txt_dias.setText("D:"+llave.getDias());
            txt_dias.setTextAlignment(TEXT_ALIGNMENT_CENTER);
        }else{
            txt_dias.setText("--");
        }

    }
}
