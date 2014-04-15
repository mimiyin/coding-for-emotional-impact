class Sine {
  float t, f, a, o;

  Sine(float _t, float _f, float _a, float _o) {
    t = _t;
    f = _f;
    a = _a;
    o = _o;
  }

  void update() {
    t +=f;
  }

  float wave() {
    return sin(t)*a + o;
  }
}

