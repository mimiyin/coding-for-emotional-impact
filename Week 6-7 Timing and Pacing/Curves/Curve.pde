class Curve {
  float base, power, speed;

  Curve( float _base, float _power, float _speed ) {
    base = _base;
    power = _power;
    speed = _speed;
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

class Exponential extends Curve {
  Exponential(float base, float power, float speed) {
    super(base, power, speed);
  }

  float run() {
    base += speed;
    return pow(base, power);
  }
}

class Logarithmic extends Curve {
  Logarithmic(float base, float power, float speed) {
    super(base, power, speed);
  }
  float run() {
    power+=speed;
    return log(power)*50;
  }
}

class Sigmoid extends Curve {
  Sigmoid(float base, float speed) {
    super(base, 0, speed);
  }
  float run() {
    base += speed;
    return height/(1+exp(-base));
  }
}

class Bounce extends Curve {
  float t;
  float a = 200; // height of bounce
  
  Bounce(float speed) {
    super(0, 0, speed);
  }
  float run() {
    t+=speed;
    float base = sin(t)*a + a;
    return log(base)*(a/4);
  }
}

