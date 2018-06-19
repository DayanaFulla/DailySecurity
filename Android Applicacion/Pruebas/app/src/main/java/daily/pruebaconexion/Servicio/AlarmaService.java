package daily.pruebaconexion.Servicio;

import android.content.Context;
import android.util.Log;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.LinkedList;
import java.util.List;

import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Usuario;

public class AlarmaService {

    public static List<Alarma> alarmaslList = new LinkedList<>();

    public static List<Alarma> getAlarmaslList(Context context) {
        actualiseList(context);
        Log.e("TamCLA",alarmaslList.size()+"");
        return alarmaslList;
    }

    public static void add(Alarma alarma){
        alarmaslList.add(alarma);
        Log.e("AÑADIENDO",alarma.getNombre());
    }

    public static List<Alarma> actualiseList(final Context context){
        String url = "http://192.168.137.21:1234/api/Alarma/GetAlarmaByUsuario/"+ Usuario.getInstance().getUsuarioID();
        final List<Alarma> alarmas = new LinkedList<>();
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        JsonArrayRequest jsonObjectRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.e("JSONArray",response.toString());
             try {

                     for (int i = 0; i < response.length(); i++) {
                         Alarma alarma = new Alarma();
                         alarma.setAlarmaId(response.getJSONObject(i).getInt("AlarmaId"));
                         alarma.setCodigo(response.getJSONObject(i).getString("Codigo").trim());
                         alarma.setEstado(response.getJSONObject(i).getInt("Estado"));
                         alarma.setAlerta(response.getJSONObject(i).getInt("Alerta"));
                         alarma.setLatitud(response.getJSONObject(i).getString("Latitud").trim());
                         alarma.setLongitud(response.getJSONObject(i).getString("Longitud").trim());
                         alarma.setUsuarioID(response.getJSONObject(i).getInt("UsuarioID"));
                         alarma.setContrasena(response.getJSONObject(i).getString("Contrasena").trim());
                         alarma.setNombre(response.getJSONObject(i).getString("Nombre").trim());
                         AlarmaService.add(alarma);
                     }

             }catch (JSONException err){
                Log.e("JSONERROR",err.toString());
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
        Log.e("TAMÑOFIN",alarmas.size()+"");
// Access the RequestQueue through your singleton class.
        requestQueue.add(jsonObjectRequest);
        return  alarmas;
    }
}
