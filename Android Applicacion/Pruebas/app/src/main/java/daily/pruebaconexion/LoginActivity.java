package daily.pruebaconexion;

import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;


public class LoginActivity extends AppCompatActivity {
    TextView txtemail, txtcontrasena;
    Button btnIngresar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        txtemail = findViewById(R.id.txtEmail);
        txtcontrasena = findViewById(R.id.txtContraseña);
        btnIngresar = findViewById(R.id.btnIngresar);
        btnIngresar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(LoginActivity.this, "Click en el boton", Toast.LENGTH_LONG).show();
                Ingresar();
            }
        });
    }

    public void Ingresar(){
        final String email = txtemail.getText().toString().trim();
        final String contraseña = txtcontrasena.getText().toString().trim();

        Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();

        JSONObject jsonBody = new JSONObject();
        try{
            jsonBody.put("Correo", email);
            jsonBody.put("Contrasena", contraseña);
        } catch (Exception e){
            Toast.makeText(LoginActivity.this, "Error: "+e, Toast.LENGTH_SHORT).show();
            Log.e("Error Fatal:", e.toString());
        }

        String url ="http://192.168.0.12:1234/api/Usuario/Login";
        RequestQueue requestQueue = Volley.newRequestQueue(this);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                if(response.equals("NOTFOUND")){
                    Log.e("Error Fatal:", "No existe WEEEEE");
                    Toast.makeText(LoginActivity.this, "NOTFOUND: No existe WEEEE", Toast.LENGTH_LONG).show();
                }else {
                    Log.i("Esto recibio", response.toString());
                    Toast.makeText(LoginActivity.this, "Recibio: " + response, Toast.LENGTH_LONG).show();
                    Intent intent = new Intent(LoginActivity.this, Principal.class);
                    intent.putExtra("UsuarioID", response.toString());
                    startActivity(intent);
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("Errorprin",error.toString());
                Toast.makeText(LoginActivity.this, "Error: " + error.toString(), Toast.LENGTH_LONG).show();
                if (error.networkResponse.statusCode == 404)
                    Toast.makeText(LoginActivity.this, "El Email ingresado no existe en el sistema", Toast.LENGTH_LONG).show();
                else
                    Toast.makeText(LoginActivity.this, "Error: " + error.getMessage(), Toast.LENGTH_LONG).show();
            }
        })
        {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String,String> map = new HashMap<>();
                map.put("Correo",email);
                map.put("Contrasena",contraseña);
                return map;
            }
        };
        requestQueue.add(stringRequest);
    }
}
