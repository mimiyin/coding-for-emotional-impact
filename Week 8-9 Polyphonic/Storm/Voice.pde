class Voice {
  ArrayList<Wave> waves = new ArrayList<Wave>();
  Wave wave; 
  boolean on; 
  int index;
  color col;
  float value;

  Voice(int _index) {
    index = _index;
    // Give each wave a different shade of gray so we can tell them a part
    col = color(0, index*16 + 16);
    
    // Keep a catalog of waves, just like in recursion example
    waves.add(new Sine());
    waves.add(new Cosine());
    waves.add(new Tan());
    waves.add(new Square());
    waves.add(new Sawtooth());
  }
  
  // Assign a wave to this voice
  // Initialize the wave with freq, amp and offset
  void init(int type) {
    wave = waves.get(type);
    wave.init(0, frequency, amplitude, amplitude);
  }
  
  // Update freq and amp of current wave function
  void mod() {
    wave.mod(frequency, amplitude, amplitude);
  }
  
  // Turn the voice on and off
  void toggle(int type) {
    on = !on; 
    if (on) {
      init(type);
    }
  }
  
  // Get the wave type so we can display it on screne
  String getType() {
    if (on) {
      return wave.getType();
    }
    return "";
  }
  
  // Run this voice's wave!
  float run() {
    wave.update();
    return wave.run();
  }
}

