package proyectofinal.software3.dailysecurity;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Set;
import java.util.UUID;

public class MainActivity extends AppCompatActivity {

    private final String DEVICE_ADDRESS = "98:D3:31:FD:4E:1E"; //MAC Address of Bluetooth Module
    private final UUID PORT_UUID = UUID.fromString("00001101-0000-1000-8000-00805f9b34fb");

    private BluetoothDevice device;
    private BluetoothSocket socket;

    private OutputStream outputStream;
    private InputStream inputStream;

    Thread thread;
    byte buffer[];

    boolean stopThread;
    boolean connected = false;
    String command;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public boolean iniciarBluetooth(){
        boolean found = false;

        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();

        if(bluetoothAdapter == null) //Comprueba si el dispositivo es compatible con bluetooth
        {
            Toast.makeText(getApplicationContext(), "El dispositivo no es compatible con bluetooth", Toast.LENGTH_SHORT).show();
        }

        if(!bluetoothAdapter.isEnabled())
        //Comprueba si bluetooth está habilitado. Si no, el programa pedirá permiso al usuario para habilitarlo
        {
            Intent enableAdapter = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(enableAdapter,0);

            try
            {
                Thread.sleep(1000);
            }
            catch(InterruptedException e)
            {
                e.printStackTrace();
            }
        }

        Set<BluetoothDevice> bondedDevices = bluetoothAdapter.getBondedDevices();

        if(bondedDevices.isEmpty())
        // Verifica si hay dispositivos Bluetooth emparejados
        {
            Toast.makeText(getApplicationContext(), "Por favor, empareje su dispositivo primero", Toast.LENGTH_SHORT).show();
        }
        else
        {
            for(BluetoothDevice iterator : bondedDevices)
            {
                if(iterator.getAddress().equals(DEVICE_ADDRESS))
                {
                    device = iterator;
                    found = true;
                    break;
                }
            }
        }

        return found;
    }

    public boolean ConectarBluetooth()
    {
        try
        {
            socket = device.createRfcommSocketToServiceRecord(PORT_UUID);
            // Crea un socket para manejar la conexión saliente
            socket.connect();
            Toast.makeText(getApplicationContext(),
                    "La conexión con el bluetooth fue exitosa", Toast.LENGTH_LONG).show();
            connected = true;
        }
        catch(IOException e)
        {
            e.printStackTrace();
            connected = false;
        }

        if(connected)
        {
            try
            {
                outputStream = socket.getOutputStream();
                Toast.makeText(this, "output: "+outputStream.toString(), Toast.LENGTH_LONG).show();
                // obtiene la corriente de salida del socket
            }
            catch(IOException e)
            {
                e.printStackTrace();
            }

            try
            {
                inputStream = socket.getInputStream();
                Toast.makeText(this, "input: "+inputStream.toString(), Toast.LENGTH_LONG).show();
                // obtiene la corriente de entrada del socket
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }

        return connected;
    }

    void beginListenForData() //comienza a escuchar cualquier información entrante del Arduino
    {
        final Handler handler = new Handler();
        stopThread = false;
        buffer = new byte[1024];

        Thread thread = new Thread(new Runnable()
        {
            public void run()
            {
                while(!Thread.currentThread().isInterrupted() && !stopThread)
                {
                    try
                    {
                        int byteCount = inputStream.available();

                        if(byteCount > 0)
                        {
                            byte[] rawBytes = new byte[byteCount];
                            inputStream.read(rawBytes);
                            final String string = new String(rawBytes, "UTF-8");

                            handler.post(new Runnable()
                            {
                                public void run()
                                {
                                    if(string.equals("3"))
                                    {
                                        Toast.makeText(MainActivity.this, "Bloqueado", Toast.LENGTH_LONG).show();
                                    }
                                    else if(string.equals("4"))
                                    {
                                        Toast.makeText(MainActivity.this, "Desbloqueado", Toast.LENGTH_LONG).show();
                                    }
                                }
                            });
                        }
                    }
                    catch (IOException ex)
                    {
                        stopThread = true;
                    }
                }
            }
        });

        thread.start();
    }

    public void conectar(View view){
        if(iniciarBluetooth())
        {
            ConectarBluetooth();
            command = "3";
            try
            {
                outputStream.write(command.getBytes());
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
    }

    public void cambiarEstado(View view){
        if(connected == false)
        {
            Toast.makeText(getApplicationContext(), "Please establish a connection with the" +
                    " bluetooth servo door lock first", Toast.LENGTH_SHORT).show();
        }
        else
        {
            command = "1";

            try
            {
                outputStream.write(command.getBytes());
                //Envía el número 1 al Arduino. Para obtener una visión detallada de cómo se
                // maneja el comando resultante, consulte el Código fuente de Arduino.
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
    }

}
