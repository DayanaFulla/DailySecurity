package daily.pruebaconexion;

import android.app.DatePickerDialog;
import android.app.DialogFragment;
import android.os.Build;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.text.method.DateTimeKeyListener;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.TimePicker;

import daily.pruebaconexion.Extras.DatePickerFragment;
import daily.pruebaconexion.Extras.TimePickerFragment;

public class CompartirLlave extends AppCompatActivity implements View.OnClickListener{

    EditText txt_Nick,txt_FechaInicio,txt_FechaFin,txt_HoraInicio, txt_HoraFin,txt_Codigo;
    CheckBox ch_LU,ch_MA,ch_MI,ch_JU,ch_VI,ch_SA,ch_DO;
    RadioButton rd_TEM, rd_PER;
    Button btn_Generar, btn_Listo;

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_compartir_llave);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        txt_Nick = findViewById(R.id.txtNick);
        txt_FechaInicio = findViewById(R.id.txtFechaInicio);
        txt_FechaFin = findViewById(R.id.txtFechaFin);
        txt_HoraInicio = findViewById(R.id.txtHoraInicio);
        txt_HoraFin =findViewById(R.id.txtHoraFin);
        txt_Codigo = findViewById(R.id.txtCodigo);

        ch_LU = findViewById(R.id.LU);
        ch_MA= findViewById(R.id.MA);
        ch_MI= findViewById(R.id.MI);
        ch_JU= findViewById(R.id.JU);
        ch_VI= findViewById(R.id.VI);
        ch_SA= findViewById(R.id.SA);
        ch_DO= findViewById(R.id.DO);

        rd_PER = findViewById(R.id.radioPermanente);
        rd_TEM = findViewById(R.id.radioTemporal);

        btn_Generar = findViewById(R.id.btnGenerar);
        btn_Listo = findViewById(R.id.btnListo);

        btn_Listo.setOnClickListener(this);
        btn_Generar.setOnClickListener(this);
        txt_FechaInicio.setOnClickListener(this);
        txt_FechaFin.setOnClickListener(this);
        txt_HoraInicio.setOnClickListener(this);
        txt_HoraFin.setOnClickListener(this);

    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.btnListo:
                break;
            case R.id.btnGenerar:
                break;
            case R.id.txtFechaInicio:
                showDatePickerDialog(txt_FechaInicio);
                break;
            case R.id.txtFechaFin:
                showDatePickerDialog(txt_FechaFin);
                break;
            case R.id.txtHoraInicio:
                showTimePickerDialog(txt_HoraInicio);
                break;
            case R.id.txtHoraFin:
                showTimePickerDialog(txt_HoraFin);
                break;
        }
    }

    public void showTimePickerDialog(View v) {
        DialogFragment newFragment = new TimePickerFragment();
        newFragment.show(this.getFragmentManager(), "timePicker");
    }

    public void showDatePickerDialog(View v) {
        DialogFragment newFragment = new DatePickerFragment();
        newFragment.show(this.getFragmentManager(), "datePicker");


    }
}
