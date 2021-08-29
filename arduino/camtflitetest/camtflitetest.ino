/*
  OV7670 & Tensorflow Lite with Arduino Nano 33 BLE Sense

  This sketch tests Tensorflow Lite with image from OV7670 Camera. 

  The Tensorflow Lite model is trained by the author, 
  and defined in model.h. 
  It determines whether dogs or cats are in the given image, or not. 
  Its input shape is (-1, 72, 88, 3) and output shape is (-1, 1). 
  If dogs or cats are in the given image, result will be close to 1.0
  and if no dogs or cats are in the given image, result will be close to 0.0. 
0
  To run this sketch, you should install Tensorflow Lite library
  from library management menu. 
  (Search tensorflowlite and download Arduino_TensorflowLite library.)
  Also, you need to download OV767X library from library management menu. 
  (Search OV767X and download Arduino_OV767X library.)

  Make sure that predefined model.h is at 
  the same directory with this sketch. 
  
  Circuit: 
    - Arduino Nano 33 BLE board
    - OV7670 camera module:
      - 3.3 connected to 3.3
      - GND connected GND
      - SIOC connected to A5
      - SIOD connected to A4
      - VSYNC connected to 8
      - HREF connected to A1
      - PCLK connected to A0
      - XCLK connected to 9
      - D7 connected to 4
      - D6 connected to 6
      - D5 connected to 5
      - D4 connected to 3
      - D3 connected to 2
      - D2 connected to 0 / RX
      - D1 connected to 1 / TX
      - D0 connected to 10
*/
#include <TensorFlowLite.h>
#include <tensorflow/lite/micro/all_ops_resolver.h>
#include <tensorflow/lite/micro/all_ops_resolver.h>
#include <tensorflow/lite/micro/micro_error_reporter.h>
#include <tensorflow/lite/micro/micro_interpreter.h>
#include <tensorflow/lite/schema/schema_generated.h>
#include <tensorflow/lite/version.h>
#include "model.h"

#include <Arduino_OV767X.h>

// global variables used for TensorFlow Lite (Micro)
tflite::MicroErrorReporter tflErrorReporter;

// pull in all the TFLM ops, you can remove this line and
// only pull in the TFLM ops you need, if would like to reduce
// the compiled size of the sketch.
tflite::AllOpsResolver tflOpsResolver;

const tflite::Model* tflModel = nullptr;
tflite::MicroInterpreter* tflInterpreter = nullptr;
TfLiteTensor* tflInputTensor = nullptr;
TfLiteTensor* tflOutputTensor = nullptr;

// Create a static memory buffer for TFLM, the size may need to
// be adjusted based on the model you are using
constexpr int tensorArenaSize = 128 * 1024;
byte tensorArena[tensorArenaSize];

// threshold to determine dangerous or safe
const float THRESHOLD = 0.5;

// variables for camera input
const int bytesPerFrame = 144 * 176 * 2;
byte data[bytesPerFrame];

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("-------------------------------------------------------");
  Serial.println("--------------- Dog & Cat Detect Model ----------------");
  Serial.println("-------------------------------------------------------");
  Serial.println("Arduino Nano 33 BLE Sense running TensorFlow Lite Micro");
  Serial.println("");

  // get the TFL representation of the model byte array
  tflModel = tflite::GetModel(model);
  if (tflModel->version() != TFLITE_SCHEMA_VERSION) {
    Serial.println("Model schema mismatch!");
    while (1);
  }

  // Create an interpreter to run the model
  tflInterpreter = new tflite::MicroInterpreter(tflModel, tflOpsResolver, tensorArena, tensorArenaSize, &tflErrorReporter);

  // Allocate memory for the model's input and output tensors
  tflInterpreter->AllocateTensors();

  // Get pointers for the model's input and output tensors
  tflInputTensor = tflInterpreter->input(0);
  tflOutputTensor = tflInterpreter->output(0);

  // Print input size
  Serial.print("Model input size: (");
  Serial.print(tflInputTensor->dims->data[0]);
  Serial.print(", ");
  Serial.print(tflInputTensor->dims->data[1]);
  Serial.print(", ");
  Serial.print(tflInputTensor->dims->data[2]);
  Serial.print(", ");
  Serial.print(tflInputTensor->dims->data[3]);
  Serial.println(")");
  Serial.print("Model output size: (");
  Serial.print(tflOutputTensor->dims->data[0]);
  Serial.print(", ");
  Serial.print(tflOutputTensor->dims->data[1]);
  Serial.println(")\n");
  
  // Load Camera
  if (!Camera.begin(QCIF, RGB565, 1)) {
    Serial.println("Failed to initialize camera!");
    while (1);
  } else {
    Serial.println("Camera initialized!");
  }

  // Validate camera size
  if (bytesPerFrame != Camera.height() * Camera.width() * Camera.bytesPerPixel()) {
    Serial.print("Bytes per frame not equal: ");
    Serial.print(bytesPerFrame);
    Serial.print("!=");
    Serial.println(Camera.height() * Camera.width() * Camera.bytesPerPixel());
    Serial.println();
  } else {
    Serial.print("Bytes per frame: ");
    Serial.println(bytesPerFrame);
    Serial.println();
  }

  // set LED
  pinMode(LED_BUILTIN, OUTPUT);

  // wait for 5 seconds
  delay(5000);
}


void loop() {
  // read image input from OV7670 camera
  Camera.readFrame(data);
  
  // input data to model
  for (int i = 0; i < 72; i++){
    for (int j = 0; j < 88; j++){
      unsigned short p = (data[2 * (176 * (2 * i) + (2 * j))] << 8) + data[2 * (176 * (2 * i) + (2 * j)) + 1];
  
      unsigned short r = ((p >> 11) & 0x1f) << 3;
      unsigned short g = ((p >> 5) & 0x3f) << 2;
      unsigned short b = ((p >> 0) & 0x1f) << 3;

      /*if (j == 0){
        Serial.print("(");
        Serial.print(r);
        Serial.print(", ");
        Serial.print(g);
        Serial.print(", ");
        Serial.print(b);
        Serial.println(")");
      }*/
      
      tflInputTensor->data.f[88 * 3 * i + 3 * j] = (float) r / 255.0;
      tflInputTensor->data.f[88 * 3 * i + 3 * j + 1] = (float) g / 255.0;
      tflInputTensor->data.f[88 * 3 * i + 3 * j + 2] = (float) b / 255.0;
    }
  }
  
  // Run inferencing
  TfLiteStatus invokeStatus = tflInterpreter->Invoke();
  if (invokeStatus != kTfLiteOk) {
    Serial.println("Invoke failed!");
    while(1);
  }

  // Output results
  Serial.print("Output: ");
  Serial.print(tflOutputTensor->data.f[0]);
  if (tflOutputTensor->data.f[0] >= THRESHOLD){
    Serial.println(" -> ALERT!!");
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    Serial.println("");
    digitalWrite(LED_BUILTIN, LOW);
  }

  //while (1);
}
