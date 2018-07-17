package daily.pruebaconexion;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.InputType;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import daily.pruebaconexion.BRL.AlarmaBRL;
import daily.pruebaconexion.BRL.LlaveBRL;
import daily.pruebaconexion.Extras.GlobalBluetooth;
import daily.pruebaconexion.Extras.VarGlobal;
import daily.pruebaconexion.Modelo.Alarma;

import static daily.pruebaconexion.BRL.AlarmaBRL.getAlarmaID;

public class Abrir extends AppCompatActivity {

    private boolean abierto;
    private GlobalBluetooth globalBluetooth;
    byte buffer[];

    boolean stopThread;
    String command;
    int alarmaId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_abrir);
        globalBluetooth = GlobalBluetooth.getInstance(this);
        Intent intent = getIntent();
        alarmaId = intent.getIntExtra("ALARMA_ID", -1);
        Log.i("Alarma", "onCreate: "+alarmaId);
        AlarmaBRL.getAlarmaID(alarmaId, this);
    }

//    public boolean iniciarBluetooth(){
//        boolean found = false;
//
//        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
//
//        if(bluetoothAdapter == null) //Comprueba si el dispositivo es compatible con bluetooth
//        {
//            Toast.makeText(getApplicationContext(), "El dispositivo no es compatible con bluetooth", Toast.LENGTH_SHORT).show();
//        }
//
//        if(!bluetoothAdapter.isEnabled())
//        //Comprueba si bluetooth está habilitado. Si no, el programa pedirá permiso al usuario para habilitarlo
//        {
//            Log.e("Bluetooth", "Ingreso bluetoothAdapter esta desahibilitado");
//            Intent enableAdapter = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
//            startActivityForResult(enableAdapter,0);
//
//            try
//            {
//                Thread.sleep(1000);
//            }
//            catch(InterruptedException e)
//            {
//                e.printStackTrace();
//            }
//        }
//
//        Set<BluetoothDevice> bondedDevices = bluetoothAdapter.getBondedDevices();
//
//        if(bondedDevices.isEmpty())
//        // Verifica si hay dispositivos Bluetooth emparejados
//        {
//            Toast.makeText(getApplicationContext(), "Por favor, empareje su dispositivo primero", Toast.LENGTH_SHORT).show();
//        }
//        else
//        {
//            for(BluetoothDevice iterator : bondedDevices)
//            {
//                if(iterator.getAddress().equals(DEVICE_ADDRESS))
//                {
//                    Log.e("Bluetooth", "Ingreso iterator get address");
//                    device = iterator;
//                    found = true;
//                    break;
//                }
//            }
//        }
//
//        return found;
//    }
//
//    public boolean ConectarBluetooth()
//    {
//        try
//        {
//            socket = device.createRfcommSocketToServiceRecord(PORT_UUID);
//            // Crea un socket para manejar la conexión saliente
//            Log.e("Bluetooth", "Creo socket = device.createRfcommSocketToServiceRecord");
//            socket.connect();
//            Toast.makeText(getApplicationContext(),
//                    "La conexión con el bluetooth fue exitosa", Toast.LENGTH_LONG).show();
//            connected = true;
//            Log.e("Bluetooth", "Connected true");
//
//        }
//        catch(IOException e)
//        {
//            e.printStackTrace();
//            connected = false;
//            Log.e("Bluetooth", "Connected false"+e.toString());
//        }
//
//        if(connected)
//        {
//            try
//            {
//                outputStream = socket.getOutputStream();
//                Toast.makeText(this, "output: "+outputStream.toString(), Toast.LENGTH_LONG).show();
//                Log.e("Bluetooth", "outputStream = socket.getOutputStream");
//                inputStream = socket.getInputStream();
//                Toast.makeText(this, "input: "+inputStream.toString(), Toast.LENGTH_LONG).show();
//                // obtiene la corriente de entrada del socket
//                // obtiene la corriente de salida del socket
//            }
//            catch (IOException e)
//            {
//                e.printStackTrace();
//                Log.e("Bluetooth", " error en inicializar outputstream y el inputStream");
//
//            }
//        }
//
//        return connected;
//    }

