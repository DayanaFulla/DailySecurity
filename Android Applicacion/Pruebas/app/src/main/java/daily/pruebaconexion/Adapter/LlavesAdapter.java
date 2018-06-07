package daily.pruebaconexion.Adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import java.util.List;

import daily.pruebaconexion.Handlers.LlavesItemAdapter;
import daily.pruebaconexion.Modelo.Alarma;

public class LlavesAdapter extends BaseAdapter{

    private List<Alarma> alarmas;
    private Context context;

    public LlavesAdapter(List<Alarma> alarmas, Context context) {
        this.alarmas = alarmas;
        this.context = context;
    }

    public int getCount(){
        return alarmas.size();
    }

    public Alarma getItem(int position){
        Alarma alarma = alarmas.get(position);
        return alarma;
    }

    public long getItemId(int position) {
        Alarma obj = alarmas.get(position);
        return obj.getUsuarioID();
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        Alarma obj = alarmas.get(position);
        convertView = new LlavesItemAdapter(context, obj);
        return convertView;
    }
}
