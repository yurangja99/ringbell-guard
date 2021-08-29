/*
  Keyes Player Mini test code

  This sketch plays a music in a given micro SD card. 
  This sketch don't use hardware serial for playing music
  because they are used for another device. 
  So, RX/TX port is set to 13 and 12 each. 
  (You can change them as you want.)

  At the same time, this sketch prints status of the 
  mp3 player to Serial output. 
  (You can refer to printDetail() function below.)

  To run this sketch, you should download DFRobotDFPlayerMini.h
  (https://wiki.dfrobot.com/DFPlayer_Mini_SKU_DFR0299)
  
  Circuit:
    - Arduino Nano 33 BLE board
    - Keyes Player Mini
      - RX connected to 13
      - TX connected to 12
      - VCC connected to 5V
      - GND connected to GND
    - LM386 Digital Amplifier Module
      - VCC connected to 5V
      - GND connected to SPK2(Keyes)
      - IN connected to SPK1(Keyes)
    - Speaker
      - Connected to LM386
*/
#include <Arduino.h>
#include "wiring_private.h"
#include <DFRobotDFPlayerMini.h>

static const uint8_t PIN_MP3_TX =12;
static const uint8_t PIN_MP3_RX =13;

UART mySerial(digitalPinToPinName(PIN_MP3_RX), digitalPinToPinName(PIN_MP3_TX), NC, NC);

DFRobotDFPlayerMini player;

void setup() {
  mySerial.begin(9600);
  
  Serial.begin(9600);
  while (!Serial);
  
  player.begin(mySerial);

  Serial.println("Connecting...");
  
  while(!player.available());
  
  Serial.println("Connected!");
    
  player.volume(20);
  player.play(1);
}

void loop() {
  if (player.available()) {
    printDetail(player.readType(), player.read()); //Print the detail message from DFPlayer to handle different errors and states.
  }
}

void printDetail(uint8_t type, int value){
  switch (type) {
    case TimeOut:
      Serial.println(F("Time Out!"));
      break;
    case WrongStack:
      Serial.println(F("Stack Wrong!"));
      break;
    case DFPlayerCardInserted:
      Serial.println(F("Card Inserted!"));
      break;
    case DFPlayerCardRemoved:
      Serial.println(F("Card Removed!"));
      break;
    case DFPlayerCardOnline:
      Serial.println(F("Card Online!"));
      player.play(1);
      Serial.println(F("Play!"));
      break;
    case DFPlayerPlayFinished:
      Serial.print(F("Number:"));
      Serial.print(value);
      Serial.println(F(" Play Finished!"));
      break;
    case DFPlayerError:
      Serial.print(F("DFPlayerError:"));
      switch (value) {
        case Busy:
          Serial.println(F("Card not found"));
          break;
        case Sleeping:
          Serial.println(F("Sleeping"));
          break;
        case SerialWrongStack:
          Serial.println(F("Get Wrong Stack"));
          break;
        case CheckSumNotMatch:
          Serial.println(F("Check Sum Not Match"));
          break;
        case FileIndexOut:
          Serial.println(F("File Index Out of Bound"));
          break;
        case FileMismatch:
          Serial.println(F("Cannot Find File"));
          break;
        case Advertise:
          Serial.println(F("In Advertise"));
          break;
        default:
          break;
      }
      break;
    default:
      break;
  }
}
