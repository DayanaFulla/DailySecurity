package daily.pruebaconexion.Extras;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Set;
import java.util.UUID;

public class GlobalBluetooth {
    private final String DEVICE_ADDRESS = "98:D3:31:FD:4E:1E"; //MAC Address of Bluetooth Module
    private final UUID PORT_UUID = UUID.fromString("00001101-0000-1000-8000-00805f9b34fb");

    private BluetoothDevice device;
    private BluetoothSocket socket;

    private OutputStream outputStream;
    private InputStream inputStream;
    private Context context;

    private Thread thread;
    private byte buffer[];

    private boolean stopThread;
    private boolean connected = false;
    private String command;

    private int conexion = 0 ;

    private static final GlobalBluetooth instaGLOBAL_BLUETOOTH = new GlobalBluetooth();

    public static GlobalBluetooth getInstance(Context ctxt){
        instaGLOBAL_BLUETOOTH.context = ctxt;
        instaGLOBAL_BLUETOOTH.setConexion(instaGLOBAL_BLUETOOTH.getConexion()+1);
        if(instaGLOBAL_BLUETOOTH.getConexion()== 1){
            instaGLOBAL_BLUETOOTH.conectar();
        }
        return instaGLOBAL_BLUETOOTH;
    }

    public int getConexion() {
        return conexion;
    }

    public void setConexion(int conexion) {
        this.conexion = conexion;
    }

    public String getDEVICE_ADDRESS() {
        return DEVICE_ADDRESS;
    }

    public UUID getPORT_UUID() {
        return PORT_UUID;
    }

    public BluetoothDevice getDevice() {
        return device;
    }

    public void setDevice(BluetoothDevice device) {
        this.device = device;
    }

    public BluetoothSocket getSocket() {
        return socket;
    }

    public void setSocket(BluetoothSocket socket) {
        this.socket = socket;
    }

    public OutputStream getOutputStream() {
        return outputStream;
    }

    public void setOutputStream(OutputStream outputStream) {
        this.outputStream = outputStream;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public Context getContext() {
        return context;
    }

    public void setContext(Context context) {
        this.context = context;
    }

    public Thread getThread() {
        return thread;
    }

    public void setThread(Thread thread) {
        this.thread = thread;
    }

    public byte[] getBuffer() {
        return buffer;
    }

    public void setBuffer(byte[] buffer) {
        this.buffer = buffer;
    }

    public boolean isStopThread() {
        return stopThread;
    }

    public void setStopThread(boolean stopThread) {
        this.stopThread = stopThread;
    }

    public boolean isConnected() {
        return connected;
    }

    public void setConnected(boolean connected) {
        this.connected = connected;
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public void conectar(){
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
                Log.e("Abrir", "conectar: "+e.toString());
            }
        }
    }

    public boolean iniciarBluetooth(){
        boolean found = false;

        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();

        if(bluetoothAdapter == null) //Comprueba si el dispositivo es compatible con bluetooth
        {
            Toast.makeText(context.getApplicationContext(), "El dispositivo no es compatible con bluetooth", Toast.LENGTH_SHORT).show();
        }

        if(!bluetoothAdapter.isEnabled())
        //Comprueba si bluetooth está habilitado. Si no, el programa pedirá permiso al usuario para habilitarlo
        {
            Log.e("Bluetooth", "Ingreso bluetoothAdapter esta desahibilitado");
            Intent enableAdapter = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            Activity activity = (Activity)context;
            activity.startActivityForResult(enableAdapter,0);

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
            Toast.makeText(context.getApplicationContext(), "Por favor, empareje su dispositivo primero", Toast.LENGTH_SHORT).show();
        }
        else
        {
            for(BluetoothDevice iterator : bondedDevices)
            {
                if(iterator.getAddress().equals(DEVICE_ADDRESS))
                {
                    Log.e("Bluetooth", "Ingreso iterator get address");
                    device = iterator;
                    found = true;
                    break;
                }
            }
        }

        return found;
    }

    public boolean ConectarBluetooth(){
        try
        {
            socket = device.createRfcommSocketToServiceRecord(PORT_UUID);
            // Crea un socket para manejar la conexión saliente
            Log.e("Bluetooth", "Creo socket = device.createRfcommSocketToServiceRecord");
            socket.connect();
            Toast.makeText(context.getApplicationContext(),
                    "La conexión con el bluetooth fue exitosa", Toast.LENGTH_LONG).show();
            connected = true;
            Log.e("Bluetooth", "Connected true");

        }
        catch(IOException e)
        {
            e.printStackTrace();
            connected = false;
            Log.e("Bluetooth", "Connected false"+e.toString());
        }

        if(connected)
        {
            try
            {
                outputStream = socket.getOutputStream();
                Toast.makeText(context.getApplicationContext(), "output: "+outputStream.toString(), Toast.LENGTH_LONG).show();
                Log.e("Bluetooth", "outputStream = socket.getOutputStream");
                inputStream = socket.getInputStream();
                Toast.makeText(context.getApplicationContext(), "input: "+inputStream.toString(), Toast.LENGTH_LONG).show();
                // obtiene la corriente de entrada del socket
                // obtiene la corriente de salida del socket
            }
            catch (IOException e)
            {
                e.printStackTrace();
                Log.e("Bluetooth", " error en inicializar outputstream y el inputStream");

            }
        }

        return connected;
    }
}
