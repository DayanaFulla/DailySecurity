/*
  Software serial multple serial test

 Receives from the hardware serial, sends to software serial.
 Receives from software serial, sends to hardware serial.

 The circuit:
 * RX is digital pin 10 (connect to TX of other device)
 * TX is digital pin 11 (connect to RX of other device)

 Note:
 Not all pins on the Mega and Mega 2560 support change interrupts,
 so only the following can be used for RX:
 10, 11, 12, 13, 50, 51, 52, 53, 62, 63, 64, 65, 66, 67, 68, 69

 Not all pins on the Leonardo and Micro support change interrupts,
 so only the following can be used for RX:
 8, 9, 10, 11, 14 (MISO), 15 (SCK), 16 (MOSI).

 created back in the mists of time
 modified 25 May 2012
 by Tom Igoe
 based on Mikal Hart's example

 This example code is in the public domain.

 */
#include <SoftwareSerial.h>
#include <Servo.h>

Servo servo;
SoftwareSerial mySerial(10, 11); // RX, TX

char data, dataincio;
int estado=1;
//1 abierto y 2 cerrado

void setup() {
  Serial.begin(9600);
  servo.attach(7);
  Serial.println("Goodnight moon!");
  mySerial.begin(9600);
  //mySerial.println("Hello, world?");
  if(estado==1){
    servo.write(70);
    delay(200);
  }else if(estado==2){
    servo.write(120);
    delay(200);
  }
  
}

void loop() {
  //Obtiene datos
  if (mySerial.available()) {
    data = mySerial.read(); 
    switch(data){
      case '1': 
        if(estado == 1) 
        {
          estado=2;
          Serial.print("3");
          for(int a = 70; a <= 120; a++) 
          {
            servo.write(a);
            delay(15);
            Serial.println(servo.read());
          }
        }
        else if(estado == 2)
        {
          estado=1; 
          Serial.print("4"); 
          for(int x = 120; x >= 70; x--)
          {
            servo.write(x);
            delay(15);
          }
        }
        break;
      case '3': 
        if(estado == 1)
        {
          Serial.print("4");
        }
        else if(estado == 2)
        {
          Serial.print("3");
        }
        break;
    }
  }

  //Envía datos
  if (Serial.available()) {
    data = Serial.read();
    Serial.println(data);
  }
}

