package daily.pruebaconexion;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
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
import android.widget.Toast;


import java.util.List;

import daily.pruebaconexion.Adapter.LlavesAdapter;
import daily.pruebaconexion.BRL.LlaveBRL;
import daily.pruebaconexion.BRL.UsuarioBRL;
import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Llave;


public class Principal extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    ListView listView;
    TextView txtUsuario, txtusuarioname;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_principal);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);



        txtUsuario = findViewById(R.id.txtUser);

        listView = findViewById(R.id.list_Keys);

        UsuarioBRL.obtenerUsuario(txtUsuario, Principal.this);

        actualizar_Alarmas();


        //txtUsuario.setText("Tus Llaves:"+Usuario.getInstance().getNombre()+" "+Usuario.getInstance().getApellido());
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                Principal.this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);


    }


    public void actualizar_Alarmas(){
        List<Llave> llaves = LlaveBRL.actualizarLista(Principal.this);
        final LlavesAdapter adapter = new LlavesAdapter(llaves,Principal.this);
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
                Intent intent = new Intent(Principal.this, Abrir.class);
                Llave llave =  adapter.getItem(position);
                Log.i("Alarma", "verificarLlave: "+llave.getAlarmaId());
                intent.putExtra("ALARMA_ID", llave.getAlarmaId());
                startActivity(intent);
            }
        });
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
            Intent intent = new Intent(Principal.this, Principal.class);
            startActivity(intent);
            finish();
            Toast.makeText(Principal.this, "Actualizando", Toast.LENGTH_LONG).show();
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
            Intent intent = new Intent(Principal.this, Productos.class);
            startActivity(intent);
        }else if (id == R.id.nsv_llaves) {
            Intent intent = new Intent(Principal.this, LlavesObtenidas.class);
            startActivity(intent);
        }else if(id == R.id.nav_close){
            Intent intent = new Intent(Principal.this, LoginActivity.class);
            intent.putExtra("Salir",true);
            startActivity(intent);
        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

}
