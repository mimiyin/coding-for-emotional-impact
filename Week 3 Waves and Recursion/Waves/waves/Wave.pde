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
  
  // Change frequency and/or amplitude of wave
  float mod(float _t, float _a) {
    // If _t or _a are less than zero,
    // don't bother changing t or a
    t = _t >=0 ? _t : t;
    a = _a >=0 ? _a : a;
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
    // From 0-PI, y = +amp
    // From PI-TWO_PI, y = -amp
    return o + (t%TWO_PI >= PI ? 1 : -1)*a;
  }
}

class Sawtooth extends Wave {
  float m;

  Sawtooth(float t, float f, float a, float o) {
    super(t, f, a, o);
    // Calculate the slope (steepness) of the tooth
    m = (a+o) / TWO_PI;
  }

  float wave() {
    // y = t*m is the formula for a line
    // Why are we modulo-ing with TWO_PI?
    return (t%TWO_PI)*m;
  }
}

