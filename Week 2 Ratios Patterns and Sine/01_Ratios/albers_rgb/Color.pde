// Your basic bouncing ball example
// except with moving walls (top and bottom)
class Color {
  float c, r, speed;

  Color(float _c, float _r, float _speed) {
    c = _c;
    r = _r;
    speed = _speed;
  }

  float run() {
    // Each color runs along a range
    // set by its "ratio"
    c+=speed*r;
    if (c > range*r || c < 0) {
      speed *=-1;
    }
    return c;
  }

  void update(float _r) {
    // Calculate "location" of color in color range
    float progress = c/(range*r);
    r += _r;    
    r = constrain(r, 0, 1);
    
    // Set color based on new ratio
    c = range*r*progress;
    
  }
}

