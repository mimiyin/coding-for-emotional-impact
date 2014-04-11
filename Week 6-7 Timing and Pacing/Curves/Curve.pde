class Curve {
  float t, speed, scale;

  Curve( float _t, float _speed, float _scale ) {
    t = _t;
    speed = _speed;
    scale = _scale;
  }
  
  void update() {
   t += speed; 
  }
  
  float calc() {
   return 0; 
  }
  
  float run() {
    update();
    return calc();
  }
}

class Linear extends Curve { 
  Linear(float t, float speed, float scale) {
    super(t, speed, scale);
  }
  float calc() {
    return t*scale;
  }
}

class Airplane extends Curve {
  Airplane(float t, float speed, float scale) {
    super(t, speed, scale);
  }

  float calc() {
    return pow(scale, t);
  }
}

class RocketShip extends Curve {
  RocketShip(float t, float speed, float scale) {
    super(t, speed, scale);
  }

  float calc() {
    return pow(t, scale);
  }
}

class Logarithmic extends Curve {
  Logarithmic(float t, float speed, float scale) {
    super(t, speed, scale);
  }
  float calc() {
    return log(t)*scale;
  }
}

class Sigmoid extends Curve {
  Sigmoid(float t, float speed, float scale) {
    super(t, speed, scale);
  }
  float calc() {
    return height/(1+exp(-t));
  }
}

class Bounce extends Curve {
  float a;
  Bounce(float t, float speed, float scale) {
    super(t, speed, scale);
    a = scale*4;
  }
  float calc() {
    float n = sin(t)*a + a;
    return log(n)*(scale);
  }
}

