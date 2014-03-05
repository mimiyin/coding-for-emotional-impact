// Manage recursion
class Cursor {  
  ArrayList<Wave>waves = new ArrayList<Wave>();
  float t, f, a, o;
  float of, oa; // Store original frequency and amplitude for "reset"
  Cursor freq; // Cursor object for frequency
  Cursor amp; // Cursor object for amplitude

  Cursor(float _t, float _f, float _a, float _o) {
    t = _t;
    f = _f;
    a = _a;
    o = _o;

    of = f;
    oa = a;

    // Create wave objects for all 5 types
    waves.add(new Sine(t, f, a, o));
    waves.add(new Cosine(t, f, a, o));
    waves.add(new Square(t, f, a, o));
    waves.add(new Sawtooth(t, f, a, o));
    waves.add(new Tan(t, f, a, o));
  }

  // Set frequency
  void setF(float _f) {
    f = _f;
    freq = new Cursor(t, f, a, o);
  }

  // Set amplitude
  void setA(float _a) {
    a = _a;      
    amp = new Cursor(t, f, a, o);
  }

  // Start over
  void reset() {
    f = of; 
    a = oa;
    freq = new Cursor(t, f, a, o);
    amp = new Cursor(t, f, a, o);
  }

  // Recurse function
  float run(int count) {

    if (count >= limit) {
      // Get and run the wave-type for this level of recursion
      return waves.get(indices[count]).run(f, a);
    }
    else {
      if (freq == null) {
        freq = new Cursor(t, f, a, o);
      }
      if (amp == null) {
        amp = new Cursor(t, f, a, o);
      }

      // Run wave functions to determine f and a for this wave function
      // Scale frequency to be a fraction of TWO_PI
      f = (freq.run(count+1)/a)*TWO_PI; // This is the same as saying f = map(f, 0, a, 0, TWO_PI);
      a = amp.run(count+1);

      // When does this line of code finally run?
      // println to find out
      return waves.get(indices[count]).run(f, a);
    }
  }
}

