class Wave {
  float t, f, a;

  Wave(float _t, float _f, float _a) {
    t = _t;
    f = _f;
    a = _a;
  }

  float  wave  () {
    t+=f;
    return sin(t)*a;
  }
}

