// A class to manage the changing rgb values for its area of the screen
class Area {

  PVector hsb, speed;

  Area(PVector _hsb, PVector _speed) {
    hsb = _hsb;
    speed = _speed;
  }

  PVector run() {    
    update(speed);
    return hsb;
  }

  float wrap(float f) {
    if (f > range) f = f - range;
    else if (f < 0) f = range + f;
    return f;
  }

  void update(PVector a) {
    hsb.add(a);
    hsb.x = wrap(hsb.x); 
    hsb.y = wrap(hsb.y);
    hsb.z = wrap(hsb.z);
  }
  
  void reset(PVector _hsb) {
    hsb = new PVector(_hsb.x, _hsb.y, _hsb.z);    
  }
}

