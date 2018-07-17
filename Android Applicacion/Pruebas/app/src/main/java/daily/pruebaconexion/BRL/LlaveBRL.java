package daily.pruebaconexion.BRL;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;
import android.text.InputType;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.RetryPolicy;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import daily.pruebaconexion.Abrir;
import daily.pruebaconexion.AbrirLlave;
import daily.pruebaconexion.Adapter.LlavesObtenidasAdapter;
import daily.pruebaconexion.ConfigureQR;
import daily.pruebaconexion.EditarLlave;
import daily.pruebaconexion.Extras.LlaveAux;
import daily.pruebaconexion.Extras.VarGlobal;
import daily.pruebaconexion.LlavesObtenidas;
import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Principal;
import daily.pruebaconexion.Servicio.MySingleton;

public class LlaveBRL {


    public static List<Llave> getPrestadas(final Context context, final int alarmaID, final int UsuarioID){
        String url = "http://"+ VarGlobal.IP+":1234/api/Llave/GetLlavesPrestadas";
        final List<Llave> llaves = new LinkedList<>();
        //Toast.makeText(LoginActivity.this, "Entro a Ingresar", Toast.LENGTH_LONG).show();
        JSONObject jsonBody = new JSONObject();
        try{
            jsonBody.put("AlarmaID", alarmaID+"");
            jsonBody.put("UsuarioID", UsuarioID+"");
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
                    for (int i = 0; i < parent.length(); i++) {
                        Llave llave = new Llave();
                        llave.setLlaveId(parent.getJSONObject(i).getInt("LlaveId"));
                        llave.setCodigo(parent.getJSONObject(i).getString("Codigo").trim());
                        llave.setEstado(parent.getJSONObject(i).getInt("Estado"));
                        llave.setTipo(parent.getJSONObject(i).getString("Tipo").trim());
                        llave.setNick(parent.getJSONObject(i).getString("Nick").trim());
                        llave.setAlarmaId(parent.getJSONObject(i).getInt("AlarmaId"));
                        llave.setHoraInicio(Time.valueOf(parent.getJSONObject(i).getString("HoraInicio").trim()));
                        llave.setHoraFin(Time.valueOf(parent.getJSONObject(i).getString("HoraFin").trim()));

                        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                        try {
                            java.util.Date date1 = format.parse(parent.getJSONObject(i).getString("FechaInicio"));
                            java.util.Date date2 = format.parse(parent.getJSONObject(i).getString("FechaFin"));
                            llave.setFechaInicio(date1);
                            llave.setFechaFin(date2);
                        } catch (ParseException e) {
                            Log.e("Error Date","No pudo convertir");
                        }
                        llave.setDias(parent.getJSONObject(i).getString("Dias").trim());
                        llave.setUsuarioId(parent.getJSONObject(i).getInt("UsuarioId"));
                        llave.setNombre(parent.getJSONObject(i).getString("Nombre").trim());
                        llave.setActDias(parent.getJSONObject(i).getInt("ActDias"));
                        llave.setActHora(parent.getJSONObject(i).getInt("ActHora"));
                        Log.d("OBTENIENDO", llave.getNombre());
                        llaves.add(llave);
                    }

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
                map.put("UsuarioID", UsuarioID+"");
                return map;
            }
        };
        requestQueue.add(stringRequest);
        return llaves;
    }


    public static void getObtenidas(final Context context, final ListView listaobtenidas){
        String url = "http://"+ VarGlobal.IP+":1234/api/Llave/GetLlavesObtenidas/"+ Usuario.getInstance().getUsuarioID();
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
                        } catch (ParseException e) {
                            Log.e("Error Date","No pudo convertir");
                        }
                        llave.setDias(response.getJSONObject(i).getString("Dias").trim());
                        llave.setUsuarioId(response.getJSONObject(i).getInt("UsuarioId"));
                        llave.setNombre(response.getJSONObject(i).getString("Nombre").trim());
                        llave.setActDias(response.getJSONObject(i).getInt("ActDias"));
                        llave.setActHora(response.getJSONObject(i).getInt("ActHora"));
                        Log.d("OBTENIENDO", response.toString());
                        llaves.add(llave);
                    }

                    final LlavesObtenidasAdapter adapter = new LlavesObtenidasAdapter(llaves,context);
                    listaobtenidas.setAdapter(adapter);
                    listaobtenidas.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                        @Override
                        public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                            Llave llave = adapter.getItem(i);



                            LlaveAux.getInstance().setLlaveId(llave.getLlaveId());
                            LlaveAux.getInstance().setCodigo(llave.getCodigo());
                            LlaveAux.getInstance().setEstado(llave.getEstado());
                            LlaveAux.getInstance().setTipo(llave.getTipo());
                            LlaveAux.getInstance().setNick(llave.getNick());
                            LlaveAux.getInstance().setAlarmaId(llave.getAlarmaId());
                            LlaveAux.getInstance().setHoraInicio(llave.getHoraInicio());
                            LlaveAux.getInstance().setHoraFin(llave.getHoraFin());
                            LlaveAux.getInstance().setFechaInicio(llave.getFechaInicio());
                            LlaveAux.getInstance().setFechaFin(llave.getFechaFin());
                            LlaveAux.getInstance().setDias(llave.getDias());
                            LlaveAux.getInstance().setUsuarioId(llave.getUsuarioId());
                            LlaveAux.getInstance().setNombre(llave.getNombre());
                            LlaveAux.getInstance().setActDias(llave.getActDias());
                            LlaveAux.getInstance().setActHora(llave.getActHora());

                            if(LlaveAux.getInstance().getEstado() == 1){
                                verificarLlave(llave, context);
                            }else{
                                showMessageDialogLlave("La llave esta Desactivada",context);
                            }
                        }
                    });

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
        jsonObjectRequest.setRetryPolicy(new DefaultRetryPolicy(DefaultRetryPolicy.DEFAULT_TIMEOUT_MS * 2, DefaultRetryPolicy.DEFAULT_MAX_RETRIES, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));

        MySingleton.getInstance(context).addToRequestQueue(jsonObjectRequest);
        Log.i("LLAVES", "obtenida: "+llaves.size());
    }

    public static void verificarLlave(Llave llave, Context context){
        boolean dias = false;
        boolean fecha = false;
        boolean horas = false;
        if(llave.getActDias() == 1){
            dias = verificarDia(llave.getDias());
        }else{
            dias = true;
        }

        if(llave.getTipo().equals("T")){
            fecha = verificarFecha(llave.getFechaInicio(), llave.getFechaFin());
        }else{
            fecha = true;
        }

        if(llave.getActHora() == 1){
            horas = verificarHora(llave.getHoraInicio(), llave.getHoraFin());
        }else{
            horas = true;
        }
        Log.i("comparacion", "D:"+dias+" H:"+horas+" F:"+fecha);
        if(fecha && dias && horas){
            Intent intent = new Intent(context, Abrir.class);
            intent.putExtra("ALARMA_ID", llave.getAlarmaId());
            Log.i("Alarma", "verificarLlave: "+llave.getAlarmaId());
            context.startActivity(intent);
        }else{
            showMessageDialogLlave("La llave esta Desactivada",context);
        }

    }

    public static boolean verificarHora(Time horainicio, Time HoraFin){

        boolean horain = false;
        boolean horafn = false;

        Calendar calendario = Calendar.getInstance();
        int hora, minutos, segundos;
        hora =calendario.get(Calendar.HOUR_OF_DAY);
        minutos = calendario.get(Calendar.MINUTE);
        segundos = calendario.get(Calendar.SECOND);
        String time = hora + ":" + minutos + ":" + segundos;
        DateFormat formatter = new SimpleDateFormat("HH:mm:ss");
        Time ahora = null;
        try {
            ahora = new Time(formatter.parse(time).getTime());
            Log.i("tiempo", "verificarHora: "+ahora);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Log.i("HORA", "igual?: " + ahora.equals(horainicio) +" - " + ahora.equals(HoraFin));
        Log.i("HORA", "meno?: " + horainicio +" - " + HoraFin +" - " +ahora.before(HoraFin));
        Log.i("HORA", "mayo? : " +  horainicio +" - " + horainicio +" - " + ahora.after(horainicio));

        if (ahora.equals(horainicio)||ahora.after(horainicio)){
            horain= true;
        }


        if (ahora.equals(HoraFin)||ahora.before(HoraFin)){
            horafn = true;
        }
        if(horain && horafn){
            return true;
        }

        return false;
    }



    public static boolean verificarFecha(Date fechainicio, Date fechafin){
        Calendar now =  Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        Date actual = null;
        try {
            actual = dateFormat.parse(dateFormat.format(new Date()));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        boolean fechIni = false;
        boolean fechFn = false;

        if (actual.equals(fechainicio)||actual.after(fechainicio)){
            fechIni= true;
        }


        if (actual.equals(fechafin)||actual.before(fechafin)){
            fechFn = true;
        }

        if(fechFn && fechIni){
            return true;
        }
        return false;
    }

    public static boolean verificarDia(String dias){
        String[] diassplit = LlaveAux.getInstance().getDias().split("\\|");
        for (int i = 0; i < diassplit.length; i++) {
            if(diassplit[i].equals(getdia())){
                return true;
            }
        }
        return false;
    }

    public static String getdia(){
        Calendar c =  Calendar.getInstance();
        int numdia = c.get(Calendar.DAY_OF_WEEK);
        String dia = "";
        switch (numdia){
            case 1:
                dia = "DO";
                break;
            case 2:
                dia = "LU";
                break;
            case 3:
                dia = "MA";
                break;
            case 4:
                dia = "MI";
                break;
            case 5:
                dia = "JU";
                break;
            case 6:
                dia = "VI";
                break;
            case 7:
                dia = "SA";
                break;
        }

        return dia;
    }

    public static void showMessageDialogLlave(String message, final Context context ) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(context);
        dialogo.setTitle("Informacion de llave:");
        dialogo.setMessage(message);
        dialogo.setCancelable(false);
        dialogo.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                Intent intent = new Intent(context, Principal.class);
                context.startActivity(intent);
                ((Activity)context).finish();
            }
        });
        dialogo.show();
    }


    public static List<Llave> actualizarLista(final Context context){
        String url = "http://"+ VarGlobal.IP+":1234/api/Llave/GetLlavesPropias/"+ Usuario.getInstance().getUsuarioID();
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
        jsonObjectRequest.setRetryPolicy(new DefaultRetryPolicy(DefaultRetryPolicy.DEFAULT_TIMEOUT_MS * 2, DefaultRetryPolicy.DEFAULT_MAX_RETRIES, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));

        MySingleton.getInstance(context).addToRequestQueue(jsonObjectRequest);
        return  llaves;
    }

    public static void GenerarLlave(TextView txtNOMBRE, Context context){
        Llave llave = new Llave();
        String codigo = Llave.generadorCodigo();
        llave.setCodigo(codigo);
        llave.setEstado(0);
        llave.setTipo("P");
        llave.setNick("Propietario");
        llave.setAlarmaId(ConfigureQR.ID);
        llave.setNombre(txtNOMBRE.getText().toString().trim());
        llave.setActDias(0);
        llave.setActHora(0);
        llave.setUsuarioId(Usuario.getInstance().getUsuarioID());
        List<String> result = crearLlavePermanente(llave,context);
        showMessageDialog("Llave", "Generada con exito", 2, context, txtNOMBRE, codigo);

    }

    public static void ConfirmarLlave(TextView txtNOMBRE, Context context, String codigo){
        Llave llave = new Llave();
        llave.setCodigo(codigo);
        llave.setEstado(0);
        llave.setTipo("P");
        llave.setNick("Propietario");
        llave.setAlarmaId(ConfigureQR.ID);
        llave.setNombre(txtNOMBRE.getText().toString().trim());
        llave.setActDias(0);
        llave.setActHora(0);
        llave.setUsuarioId(Usuario.getInstance().getUsuarioID());
        List<String> result2 = ConfirmarLlave(llave, context);
    }

    public static void showMessageDialog(String titulo, String message, int error, final Context context, final TextView txtNOMBRE, final String codigo ) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(context);
        dialogo.setTitle(titulo);
        dialogo.setMessage(message);
        dialogo.setCancelable(false);

        if(error == 0){
            dialogo.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    Intent intent = new Intent(context, Principal.class);
                    context.startActivity(intent);
                    ((Activity)context).finish();

                }
            });
        }else if(error == 2){
            dialogo.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    ConfirmarLlave(txtNOMBRE,context, codigo);
                    Intent intent = new Intent(context, Principal.class);
                    context.startActivity(intent);
                    ((Activity)context).finish();

                }
            });
        }
        dialogo.show();
    }


    public static void setTipo(Context context, Llave llave){
        if(llave.getTipo().equals("T")){
            insertLlaveTemporal(context, llave);
        }else{
            insertLlavePermanente(context, llave);
        }
    }


    public static void insertLlavePermanente(final Context context, final Llave llave){

        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("Codigo", llave.getCodigo());
            jsonObject.put("Estado", 0);
            jsonObject.put("Tipo", llave.getTipo());
            jsonObject.put("Nick", llave.getNick());
            jsonObject.put("AlarmaId", llave.getAlarmaId());
            jsonObject.put("HoraInicio", llave.getHoraInicio());
            jsonObject.put("HoraFin", llave.getHoraFin());
            jsonObject.put("Dias", llave.getDias());
            jsonObject.put("ActDias", llave.getActDias());
            jsonObject.put("ActHora", llave.getActHora());


        } catch (JSONException e) {
            e.printStackTrace();
        }

        String url ="http://"+ VarGlobal.IP+":1234/api/Llave/InsertLlave";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en crear llave permanente");
                    Toast.makeText(context, "Compartido con exito",Toast.LENGTH_LONG).show();
                    //showMessageDialog("Mensaje", "Se configuro con Exito.");
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Toast.makeText(context, "Compartido ERROR",Toast.LENGTH_LONG).show();
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
                map.put("Estado", 0+"");
                map.put("Tipo", llave.getTipo()+"");
                map.put("Nick", llave.getNick()+"");
                map.put("AlarmaId", llave.getAlarmaId()+"");
                map.put("HoraInicio", llave.getHoraInicio()+"");
                map.put("HoraFin", llave.getHoraFin()+"");
                map.put("Dias", llave.getDias()+"");
                map.put("ActDias", llave.getActDias()+"");
                map.put("ActHora", llave.getActHora()+"");
                return map;
            }
        };

        stringRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 500;
            }

            @Override
            public int getCurrentRetryCount() {
                return 500;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {
                Log.e("time Error", "tiem error"+error.toString());
            }
        });
        requestQueue.add(stringRequest);

    }

    public static void insertLlaveTemporal(final Context context, final Llave llave){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
            Log.e("Fechas: ", "crearLlave: " + llave.getFechaInicio() + ":" + llave.getFechaFin());
            final String format1 = formatter.format(llave.getFechaInicio())+"";
            final String format2 = formatter.format(llave.getFechaFin())+"";

        String url ="http://"+ VarGlobal.IP+":1234/api/Llave/InsertLlave";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en crear llave permanente");
                    Toast.makeText(context, "Compartido con exito",Toast.LENGTH_LONG).show();
                    //showMessageDialog("Mensaje", "Se configuro con Exito.");
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Toast.makeText(context, "Compartido ERROR",Toast.LENGTH_LONG).show();
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
                map.put("Estado", 0+"");
                map.put("Tipo", llave.getTipo()+"");
                map.put("Nick", llave.getNick()+"");
                map.put("AlarmaId", llave.getAlarmaId()+"");
                map.put("HoraInicio", llave.getHoraInicio()+"");
                map.put("HoraFin", llave.getHoraFin()+"");
                map.put("FechaInicio", format1+"");
                map.put("FechaFin", format2+"");
                map.put("Dias", llave.getDias()+"");
                map.put("ActDias", llave.getActDias()+"");
                map.put("ActHora", llave.getActHora()+"");
                return map;
            }
        };

        stringRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 500;
            }

            @Override
            public int getCurrentRetryCount() {
                return 500;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {
                Log.e("time Error", "tiem error"+error.toString());
            }
        });
        requestQueue.add(stringRequest);

    }

    public static String dateinicio(Llave llave){
        String format1 = null;
        if(llave.getTipo().equals("T")){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
            Log.e("Fechas: ", "crearLlave: " + llave.getFechaInicio() + ":" + llave.getFechaFin());
            format1 = formatter.format(llave.getFechaInicio());
            return format1;
        };
        return null;
    };
    public static String datefin(Llave llave){
        String format1 = null;
        if(llave.getTipo().equals("T")){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
            Log.e("Fechas: ", "crearLlave: " + llave.getFechaFin() + ":" + llave.getFechaFin());
            format1 = formatter.format(llave.getFechaFin());
            return format1;
        };
        return null;
    };

    public static void UpdateLlave (final Context context, final Llave llave){


        String url ="http://"+ VarGlobal.IP+":1234/api/Llave/Update";

        JSONObject object =  new JSONObject();
        try {
            object.put("LlaveId", llave.getLlaveId());object.put("Codigo", llave.getCodigo()+"");
            object.put("Estado", llave.getEstado()+"");
            object.put("Tipo", llave.getTipo()+"");
            object.put("Nick", llave.getNick()+"");
            object.put("AlarmaId", llave.getAlarmaId()+"");
            object.put("HoraInicio", llave.getHoraInicio()+"");
            object.put("HoraFin", llave.getHoraFin()+"");
            object.put("FechaInicio", dateinicio(llave));
            object.put("FechaFin", datefin(llave));
            object.put("Dias", llave.getDias()+"");
            object.put("UsuarioId", llave.getUsuarioId()+"");
            object.put("Nombre", llave.getNombre()+"");
            object.put("ActDias", llave.getActDias()+"");
            object.put("ActHora", llave.getActHora()+"");

            Log.i("Mandando", "UpdateLlave: "+object.toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }


        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en crear llave permanente");
                    Toast.makeText(context, "Compartido con exito",Toast.LENGTH_LONG).show();
                    //showMessageDialog("Mensaje", "Se configuro con Exito.");
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Toast.makeText(context, "Compartido ERROR",Toast.LENGTH_LONG).show();
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
                map.put("LlaveId", llave.getLlaveId()+"");
                map.put("Codigo", llave.getCodigo()+"");
                map.put("Estado", llave.getEstado()+"");
                map.put("Tipo", llave.getTipo()+"");
                map.put("Nick", llave.getNick()+"");
                map.put("AlarmaId", llave.getAlarmaId()+"");
                map.put("HoraInicio", llave.getHoraInicio()+"");
                map.put("HoraFin", llave.getHoraFin()+"");
                map.put("FechaInicio", dateinicio(llave));
                map.put("FechaFin", datefin(llave));
                map.put("Dias", llave.getDias()+"");
                map.put("UsuarioId", llave.getUsuarioId()+"");
                map.put("Nombre", llave.getNombre()+"");
                map.put("ActDias", llave.getActDias()+"");
                map.put("ActHora", llave.getActHora()+"");
                return map;
            }
        };

        stringRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 500;
            }

            @Override
            public int getCurrentRetryCount() {
                return 500;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {
                Log.e("time Error", "tiem error"+error.toString());
            }
        });
        requestQueue.add(stringRequest);

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

        String url ="http://"+ VarGlobal.IP+":1234/api/Llave/InsertLlave";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en crear llave permanente");
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

        stringRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 500;
            }

            @Override
            public int getCurrentRetryCount() {
                return 500;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {
                Log.e("time Error", "tiem error"+error.toString());
            }
        });
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

        String url ="http://"+ VarGlobal.IP+":1234/api/Llave/UpdateConfirmar";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en Confirmar llave");
                    String Ok = "OK";
                    lista.add(Ok);
                    //showMessageDialog("Mensaje", "Se configuro con Exito.");
                }else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.i("ERROR", response.toString()+"   CONFIRMACION DE LLAVE");
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
        return lista;
    }

    public static Integer CantidadPrestadas(final TextView txtCantidad, final Context context, final String alarmaID , final String UsuarioId){
        String url = "http://"+ VarGlobal.IP+":1234/api/Llave/GetLlavesPrestadas";
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
                    txtCantidad.setText("Llaves prestadas:"+parent.length()+"");
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

    public static void obtenerLlavePorCodigo(final Context context, final String codigo){
        String url = "http://"+VarGlobal.IP+":1234/api/Llave/GetLlaveByCodigo/"+codigo.trim();
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
            (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                    try {
                        Llave llave = new Llave();
                        llave.setLlaveId(response.getInt("LlaveId"));
                        llave.setCodigo(response.getString("Codigo"));
                        llave.setEstado(response.getInt("Estado"));
                        llave.setTipo(response.getString("Tipo"));
                        llave.setNick(response.getString("Nick"));
                        llave.setAlarmaId(response.getInt("AlarmaId"));
                        Log.i("Este codigo de Llave", codigo+" <-");
                        Log.i("Obteniendo", llave.getNick()+" <-");
                        DateFormat format = new SimpleDateFormat("yyyy-mm-dd");
                        try {
                            Time tm_inicio = Time.valueOf(response.getString("HoraInicio"));
                            Time tm_fin = Time.valueOf(response.getString("HoraFin"));
                            llave.setHoraInicio(tm_inicio);
                            llave.setHoraFin(tm_fin);
                            Date date = format.parse(response.getString("FechaInicio"));
                            Date date2 = format.parse(response.getString("FechaFin"));
                            llave.setFechaInicio(date);
                            llave.setFechaFin(date2);

                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        llave.setDias(response.getString("Dias"));
                        llave.setUsuarioId(response.getInt("UsuarioId"));
                        llave.setNombre(response.getString("Nombre"));
                        llave.setActDias(response.getInt("ActDias"));
                        llave.setActHora(response.getInt("ActHora"));
                        ponerNombre(context,llave, codigo);

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
                        Log.e("ERROR:", "404 "+error.toString());
                        showMessageDialog("Error en blanco", context);
                    }else if(error.networkResponse == null){
                        if(error.getClass().equals(TimeoutError.class)){
                            Log.e("ERROR:", "NULL TIME "+error.toString());
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

    public static void ponerNombre(final Context context, final Llave llave, final String codigo){
        Log.i("InfoLlave", "Esta por aqui"+codigo);
        if(llave.getUsuarioId() != 0 ){
            if(llave.getUsuarioId() == Usuario.getInstance().getUsuarioID()){
                showMessageDialog("Ya esta registrado en tu nombre.",context);
            }else{
                showMessageDialog("Revise el codigo que ingreso.",context);
            }
        }

            AlertDialog.Builder creador = new AlertDialog.Builder(context);
            creador.setTitle("Ingrese nombre de Llave:");

            final EditText nombre = new EditText(context);
            nombre.setInputType(InputType.TYPE_TEXT_FLAG_MULTI_LINE);
            nombre.setSingleLine(true);
            nombre.setPadding(100, 50, 50, 50);
            nombre.setGravity(Gravity.LEFT | Gravity.TOP);
            creador.setView(nombre);
            creador.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {
                    llave.setUsuarioId(Usuario.getInstance().getUsuarioID());
                    llave.setNombre(nombre.getText().toString());
                    llave.setCodigo(codigo);
                    ConfirmarLlave(context, llave);
                }
            });
            AlertDialog alert = creador.create();
            alert.show();
    }

    public static void showMessageDialog(String message, final Context context) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(context);
        dialogo.setTitle("Llave:");
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

    public static void showMessageDialog2(String message, final Context context) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(context);
        dialogo.setTitle("Exito");
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

    public static void ConfirmedError(final Context context) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(context);
        dialogo.setTitle("Fallo");
        dialogo.setMessage("Usted ya tiene una llave para este producto.");
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

    public static void ConfirmarLlave(final Context context, final Llave llave){
        String url ="http://"+ VarGlobal.IP+":1234/api/Llave/UpdateConfirmar";
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

                if(response.toString().equals("\"OK\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Log.e("OK:", "EXITO en crear llave permanente");
                    Toast.makeText(context, "Compartido con exito",Toast.LENGTH_LONG).show();
                    showMessageDialog2("Ya tienes tu llave.", context);
                }else if (response.equals("\"RPT\"") ){
                    Log.e("OK:", "FALLO POR QUE ESTA REPETIDO");
                    ConfirmedError(context);
                }
                else if (response.equals("\"ERROR\"")){
                    //loadinBar.setVisibility(View.INVISIBLE);
                    Toast.makeText(context, "Compartido ERROR",Toast.LENGTH_LONG).show();
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
                map.put("LlaveId", llave.getLlaveId()+"");
                map.put("Codigo", llave.getCodigo()+"");
                map.put("Estado", 0+"");
                map.put("Tipo", llave.getTipo()+"");
                map.put("Nick", llave.getNick()+"");
                map.put("AlarmaId", llave.getAlarmaId()+"");
                map.put("HoraInicio", llave.getHoraInicio()+"");
                map.put("HoraFin", llave.getHoraFin()+"");
                map.put("FechaInicio", llave.getFechaInicio()+"");
                map.put("FechaFin", llave.getFechaFin()+"");
                map.put("Dias", llave.getDias()+"");
                map.put("UsuarioId", llave.getUsuarioId()+"");
                map.put("Nombre", llave.getNombre()+"");
                map.put("ActDias", llave.getActDias()+"");
                map.put("ActHora", llave.getActHora()+"");
                return map;
            }
        };

        stringRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 500;
            }

            @Override
            public int getCurrentRetryCount() {
                return 500;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {
                Log.e("time Error", "tiem error"+error.toString());
            }
        });
        requestQueue.add(stringRequest);
    }


}

