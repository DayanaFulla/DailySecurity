package daily.pruebaconexion.BRL;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.RetryPolicy;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import daily.pruebaconexion.Abrir;
import daily.pruebaconexion.Adapter.CerradurasAdapter;
import daily.pruebaconexion.ConfigureGPS;
import daily.pruebaconexion.ConfigureQR;
import daily.pruebaconexion.Extras.VarGlobal;
import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Principal;
import daily.pruebaconexion.Productos;
import daily.pruebaconexion.R;
import daily.pruebaconexion.Servicio.MySingleton;

public class AlarmaBRL {

    public AlarmaBRL() {
    }

    public static List<Alarma> actualizarLista(final Context context){
        String url = "http://"+ VarGlobal.IP+":1234/api/Alarma/GetAlarmaByUsuario/"+ Usuario.getInstance().getUsuarioID();

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
                        alarmas.add(alarma);
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

    public void listo(TextView txtPin1, final TextView txtNOMBRE, final Context context){
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
            Toast.makeText(context, "Error: "+e, Toast.LENGTH_SHORT).show();
            Log.e("Error JSON:", e.toString());
        }

        String url ="http://"+ VarGlobal.IP+":1234/api/Alarma/UpdateAlarma";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"BIEN\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en ");
//                    LlaveBRL.GenerarLlave(txtNOMBRE, context);
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("ERROR", response.toString()+"::: Configuracion");
                    Toast.makeText(context, "Configuracion", Toast.LENGTH_LONG).show();
                    showMessageDialog("Error en Configuracion retorno ERROR", context);
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                //loadinBar.setVisibility(View.INVISIBLE);

                Log.e("Error ALARMA:", error.toString());
                showMessageDialog("Error en Configuracion", context);
                //Toast.makeText(LoginActivity.this, "Error: " + error.toString()+" esto", Toast.LENGTH_LONG).show();
                if (error.networkResponse.statusCode == 404) {
                    Toast.makeText(context, "ERROR 404", Toast.LENGTH_LONG).show();
                }else if(error.networkResponse == null){
                    if(error.getClass().equals(TimeoutError.class)){
                        Toast.makeText(context,"ERROR TIME_ERROR",Toast.LENGTH_LONG).show();
                    }
                }else{
                    Toast.makeText(context, "ERROR!!", Toast.LENGTH_LONG).show();
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

    public static List<Alarma> actualizarAlarmas(final ListView listView, final Context context){
        String url = "http://"+ VarGlobal.IP+":1234/api/Alarma/GetAlarmaByUsuario/"+ Usuario.getInstance().getUsuarioID();
        final List<Alarma> alarms = new LinkedList<>();
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        JsonArrayRequest jsonObjectRequest = new JsonArrayRequest
            (Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
                @Override
                public void onResponse(JSONArray response) {

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
                            alarms.add(alarma);

                        }
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
        requestQueue.add(jsonObjectRequest);
        return alarms;
    }

    public void showMessageDialog(String message, final Context context) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(context);
        dialogo.setTitle("Configuracion:");
        dialogo.setMessage(message);
        dialogo.setCancelable(false);
        dialogo.setPositiveButton("ACEPTAR", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                Intent intent = new Intent(context, Principal.class);
                context.startActivity(intent);
            }
        });
        dialogo.show();
    }


}
