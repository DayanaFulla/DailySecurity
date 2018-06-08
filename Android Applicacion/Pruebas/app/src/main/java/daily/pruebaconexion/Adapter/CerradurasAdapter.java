package daily.pruebaconexion.Adapter;

import android.content.Context;
import android.provider.CallLog;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.android.volley.Response;

import org.json.JSONArray;

import java.util.List;

import daily.pruebaconexion.Handlers.CerradurasItemAdapter;
import daily.pruebaconexion.Handlers.LlavesItemAdapter;
import daily.pruebaconexion.Modelo.Alarma;

public class CerradurasAdapter extends BaseAdapter{
    private List<Alarma> alarmas;
    private Context context;

    public CerradurasAdapter(List<Alarma> alarmas, Context context) {
        this.alarmas = alarmas;
        Log.e("RecADP",alarmas.size()+"");
        this.context = context;
    }


    public int getCount(){
        return alarmas.size();
    }

    public Alarma getItem(int position){
        Alarma obj = alarmas.get(position);
        return obj;
    }

    public long getItemId(int position) {
        Alarma obj = alarmas.get(position);
        return obj.getAlarmaId();
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        Alarma obj = alarmas.get(position);
        Log.e("EnvItem",obj.getNombre());
        convertView = new CerradurasItemAdapter(context, obj);
        return convertView;
    }
}
