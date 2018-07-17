package daily.pruebaconexion.Extras;

import android.content.Context;
import android.content.SharedPreferences;

import com.android.volley.toolbox.StringRequest;

import java.util.logging.FileHandler;

public class GlobalInicioSesion {

    final static String fileName = "DailySecurity";

    public static String readSharedSetting (Context ctxt, String settingName, String defaultValue){
        SharedPreferences preferences = ctxt.getSharedPreferences(fileName, ctxt.MODE_PRIVATE);
        return preferences.getString(settingName, defaultValue);
    }

    public static void saveSharedSetting(Context context, String settingName, String settingValue){
        SharedPreferences preferences = context.getSharedPreferences(fileName, context.MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString(settingName,settingValue);
        editor.apply();
    }

    public static void SharedPrefeSave(Context context, String name){
        SharedPreferences preferences = context.getSharedPreferences("UsuarioID", 0);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString("UsuarioID",name);
        editor.commit();
    }
}
