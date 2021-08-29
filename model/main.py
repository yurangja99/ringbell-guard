import logging
from datetime import timedelta, timezone, datetime
from os import makedirs
from os.path import join, dirname, abspath
import tensorflow as tf
from tensorflow.keras.applications import MobileNetV3Small
from tensorflow.keras.models import Sequential, load_model
from tensorflow.keras.layers import Input, MaxPooling2D, Dense, Flatten, Conv2D
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.utils import plot_model
from tensorflow.python.client import device_lib
from tensorflow import math, lite
from matplotlib import pyplot as plt

from config import Config

def main(): 
  ###################
  ## Create Output File
  ###################
  now = datetime.now(timezone(timedelta(hours=9))).strftime("%m_%d_%H_%M_%S")
  results_path = join(dirname(abspath(__file__)), "results")
  result_path = join(results_path, now)
  makedirs(result_path, exist_ok=True)
  
  ###################
  ## Define Logger
  ###################
  logger = logging.getLogger()
  logger.setLevel(logging.INFO)
  logger.addHandler(logging.FileHandler(join(result_path, "log.log")))

  ###################
  ## Get config
  ###################
  cfg = Config()
  cfg.log_config(logger)

  ###################
  ## Check GPU
  ###################
  device_types = [device.device_type for device in device_lib.list_local_devices()]
  logger.info(f"\tUsing GPU: {'GPU' in device_types}")

  ###################
  ## Define Dataset Generator
  ###################
  train_datagen = ImageDataGenerator(
    rescale=1./255, 
    zoom_range=cfg.gen_zoom_range, 
    width_shift_range=cfg.gen_width_shift_range, 
    height_shift_range=cfg.gen_height_shift_range, 
    rotation_range=cfg.gen_rotation_range, 
    horizontal_flip=cfg.gen_horizontal_flip
  )

  train_generator = train_datagen.flow_from_directory(
    directory=join(dirname(abspath(__file__)), "dataset", "training_set"), 
    target_size=cfg.model_input_size[:2], 
    color_mode="rgb", 
    class_mode="binary", 
    batch_size=cfg.batch_size, 
    shuffle=cfg.gen_shuffle, 
    interpolation="lanczos"
  )

  test_datagen = ImageDataGenerator(
    rescale=1./255, 
    zoom_range=cfg.gen_zoom_range, 
    width_shift_range=cfg.gen_width_shift_range, 
    height_shift_range=cfg.gen_height_shift_range, 
    rotation_range=cfg.gen_rotation_range, 
    horizontal_flip=cfg.gen_horizontal_flip
  )

  test_generator = test_datagen.flow_from_directory(
    directory=join(dirname(abspath(__file__)), "dataset", "test_set"), 
    target_size=cfg.model_input_size[:2], 
    color_mode="rgb", 
    class_mode="binary", 
    batch_size=cfg.batch_size, 
    shuffle=cfg.gen_shuffle, 
    interpolation="lanczos"
  )

  ###################
  ## Visualize Generated Data
  ###################
  for x, y in train_generator:
    x_len = len(x)
    row_len = x_len // 8 + (0 if x_len % 8 == 0 else 1)

    plt.figure(figsize=(24, row_len * 3))
    
    for i in range(x_len):
      plt.subplot(row_len, 8, i + 1)
      plt.imshow(x[i])
      plt.title(y[i], fontsize=15)
      plt.axis('off')
    
    plt.savefig(join(result_path, "example_inputs.png"))
    plt.close()
    break
  
  ###################
  ## Define Model
  ###################
  '''
  model = MobileNetV3Small(
    input_shape=cfg.model_input_size, 
    alpha=1.0, 
    minimalistic=True, 
    include_top=True, 
    weights=cfg.model_weights, 
    classes=2, 
    dropout_rate=cfg.model_dropout_rate, 
    classifier_activation="softmax", 
    include_preprocessing=False
  )
  '''

  model = Sequential([
    Input(shape=cfg.model_input_size), 
    Conv2D(2, 3, activation='relu'),
    MaxPooling2D(),
    Conv2D(4, 3, activation='relu'),
    MaxPooling2D(),
    Conv2D(2, 3, activation='relu'),
    MaxPooling2D(),
    Flatten(),
    Dense(32, activation='relu'), 
    Dense(1, activation='sigmoid')
  ])

  model.compile(
    loss="binary_crossentropy", 
    optimizer="adam", 
    metrics=["accuracy"]
  )
  
  plot_model(
    model=model, 
    to_file=join(result_path, 'model.png'), 
    show_shapes=True, 
    show_dtype=True, 
    show_layer_names=True
  )

  ###################
  ## Train Model
  ###################
  history = model.fit(
    x=train_generator, 
    validation_data=test_generator, 
    steps_per_epoch=cfg.train_step_per_epoch, 
    validation_steps=cfg.val_step_per_epoch, 
    epochs=cfg.epochs
  )

  ###################
  ## Save Model (TFLite)
  ###################
  model.save(join(result_path, "model.h5"))
  model.save(join(result_path, "model"))
  
  converter = lite.TFLiteConverter.from_saved_model(join(result_path, "model"))
  tflite_model = converter.convert()
  open(join(result_path, "model.tflite"), "wb").write(tflite_model)

  ###################
  ## Plot Train Results
  ###################
  plt.title("Accuracy")
  plt.xlabel("Epoch")
  plt.ylabel("Accuracy")
  plt.plot(history.history["accuracy"], label="Train")
  plt.plot(history.history["val_accuracy"], label="Test")
  plt.legend()
  plt.savefig(join(result_path, "accuracy.png"))
  plt.close()

  plt.title("Loss")
  plt.xlabel("Epoch")
  plt.ylabel("Loss")
  plt.plot(history.history["loss"], label="Train")
  plt.plot(history.history["val_loss"], label="Test")
  plt.legend()
  plt.savefig(join(result_path, "loss.png"))
  plt.close()

  ###################
  ## Evaluate Model
  ###################
  scores = model.evaluate(
    x=test_generator
  )
  logger.info(f"Result\n\t{model.metrics_names[1]}: {scores[1] * 100.0}%")

  ###################
  ## Visualize Predictions
  ###################
  logger.info("\tExamples")
  for x, y in test_generator:
    x_len = len(x)
    row_len = x_len // 8 + (0 if x_len % 8 == 0 else 1)

    y = tf.reshape(y, (-1, 1))
    pred = model.predict(x=x)
    equal = math.logical_or(
      math.logical_and(y >= cfg.threshold, pred >= cfg.threshold), 
      math.logical_and(y < cfg.threshold, pred < cfg.threshold)
    )

    plt.figure(figsize=(24, row_len * 3.5))

    for i in range(x_len):
      logger.info(f"\t\ty: {y[i]}, pred: {pred[i]}, equal: {equal[i]}")

      plt.subplot(row_len, 8, i + 1)
      plt.imshow(x[i])
      plt.title(f"y {y[i]}\npred {pred[i]}\nequal {equal[i]}", fontsize=15)
      plt.axis('off')
    
    plt.savefig(join(result_path, "example_predictions.png"))
    plt.close()
    break

if __name__ == "__main__":
  main()
