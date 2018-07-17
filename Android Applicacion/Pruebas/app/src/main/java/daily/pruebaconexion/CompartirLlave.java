package daily.pruebaconexion;

import android.app.DatePickerDialog;
import android.app.DialogFragment;
import android.app.TimePickerDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.text.method.DateTimeKeyListener;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;

import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import daily.pruebaconexion.BRL.LlaveBRL;
import daily.pruebaconexion.Extras.DatePickerFragment;
import daily.pruebaconexion.Extras.TimePickerFragment;
import daily.pruebaconexion.Modelo.Llave;

public class CompartirLlave extends AppCompatActivity implements View.OnClickListener {

    EditText txt_Nick,txt_FechaInicio,txt_FechaFin,txt_HoraInicio, txt_HoraFin,txt_Codigo;
    CheckBox act_dias, act_horas, ch_LU,ch_MA,ch_MI,ch_JU,ch_VI,ch_SA,ch_DO;
    RadioGroup grupo;
    RadioButton rd_tipo, rd_PER, rd_TEM;
    Button btn_Generar, btn_Listo;
    LinearLayout linearTemporal;
    TextView txt_titulo, txt_msg;
    String horainicio, horafin, fechainicio, fechafin, diasselec;
    int AlramId;
    Llave llave;
    private int hora, minutos, dia, mes, ano;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_compartir_llave);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Intent intentaux = getIntent();
        AlramId = intentaux.getIntExtra("Alarma_id", -1);

        txt_Nick = findViewById(R.id.txtNick);
        txt_FechaInicio = findViewById(R.id.txtFechaInicio);
        txt_FechaFin = findViewById(R.id.txtFechaFin);
        txt_HoraInicio = findViewById(R.id.txtHoraInicio);
        txt_HoraFin =findViewById(R.id.txtHoraFin);

        txt_msg = findViewById(R.id.txt_msg);

        ch_LU = findViewById(R.id.LU);
        ch_MA= findViewById(R.id.MA);
        ch_MI= findViewById(R.id.MI);
        ch_JU= findViewById(R.id.JU);
        ch_VI= findViewById(R.id.VI);
        ch_SA= findViewById(R.id.SA);
        ch_DO= findViewById(R.id.DO);
        act_dias = findViewById(R.id.dias);
        act_horas = findViewById(R.id.horas);


        btn_Listo = findViewById(R.id.btnCompartir);

        linearTemporal = findViewById(R.id.div_fecha);

        txt_titulo = findViewById(R.id.txtTitulo);

        grupo = (RadioGroup) findViewById(R.id.opciones_usuario);

        rd_PER = findViewById(R.id.radio_permanente);
        rd_TEM = findViewById(R.id.radio_temporal);

        btn_Listo.setOnClickListener(this);
        txt_FechaInicio.setOnClickListener(this);
        txt_FechaFin.setOnClickListener(this);
        txt_HoraInicio.setOnClickListener(this);
        txt_HoraFin.setOnClickListener(this);

        ch_LU.setOnClickListener(this);
        ch_MA.setOnClickListener(this);
        ch_MI.setOnClickListener(this);
        ch_JU.setOnClickListener(this);
        ch_VI.setOnClickListener(this);
        ch_SA.setOnClickListener(this);
        ch_DO.setOnClickListener(this);
        act_dias.setOnClickListener(this);
        act_horas.setOnClickListener(this);
        rd_PER.setOnClickListener(this);
        rd_TEM.setOnClickListener(this);

        grupo.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup radioGroup, int i) {
                if(i == R.id.radio_permanente){
                    Toast.makeText(CompartirLlave.this, "Permanente", Toast.LENGTH_LONG).show();
                    txt_titulo.setText("Permanente");
                    LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, 0);
                    linearTemporal.setLayoutParams(params);
                }else if(i == R.id.radio_temporal){
                    Toast.makeText(CompartirLlave.this, "Temporal", Toast.LENGTH_LONG).show();
                    txt_titulo.setText("Temporal");
                    LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.MATCH_PARENT);
                    linearTemporal.setLayoutParams(params);
                    txt_FechaFin.setEnabled(true);
                    txt_FechaInicio.setEnabled(true);
                }
            }
        });
