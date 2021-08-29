from logging import RootLogger

class Config:
  '''
  Configurations for training and testing. 
  '''

  def __init__(self):
    '''
    Set configurations. 
    '''

    self.gen_zoom_range = 0.1
    self.gen_width_shift_range = 0.1
    self.gen_height_shift_range = 0.1
    self.gen_rotation_range = 10
    self.gen_horizontal_flip = True
    self.gen_shuffle = True

    self.model_input_size = (72, 88, 3)
    self.model_dropout_rate = 0.1
    self.model_weights = None # None or path to weight

    self.epochs = 100
    self.batch_size = 32
    self.train_step_per_epoch = None # None or integer
    self.val_step_per_epoch = None # None or integer

    self.threshold = 0.5 # in range (0, 1)

  def log_config(self, logger: RootLogger):
    '''
    Log configurations. 
    '''
    
    logger.info("Generator Config")
    logger.info(f"\tWidth shift range: {self.gen_width_shift_range}")
    logger.info(f"\tHeight shift range: {self.gen_height_shift_range}")
    logger.info(f"\tRotation range: {self.gen_rotation_range}")
    logger.info(f"\tHorizontal flip: {self.gen_horizontal_flip}")
    logger.info(f"\tShuffle: {self.gen_shuffle}")

    logger.info("Model Config")
    logger.info(f"\tInput size: {self.model_input_size}")
    logger.info(f"\tDropout rate: {self.model_dropout_rate}")
    logger.info(f"\tWeights: {self.model_weights}")
    
    logger.info("Training Config")
    logger.info(f"\tEpochs: {self.epochs}")
    logger.info(f"\tBatch size: {self.batch_size}")
    logger.info(f"\tSteps per epoch (train): {self.train_step_per_epoch}")
    logger.info(f"\tSteps per epoch (val): {self.val_step_per_epoch}")

    logger.info("Testing Config")
    logger.info(f"\tThreshold: {self.threshold}")

    logger.info("Other Config")
