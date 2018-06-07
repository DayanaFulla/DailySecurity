package daily.pruebaconexion;

import android.content.Intent;
import android.content.SharedPreferences;
import android.provider.ContactsContract;
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
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

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
        btnIngresar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //Toast.makeText(LoginActivity.this, "Click en el boton", Toast.LENGTH_LONG).show();
                Ingresar();
            }
        });
    }

    public void Ingresar(){
        loadinBar.setVisibility(View.VISIBLE);
        final String email = txtemail.getText().toString().trim();
        final String contraseña = txtcontrasena.getText().toString().trim();

        //Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();

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

                if(response.toString().equals("\"NOTFOUND\"")){
                    loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("Error Fatal:", "No existe WEEEEE");
                    Toast.makeText(LoginActivity.this, "Revise sus Datos", Toast.LENGTH_LONG).show();
                    txtemail.setText("");
                    txtcontrasena.setText("");
                }else if (response.equals("\"VERIFICACION\"")){
                    loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("Esto recibio", response.toString()+"   VERIFICACION");
                    Toast.makeText(LoginActivity.this, "Verifique su cuenta en la WEB", Toast.LENGTH_LONG).show();
                    txtemail.setText("");
                    txtcontrasena.setText("");
                }else{
                    loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("Esto recibio", response.toString()+" ira a principal");
                    //Toast.makeText(LoginActivity.this, "Recibio: " + response, Toast.LENGTH_LONG).show();
                    String idUsuario = response.toString();
                    idUsuario = idUsuario.substring(1,idUsuario.length()-1);
                    //idUsuario = idUsuario.substring(idUsuario.length()-1, idUsuario.length());
                    Toast.makeText(LoginActivity.this, "esto es lo que recibio: "+idUsuario, Toast.LENGTH_LONG).show();
                    Usuario.getInstance().setUsuarioID(Integer.parseInt(idUsuario));
                    Intent intent = new Intent(LoginActivity.this, Principal.class);
                    startActivity(intent);
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                loadinBar.setVisibility(View.INVISIBLE);
                Log.e("Error prin", error.toString());
                //Toast.makeText(LoginActivity.this, "Error: " + error.toString()+" esto", Toast.LENGTH_LONG).show();
                if (error.networkResponse.statusCode == 404) {
                    Toast.makeText(LoginActivity.this, "revise sus Datos", Toast.LENGTH_LONG).show();
                    txtemail.setText("");
                    txtcontrasena.setText("");
                }else if(error.networkResponse == null){
                    if(error.getClass().equals(TimeoutError.class)){
                        Toast.makeText(LoginActivity.this,"Oops. Timeout error!",Toast.LENGTH_LONG).show();
                    }
                }else{
                    Toast.makeText(LoginActivity.this, "Revise sus datos", Toast.LENGTH_LONG).show();
                    txtemail.setText("");
                    txtcontrasena.setText("");}
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
