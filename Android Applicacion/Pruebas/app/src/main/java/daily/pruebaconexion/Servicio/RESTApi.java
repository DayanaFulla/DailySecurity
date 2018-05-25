package daily.pruebaconexion.Servicio;

import android.content.Context;
import android.view.View;
import android.widget.ProgressBar;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.Volley;

public class RESTApi {
    private static RESTApi instance;
    private RequestQueue requestQueue;
    private static  Context context;

    public RESTApi(Context context) {
        this.context = context;
        this.requestQueue = getRequestQueue();
    }

    public static synchronized RESTApi getInstance(Context context) {
        if(instance == null){
            instance = new RESTApi(context);
        }
        return instance;
    }

    public<T> void addToRequestque(Request<T> request){

    }

    public RequestQueue getRequestQueue() {
        if(requestQueue == null){
            requestQueue = Volley.newRequestQueue(context.getApplicationContext());
        }
        return requestQueue;
    }

    public static Context getContext() {
        return context;
    }
}
