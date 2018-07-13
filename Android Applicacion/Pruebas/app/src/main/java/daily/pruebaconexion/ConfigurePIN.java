package daily.pruebaconexion;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import daily.pruebaconexion.BRL.AlarmaBRL;
import daily.pruebaconexion.BRL.LlaveBRL;

public class ConfigurePIN extends AppCompatActivity {

    TextView txtPin1,txtPin2,txtERROR, txtNOMBRE;
    Button btnListo;
    String codigo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_configure_pin);

        txtPin1 = findViewById(R.id.txtPIN1);
        txtPin2 = findViewById(R.id.txtPIN2);
        txtERROR = findViewById(R.id.txtError);
        txtNOMBRE = findViewById(R.id.txtNombre);
        btnListo = findViewById(R.id.btnPin);

        btnListo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(!txtPin1.getText().toString().equals(txtPin2.getText().toString())){
                    txtERROR.setText("INGRESE EL MISMO PIN");
                }else if(txtNOMBRE.getText().equals("")|| txtNOMBRE.getText().length() <=0 ){
                    txtERROR.setText("INGRESE UN NOMBRE A LA LLAVE");
                }else{
                    AlarmaBRL alarmaBRL = new AlarmaBRL();
                    alarmaBRL.listo(txtPin1,txtNOMBRE, ConfigurePIN.this);
                    LlaveBRL.GenerarLlave(txtNOMBRE,ConfigurePIN.this);
                }
            }
        });
    }

}
