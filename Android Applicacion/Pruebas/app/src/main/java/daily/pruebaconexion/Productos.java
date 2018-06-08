package daily.pruebaconexion;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.ContextMenu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import daily.pruebaconexion.Adapter.CerradurasAdapter;
import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Servicio.AlarmaService;
import daily.pruebaconexion.Servicio.LlaveService;
import daily.pruebaconexion.Servicio.MySingleton;
import daily.pruebaconexion.Servicio.ProductosService;

public class Productos extends AppCompatActivity {

    ListView listView;
    public static List<Alarma> alarmas = new LinkedList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_productos);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);


        listView = findViewById(R.id.list_product);
        registerForContextMenu(listView);
        actualizarLista();

    }

    public void actualizarLista(){
        String url = "http://192.168.0.12:1234/api/Alarma/GetAlarmaByUsuario/"+ Usuario.getInstance().getUsuarioID();
        final List<Alarma> alarms = new LinkedList<>();
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
                            final CerradurasAdapter adapter = new CerradurasAdapter(alarms,Productos.this);
                            listView.setAdapter(adapter);
                            listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                                @Override
                                public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                                    Intent intent = new Intent(Productos.this, Abrir.class);
                                    View llave = adapter.getView(i,view,adapterView);
                                    TextView txtUsr = llave.findViewById(R.id.txtAlarmaId);
                                    intent.putExtra("LLAVE_ID", Integer.parseInt(txtUsr.getText()+""));
                                    //Log.e("INFO:",txtUsr.getText()+"");
                                    startActivity(intent);
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
        MySingleton.getInstance(Productos.this).addToRequestQueue(jsonObjectRequest);
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        MenuInflater inflater = new MenuInflater(this);
        inflater.inflate(R.menu.menu_cerraduras,menu);

    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
        switch (item.getItemId()) {
            case R.id.menu_compartir:
                Intent intent = new Intent(Productos.this, CompartirLlave.class);
                startActivity(intent);
                return true;
            case R.id.menu_delete:
                Toast.makeText(this,"Eliminando",Toast.LENGTH_LONG).show();
                return true;
            default:
                return super.onContextItemSelected(item);
        }
    }
}
