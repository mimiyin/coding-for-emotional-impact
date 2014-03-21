class Curve {
  float t, base, power, speed;

  Curve( float _base, float _power, float _speed ) {
    base = _base;
    power = _power;
    speed = _speed;
  }

  Curve() {
  }

  // New update function to move along the curve "manually"
  void update( float _t, float _base, float _power, float _speed ) {
    t += _t;
    base += _base;
    power += _power;
    speed += _speed;
  } 

  float run() {
    return 0;
  }
}

class Linear extends Curve { 
  float m; 

  Linear(float _m) {
    super(0, 0, 0);
    m = _m;
  }
  float run() {
    t+=speed;
    t = constrain(t, 0, 1000);
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
    power = constrain(power, 1, 1000);
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

  Bounce(float _speed) {
    super(0, 0, _speed);
  }
  float run() {
    t+=speed;
    float base = sin(t*0.1)*200 + 200;
    return log(base)*50;
  }
}

