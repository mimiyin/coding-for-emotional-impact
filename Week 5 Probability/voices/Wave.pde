class Wave {
  Voice voice;
  String type = "WAV";
  float t, f, a, o;

  Wave(Voice _voice) {
    voice = _voice;
  }
  void init(float _t, float _f, float _a, float _o) {
    t = _t;
    f = _f;
    a = _a;
    o = _o;
  }

  float run() {
    update();
    return wave();
  }
  
  void update() {
    t+=f;
  }

  float wave() {
    return 0;
  }

  String getType() {
    return type;
  }
}

class Sine extends Wave {
  String type = "SIN";

  Sine(Voice _voice) {
    super(_voice);
  }

  float wave() {
    return sin(t)*a + o;
  }

  String getType() {
    return type;
  }
}

class Cosine extends Wave {
  String type = "COS";

  Cosine(Voice _voice) {
    super(_voice);
  }

  float wave() {
    return cos(t)*a + o;
  }
  String getType() {
    return type;
  }
}

class Tan extends Wave {
  String type = "TAN";

  Tan(Voice _voice) {
    super(_voice);
  }

  float wave() {
    return abs(tan(t)*a);
  }
  String getType() {
    return type;
  }
}

class Square extends Wave {
  String type = "SQU";

  Square(Voice _voice) {
    super(_voice);
  }

  float wave() {
    return o + (t%TWO_PI >= PI ? 1 : -1)*a;
  }
  String getType() {
    return type;
  }
}

class Sawtooth extends Wave {
  String type = "SAW";
  float m;

  Sawtooth(Voice _voice) {
    super(_voice);
  }

  float wave() {
    m = (a+o) / TWO_PI;
    return (t%TWO_PI)*m;
  }
  String getType() {
    return type;
  }
}

