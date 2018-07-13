package daily.pruebaconexion.BRL;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.View;
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
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import daily.pruebaconexion.Extras.VarGlobal;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Principal;
import daily.pruebaconexion.Servicio.MySingleton;

public class UsuarioBRL {

    public static void Ingresar(final ProgressBar loadinBar, final TextView txtemail, final TextView txtcontrasena, final Context context ){
        loadinBar.setVisibility(View.VISIBLE);
        final String email = txtemail.getText().toString().trim();
        final String contraseña = txtcontrasena.getText().toString().trim();

        //Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();


        String url ="http://"+ VarGlobal.IP+":1234/api/Usuario/Login";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"NOTFOUND\"")){
                    loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("Error Fatal:", "No existe WEEEEE");
                    Toast.makeText(context, "Revise sus Datos", Toast.LENGTH_LONG).show();
                    txtemail.setText("");
                    txtcontrasena.setText("");
                }else if (response.equals("\"VERIFICACION\"")){
                    loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("Esto recibio", response.toString()+"   VERIFICACION");
                    Toast.makeText(context, "Verifique su cuenta en la WEB", Toast.LENGTH_LONG).show();
                    txtemail.setText("");
                    txtcontrasena.setText("");
                }else{
                    loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("Esto recibio", response.toString()+" ira a principal");
                    //Toast.makeText(LoginActivity.this, "Recibio: " + response, Toast.LENGTH_LONG).show();
                    String idUsuario = response.toString();
                    idUsuario = idUsuario.substring(1,idUsuario.length()-1);
                    Usuario.getInstance().setUsuarioID(Integer.parseInt(idUsuario));
                    Toast.makeText(context, "esto es lo que recibio: "+idUsuario, Toast.LENGTH_LONG).show();
                    Intent intent = new Intent(context, Principal.class);
                    context.startActivity(intent);
                    ((Activity)context).finish(); // 'ana'
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                loadinBar.setVisibility(View.INVISIBLE);
                Log.e("Error prin", error.toString());
                //Toast.makeText(LoginActivity.this, "Error: " + error.toString()+" esto", Toast.LENGTH_LONG).show();
                if (error.networkResponse.statusCode == 404) {
                    Toast.makeText(context, "revise sus Datos", Toast.LENGTH_LONG).show();
                    txtemail.setText("");
                    txtcontrasena.setText("");
                }else if(error.networkResponse == null){
                    if(error.getClass().equals(TimeoutError.class)){
                        Toast.makeText(context,"Oops. Timeout error!",Toast.LENGTH_LONG).show();
                    }
                }else{
                    Toast.makeText(context, "Revise sus datos", Toast.LENGTH_LONG).show();
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

        stringRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 60000;
            }

            @Override
            public int getCurrentRetryCount() {
                return 60000;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {
                Log.e("time Error", "tiem error"+error.toString());
            }
        });
        requestQueue.add(stringRequest);
    }

    public static void obtenerUsuario(final TextView txtUsuario, Context context){
        String url = "http://"+ VarGlobal.IP+":1234/api/Usuario/GetUsuario/"+Usuario.getInstance().getUsuarioID();

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
            (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                @Override
                public void onResponse(JSONObject response) {
                    try {
                        Usuario.getInstance().setNombre(response.getString("Nombre"));
                        Usuario.getInstance().setApellido(response.getString("Apellido"));
                        Usuario.getInstance().setTelefono(response.getString("Telefono"));
                        Usuario.getInstance().setCorreo(response.getString("Correo"));

                        txtUsuario.setText("Tus Llaves: "+Usuario.getInstance().getNombre()+" "+Usuario.getInstance().getApellido());
                    } catch (JSONException e) {
                        e.printStackTrace();
                        Log.e("ERROR:", e.toString());
                    }

                }
            }, new Response.ErrorListener() {

                @Override
                public void onErrorResponse(VolleyError error) {
                    // TODO: Handle error
                    if (error.networkResponse.statusCode == 404) {
                        Log.e("ERROR:", "404");
                    }else if(error.networkResponse == null){
                        if(error.getClass().equals(TimeoutError.class)){
                            Log.e("ERROR:", "NULL TIME");
                        }
                    }else{
                        Log.e("ERROR:", error.toString());
                    }
            }
                });
        jsonObjectRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 60000;
            }

            @Override
            public int getCurrentRetryCount() {
                return 60000;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {
                Log.e("time Error", "tiem error"+error.toString());
            }
        });
        MySingleton.getInstance(context).addToRequestQueue(jsonObjectRequest);
    }

}
