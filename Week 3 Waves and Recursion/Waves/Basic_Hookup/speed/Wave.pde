class Wave {
  float t, f, a, o;

  Wave(float _t, float _f, float _a, float _o) {
    t = _t;
    f = _f;
    a = _a;
    o = _o;
  }

  float  wave  () {
    t+=f;
    return sin(t)*a + o;
  }
}
