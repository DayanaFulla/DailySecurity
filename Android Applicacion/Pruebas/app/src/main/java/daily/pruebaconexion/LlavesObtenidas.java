package daily.pruebaconexion;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.InputType;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Toast;

import java.util.List;

import daily.pruebaconexion.Adapter.LlavesObtenidasAdapter;
import daily.pruebaconexion.Adapter.LlavesPrestadasAdapter;
import daily.pruebaconexion.BRL.LlaveBRL;
import daily.pruebaconexion.Extras.LlaveAux;
import daily.pruebaconexion.Handlers.PrestadasItemAdapter;
import daily.pruebaconexion.Modelo.Llave;
import daily.pruebaconexion.Modelo.Usuario;

public class LlavesObtenidas extends AppCompatActivity {

    ListView listView;
    LlavesObtenidasAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_llaves_obtenidas);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG).setAction("Action", null).show();
                AlertDialog.Builder builder = new AlertDialog.Builder(LlavesObtenidas.this);
                builder.setTitle("Codigo de Llave:");

                final EditText input = new EditText(LlavesObtenidas.this);
                input.setInputType(InputType.TYPE_TEXT_FLAG_MULTI_LINE);
                input.setSingleLine(true);
                input.setPadding(100, 50,50,50);
                input.setGravity(Gravity.LEFT | Gravity.TOP);
                builder.setView(input);
                builder.setPositiveButton("Buscar", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int whichButton) {
                        LlaveBRL.obtenerLlavePorCodigo(LlavesObtenidas.this, input.getText()+"");
                    }
                });

                builder.setNegativeButton("Cancelar",
                        new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                dialog.dismiss();
                            }
                        });
                AlertDialog alert = builder.create();
                alert.show();
            }
        });



        listView = findViewById(R.id.list_obtenidas);

        //registerForContextMenu(listView);
        LlaveBRL.getObtenidas(LlavesObtenidas.this, listView);
//        adapter = new LlavesObtenidasAdapter(llaves,LlavesObtenidas.this);
//        listView.setAdapter(adapter);
//        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
//            @Override
//            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
//                Intent intent = new Intent(LlavesObtenidas.this, EditarLlave.class);
//                Llave llave = adapter.getItem(i);
//                LlaveAux.getInstance().setLlaveId(llave.getLlaveId());
//                LlaveAux.getInstance().setCodigo(llave.getCodigo());
//                LlaveAux.getInstance().setEstado(llave.getEstado());
//                LlaveAux.getInstance().setTipo(llave.getTipo());
//                LlaveAux.getInstance().setNick(llave.getNick());
//                LlaveAux.getInstance().setAlarmaId(llave.getAlarmaId());
//                LlaveAux.getInstance().setHoraInicio(llave.getHoraInicio());
//                LlaveAux.getInstance().setHoraFin(llave.getHoraFin());
//                LlaveAux.getInstance().setFechaInicio(llave.getFechaInicio());
//                LlaveAux.getInstance().setFechaFin(llave.getFechaFin());
//                LlaveAux.getInstance().setDias(llave.getDias());
//                LlaveAux.getInstance().setUsuarioId(llave.getUsuarioId());
//                LlaveAux.getInstance().setNombre(llave.getNombre());
//                LlaveAux.getInstance().setActDias(llave.getActDias());
//                LlaveAux.getInstance().setActHora(llave.getActHora());
//                intent.putExtra("Llave_id", llave.getLlaveId());
//                startActivity(intent);
//            }
//        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.principal, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            Intent intent = new Intent(LlavesObtenidas.this, LlavesObtenidas.class);
            startActivity(intent);
            finish();
            Toast.makeText(LlavesObtenidas.this, "Actualizando Cerraduras", Toast.LENGTH_LONG).show();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

}
