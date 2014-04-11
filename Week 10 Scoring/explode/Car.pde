class Car {
  int type;
  color col;
  float diameter;
  PVector location, velocity, acceleration;


  Car(int _type, PVector _location, PVector _velocity, PVector _acceleration) {
    type = _type;
    location = _location;
    velocity = _velocity;
    acceleration = _acceleration;  

    switch(type) {
    case 0:
      col = color(0, 0, 255);
      diameter = 30;
      break;
    case 1:
      col = color(0, 255, 0);
      diameter = 20;
      break;
    case 2:
      col = color(255, 0, 0);
      diameter = 10;
      break;
    }
  }

  void run() {
    update();
    display();
  }

  void update() {
    // Accelerate
    velocity.add(acceleration);
    // Move
    location.add(velocity);
  }

  void setSize(float sz) {
    diameter = sz;
  }

  void display() {
    fill(col);
    ellipse(location.x, location.y, diameter, diameter);
  }  

  boolean isDead() {
    return location.x > width;
  }
}

