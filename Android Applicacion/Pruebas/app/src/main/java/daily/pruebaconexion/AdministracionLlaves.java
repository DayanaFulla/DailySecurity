package daily.pruebaconexion;

import android.content.Intent;
import android.os.Parcelable;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.ContextMenu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import java.util.List;

import daily.pruebaconexion.Adapter.LlavesAdapter;
import daily.pruebaconexion.Adapter.LlavesPrestadasAdapter;
import daily.pruebaconexion.BRL.LlaveBRL;
import daily.pruebaconexion.Extras.LlaveAux;
import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.Modelo.Usuario;

public class AdministracionLlaves extends AppCompatActivity {

    ListView listView;
    LlavesPrestadasAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_administracion_llaves);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Intent intentaux = getIntent();
        int id = intentaux.getIntExtra("Alarma_id", -1);

        listView = findViewById(R.id.list_llaves_prestadas);

        registerForContextMenu(listView);

        List<Llave> llaves = LlaveBRL.getPrestadas(this, id, Usuario.getInstance().getUsuarioID());
        adapter = new LlavesPrestadasAdapter(llaves,AdministracionLlaves.this);
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent(AdministracionLlaves.this, EditarLlave.class);
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
                intent.putExtra("Llave_id", llave.getLlaveId());
                startActivity(intent);
            }
        });
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        MenuInflater inflater = new MenuInflater(this);
        inflater.inflate(R.menu.menu_llaves,menu);

    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
        switch (item.getItemId()) {
            case R.id.menu_eliminar_llave:
                Llave llave = adapter.getItem(info.position);
                Toast.makeText(this, "OBTUVO: "+llave.getLlaveId()+ " Se eliminara", Toast.LENGTH_LONG).show();
                return true;
            default:
                return super.onContextItemSelected(item);
        }
    }
}
