class Voice {
  Wave wave; 

  Voice(Wave _wave) {
     init(_wave);
  }
  // (Re-)initialize voice with a wave
  void init(Wave _wave) {
    wave = _wave;        
  }

  // Update freq and amp of current wave function
  void mod(float f, float a, float o) {
    wave.mod(f, a, o);
  }
  // Run the voice, calculate its wave value
  float run() {
    wave.update();
    return wave.run();
  }
}

