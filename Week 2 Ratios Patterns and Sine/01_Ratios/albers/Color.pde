// Your basic bouncing ball example
// except with moving walls (top and bottom)
class Color {
  float c;
  float speed;

  Color(float _c, float _speed) {
    c = _c;
    speed = _speed;
  }

  float run() {
    c+=speed;
    if (c > top || c < bottom) {
      speed *=-1;
    }
    c = constrain(c, bottom, top);
    return c;
  }
}

