class Voice {
  ArrayList<Wave> waves = new ArrayList<Wave>();
  Wave wave; 
  boolean on; 
  color col;
  float t, value;

  Voice(int index, float _t) {
    t = _t;
    col = color(0, index*255/max);
    waves.add(new Sine(this));
    waves.add(new Cosine(this));
    waves.add(new Tan(this));
    waves.add(new Square(this));
    waves.add(new Sawtooth(this));
  }

  void init(int type, float _f, float _a) {
    wave = waves.get(type);
    wave.init(t, _f, _a, _a);
  }

  void toggle(int type) {
    on = !on; 
    if (on) {
      init(type, frequency, amplitude);
    }
  }

  String getType() {
    if (on) {
      return wave.getType();
    }
    return "";
  }

  float run() {
    wave.update();
    return wave.run();
  }
}