//    void beginListenForData() //comienza a escuchar cualquier información entrante del Arduino
//    {
//        final Handler handler = new Handler();
//        stopThread = false;
//        buffer = new byte[1024];
//
//        Thread thread = new Thread(new Runnable()
//        {
//            public void run()
//            {
//                while(!Thread.currentThread().isInterrupted() && !stopThread)
//                {
//                    try
//                    {
//                        int byteCount = inputStream.available();
//
//                        if(byteCount > 0)
//                        {
//                            byte[] rawBytes = new byte[byteCount];
//                            inputStream.read(rawBytes);
//                            final String string = new String(rawBytes, "UTF-8");
//
//                            handler.post(new Runnable()
//                            {
//                                public void run()
//                                {
//                                    if(string.equals("3"))
//                                    {
//                                        Toast.makeText(Abrir.this, "Bloqueado", Toast.LENGTH_LONG).show();
//                                    }
//                                    else if(string.equals("4"))
//                                    {
//                                        Toast.makeText(Abrir.this, "Desbloqueado", Toast.LENGTH_LONG).show();
//                                    }
//                                }
//                            });
//                        }
//                    }
//                    catch (IOException ex)
//                    {
//                        stopThread = true;
//                    }
//                }
//            }
//        });
//
//        thread.start();
//    }

//    public void conectar(){
//        if(iniciarBluetooth())
//        {
//            ConectarBluetooth();
//            command = "3";
//            try
//            {
//                outputStream.write(command.getBytes());
//
//            }
//            catch (IOException e)
//            {
//                Log.e("Abrir", "conectar: "+e.toString());
//            }
//        }
//    }

    public void cambiarEstado(final View view){

        AlertDialog.Builder builder = new AlertDialog.Builder(Abrir.this);
        builder.setTitle("Ingrese el codigo de Alarma:");

        final EditText input = new EditText(Abrir.this);
        input.setInputType(InputType.TYPE_TEXT_FLAG_MULTI_LINE);
        input.setSingleLine(true);
        input.setPadding(100, 50,50,50);
        input.setGravity(Gravity.LEFT | Gravity.TOP);
        builder.setView(input);
        builder.setPositiveButton("Verificar", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                if(verificarContrasena(input.getText()+"".trim())){
                    if(globalBluetooth.isConnected() == false)
                    {
                        Toast.makeText(getApplicationContext(), "Please establish a connection with the" +
                                " bluetooth servo door lock first", Toast.LENGTH_SHORT).show();
                    }
                    else
                    {
                        command = "1";
                        try
                        {
                            ImageButton imageButton = (ImageButton)view;
                            if(!abierto){
                                abierto = true;
                                imageButton.setImageResource(R.drawable.ic_padlockopen);
                            }else{
                                abierto = false;
                                imageButton.setImageResource(R.drawable.ic_padlockclose);
                            }
                            globalBluetooth.getOutputStream().write(command.getBytes());
                            //Envía el número 1 al Arduino. Para obtener una visión detallada de cómo se
                            // maneja el comando resultante, consulte el Código fuente de Arduino.
                        }
                        catch (IOException e)
                        {
                            e.printStackTrace();
                        }
                    }
                }
//
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

    public boolean verificarContrasena(String contrasena){
        Log.i("Alarma", "verificarContrasena: "+ VarGlobal.CONTRESEÑA);
        if(VarGlobal.CONTRESEÑA.equals(contrasena)){
            return true;
        }
        showMessageDialog();
        return false;
    }

    public void showMessageDialog() {

        AlertDialog.Builder dialogo = new AlertDialog.Builder(Abrir.this);
        dialogo.setTitle("Alerta:");
        dialogo.setMessage("Verifique bien su contraseña.");
        dialogo.setCancelable(true);
        dialogo.setPositiveButton("ACEPTAR", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                Intent intent = new Intent(Abrir.this , Principal.class);
                startActivity(intent);
            }
        });
        dialogo.show();
    }
}