//

    }

    @Override
    public void onClick(View view) {
        if(act_dias.isChecked()){
            ch_LU.setEnabled(true);
            ch_MA.setEnabled(true);
            ch_MI.setEnabled(true);
            ch_JU.setEnabled(true);
            ch_VI.setEnabled(true);
            ch_SA.setEnabled(true);
            ch_DO.setEnabled(true);
        }else if (!act_dias.isChecked()){
            ch_LU.setEnabled(false);
            ch_MA.setEnabled(false);
            ch_MI.setEnabled(false);
            ch_JU.setEnabled(false);
            ch_VI.setEnabled(false);
            ch_SA.setEnabled(false);
            ch_DO.setEnabled(false);
        }
        if(act_horas.isChecked()){
            txt_HoraInicio.setEnabled(true);
            txt_HoraFin.setEnabled(true);
        }else if(!act_horas.isChecked()){
            txt_HoraInicio.setEnabled(false);
            txt_HoraFin.setEnabled(false);
        }
        if(view==txt_HoraFin){
            final Calendar c= Calendar.getInstance();
             hora = c.get(Calendar.HOUR_OF_DAY);
             minutos= c.get(Calendar.MINUTE);

            TimePickerDialog timePickerDialog = new TimePickerDialog(this, new TimePickerDialog.OnTimeSetListener() {
                @Override
                public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
                    txt_HoraFin.setText(twoDigits(hourOfDay)+":"+twoDigits(minute));
                    horafin = twoDigits(hourOfDay)+":"+twoDigits(minute)+":00";
                }
            },hora,minutos,true);
            timePickerDialog.setTitle("Fecha Fin:");
            timePickerDialog.show();
        }
        if(view==txt_HoraInicio){
            final Calendar c= Calendar.getInstance();
            hora = c.get(Calendar.HOUR_OF_DAY);
            minutos= c.get(Calendar.MINUTE);

            TimePickerDialog timePickerDialog = new TimePickerDialog(this, new TimePickerDialog.OnTimeSetListener() {
                @Override
                public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
                    txt_HoraInicio.setText(twoDigits(hourOfDay)+":"+twoDigits(minute));
                    horainicio = twoDigits(hourOfDay)+":"+twoDigits(minute)+":00";
                }
            },hora,minutos,true);
            timePickerDialog.setTitle("Fecha Inicio:");
            timePickerDialog.show();
        }
        if(view==txt_FechaInicio){
            final Calendar c= Calendar.getInstance();
            dia=c.get(Calendar.DAY_OF_MONTH);
            mes=c.get(Calendar.MONTH);
            ano=c.get(Calendar.YEAR);

            DatePickerDialog datePickerDialog = new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener() {
                @Override
                public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                    txt_FechaInicio.setText(twoDigits(year)+"-"+ twoDigits(monthOfYear+1)+"-"+twoDigits(dayOfMonth));
                    fechainicio = twoDigits(year) +"-"+ twoDigits(monthOfYear+1)+"-"+twoDigits(dayOfMonth);
                }
            },dia,mes,ano);
            datePickerDialog.getDatePicker().setMinDate(c.getTimeInMillis());
            datePickerDialog.setTitle("Fecha Inicio:");
            datePickerDialog.show();
        }
        if(view==txt_FechaFin){
            final Calendar c= Calendar.getInstance();
            dia=c.get(Calendar.DAY_OF_MONTH);
            mes=c.get(Calendar.MONTH);
            ano=c.get(Calendar.YEAR);

            DatePickerDialog datePickerDialog = new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener() {
                @Override
                public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                    txt_FechaFin.setText(twoDigits(year)+"-"+ twoDigits(monthOfYear+1)+"-"+twoDigits(dayOfMonth));
                    fechafin = twoDigits(year)+"-"+ twoDigits(monthOfYear+1)+"-"+twoDigits(dayOfMonth);
                }
            },dia,mes,ano);
            datePickerDialog.getDatePicker().setMinDate(c.getTimeInMillis());
            datePickerDialog.setTitle("Fecha Fin:");
            datePickerDialog.show();
        }
        if(view == btn_Listo){
            generarLlave();
        }

    }


    public void generarLlave(){
        llave = new Llave();

        if(txt_Nick.getText().toString().isEmpty()){
            txt_msg.setText("Ingrese nombre de invitado");
        }else{
            llave.setNick(txt_Nick.getText()+"");
        }
        llave.setAlarmaId(AlramId);
        if(rd_TEM.isChecked()){
            llave.setTipo("T");
            if(fechainicio == null || fechainicio.isEmpty() || fechafin == null || fechafin.isEmpty() ){
                Log.e("Hora", "generarLlave: "+fechainicio+fechafin );
                txt_msg.setText("Revise los datos de Fecha");
                return;
            }else{
                DateFormat format = new SimpleDateFormat("yyyy-mm-dd");
                try {
                    Date date = format.parse(fechainicio);
                    Date date2 = format.parse(fechafin);
                    llave.setFechaInicio(date);
                    llave.setFechaFin(date2);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

        }else if(rd_PER.isChecked()){
            llave.setTipo("P");
        }
        if(act_horas.isChecked()){
            llave.setActHora(1);
            Log.e("Hora", "generarLlave: "+horafin+horainicio );
            if(horainicio == null || horainicio.isEmpty() || horafin == null || horafin.isEmpty() ){
                txt_msg.setText("Revise los datos de Hora");
                return;
            }else{
                Time tm_inicio = Time.valueOf(horainicio);
                Time tm_fin = Time.valueOf(horafin);
                llave.setHoraInicio(tm_inicio);
                llave.setHoraFin(tm_fin);
            }

        }else if(!act_horas.isChecked()){
            llave.setActHora(0);
        }
        if(act_dias.isChecked()){
            llave.setActDias(1);
            StringBuilder dias = new StringBuilder();
            if(ch_LU.isChecked())
                dias = dias.append("LU|");
            if(ch_MA.isChecked())
                dias = dias.append("MA|");
            if(ch_MI.isChecked())
                dias = dias.append("MI|");
            if(ch_JU.isChecked())
                dias = dias.append("JU|");
            if(ch_VI.isChecked())
                dias = dias.append("VI|");
            if(ch_SA.isChecked())
                dias = dias.append("SA|");
            if(ch_DO.isChecked())
                dias = dias.append("DO|");
            if(dias.length()== 0 || dias == null){
                txt_msg.setText("Seleccione los dias");
                return;
            }
            llave.setDias(dias.toString());
        }else{
            llave.setActDias(0);
        }


        showMessageDialog(CompartirLlave.this, llave);
    }


    private String twoDigits(int n) {
        return (n<=9) ? ("0"+n) : String.valueOf(n);
    }

    public void showMessageDialog(final Context context, final Llave llave1) {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(context);
        dialogo.setTitle("Aceptar:");
        final String codigo = Llave.generadorCodigo();
        llave.setCodigo(codigo);
        dialogo.setMessage("Codigo de Llave: "+codigo);
        dialogo.setCancelable(false);
        dialogo.setPositiveButton("ACEPTAR", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                LlaveBRL.setTipo(context, llave1);
                Compartir(codigo);

            }
        });
        dialogo.show();
    }

    public void Compartir(String codigo){
        Intent intentCompartir = new Intent(Intent.ACTION_SEND);
        intentCompartir.setType("text/plain");
        intentCompartir.putExtra(Intent.EXTRA_SUBJECT, "Daily Security");
        intentCompartir.putExtra(Intent.EXTRA_TEXT, "Codigo de Llave: "+codigo);
        Intent principal = new Intent(CompartirLlave.this, Principal.class);
        Intent[] intents = {principal,intentCompartir};
        this.startActivities(intents);
        finish();
    }

}
