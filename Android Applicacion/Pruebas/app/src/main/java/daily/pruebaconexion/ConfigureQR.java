package daily.pruebaconexion;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.ViewGroup;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONException;
import org.json.JSONObject;

import daily.pruebaconexion.Extras.VarGlobal;
import daily.pruebaconexion.Modelo.Alarma;
import daily.pruebaconexion.Servicio.MySingleton;
import me.dm7.barcodescanner.zbar.Result;
import me.dm7.barcodescanner.zbar.ZBarScannerView;

public class ConfigureQR extends AppCompatActivity implements ZBarScannerView.ResultHandler {
    private ZBarScannerView mScannerView;

    public static String CODIGO = "VACIOQR";
    public static int ID = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_configure_qr);
        ViewGroup contentFrame = (ViewGroup) findViewById(R.id.content_frame);
        mScannerView = new ZBarScannerView(this);
        contentFrame.addView(mScannerView);
    }

    @Override
    public void onResume() {
        super.onResume();
        mScannerView.setResultHandler(this);
        mScannerView.startCamera();
    }

    @Override
    public void onPause() {
        super.onPause();
        mScannerView.stopCamera();
    }

    @Override
    public void handleResult(Result rawResult) {
        //Toast.makeText(this, "Contents = " + rawResult.getContents() +
              //  ", Format = " + rawResult.getBarcodeFormat().getName(), Toast.LENGTH_SHORT).show();

        CODIGO = rawResult.getContents()+"";

        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                mScannerView.resumeCameraPreview(ConfigureQR.this);
            }
        }, 2000);
        obtenerAlarma();
    }

    public void obtenerAlarma(){
        String url = "http://"+ VarGlobal.IP+":1234/api/Alarma/GetAlarmaByCodigo/"+CODIGO;

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
        (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

            @Override
            public void onResponse(JSONObject response) {
                //mTextView.setText("Response: " + response.toString());
                try {
                    Alarma alarma = new Alarma();
                    alarma.setAlarmaId(response.getInt("AlarmaId"));
                    alarma.setCodigo(response.getString("Codigo").trim());
                    alarma.setEstado(response.getInt("Estado"));
                    ID = alarma.getAlarmaId();
                    if(alarma.getEstado() == 0){
                        showMessageDialog("Producto:","Listo para configurarse.",1);
                    }else{
                        showMessageDialog("Producto:","El producto ya esta configurado.",0);
                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
        }, new Response.ErrorListener() {

            @Override
            public void onErrorResponse(VolleyError error) {
                // TODO: Handle error
                if (error.networkResponse.statusCode == 404) {
                    showMessageDialog("ERROR:","Producto no existente.", 2);
                }else if(error.networkResponse == null){
                    if(error.getClass().equals(TimeoutError.class)){
                        showMessageDialog("ERROR:","NULL:"+error,2);
                    }
                }else{
                    showMessageDialog("ERROR:",error.toString(),2);
            }
            }
        });
        MySingleton.getInstance(this).addToRequestQueue(jsonObjectRequest);
    }

    public void showMessageDialog(String titulo,String message, final int poner) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(this);
        dialogo.setTitle(titulo);
        dialogo.setMessage(message);
        dialogo.setCancelable(false);

        dialogo.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                if(poner ==1){
                    Intent intent = new Intent(ConfigureQR.this, ConfigureGPS.class);
                    startActivity(intent);
                    finish();
                }else{
                    Intent intent = new Intent(ConfigureQR.this, Principal.class);
                    startActivity(intent);
                    finish();
                }
            }
        });
        dialogo.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialogInterface, int id) {
                //codigo
            }
        });
        dialogo.show();
    }
}
