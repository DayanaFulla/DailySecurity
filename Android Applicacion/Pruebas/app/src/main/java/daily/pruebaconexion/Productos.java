package daily.pruebaconexion;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.ContextMenu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.w3c.dom.Text;

import java.util.LinkedList;
import java.util.List;

import daily.pruebaconexion.Adapter.CerradurasAdapter;
import daily.pruebaconexion.BRL.AlarmaBRL;
import daily.pruebaconexion.Extras.VarGlobal;
import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Usuario;
import daily.pruebaconexion.Servicio.MySingleton;

public class Productos extends AppCompatActivity {

    ListView listView;
    CerradurasAdapter adapter;
    /*public static List<Alarma> alarmas = new LinkedList<>();*/

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_productos);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);


        listView = findViewById(R.id.list_product);
        registerForContextMenu(listView);
        List<Alarma> alarms = AlarmaBRL.actualizarAlarmas(listView, Productos.this);
        adapter = new CerradurasAdapter(alarms,Productos.this);
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent(Productos.this, AdministracionLlaves.class);
                Alarma alarma = adapter.getItem(i);
                intent.putExtra("Alarma_id", alarma.getAlarmaId());
                //Log.e("INFO:",txtUsr.getText()+"");
                startActivity(intent);
            }
        });
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
                Alarma alarma = adapter.getItem(info.position);
                Toast.makeText(this, "OBTUVO: "+alarma.getAlarmaId(), Toast.LENGTH_LONG).show();
                Intent intent = new Intent(Productos.this, CompartirLlave.class);
                intent.putExtra("Alarma_id", alarma.getAlarmaId());
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
