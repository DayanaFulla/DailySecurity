package daily.pruebaconexion.ServiciosModelo;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.StringRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.net.URL;
import java.util.ArrayList;
import java.util.ConcurrentModificationException;

import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Servicio.RESTApi;
import daily.pruebaconexion.Servicio.RESTListener;

public class RESTUsuario {
    private Context context;
    private String URL_json =  "http://192.168.0.12:1234/api/Usuario/getUsuarios";
    private ArrayList<Usuario> usuarios = new ArrayList<>();

    public RESTUsuario(Context context) {
        this.context = context;
    }

    /*public static void getUsuarios(final RESTListener<ArrayList<Usuario>> listener){
        StringRequest stringRequest = new StringRequest(Request.Method.GET, RESTApi.getURL() + "/api/Usuario/GetUsuarios",
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        ArrayList<Usuario> usuarios = new ArrayList<>();
                        try {
                        JSONArray jsonArray = new JSONArray();
                            Log.e("Info dentro", "Entro dentro del metodo getUsuarios");
                            Log.e("Info dentro", "obtuvo: "+response);
                            for (int i = 0; i < jsonArray.length(); i++) {

                                    JSONObject jsonObject = jsonArray.getJSONObject(i);
                                    Usuario usr = new Usuario();
                                    usr.setUsuarioID(jsonObject.getInt("UsuarioID"));
                                    usr.setNombre(jsonObject.getString("Nombre"));
                                    usr.setApellido(jsonObject.getString("Apellido"));
                                    usr.setTelefono(jsonObject.getString("Telefono").trim());
                                    usr.setCorreo(jsonObject.getString("Correo"));
                                    usr.setContrasena(jsonObject.getString("Contrasena").trim());
                                    usr.setEstadoEspera(jsonObject.getBoolean("EstadoEspera"));
                                    usr.setEstadoCuenta(jsonObject.getBoolean("EstadoCuenta"));

                                    usuarios.add(usr);

                            }
                        listener.onResult(usuarios);
                        }catch (JSONException e){
                            e.printStackTrace();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(RESTApi.getContext(), error.toString(), Toast.LENGTH_LONG).show();
            }
        });
        RESTApi.getRequestQueue().add(stringRequest);
    }*/


    public  ArrayList<Usuario> getusuarios(){
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET,URL_json, null,
                new Response.Listener<JSONArray>() {
                    @Override
                    public void onResponse(JSONArray response) {
                        for (int i = 0; i < response.length(); i++) {
                            try {
                                JSONObject jsonObject = response.getJSONObject(i);
                                Usuario usr = new Usuario();
                                usr.setUsuarioID(jsonObject.getInt("UsuarioID"));
                                usr.setNombre(jsonObject.getString("Nombre"));
                                usr.setApellido(jsonObject.getString("Apellido"));
                                usr.setTelefono(jsonObject.getString("Telefono").trim());
                                usr.setCorreo(jsonObject.getString("Correo"));
                                usr.setContrasena(jsonObject.getString("Contrasena").trim());
                                usr.setEstadoEspera(jsonObject.getBoolean("EstadoEspera"));
                                usr.setEstadoCuenta(jsonObject.getBoolean("EstadoCuenta"));
                                usuarios.add(usr);

                            }catch (JSONException e){
                                Log.e("Exception---:",e.toString());
                            }
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("ErrorResponse",error.toString());
            }
        });

        RESTApi.getInstance(context).addToRequestque(jsonArrayRequest);

        return usuarios;
    }
}
