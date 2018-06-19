package daily.pruebaconexion.Servicio;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Toast;

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

import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.Modelo.Usuario;

public class LlaveService {

    public static List<Llave> actualizarLista(final Context context){
        String url = "http://192.168.137.21:1234/api/Llave/GetLlavesPropias/"+ Usuario.getInstance().getUsuarioID();
        final List<Llave> llaves = new LinkedList<>();
        JsonArrayRequest jsonObjectRequest = new JsonArrayRequest
        (Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {

        try {
            for (int i = 0; i < response.length(); i++) {
                Llave llave = new Llave();
                llave.setLlaveId(response.getJSONObject(i).getInt("LlaveId"));
                llave.setCodigo(response.getJSONObject(i).getString("Codigo").trim());
                llave.setEstado(response.getJSONObject(i).getInt("Estado"));
                llave.setTipo(response.getJSONObject(i).getString("Tipo").trim());
                llave.setNick(response.getJSONObject(i).getString("Nick").trim());
                llave.setAlarmaId(response.getJSONObject(i).getInt("AlarmaId"));
                llave.setHoraInicio(Time.valueOf(response.getJSONObject(i).getString("HoraInicio").trim()));
                llave.setHoraFin(Time.valueOf(response.getJSONObject(i).getString("HoraFin").trim()));

                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                try {
                    java.util.Date date1 = format.parse(response.getJSONObject(i).getString("FechaInicio"));
                    java.util.Date date2 = format.parse(response.getJSONObject(i).getString("FechaFin"));
                    llave.setFechaInicio(date1);
                    llave.setFechaFin(date2);
                    Log.i("Conversion:",date1+"|"+date2);
                } catch (ParseException e) {
                    Log.e("Error Date","No pudo convertir");
                }
                llave.setDias(response.getJSONObject(i).getString("Dias").trim());
                llave.setUsuarioId(response.getJSONObject(i).getInt("UsuarioId"));
                llave.setNombre(response.getJSONObject(i).getString("Nombre").trim());
                llaves.add(llave);
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
        MySingleton.getInstance(context).addToRequestQueue(jsonObjectRequest);
        return  llaves;
    }

    public static List<String> crearLlavePermanente(final Llave llave, final Context context){

        final List<String> lista = new LinkedList<>();
        //Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();
        JSONObject jsonBody = new JSONObject();
        try{
            jsonBody.put("Codigo", llave.getCodigo()+"");
            jsonBody.put("Estado", llave.getEstado()+"");
            jsonBody.put("Tipo", llave.getTipo()+"");
            jsonBody.put("Nick", llave.getNick()+"");
            jsonBody.put("AlarmaId", llave.getAlarmaId()+"");
        } catch (Exception e){
            Toast.makeText(context, "Error: "+e, Toast.LENGTH_SHORT).show();
            Log.e("Error JSON:", e.toString());
        }

        String url ="http://192.168.137.21:1234/api/Llave/InsertLlave";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en ");
                     String Ok = "OK";
                     lista.add(Ok);
                    //showMessageDialog("Mensaje", "Se configuro con Exito.");
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("ERROR", response.toString()+"   VERIFICACION");
                    //Toast.makeText(ConfigurePIN.this, "Verifique su cuenta en la WEB", Toast.LENGTH_LONG).show();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                //loadinBar.setVisibility(View.INVISIBLE);
                Log.e("Error ALARMA:", error.toString());
                //Toast.makeText(LoginActivity.this, "Error: " + error.toString()+" esto", Toast.LENGTH_LONG).show();
                if (error.networkResponse.statusCode == 404) {
                    //Toast.makeText(ConfigurePIN.this, "ERROR 404", Toast.LENGTH_LONG).show();
                    Log.e("Error 404:", error.toString());
                }else if(error.networkResponse == null){
                    if(error.getClass().equals(TimeoutError.class)){
                        //Toast.makeText(ConfigurePIN.this,"ERROR TIME_ERROR",Toast.LENGTH_LONG).show();
                        Log.e("Error TimeError:", error.toString());
                    }
                }else{
                    //Toast.makeText(ConfigurePIN.this, "ERROR!!", Toast.LENGTH_LONG).show();
                    Log.e("Error: ", error.toString());
                }
            }
        })
        {
            @Override
            protected Map<String, String> getParams() {
                Map<String,String> map = new HashMap<>();
                map.put("Codigo", llave.getCodigo()+"");
                map.put("Estado", llave.getEstado()+"");
                map.put("Tipo", llave.getTipo()+"");
                map.put("Nick", llave.getNick()+"");
                map.put("AlarmaId", llave.getAlarmaId()+"");
                return map;
            }
        };
        requestQueue.add(stringRequest);
        return lista;
    }

    public static List<String> ConfirmarLlave(final Llave llave, final Context context){

        final List<String> lista = new LinkedList<>();
        //Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();
        JSONObject jsonBody = new JSONObject();
        try{
            jsonBody.put("Codigo", llave.getCodigo()+"");
            jsonBody.put("UsuarioId", llave.getUsuarioId()+"");
            jsonBody.put("Nombre", llave.getNombre()+"");
        } catch (Exception e){
            Toast.makeText(context, "Error: "+e, Toast.LENGTH_SHORT).show();
            Log.e("Error JSON:", e.toString());
        }

        String url ="http://192.168.137.21:1234/api/Llave/UpdateConfirmar";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en ");
                    String Ok = "OK";
                    lista.add(Ok);
                    //showMessageDialog("Mensaje", "Se configuro con Exito.");
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("ERROR", response.toString()+"   VERIFICACION");
                    //Toast.makeText(ConfigurePIN.this, "Verifique su cuenta en la WEB", Toast.LENGTH_LONG).show();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                //loadinBar.setVisibility(View.INVISIBLE);
                Log.e("Error ALARMA:", error.toString());
                //Toast.makeText(LoginActivity.this, "Error: " + error.toString()+" esto", Toast.LENGTH_LONG).show();
                if (error.networkResponse.statusCode == 404) {
                    //Toast.makeText(ConfigurePIN.this, "ERROR 404", Toast.LENGTH_LONG).show();
                    Log.e("Error 404:", error.toString());
                }else if(error.networkResponse == null){
                    if(error.getClass().equals(TimeoutError.class)){
                        //Toast.makeText(ConfigurePIN.this,"ERROR TIME_ERROR",Toast.LENGTH_LONG).show();
                        Log.e("Error TimeError:", error.toString());
                    }
                }else{
                    //Toast.makeText(ConfigurePIN.this, "ERROR!!", Toast.LENGTH_LONG).show();
                    Log.e("Error: ", error.toString());
                }
            }
        })
        {
            @Override
            protected Map<String, String> getParams() {
                Map<String,String> map = new HashMap<>();
                map.put("Codigo", llave.getCodigo()+"");
                map.put("UsuarioId", llave.getUsuarioId()+"");
                map.put("Nombre", llave.getNombre()+"");
                return map;
            }
        };
        requestQueue.add(stringRequest);
        return lista;
    }

    public static Integer CantidadPrestadas(final Context context,final String alarmaID , final String UsuarioId){
        String url = "http://192.168.137.21:1234/api/Llave/GetLlavesPrestadas";
        final Integer[] lista = new Integer[1];
        //Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();
        JSONObject jsonBody = new JSONObject();
        try{
            jsonBody.put("AlarmaID", alarmaID+"");
            jsonBody.put("UsuarioID", UsuarioId+"");
        } catch (Exception e){
            Toast.makeText(context, "Error: "+e, Toast.LENGTH_SHORT).show();
            Log.e("Error JSON:", e.toString());
        }

        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                try {
                    JSONArray parent = new JSONArray(response);
                    Log.e("JSONAR",response.toString()+"|||||"+parent.length());
                    lista[0] = parent.length();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        }){
            @Override
            protected Map<String, String> getParams() {
                Map<String,String> map = new HashMap<>();
                map.put("AlarmaID", alarmaID+"");
                map.put("UsuarioID", UsuarioId+"");
                return map;
            }
        };
        requestQueue.add(stringRequest);
        return lista[0];
    }
}
