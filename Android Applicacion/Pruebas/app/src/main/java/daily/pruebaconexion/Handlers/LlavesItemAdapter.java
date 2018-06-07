package daily.pruebaconexion.Handlers;

import android.content.Context;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.TextView;

import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.R;

public class LlavesItemAdapter extends LinearLayout{

    private TextView txtNombreLlave;

    public LlavesItemAdapter(Context context, Alarma alarma) {
        super(context);
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if(inflater != null){
            inflater.inflate(R.layout.llave_item, this);
        }

        txtNombreLlave = findViewById(R.id.txtNombreLlave);

        txtNombreLlave.setText(alarma.getNombre());
    }
}
