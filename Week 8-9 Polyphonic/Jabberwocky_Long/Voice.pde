class Voice {
  ArrayList<Wave> waves = new ArrayList<Wave>();
  Wave wave; 
  boolean on; 
  int index;
  String word;
  float value;
  int counter;
  
  Voice(int _index, String _word) {
    index = _index;
    word = _word;
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
  
  void run() {
    println(value);
    if(counter > value) {
      wave.update();
      value = wave.run();
      counter = 0;
    }
    
    // Display the word for half the count
    if(counter < value/10) {
       textSize(value);
       textAlign(CENTER, CENTER);
       text(word, width/2, height/2); 
    }  
    counter++;    
  }
}

