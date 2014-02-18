class Field {

  float x, y;

  Field(float f, float a, float o, int[] i, boolean s, boolean e ) {
    frequency = f;
    amplitude = a;
    offset = o;
    indices = i;
    show = s;
    erase = e;
  }

  void display(float _x, float _y) {
    for (int x = -tx; x < tx; x+=20) {
      for (int y = -ty; y < ty; y+=20) {
        float xdisp = (x - _x)/20;
        float ydisp = (y - _y)/20;
        
        // What is strokeWeight a function of?
        strokeWeight(0.001*abs(xdisp*ydisp));
        stroke(0);
        line(x, y, x+xdisp, y+ydisp);
        noStroke();
      }
    }
  }
}

