/*
  Tensorflow Lite with Arduino Nano 33 BLE Sense

  This sketch tests Tensorflow Lite on Arduino Nano 33 BLE Sense
  with simple test model. 

  The model is defined in simple_model.h. 
  Its input shape is (-1, 2, 2, 2) and output shape is (-1, 1). 
  
  Tested examples are following:
    - Input: {{{0.1, 0.2}, {0.3, 0.4}}, {{0.5, 0.6}, {0.7, 0.8}}}
    - Output: {{-0.47376174}}

  To run this sketch, you should install Tensorflow Lite library
  from library management menu. 
  (Search tensorflowlite and download Arduino_TensorflowLite library.)

  Also, make sure that predefined simple_model.h is at 
  the same directory with this sketch. 
  
  Circuit: 
    - Arduino Nano 33 BLE board
*/
#include <TensorFlowLite.h>
#include <tensorflow/lite/micro/all_ops_resolver.h>
#include <tensorflow/lite/micro/all_ops_resolver.h>
#include <tensorflow/lite/micro/micro_error_reporter.h>
#include <tensorflow/lite/micro/micro_interpreter.h>
#include <tensorflow/lite/schema/schema_generated.h>
#include <tensorflow/lite/version.h>
#include "simple_model.h"

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

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("-------------------------------------------------------");
  Serial.println("--------------- Sample 2x2x2 to 1 Model ---------------");
  Serial.println("-------------------------------------------------------");
  Serial.println("Arduino Nano 33 BLE Sense running TensorFlow Lite Micro");
  Serial.println("");

  // get the TFL representation of the model byte array
  tflModel = tflite::GetModel(model);
  if (tflModel->version() != TFLITE_SCHEMA_VERSION) {
    Serial.println("Model schema mismatch!");
    while(1);
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

  // wait for 5 seconds
  delay(5000);
}

void loop() {
  // generate input data
  float sample_input[2][2][2] = {{{0.1, 0.2}, {0.3, 0.4}}, {{0.5, 0.6}, {0.7, 0.8}}};

  // input data to model
  for (int i = 0; i < 2; i++){
    for (int j = 0; j < 2; j++){
      for (int k = 0; k < 2; k++){
        tflInputTensor->data.f[4 * i + 2 * j + k] = sample_input[i][j][k];
      }
    }
  }

  // Run inferencing
  TfLiteStatus invokeStatus = tflInterpreter->Invoke();
  if (invokeStatus != kTfLiteOk) {
    Serial.println("Invoke failed!");
    while(1);
  }

  // Output results
  Serial.print("Output (gt: -0.47376174): ");
  Serial.println(tflOutputTensor->data.f[0]);
  
  while (1);
}
