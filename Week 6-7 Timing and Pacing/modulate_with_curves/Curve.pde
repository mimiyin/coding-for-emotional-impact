class Curve {
  float t, speed, scale;

  Curve( float _t, float _speed, float _scale ) {
    t = _t;
    speed = _speed;
    scale = _scale;
  }

  Curve() { 
  }

  float run() {
    return 0;
  }
}

class Linear extends Curve { 
  float t, m; 

  Linear(float _m) {
    super(0, 0, 1);
    m = _m;
  }
  float run() {
    t+=speed;
    return m*t;
  }
}

class Geometric extends Curve {
  Geometric(float t, float speed, float scale) {
    super(t, speed, scale);
  }

  float run() {
    t += speed;
    return pow(scale, t);
  }
}

class Exponential extends Curve {
  Exponential(float t, float speed, float scale) {
    super(t, speed, scale);
  }

  float run() {
    t += speed;
    return pow(t, scale);
  }
}

class Logarithmic extends Curve {
  Logarithmic(float t, float speed, float scale) {
    super(t, speed, scale);
  }
  float run() {
    t+=speed;
    return log(t)*scale;
  }
}

class Sigmoid extends Curve {
  Sigmoid(float t, float speed, float scale) {
    super(t, speed, scale);
  }
  float run() {
    t += speed;
    return height/(1+exp(-t));
  }
}

class Bounce extends Curve {
  float a; // height of bounce
  
  Bounce(float t, float speed, float scale, float _a) {
    super(0, 0, speed);
    a = _a;
  }
  float run() {
    t+=speed;
    float n = sin(t)*a + a;
    return log(n)*(a/4);
  }
}

