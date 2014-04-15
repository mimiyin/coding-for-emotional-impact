class Voice {
  Wave wave; 

  Voice(Wave _wave) {
    wave = _wave;
  }
  

  // Update freq and amp of current wave function
  void mod(float f, float a, float o) {
    wave.mod(f, a, o);
  }

  float run() {
    wave.update();
    return wave.run();
  }
}

