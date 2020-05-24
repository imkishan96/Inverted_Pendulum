
#include <SPI.h>          //SPI is used to talk to the CAN Controller
#include <mcp_can.h>
#include <Encoder.h>
Encoder myEnc(2, 3);

MCP_CAN CAN(10);          //set SPI Chip Select to pin 10

void setup()
{
  Serial.begin(115200);   //to communicate with Serial monitor
START_INIT:

    if(CAN_OK == CAN.begin(CAN_1000KBPS))      //setting CAN baud rate to 1000Kbps but actually its going to be 500KBPS because CAN module has 8MHz crystal not 16MHz
    {
        Serial.println("CAN BUS Shield init ok!");
    }
    else
    {
        Serial.println("CAN BUS Shield init fail");
        Serial.println("Init CAN BUS Shield again");
        delay(100);
        goto START_INIT;
    }

    //pinMode(8, INPUT);
    //pinMode(7, INPUT);
    //pinMode(6, INPUT);
}

//loading the data bytes of the message. Up to 8 bytes
byte data[4] = {225,3,0,0};
byte data_NMT[2] = {129,1};
byte data_HB[1] = {5};
long oldPosition  = -999;
long newPosition;
long posoffset;
unsigned long past_time = 0;
unsigned long onesec = 0;
int int_pos = 10000;
void loop()
{   /*
    //CAN.sendMsgBuf(msg ID, extended?, #of data bytes, data array);
    //CAN.sendMsgBuf(385 , 0, 4, data); // TPD0 (COB-ID-182H,1byte,127)
    //delay(1000);     
    
    //byte data_HB[1] = {99};
    //CAN.sendMsgBuf(1794 , 0, 1, data_HB ); // Heartbeat (COB-ID-702H, 1byte , [r, status: pre-op(127D)])
    //delay(100);
    //CAN.sendMsgBuf(0, 0, 2 ,data_NMT ); // NMT msg (COB-ID-0H,2byte,[cmd: op(1), Node-ID:(0-all) ])
    //delay(5000);
    
    if (digitalRead(8) == HIGH){
    byte data_NMT[2] = {1,1}; // (cmd,node) oprational:1 | pre-op:128
    CAN.sendMsgBuf(0, 0, 2 ,data_NMT ); // NMT msg operational (COB-ID-0H,2byte,[cmd: op(1), Node-ID:(0-all) ])
    delay(1000);
    }
    if (digitalRead(7) == HIGH){
    byte data_NMT[2] = {128,1}; // (cmd,node) oprational:1 | pre-op:128
    CAN.sendMsgBuf(0, 0, 2 ,data_NMT ); // NMT msg operational (COB-ID-0H,2byte,[cmd: op(1), Node-ID:(0-all) ])
    delay(1000);
    }
    if (digitalRead(6) == HIGH){
    byte data_NMT[2] = {129,1}; // (cmd,node) oprational:1 | pre-op:128 | reset node: 129
    CAN.sendMsgBuf(0, 0, 2 ,data_NMT ); // NMT msg operational (COB-ID-0H,2byte,[cmd: op(1), Node-ID:(0-all) ])
    delay(1000);
    }
    */
    
    newPosition = myEnc.read();
    
    if (micros()-past_time >999) //sends data every one millisecond 
    {
      oldPosition = newPosition;
      posoffset = newPosition + 1200; //2400 pulse for one rev so 1200 pulse to offset from vertical down position 
      CAN.sendMsgBuf(999, 0, 4 ,(byte *) &posoffset ); 
      //Serial.println("-------");
      past_time = micros();
    }
      
    if(micros()-onesec > 4999999) // sends Heartbeat every 5 second
    {
      CAN.sendMsgBuf(1794 , 0, 1, data_HB ); // Heartbeat (COB-ID-702H, 1byte , [r, status: pre-op(127D)])
      onesec = micros();
      //past_time = micros();
      Serial.println("I am Alive");
    }
}
