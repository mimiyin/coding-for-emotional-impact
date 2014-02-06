class Wave {
  float t, f, a, o;

  Wave(float _t, float _f, float _a, float _o) {
    t = _t;
    f = _f;
    a = _a;
    o = _o;
  }

  void update() {
    t+=f;
  }

  float run() {
    update();
    return wave();
  }

  float modFreq(float _t) {
    t = _t;
    return wave();
  }

  float modAmp(float _a) {
    a = _a;
    return run();
  }

  float mod(float _t, float _a) {
    t = _t;
    a = _a;
    return wave();
  }

  float wave() {
    return 0;
  }
}

class Sine extends Wave {

  Sine(float t, float f, float a, float o) {
    super(t, f, a, o);
  }

  float wave() {
    return sin(t)*a + o;
  }
}

class Cosine extends Wave {

  Cosine(float t, float f, float a, float o) {
    super(t, f, a, o);
  }

  float wave() {
    return cos(t)*a + o;
  }
}

class Tan extends Wave {

  Tan(float t, float f, float a, float o) {
    super(t, f, a, o);
  }

  float wave() {
    return tan(t)*a + o;
  }
}

class Square extends Wave {

  Square(float t, float f, float a, float o) {
    super(t, f, a, o);
  }

  float wave() {
    return o + (t%TWO_PI >= PI ? 1 : -1)*a;
  }
}

class Sawtooth extends Wave {
  float m;

  Sawtooth(float t, float f, float a, float o) {
    super(t, f, a, o);
    m = (a+o) / TWO_PI;
  }

  float wave() {
    return (t%TWO_PI)*m;
  }
}

