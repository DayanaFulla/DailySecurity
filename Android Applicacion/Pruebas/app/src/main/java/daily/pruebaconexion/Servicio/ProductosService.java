package daily.pruebaconexion.Servicio;

import android.content.Context;
import android.util.Log;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Productos;

public class ProductosService {

    private String jsonArray = "*";

    private void actualizarLista(Context context){
        String url = "http://192.168.0.12:1234/api/Alarma/GetAlarmaByUsuario/"+ Usuario.getInstance().getUsuarioID();
        RequestQueue queue = Volley.newRequestQueue(context);


// Request a string response from the provided URL.
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        jsonArray = response;
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("ERROR", "Volley "+error);
            }
        });

// Add the request to the RequestQueue.
        queue.add(stringRequest);
    }

    public static void Obtener(Context context){
        ProductosService service = new ProductosService();
        service.actualizarLista(context);
        Log.e("OBTUVO", service.jsonArray);
        /*try{

        }catch (JSONException erro){

        }*/

    }

}
