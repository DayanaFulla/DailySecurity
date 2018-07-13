package daily.pruebaconexion.Adapter;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;

import java.util.List;

import daily.pruebaconexion.Handlers.LlavesItemAdapter;
import daily.pruebaconexion.Modelo.Llave;

public class LlavesAdapter extends BaseAdapter{

    private List<Llave> llaves;
    private Context context;
    private String tipo;

    public LlavesAdapter(List<Llave> llaves, Context context) {
        this.llaves = llaves;
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
        convertView = new LlavesItemAdapter(context, obj);
        return convertView;
    }
}
