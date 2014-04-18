class Voice {
  ArrayList<Wave> waves = new ArrayList<Wave>();
  Wave wave; 

  Voice(Wave _wave) {
    init(_wave);
  }

  // (Re-)initialize voice with a wave
  void init(Wave _wave) {
    wave = _wave;
    waves.add(wave);
  }
  
  // Switch between waves
  void change(int i) {
   wave = waves.get(i);     
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

