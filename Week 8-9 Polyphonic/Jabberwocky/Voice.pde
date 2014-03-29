class Voice {
  ArrayList<Wave> waves = new ArrayList<Wave>();
  Wave wave; 
  boolean on; 
  int index;
  color col;
  float value = 1;
  int counter = 0;
  
  Voice(int _index) {
    index = _index;
    col = color(0, index*16 + 16);
    waves.add(new Sine());
    waves.add(new Cosine());
    waves.add(new Tan());
    waves.add(new Square());
    waves.add(new Sawtooth());
  }

  void init(int type) {
    wave = waves.get(type);
    wave.init(0, frequency, amplitude, amplitude);
    value = 1;
    counter = 0;
  }
  
  // Update freq and amp of current wave function
  void mod() {
    wave.mod(frequency, amplitude, amplitude);
  }

  void toggle(int type) {
    on = !on; 
    if (on) {
      init(type);
    }
  }

  String getType() {
    if (on) {
      return wave.getType();
    }
    return "";
  }
  
  float ready() {
    if(counter%value < 1) {
      wave.update();
      value = wave.run();
      return value;
    }
    else return -1;
  }
 void run() {
    counter++;    
  }
}

