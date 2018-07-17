package daily.pruebaconexion;

import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.RetryPolicy;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import daily.pruebaconexion.BRL.UsuarioBRL;
import daily.pruebaconexion.Extras.GlobalInicioSesion;
import daily.pruebaconexion.Extras.VarGlobal;
import daily.pruebaconexion.Modelo.Usuario;


public class LoginActivity extends AppCompatActivity {
    TextView txtemail, txtcontrasena;
    Button btnIngresar;
    ProgressBar loadinBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        loadinBar = findViewById(R.id.loading_bar);
        loadinBar.setVisibility(View.INVISIBLE);
        txtemail = findViewById(R.id.txtEmail);
        txtcontrasena = findViewById(R.id.txtContraseña);
        btnIngresar = findViewById(R.id.btnIngresar);

        boolean salir = getIntent().getBooleanExtra("Salir",false);

        final SharedPreferences sharedPreferences = getSharedPreferences("DailySecurity", this.MODE_PRIVATE);

        if(salir){

        }

        if(!CheckUser(salir)){
            Log.i("SESION", "CheckUser: ya no mantener");
            btnIngresar.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    UsuarioBRL.Ingresar(loadinBar, txtemail, txtcontrasena,LoginActivity.this);

                }
            });
        }
    }

    public boolean CheckUser(boolean salir){
        boolean mantener = false;
        if(salir){
            Log.i("SESION", "CheckUser: ya no mantener");
            return false;
        }
        Intent intent = new Intent(LoginActivity.this, Principal.class);
        SharedPreferences sharedPreferences = this.getPreferences(this.MODE_PRIVATE);
        String idUsuario = sharedPreferences.getString("IDUsuario","0");
        if(!idUsuario.equals("0")){
            Usuario.getInstance().setUsuarioID(Integer.parseInt(idUsuario));
            startActivity(intent);
            Log.i("SESION", "CheckUser: mantener");
            return true;
        }
        return false;
    }
}