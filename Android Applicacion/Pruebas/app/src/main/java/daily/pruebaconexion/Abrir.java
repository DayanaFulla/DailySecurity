package daily.pruebaconexion;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class Abrir extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_abrir);

        TextView txtLlave = findViewById(R.id.txtLlaveID);

        Intent intentaux = getIntent();
        int id = intentaux.getIntExtra("LLAVE_ID", -1);
        txtLlave.setText("Este es la LLAVE: "+id);
    }
}
