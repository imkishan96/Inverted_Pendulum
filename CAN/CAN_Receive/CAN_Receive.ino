#include <SPI.h>          
#include <mcp_can.h>

MCP_CAN CAN(10);          //set SPI Chip Select to pin 10

unsigned char len = 0;
unsigned char buf[8];
unsigned int canID;

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
}



void loop()
{
    if(CAN_MSGAVAIL == CAN.checkReceive())    //check if data is coming
    {
        CAN.readMsgBuf(&len, buf);    //read data,  len: data length, buf: data buffer
        canID = CAN.getCanId();       //getting the ID of the incoming message

        Serial.print("ID is: ");
        Serial.print(canID, HEX);     //printing the ID in its standard form, HEX

        Serial.print("    Length is: ");
        Serial.println(len);
        
        for(int i = 0; i<len; i++)    //looping on the incoming data to print them
        {
            Serial.println(buf[i],DEC);     //Serial.write prints the character itself
        }
        Serial.println("\n\t*****************\n");
    }
}
