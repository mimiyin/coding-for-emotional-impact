class Wave {
  float t, f, a, o;

  Wave(float _t, float _f, float _a, float _o) {
    t = _t;
    f = _f;
    a = _a;
    o = _o;
  }

  float run() {
    update();
    return wave();
  }

  // Change the frequency, amplitude and offset of wave mid-stream  
  void mod(float _f, float _a, float _o) {
    f = _f;     
    a = _a;
    o = _o;
  }

  void update() {
    t+=f;
  }

  float wave() {
    return 0;
  }
}

class Sine extends Wave {
  Sine(float _t, float _f, float _a, float _o) {
    super(_t, _f, _a, _o);
  }

  float wave() {
    return sin(t)*a + o;
  }
}

class Cosine extends Wave {
  String type = "COS";

  Cosine(float _t, float _f, float _a, float _o) {    
    super(_t, _f, _a, _o);
  }

  float wave() {
    return cos(t)*a + o;
  }
}

class Tan extends Wave {
  Tan(float _t, float _f, float _a, float _o) { 
    super(_t, _f, _a, _o);
  }

  float wave() {
    return abs(tan(t)*a);
  }
}

class Square extends Wave {
  Square(float _t, float _f, float _a, float _o) {
    super(_t, _f, _a, _o);
  }

  float wave() {
    return o + (t%TWO_PI >= PI ? 1 : -1)*a;
  }
}

class Sawtooth extends Wave {
  float m;

  Sawtooth(float _t, float _f, float _a, float _o) {
    super(_t, _f, _a, _o);
  }

  float wave() {
    m = (a+o) / TWO_PI;
    return (t%TWO_PI)*m;
  }
}

