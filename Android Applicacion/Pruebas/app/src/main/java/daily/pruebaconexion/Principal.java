package daily.pruebaconexion;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.util.Log;
import android.view.View;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.LinkedList;
import java.util.List;

import daily.pruebaconexion.Adapter.LlavesAdapter;
import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Servicio.MySingleton;


public class Principal extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_principal);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        listView = findViewById(R.id.list_Keys);
        obtenerUsuario();
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);


    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.principal, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.nav_configure) {
            Intent intent = new Intent(Principal.this, ConfigureQR.class);
            startActivity(intent);
        }else if (id == R.id.nsv_mis_llaves) {

        }else if (id == R.id.nsv_llaves) {

        }else if (id == R.id.nav_share) {

        } else if (id == R.id.nav_send) {

        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }


    public void obtenerUsuario(){
        String url = "http://192.168.0.12:1234/api/Usuario/GetUsuario/"+Usuario.getInstance().getUsuarioID();

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            Usuario.getInstance().setNombre(response.getString("Nombre"));
                            Usuario.getInstance().setApellido(response.getString("Apellido"));
                            Usuario.getInstance().setTelefono(response.getString("Telefono"));
                            Usuario.getInstance().setCorreo(response.getString("Correo"));

                            //txtUsuario.setText(Usuario.getInstance().getNombre()+" "+Usuario.getInstance().getApellido()+" Bienvenido");
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
        MySingleton.getInstance(this).addToRequestQueue(jsonObjectRequest);
    }

    private void actualizarLista(){
        String url = "http://192.168.0.12:1234/api/Usuario/GetUsuario/"+Usuario.getInstance().getUsuarioID();

        JsonArrayRequest jsonObjectRequest = new JsonArrayRequest
            (Request.Method.GET, url, null, new Response.Listener<JSONArray>() {

                @Override
                public void onResponse(JSONArray response) {
                    List<Alarma> alarmas = new LinkedList<>();
                    try {
                        for (int i = 0; i < response.length(); i++) {
                            Alarma alarma = new Alarma();
                            alarma.setAlarmaId(response.getJSONObject(i).getInt("AlarmaId"));
                            alarma.setCodigo(response.getJSONObject(i).getString("Codigo"));
                            alarma.setEstado(response.getJSONObject(i).getInt("Estado"));
                            alarma.setAlerta(response.getJSONObject(i).getInt("Alerta"));
                            alarma.setLatitud(response.getJSONObject(i).getString("Latitud"));
                            alarma.setLongitud(response.getJSONObject(i).getString("Longitud"));
                            alarma.setUsuarioID(response.getJSONObject(i).getInt("UsuarioID"));
                            alarma.setContrasena(response.getJSONObject(i).getString("Contrasena"));
                            alarma.setNombre(response.getJSONObject(i).getString("Nombre"));
                            alarmas.add(alarma);
                        }

                        LlavesAdapter adapter = new LlavesAdapter(alarmas,Principal.this);
                        listView.setAdapter(adapter);
                        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                            @Override
                            public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
                                Intent intent = new Intent(Principal.this, Abrir.class);
                                intent.putExtra("LLAVE_ID", (int)id);
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
        MySingleton.getInstance(this).addToRequestQueue(jsonObjectRequest);
    }


}
