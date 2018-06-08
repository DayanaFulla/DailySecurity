package daily.pruebaconexion;

import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;
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
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Servicio.LlaveService;

public class ConfigurePIN extends AppCompatActivity {

    TextView txtPin1,txtPin2,txtERROR, txtNOMBRE;
    Button btnListo;

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
                    listo();

                }
            }
        });
    }

    public void listo(){
        final String PIN = txtPin1.getText().toString().trim();
        final String Nombre = txtNOMBRE.getText().toString().trim();
        //Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();

        JSONObject jsonBody = new JSONObject();
        try{
            jsonBody.put("AlarmaId", ConfigureQR.ID+"");
            jsonBody.put("Codigo", ConfigureQR.CODIGO+"");
            jsonBody.put("Estado", 1+"");
            jsonBody.put("Alerta", 0+"");
            jsonBody.put("Latitud", ConfigureGPS.LATITUD+"");
            jsonBody.put("Longitud", ConfigureGPS.LONGITUD+"");
            jsonBody.put("UsuarioID", Usuario.getInstance().getUsuarioID()+"");
            jsonBody.put("Contrasena", PIN+"");
            jsonBody.put("Nombre", Nombre+"");
        } catch (Exception e){
            Toast.makeText(ConfigurePIN.this, "Error: "+e, Toast.LENGTH_SHORT).show();
            Log.e("Error JSON:", e.toString());
        }

        String url ="http://192.168.0.12:1234/api/Alarma/UpdateAlarma";
        RequestQueue requestQueue = Volley.newRequestQueue(this);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"BIEN\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en ");
                    GenerarLlave();
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("ERROR", response.toString()+"::: Configuracion");
                    Toast.makeText(ConfigurePIN.this, "Configuracion", Toast.LENGTH_LONG).show();
                    showMessageDialog("ERROR","Error en Configuracion", 1);
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                //loadinBar.setVisibility(View.INVISIBLE);

                Log.e("Error ALARMA:", error.toString());
                showMessageDialog("ERROR","Error en Configuracion", 1);
                //Toast.makeText(LoginActivity.this, "Error: " + error.toString()+" esto", Toast.LENGTH_LONG).show();
                if (error.networkResponse.statusCode == 404) {
                    Toast.makeText(ConfigurePIN.this, "ERROR 404", Toast.LENGTH_LONG).show();
                }else if(error.networkResponse == null){
                    if(error.getClass().equals(TimeoutError.class)){
                        Toast.makeText(ConfigurePIN.this,"ERROR TIME_ERROR",Toast.LENGTH_LONG).show();
                    }
                }else{
                    Toast.makeText(ConfigurePIN.this, "ERROR!!", Toast.LENGTH_LONG).show();
                }
            }
        })
        {
            @Override
            protected Map<String, String> getParams() {
                Map<String,String> map = new HashMap<>();
                map.put("AlarmaId", ConfigureQR.ID+"");
                map.put("Codigo", ConfigureQR.CODIGO+"");
                map.put("Estado", 1+"");
                map.put("Alerta", 0+"");
                map.put("Latitud", ConfigureGPS.LATITUD+"");
                map.put("Longitud", ConfigureGPS.LONGITUD+"");
                map.put("UsuarioID", Usuario.getInstance().getUsuarioID()+"");
                map.put("Contrasena", PIN+"");
                map.put("Nombre", Nombre+"");
                return map;
            }
        };
        requestQueue.add(stringRequest);
    }

    public void GenerarLlave(){
        Llave llave = new Llave();
        llave.setCodigo(Llave.generadorCodigo());
        llave.setEstado(0);
        llave.setTipo("P");
        llave.setNick("Propietario");
        llave.setAlarmaId(ConfigureQR.ID);
        llave.setNombre(txtNOMBRE.getText().toString().trim());
        llave.setUsuarioId(Usuario.getInstance().getUsuarioID());
        List<String> result = LlaveService.crearLlavePermanente(llave,ConfigurePIN.this);
        List<String> result2 = LlaveService.ConfirmarLlave(llave, ConfigurePIN.this);
        if(result.size() == 1 && result2.size()==1){
            showMessageDialog("EXITO","Se configuro con Exito", 0);
        }else{
            showMessageDialog("ERROR","Error en crear Llave", 1);
        }
    }

    public void showMessageDialog(String titulo,String message, int error) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(this);
        dialogo.setTitle(titulo);
        dialogo.setMessage(message);
        dialogo.setCancelable(false);

        if(error == 0){
            dialogo.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    Intent intent = new Intent(ConfigurePIN.this, Principal.class);
                    startActivity(intent);

                }
            });
        }
        dialogo.show();
    }
}
