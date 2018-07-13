package daily.pruebaconexion.Adapter;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import java.util.List;

import daily.pruebaconexion.Handlers.LlavesPrestadasItemAdapter;
import daily.pruebaconexion.Handlers.PrestadasItemAdapter;
import daily.pruebaconexion.Modelo.Llave;

public class LlavesObtenidasAdapter extends BaseAdapter {
    private List<Llave> llaves;
    private Context context;
    private String tipo;

    public LlavesObtenidasAdapter(List<Llave> llaves, Context context) {
        this.llaves = llaves;
        Log.e("LLAVESOBTENIEDNO:", "llaves tamaño adapter: "+llaves.size());
        this.context = context;
    }

    public int getCount(){
        return llaves.size();
    }

    public Llave getItem(int position){
        Llave obj = llaves.get(position);
        return obj;
    }

    public long getItemId(int position) {
        Llave obj = llaves.get(position);
        return obj.getLlaveId();
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        Llave obj = llaves.get(position);
        convertView = new PrestadasItemAdapter(context, obj);
        return convertView;
    }
}
