package daily.pruebaconexion.Handlers;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.TextView;

import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.R;
import daily.pruebaconexion.Servicio.LlaveService;

public class CerradurasItemAdapter  extends LinearLayout{
    private TextView txtNombreAlarma,txtCantidad, txtAlarma, txtAlarmaId;

    public CerradurasItemAdapter(Context context, Alarma alarma) {
        super(context);

        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if(inflater != null){
            inflater.inflate(R.layout.item_cerraduras, this);
        }
        //Log.e("RecDEnIT",alarma.getNombre()+"");
        txtNombreAlarma = findViewById(R.id.txtNombreCerradura);
        txtCantidad = findViewById(R.id.txtCantidadLlaves);
        txtAlarma = findViewById(R.id.txtAlerta);
        txtAlarmaId = findViewById(R.id.txtAlarmaId);
        //String nombre =  alarma.getNombre()+"";

        txtNombreAlarma.setText(alarma.getNombre()+"");
        txtAlarma.setText("Alarma: "+(alarma.getEstado() == 1 ? "ACTIVADA" : "DESACTIVADA"));

        Integer cantidad = LlaveService.CantidadPrestadas(context, alarma.getAlarmaId()+"", Usuario.getInstance().getUsuarioID()+"");
        Log.e("cantidad",cantidad+"");
        txtCantidad.setText("Llaves:"+cantidad+"");
        txtAlarmaId.setText(alarma.getAlarmaId()+"");
    }


}
