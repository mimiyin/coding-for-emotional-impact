class Sine {
  float t, f, a, o, of, oa, fm, am;
  Sine freq;
  Sine amp;

  Sine(float _t, float _f, float _a, float _o, float _fm, float _am) {
    t = _t;
    f = _f;
    a = _a;
    o = _o;
    fm = _fm;
    am = _am;
  }
  
  // Reset everything
  void reset() {
    f = frequency; 
    a = amplitude;
    freq = null;
    amp = null;
  }
  
  // Set frequency
  void setF(float _f) {
    f = _f;
    freq = new Sine(t, f, a, o, fm, am);
  }
  
  // Set amplitude
  void setA(float _a) {
    a = _a;      
    amp = new Sine(t, f, a, o, fm, am);
  }

  //Set frequency multiplier
  void setFm(float _fm) {
    fm = _fm;
  }
  
  //Set amplitude multiplier  
  void setAm(float _am) {
    am = _am;  
  }
  
  // Recursive wave function
  float wave(int count) {
    if (count >= limit) {
      return sine();
    }
    else {
      if (freq == null) setF(f);
      if (amp == null) setA(a);
      
      // Set the frequency to be some %age of TWO_PI
      f = freq.wave(count+1)/(a*TWO_PI);
      a = amp.wave(count+1);
      return sine();
    }
  }
  
  // Calculate sine value
  float sine() {
    t+=f;
    t%=TWO_PI;
    return sin(t*fm)*a*am + o;
  }
}

