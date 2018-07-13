package daily.pruebaconexion.Handlers;

import android.content.Context;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.TextView;

import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.R;

public class LlavesItemAdapter extends LinearLayout{

    private TextView txtNombreLlave,txtActive, txtKeyID;

    public LlavesItemAdapter(Context context, Llave llave) {
        super(context);
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if(inflater != null){
            inflater.inflate(R.layout.item_llave, this);
        }

        txtNombreLlave = findViewById(R.id.txtNombreLlave);
        txtActive = findViewById(R.id.txtActivado);
        txtKeyID = findViewById(R.id.txtLlaveID);

        txtNombreLlave.setText(llave.getNombre());
        txtActive.setText(llave.getEstado() == 1 ? "ACTIVADO" : "DESACTIVADO");
        txtKeyID.setText(llave.getLlaveId() + "");
    }
}
